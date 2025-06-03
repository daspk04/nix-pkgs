{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:

buildGoModule (finalAttrs: {
  pname = "runpodctl";
  version = "1.14.5";

  src = fetchFromGitHub {
    owner = "runpod";
    repo = "runpodctl";
    tag = "v${finalAttrs.version}";
    hash = "sha256-wRHf2Bh0jz9UqrjJmc2ZV3WSLDYl+9frZ8nD0qDay7g=";
  };

  proxyVendor = true;
  vendorHash = "sha256-hiOEAUsPEceJUO/3Nj5Bg06FGTWopkAJ0/l/MvcEORw=";

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${finalAttrs.version}"
  ];

  doInstallCheck = true;

  versionCheckProgramArg = "--version";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "RunPod CLI for pod management";
    homepage = "https://github.com/runpod/runpodctl";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ daspk04 ];
    mainProgram = "runpodctl";
  };
})
