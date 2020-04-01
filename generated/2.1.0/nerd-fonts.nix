{ stdenv
, fetchzip
, symlinkJoin
}:
let
  generic =
    { name
    , sha256
    , url
    , version
    }:
      stdenv.mkDerivation {
        pname = "nerd-font-${name}";
        inherit version;

        src = fetchzip {
          inherit sha256 url;
          stripRoot = false;
        };

        dontConfigure = true;

        dontBuild = true;

        installPhase = ''
          runHook preInstall

          find \( -iname \*.ttf -o -iname \*.otf \) \
            -exec install "$(basename "{}")" \
            -v -m644 -D "$out/share/fonts/truetype/{}" ';'

          runHook postInstall
        '';

      };
in
rec {
  nerd-font-3270 = generic {
    name = "3270";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/3270.zip";
    sha256 = "1ajcvpwrr2zfk4zg22252j95ifcc7x9sbn0xwmp0lj21y9dbdnq0";
    version = "2.1.0";
  };
  nerd-font-agave = generic {
    name = "agave";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Agave.zip";
    sha256 = "09r3yl7rsh2p9w0s6ia723ar3cqalcdq8c6z5pa1k4jv4lgil9fi";
    version = "2.1.0";
  };
  nerd-font-anonymouspro = generic {
    name = "anonymouspro";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/AnonymousPro.zip";
    sha256 = "1mb222ig1fc86vfmhk6r23jhaxn7wk45rlp16msxkyf4g0wp93fb";
    version = "2.1.0";
  };
  nerd-font-arimo = generic {
    name = "arimo";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Arimo.zip";
    sha256 = "1hcc8l3kdh8wrwsz97xfz7frn84828a2csbq3jjhw1pcwpsp5q2i";
    version = "2.1.0";
  };
  nerd-font-aurulentsansmono = generic {
    name = "aurulentsansmono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/AurulentSansMono.zip";
    sha256 = "1nhdzy9gdzkahz1bw02vq0fw3pb0c9zhhyqyc3fy88si5j5lba6d";
    version = "2.1.0";
  };
  nerd-font-bigblueterminal = generic {
    name = "bigblueterminal";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/BigBlueTerminal.zip";
    sha256 = "1snbk0y83bbp3ziihxpsskkl18lfgyjnh8a8430msszlyp1hia1b";
    version = "2.1.0";
  };
  nerd-font-bitstreamverasansmono = generic {
    name = "bitstreamverasansmono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/BitstreamVeraSansMono.zip";
    sha256 = "0gddvb115jjmwjv6aw62ycp7vccqjcd4c0yfky6nlc35nb1bcz20";
    version = "2.1.0";
  };
  nerd-font-cascadiacode = generic {
    name = "cascadiacode";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip";
    sha256 = "1s80rj958in5y5ncwh98nkadyjz9grzykflcb7ahcs37l75clb0q";
    version = "2.1.0";
  };
  nerd-font-codenewroman = generic {
    name = "codenewroman";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CodeNewRoman.zip";
    sha256 = "11c4i1wlwcl41nq0fh4h7v0b28alg75kc4llbf4m2y4bx45frd7y";
    version = "2.1.0";
  };
  nerd-font-cousine = generic {
    name = "cousine";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Cousine.zip";
    sha256 = "1xrnvjacl694shi47m3vz6jfmdd48m54cjk7zqyms74q0cjnfkiq";
    version = "2.1.0";
  };
  nerd-font-daddytimemono = generic {
    name = "daddytimemono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DaddyTimeMono.zip";
    sha256 = "07vp62gfym6xxfd0p8px92h2zdp24b1mg9zxdarpijfsy3bn6pw0";
    version = "2.1.0";
  };
  nerd-font-dejavusansmono = generic {
    name = "dejavusansmono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DejaVuSansMono.zip";
    sha256 = "08ry57vdjr2vsjy1i1ynzzrh424jvcsjpz5yhqgj562c783gm0ji";
    version = "2.1.0";
  };
  nerd-font-droidsansmono = generic {
    name = "droidsansmono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip";
    sha256 = "0yx6dqmj3vdjrc7wzl8hksgyrrmsd2cg3i6n7y7mz98ra2m78gw9";
    version = "2.1.0";
  };
  nerd-font-fantasquesansmono = generic {
    name = "fantasquesansmono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FantasqueSansMono.zip";
    sha256 = "0ayv8bc5i6vdlfm5f17ivqrmj8r1sz2k7a45kvkpxxrsz7d07s8y";
    version = "2.1.0";
  };
  nerd-font-firacode = generic {
    name = "firacode";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip";
    sha256 = "0k064h89ynbbqq5gvisng2s0h65ydnhr6wzx7hgaw8wfbc3qayvp";
    version = "2.1.0";
  };
  nerd-font-firamono = generic {
    name = "firamono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraMono.zip";
    sha256 = "1ssl1mbnj2ga1n3n1z25fx5p5iarny6pw2w7kbbpbzjgh9c9r4gi";
    version = "2.1.0";
  };
  nerd-font-go-mono = generic {
    name = "go-mono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Go-Mono.zip";
    sha256 = "1irm8zf24m5i4jyhpybjnj8zxa59cvqdaj84jp233ajgczw05f1x";
    version = "2.1.0";
  };
  nerd-font-gohu = generic {
    name = "gohu";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Gohu.zip";
    sha256 = "1gxppjs1hxfscic093cjsd2ba8fmpqrdx4c6p1swd6wyn2zrrcww";
    version = "2.1.0";
  };
  nerd-font-hack = generic {
    name = "hack";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip";
    sha256 = "1gwiaqq97k6xzp5ia1cqfk9rqivjr62hv5swivf1sfmzp9rivbfj";
    version = "2.1.0";
  };
  nerd-font-hasklig = generic {
    name = "hasklig";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hasklig.zip";
    sha256 = "19wv1k4dbirzkks7d3i0j14zpb0dh87yxxa9bz5b77949bkiyx0a";
    version = "2.1.0";
  };
  nerd-font-heavydata = generic {
    name = "heavydata";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/HeavyData.zip";
    sha256 = "031ahnkvgmgh3z0d53p1c3j1da6dd33wqlwxky4s2rmkrvmdxa0c";
    version = "2.1.0";
  };
  nerd-font-hermit = generic {
    name = "hermit";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hermit.zip";
    sha256 = "12nv5dnjj40k2c8rxx16caj5mamqc1m1v5fidf6falk9lhl8p2ff";
    version = "2.1.0";
  };
  nerd-font-ia-writer = generic {
    name = "ia-writer";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/iA-Writer.zip";
    sha256 = "0qk663i2h4kd9r5n3yxc0zg48gpw6bfn7hxv810mskp5k8shy091";
    version = "2.1.0";
  };
  nerd-font-ibmplexmono = generic {
    name = "ibmplexmono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/IBMPlexMono.zip";
    sha256 = "1x2nf3zjg5ag582wlr0djb4dqqs1s22qyja88c1nfyxpycaclmld";
    version = "2.1.0";
  };
  nerd-font-inconsolata = generic {
    name = "inconsolata";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Inconsolata.zip";
    sha256 = "09ibapyiybn6lgqgpqm4whfdgcp5sz75s05ndnhg898bvc0f5m94";
    version = "2.1.0";
  };
  nerd-font-inconsolatago = generic {
    name = "inconsolatago";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/InconsolataGo.zip";
    sha256 = "0nkbc7srxjcn80q8cm1200gmdvb3hjnlh9jl6bngp042ld5j6sjx";
    version = "2.1.0";
  };
  nerd-font-inconsolatalgc = generic {
    name = "inconsolatalgc";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/InconsolataLGC.zip";
    sha256 = "11r85iawckc7yzimk6x8rm7c2kpyqsqd6j6dqm3x6gys2d6fhf0v";
    version = "2.1.0";
  };
  nerd-font-iosevka = generic {
    name = "iosevka";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip";
    sha256 = "1c4rz3qxvyns1sgv4p4pa7wdihaxq9n8hkjsnkygmwr6pylaj7lw";
    version = "2.1.0";
  };
  nerd-font-jetbrainsmono = generic {
    name = "jetbrainsmono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip";
    sha256 = "1dzdys75r00i86qxm5b4ibbjbgimpmj7d35l7nd4y311mhq4ki13";
    version = "2.1.0";
  };
  nerd-font-lekton = generic {
    name = "lekton";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Lekton.zip";
    sha256 = "0dylgi5cdwxxrgv1yh5ghbw9w4mh515ik734jvf698wav0hpk3v7";
    version = "2.1.0";
  };
  nerd-font-liberationmono = generic {
    name = "liberationmono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/LiberationMono.zip";
    sha256 = "0p2ghw62jv024mk3gidaary5gafbpykkhs88n99j8n9vmpqbwkgx";
    version = "2.1.0";
  };
  nerd-font-meslo = generic {
    name = "meslo";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip";
    sha256 = "068l6931pmjnlcmfx05rn5kh9r5b3nc94hj0impmc5lp9p66rcjq";
    version = "2.1.0";
  };
  nerd-font-monofur = generic {
    name = "monofur";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Monofur.zip";
    sha256 = "040ha5rlsa3ll1js6p03lshrmv86bnamidyx290lpl7gcf2z2pdi";
    version = "2.1.0";
  };
  nerd-font-monoid = generic {
    name = "monoid";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Monoid.zip";
    sha256 = "084aphj8sxx6wx1k7hp5cbvysv026ivqs6j2pszijm54blxlip40";
    version = "2.1.0";
  };
  nerd-font-mononoki = generic {
    name = "mononoki";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Mononoki.zip";
    sha256 = "1yb5x9fxx21sal6d83dsk3a41cbyxranw24v6gkxrjfik0xd8r4r";
    version = "2.1.0";
  };
  nerd-font-mplus = generic {
    name = "mplus";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/MPlus.zip";
    sha256 = "16wm6lyh4qkbxn6zavsj1xvv4sjgx6jk3707pkbh8vm408jdajad";
    version = "2.1.0";
  };
  nerd-font-noto = generic {
    name = "noto";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Noto.zip";
    sha256 = "11xac5gbl3l49mwlv6xwqgdbx332f6l1ncqp46xbpjz5bag31zls";
    version = "2.1.0";
  };
  nerd-font-opendyslexic = generic {
    name = "opendyslexic";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/OpenDyslexic.zip";
    sha256 = "1pnapybdq82ywqnx9bnaxvpcz4l023b8ip61kysfyx9rmq8gcmi3";
    version = "2.1.0";
  };
  nerd-font-overpass = generic {
    name = "overpass";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Overpass.zip";
    sha256 = "003kr60vj0yvgqky966vfy1zdp4bgj4r3v8wjw1476b4mb8zz4b1";
    version = "2.1.0";
  };
  nerd-font-profont = generic {
    name = "profont";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/ProFont.zip";
    sha256 = "1nhsq7pczcwbqlbkpxhbcsmsn2dh3qmxcyr7rgdwrn4mzsddw12a";
    version = "2.1.0";
  };
  nerd-font-proggyclean = generic {
    name = "proggyclean";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/ProggyClean.zip";
    sha256 = "0gxr9mh11n8rzmhrjd695pivn17g9pqsmkn1j05pa5l3sxd9ccg5";
    version = "2.1.0";
  };
  nerd-font-robotomono = generic {
    name = "robotomono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip";
    sha256 = "1l5ys5wvb0gaf30m3axs2b3gv216j9p70mlks4w3xa0pybvdk1ln";
    version = "2.1.0";
  };
  nerd-font-sharetechmono = generic {
    name = "sharetechmono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/ShareTechMono.zip";
    sha256 = "0wign6aax1h27cs7vw67mi8hb9jwa5rgpki0jpqg352srljgg1ny";
    version = "2.1.0";
  };
  nerd-font-sourcecodepro = generic {
    name = "sourcecodepro";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip";
    sha256 = "116s7md53lql8wd08wcld64yq1z4ighkld4p3pl4z72xhvxwmbnf";
    version = "2.1.0";
  };
  nerd-font-spacemono = generic {
    name = "spacemono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SpaceMono.zip";
    sha256 = "1vlb8pmp5k8yr2p1yzyrxjbgaxf5vz42k65l4r1164impyq9p5z0";
    version = "2.1.0";
  };
  nerd-font-terminus = generic {
    name = "terminus";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Terminus.zip";
    sha256 = "12plz9466s8lv32cmmg13prkyhxb60mg2wn58bvny8kl2mxj7lj6";
    version = "2.1.0";
  };
  nerd-font-tinos = generic {
    name = "tinos";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Tinos.zip";
    sha256 = "07ab7601np9ky1mb5gssx0s0szsqqw7aa26yfn54r0cd5a008y7b";
    version = "2.1.0";
  };
  nerd-font-ubuntu = generic {
    name = "ubuntu";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Ubuntu.zip";
    sha256 = "1r72l46pwj3h3wfs77d8sv5rzpafz94fz6nd7831qyr79ndk6m95";
    version = "2.1.0";
  };
  nerd-font-ubuntumono = generic {
    name = "ubuntumono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip";
    sha256 = "1vj7vp0spxnz208ikph6gv4mgj54w5k12mqyg2w6wz129jaxq3dq";
    version = "2.1.0";
  };
  nerd-font-victormono = generic {
    name = "victormono";
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/VictorMono.zip";
    sha256 = "0scjbwzxrmawbmrnh1ggsr8zxz5fp47g0mrdb0hv7hqb80zlzw1s";
    version = "2.1.0";
  };

  nerd-fonts = symlinkJoin {
    name = "nerd-fonts";
    paths = [
      nerd-font-3270
      nerd-font-agave
      nerd-font-anonymouspro
      nerd-font-arimo
      nerd-font-aurulentsansmono
      nerd-font-bigblueterminal
      nerd-font-bitstreamverasansmono
      nerd-font-cascadiacode
      nerd-font-codenewroman
      nerd-font-cousine
      nerd-font-daddytimemono
      nerd-font-dejavusansmono
      nerd-font-droidsansmono
      nerd-font-fantasquesansmono
      nerd-font-firacode
      nerd-font-firamono
      nerd-font-go-mono
      nerd-font-gohu
      nerd-font-hack
      nerd-font-hasklig
      nerd-font-heavydata
      nerd-font-hermit
      nerd-font-ia-writer
      nerd-font-ibmplexmono
      nerd-font-inconsolata
      nerd-font-inconsolatago
      nerd-font-inconsolatalgc
      nerd-font-iosevka
      nerd-font-jetbrainsmono
      nerd-font-lekton
      nerd-font-liberationmono
      nerd-font-meslo
      nerd-font-monofur
      nerd-font-monoid
      nerd-font-mononoki
      nerd-font-mplus
      nerd-font-noto
      nerd-font-opendyslexic
      nerd-font-overpass
      nerd-font-profont
      nerd-font-proggyclean
      nerd-font-robotomono
      nerd-font-sharetechmono
      nerd-font-sourcecodepro
      nerd-font-spacemono
      nerd-font-terminus
      nerd-font-tinos
      nerd-font-ubuntu
      nerd-font-ubuntumono
      nerd-font-victormono
    ];
  };
}
