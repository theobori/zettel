{
  lib,
  stdenvNoCC,
  emanote,
}:
stdenvNoCC.mkDerivation {
  pname = "notes";
  version = "0.0.1";

  src = ./.;

  nativeBuildInputs = [
    emanote
  ];

  env = {
    LC_ALL = "C.UTF-8";
  };

  buildPhase = ''
    runHook preBuild

    mkdir -p output
    emanote --layers "./zettel" gen output

    runHook postBuild
  '';

  installPhase = ''
    runHook predInstall

    install
    cp -r output $out

    runHook postInstall
  '';

  meta = {
    description = "My public zettelkasten";
    homepage = "https://github.com/theobori/zettel";
    license = lib.licenses.gpl3Plus;
  };
}
