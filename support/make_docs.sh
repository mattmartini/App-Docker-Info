#!/usr/bin/env bash

set -Eeuo pipefail

source ${BASH_FUNCTION_DIR}/color_fns.sh

# namename prints the basename without extension
namename() {
  local name=${1##*/}
  local name0="${name%.*}"
  printf "%s\n" "${name0:-$name}"
}

# Update API Docs
printf '%s\n' "${Blue}Updating Module docs...${NC}"

rm -rf docs/*
for i in lib/App/Docker/Info.pm lib/App/Docker/Info/*pm
do
  j=$(namename "${i}")
  pod2markdown "${i}" > "docs/${j}.md"
done
printf "%s\n" "${Green}done${NC}"

printf '%s\n' "${Blue}Updating Manifest...${NC}"
if [[ -e 'MANIFEST' ]]; then
  rm MANIFEST
fi
make manifest
printf "%s\n" "${Green}done${NC}"

# Update Changelog
printf '%s\n' "${Blue}Updating Changelog...${NC}"
if [[ -e 'CHANGELOG.md' ]]; then
  rm CHANGELOG.md
fi
git cliff > CHANGELOG.md
printf "%s\n" "${Green}done${NC}"

printf '%s\n' "${Blue}Updating Signatures...${NC}"
if [[ -e 'SIGNATURE' ]]; then
  rm SIGNATURE
fi
make signature
printf "%s\n" "${Green}done${NC}"

