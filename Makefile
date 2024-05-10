current_version := $(shell sed -nE 's/^## Version: ([0-9]+\.[0-9]+\.[0-9]+)/\1/p' MikScrollingBattleText/MikScrollingBattleText.toc)
incremented_version := $(shell echo ${current_version} | awk -F. '{$$NF = $$NF + 1;} 1' | sed 's/ /./g')
git_tag := "Release: ${incremented_version}"

build:
	cp -r MikScrollingBattleText /mnt/d/Games/World\ of\ Warcraft/_classic_/Interface/AddOns/

release-build:
# Update version in MikScrollingBattleText.toc
	sed -i "s/^## Version: ${current_version}/## Version: ${incremented_version}/" MikScrollingBattleText/MikScrollingBattleText.toc

# Commit the changes
	git add MikScrollingBattleText/MikScrollingBattleText.toc
	git commit -m "Increment version to ${incremented_version}"

# Tag the commit with the incremented semver version
	git tag -a "v${incremented_version}" HEAD -m ${git_tag}

# Push the commit and tag to the remote
	git push
	git push origin "v${incremented_version}"
