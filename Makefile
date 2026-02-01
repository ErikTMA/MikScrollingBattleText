current_version := $(shell sed -nE 's/^## Version: ([0-9]+\.[0-9]+\.[0-9]+)/\1/p' MikScrollingBattleText/MikScrollingBattleText.toc)
incremented_build_version := $(shell echo ${current_version} | awk -F. '{$$3 = $$3 + 1;} 1' | sed 's/ /./g')
incremented_minor_version := $(shell echo ${current_version} | awk -F. '{$$2 = $$2 + 1;$$3 = 0} 1' | sed 's/ /./g')
incremented_major_version := $(shell echo ${current_version} | awk -F. '{$$1 = $$1 + 1;$$2 = 0;$$3 = 0} 1' | sed 's/ /./g')
git_tag := "v${incremented_build_version}"

build:
	cp -r MikScrollingBattleText /mnt/d/Games/World\ of\ Warcraft/_classic_/Interface/AddOns/

release-build:
# Update version in MikScrollingBattleText.toc
	sed -i "s/^## Version: ${current_version}/## Version: ${incremented_build_version}/" MikScrollingBattleText/MikScrollingBattleText.toc

# Commit the changes
	git add MikScrollingBattleText/MikScrollingBattleText.toc
	git commit -m "Increment version to ${incremented_build_version}"

# Tag the commit with the incremented semver version
	git tag -a "v${incremented_build_version}" HEAD -m ${git_tag}

# Push the commit and tag to the remote
	git push
	git push origin "v${incremented_build_version}"

release-minor:
# Update version in MikScrollingBattleText.toc
	sed -i "s/^## Version: ${current_version}/## Version: ${incremented_minor_version}/" MikScrollingBattleText/MikScrollingBattleText.toc

# Commit the changes
	git add MikScrollingBattleText/MikScrollingBattleText.toc
	git commit -m "Increment version to ${incremented_minor_version}"

# Tag the commit with the incremented semver version
	git tag -a "v${incremented_minor_version}" HEAD -m ${git_tag}

# Push the commit and tag to the remote
	git push
	git push origin "v${incremented_minor_version}"

release-major:
# Update version in MikScrollingBattleText.toc
	sed -i "s/^## Version: ${current_version}/## Version: ${incremented_major_version}/" MikScrollingBattleText/MikScrollingBattleText.toc

# Commit the changes
	git add MikScrollingBattleText/MikScrollingBattleText.toc
	git commit -m "Increment version to ${incremented_major_version}"

# Tag the commit with the incremented semver version
	git tag -a "v${incremented_major_version}" HEAD -m ${git_tag}

# Push the commit and tag to the remote
	git push
	git push origin "v${incremented_major_version}"

get-versions:
	@echo "Current version: ${current_version}"
	@echo "Incremented version: ${incremented_build_version}"
	@echo "Git tag: ${git_tag}"
