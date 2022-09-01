#!/usr/bin/env bash
set -e

git status

slug='codepotent-registration-honeypot'

phpfile="${slug}.php"

version=$(wp --allow-root --skip-plugins eval '$v = get_plugin_data( "'${phpfile}'" ); echo $v["Version"];')

echo "Going to release      : v${version}"

read -n 1 -s -r -p "If OK, press any key to continue (CTRL-C to exit)."

echo

git archive -o "../${slug}-${version}.zip" --prefix ${slug}/ HEAD

hub release create -d -a "../${slug}-${version}.zip" -m "Registration Honeypot ${version}" "${version}"

rm "../${slug}-${version}.zip"