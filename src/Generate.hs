{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RecordWildCards #-}

module Generate
  ( run
  )
where

import           Protolude

import           Control.Monad.Logger           ( runStderrLoggingT )
import           Data.Aeson                     ( ToJSON
                                                , eitherDecodeFileStrict'
                                                , toJSON
                                                )
import           Data.Aeson.Encode.Pretty       ( encodePretty )
import qualified Data.ByteString.Char8         as CharBytes
import qualified Data.ByteString.Lazy          as LazyBytes
import qualified Data.HashMap.Strict           as HashMap
import qualified Data.Text                     as Text
import qualified Data.Text.IO                  as Text
import qualified Data.Vector                   as Vector
import qualified GitHub
import qualified Shell
import           System.Directory               ( createDirectoryIfMissing
                                                , doesFileExist
                                                )
import           System.Environment             ( lookupEnv )
import qualified System.FilePath.Posix         as FilePath
import           System.FilePath.Posix          ( (</>) )
import           Text.EDE                hiding ( version )

data FontInfo = FontInfo
  { name :: Text
  , url :: Text
  , sha256 :: Text
  , version :: Text
  } deriving (Eq, Generic, Show)

instance ToJSON FontInfo where

lookupToken :: (MonadIO m, MonadError Text m) => m ByteString
lookupToken = do
  mToken <- liftIO . lookupEnv $ "GITHUB_TOKEN"
  case mToken of
    Just token -> pure . CharBytes.pack $ token
    Nothing    -> throwError "no GitHub token found in the environment."

request
  :: ( MonadIO m
     , GitHub.AuthMethod am
     , GitHub.GitHubRW req (IO (Either a b))
     , MonadError Text m
     , Show a
     )
  => am
  -> req
  -> m b
request auth rq = do
  eRet <- liftIO . GitHub.github auth $ rq
  case eRet of
    Right ret   -> pure ret
    Left  error -> throwError ("GitHub request failed: " <> show error <> ".")

annotate :: (Monad m, Show e) => ExceptT e m a -> Text -> ExceptT Text m a
annotate action msg = action `catchE` (throwE . (msg `mappend`) . show)

hoistEither :: Monad m => Either e a -> ExceptT e m a
hoistEither = ExceptT . return

computeHash :: MonadIO m => Text -> ExceptT Text m Text
computeHash url =
  flip annotate "`nix-prefetch-url` failed"
    $ fmap Text.strip
    $ runStderrLoggingT
    $ Shell.shell "nix-prefetch-url"
    $ do
        Shell.switch "--unpack"
        Shell.option "--name" "source"
        Shell.arg url
        Shell.raw "2>/dev/null"

run :: IO ()
run = do
  ret <- runExceptT $ do
    token <- lookupToken
    let rq = GitHub.latestReleaseR "ryanoasis" "nerd-fonts"
    release <- request (GitHub.OAuth token) rq
    let version       = Text.dropWhile (== 'v') . GitHub.releaseName $ release
    let cacheFileName = "cache/" <> toS version <> "/hashes.json"
    haveCache    <- liftIO . doesFileExist $ cacheFileName
    initialCache <- if haveCache
      then
        (hoistEither . first toS)
          =<< (liftIO . eitherDecodeFileStrict' $ cacheFileName)
      else pure HashMap.empty
    (fonts, updatedCache) <-
      flip runStateT initialCache
      $ for (GitHub.releaseAssets release)
      $ \asset -> do
          let name =
                Text.toLower
                  . toS
                  . FilePath.takeBaseName
                  . toS
                  . GitHub.releaseAssetName
                  $ asset
          let url = GitHub.releaseAssetBrowserDownloadUrl asset
          cache  <- get
          sha256 <- case HashMap.lookup name cache of
            Just cached -> pure cached
            Nothing     -> lift . computeHash $ url
          put (HashMap.insert name sha256 cache)
          return (FontInfo { .. })
    let Just env =
          fromValue
            . toJSON
            . HashMap.fromList
            $ [("fonts" :: Text, Vector.toList fonts)]
    template <-
      hoistEither
      .   first toS
      =<< (liftIO . eitherParseFile $ "template/nerd-fonts.nix.ede")
    ret <- hoistEither . first toS =<< pure (eitherRender template env)
    liftIO . createDirectoryIfMissing True $ "generated" </> toS version
    liftIO
      . Text.writeFile ("generated" </> toS version </> "nerd-fonts.nix")
      . toS
      $ ret
    liftIO
      . createDirectoryIfMissing True
      . FilePath.takeDirectory
      $ cacheFileName
    liftIO . Text.writeFile cacheFileName . decodeUtf8 . LazyBytes.toStrict . encodePretty $ updatedCache
  case ret of
    Left (err :: Text) -> do
      putText ("An error occurred: " <> err)
      exitFailure
    Right _ -> exitSuccess
