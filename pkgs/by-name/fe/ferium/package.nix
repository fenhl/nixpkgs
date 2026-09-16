{
  lib,
  fetchFromGitHub,
  rustPlatform,
  installShellFiles,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "ferium";
  version = "5.0.0-dev";

  src = fetchFromGitHub {
    owner = "gorilla-devs";
    repo = "ferium";
    rev = "9d6f16a5397edbfde8cbe82c0e6657355105b7e1";
    hash = "sha256-eeQjezB6pRdnPADLgDLo8b+bUSP12gfBhFNt/uYCwHU=";
  };

  cargoHash = "sha256-3YKFKngyLg2ah4GY+LlbPbnVks7/xFawnMf3D1gjmwI=";

  # Disable the GUI file picker so that GTK/XDG dependencies aren't used
  buildNoDefaultFeatures = true;

  # Requires an internet connection
  doCheck = false;

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    for shell in bash fish zsh; do
      $out/bin/ferium complete $shell > ferium.$shell
      installShellCompletion ferium.$shell
    done
  '';

  meta = {
    description = "Fast and multi-source CLI program for managing Minecraft mods and modpacks from Modrinth, CurseForge, and GitHub Releases";
    mainProgram = "ferium";
    homepage = "https://github.com/gorilla-devs/ferium";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [
      leo60228
      soupglasses
    ];
  };
})
