{
  lib,
  stdenvNoCC,
  emanote,
}:
stdenvNoCC.mkDerivation {
  pname = "my-zettelkasten";
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

    mkdir -p emanote_output
    emanote --layers "./zettel" gen emanote_output

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp -r emanote_output $out

    runHook postInstall
  '';

  meta = {
    description = "My public zettelkasten";
    homepage = "https://github.com/theobori/zettel";
    license = lib.licenses.gpl3Plus;
  };
}
