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
    runHook predInstalll

    # mkdir -p $out
    cp -r output $out

    runHook postInstalll
  '';

  meta = {
    description = "";
    homepage = "";
    license = lib.licenses.mit;
  };
}
