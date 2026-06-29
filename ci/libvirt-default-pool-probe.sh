#!/bin/bash

## Copyright (C) 2026 - 2026 ENCRYPTED SUPPORT LLC <adrelanos@whonix.org>
## See the file COPYING for copying conditions.

## AI-Assisted

## Proof, on a pristine CI runner, of whether libvirt auto-creates the
## qemu:///session default storage pool directory (~/.local/share/libvirt/
## images). The libvirt-dist domain XML references <source pool='default'>,
## so whether that directory exists by itself decides if a setup step must
## create it. Each step is an assertion: the script exits non-zero (failing
## CI) if libvirt's behaviour ever stops matching the documented claim.

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace
shopt -s inherit_errexit
shopt -s shift_verbose

set -x

# shellcheck source=../../helper-scripts/usr/libexec/helper-scripts/log_run_die.sh
source "${HELPER_SCRIPTS_PATH:-}"/usr/libexec/helper-scripts/log_run_die.sh

images_dir="${HOME}/.local/share/libvirt/images"
pool_xml=""

probe_cleanup() {
   virsh -c qemu:///session pool-destroy default &>/dev/null || true
   virsh -c qemu:///session pool-undefine default &>/dev/null || true
   if [ -n "${pool_xml}" ]; then
      safe-rm --force -- "${pool_xml}"
   fi
   ## Only ever remove the directory this probe itself may have built.
   safe-rm --recursive --force -- "${images_dir}"
}

assert_images_dir_absent() {
   local context

   context="$1"
   if [ -e "${images_dir}" ]; then
      die 1 "FAIL (${context}): '${images_dir}' exists - it was auto-created"
   fi
   log notice "OK (${context}): '${images_dir}' does not exist"
}

main() {
   local start_rc

   trap probe_cleanup EXIT

   ## 1. Pristine runner: the directory must not exist yet.
   assert_images_dir_absent "fresh runner"

   ## 2. Spawn the per-user session daemon and list pools. Merely connecting
   ##    must neither auto-define a 'default' pool nor create the directory.
   virsh -c qemu:///session pool-list --all
   if virsh -c qemu:///session pool-info default &>/dev/null; then
      die 1 "FAIL: a 'default' storage pool is auto-defined for qemu:///session"
   fi
   log notice "OK: no 'default' pool is auto-defined for qemu:///session"
   assert_images_dir_absent "after connect + pool-list"

   ## 3. Define a 'default' dir pool at the standard path. Defining stores the
   ##    pool config only; it must not create the target directory.
   pool_xml="$(mktemp)"
   printf '%s\n' \
      "<pool type='dir'><name>default</name><target><path>${images_dir}</path></target></pool>" \
      > "${pool_xml}"
   virsh -c qemu:///session pool-define "${pool_xml}"
   assert_images_dir_absent "after pool-define"

   ## 4. Starting the pool must NOT create the directory: it fails when the
   ##    target is missing. This is the key result - pool-start is not the
   ##    creator.
   start_rc=0
   virsh -c qemu:///session pool-start default || start_rc="$?"
   if [ "${start_rc}" = "0" ]; then
      die 1 "FAIL: pool-start succeeded without the directory existing"
   fi
   log notice "OK: pool-start did NOT create the directory (it failed, rc=${start_rc})"
   assert_images_dir_absent "after failed pool-start"

   ## 5. pool-build is the operation that creates the directory.
   virsh -c qemu:///session pool-build default
   if [ ! -d "${images_dir}" ]; then
      die 1 "FAIL: pool-build did not create '${images_dir}'"
   fi
   log notice "PROVEN: '${images_dir}' is created only by 'virsh pool-build', not by connecting, pool-define, or pool-start."
}

main "$@"
