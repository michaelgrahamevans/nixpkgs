{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  git,
}:
buildDotnetModule rec {
  pname = "min-ed-launcher";
  version = "0.12.1";

  src = fetchFromGitHub {
    owner = "rfvgyhn";
    repo = "min-ed-launcher";
    tag = "v${version}";
    hash = "sha256-/dzcWwpg1nIrqICAQIxzwMgfrCB1G9bu2bT7Cv1khFM=";

    leaveDotGit = true; # During build the current commit is appended to the version
  };

  projectFile = "MinEdLauncher.sln";
  nugetDeps = ./deps.json;
  buildInputs = [
    git # During build the current commit is appended to the version
  ];

  executables = [ "MinEdLauncher" ];

  meta = {
    homepage = "https://github.com/rfvgyhn/min-ed-launcher";
    description = "Minimal Elite Dangerous Launcher";
    license = lib.licenses.mit;
    platforms = lib.platforms.x86_64;
    mainProgram = "MinEdLauncher";
    maintainers = with lib.maintainers; [ jiriks74 ];
  };
}
