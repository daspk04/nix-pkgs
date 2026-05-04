# Agents Guide

This repository provides a collection of Nix packages and environments specifically designed for Machine Learning (ML), Geospatial analysis, and Large Language Model (LLM) workflows. It is optimized for use by AI agents and developers seeking reproducible environments.

## Nix Environments

This repository defines several pre-configured environments. Agents can use these to quickly set up a workspace with all necessary tools for specific tasks.

| Environment | Focus | Key Packages |
|-------------|-------|--------------|
| `llmEnv`    | LLMs & NLP | `notebooklm-py` |
| `mlEnv`     | Machine Learning | `torch`, `tensorflow`, `keras`, `optuna`, `ray`, `pytorch-lightning` |
| `geoEnv`    | Geospatial Data | `gdal`, `pyinterp`, `verde` |
| `otbEnv`    | Remote Sensing | `otb`, `pyotb`, `otbtf` (Orfeo ToolBox) |
| `stacEnv`   | STAC Catalogs | `planetary-computer`, `rio-stac` |
| `cloudEnv`  | Cloud Compute | `runpod`, `skypilot`, `vastai`, `runpodctl` |
| `geoxrEnv`  | Geo Xarray | `rioxarray`, `odc-stac`, `odc-geo` |
| `xcubeEnv`  | xcube Data Cube | `xcube`, `xcube-sh` |

### How to use an environment
Enter a specific environment shell:

```bash
nix shell github:daspk04/nix-pkgs#llmEnv
```

Or run a command within an environment:

```bash
nix shell github:daspk04/nix-pkgs#mlEnv --command python -c "import torch; print(torch.__version__)"
```

## Repository Structure

- `flake.nix`: Main entry point for the flake, defines packages, environments, and overlays.
- `overlays/`: Contains the Nix expressions for each package.
  - Each subdirectory usually contains a `default.nix` for the package definition.
- `treefmt.nix`: Configuration for code formatting (`nixfmt`, `shellcheck`, etc.).

## Development

To contribute or modify packages, use the development shell which provides all necessary maintenance tools:

```bash
nix develop github:daspk04/nix-pkgs
```

Includes: `bashInteractive`, `python3`, `skopeo`, `bump-my-version`.
