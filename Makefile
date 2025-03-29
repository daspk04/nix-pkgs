build_all:
	nix build .\#allPkgsEnv

.PHONY: bump_patch
bump_patch:
	bump-my-version bump patch

.PHONY: bump_minor
bump_minor:
	bump-my-version bump minor

.PHONY: bump_major
bump_major:
	bump-my-version bump major