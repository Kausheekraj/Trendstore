#!/usr/bin/env bash
cd $(dirname "${0}") || exit 1

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Project root = one level above /operation
OPERATION_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Paths inside operation
DOCKER_DIR="$OPERATION_ROOT/Docker/"
SCRIPTS_DIR="$OPERATION_ROOT/scripts/"
cd "${DOCKER_DIR}"
usage () {
  echo "[Usage]: <${0}> [-d] [-s] [-b] "
  echo "   ============================== "
  echo "    -b   - building image"
  echo "    -d   - Deploy Container"
  echo "    -s   - Stop Container"
  echo "    -r   - Remove Container image"
  echo "   ============================== "
  exit 1
}
no_opts () {
  echo "Pls provide a valid option to run the script"
  echo "Try ${0} '-h' or '--help' for more "
  exit 1

}
for arg in "${@}"; do
  if [[ "$arg" == '--help' ]]; then
    usage 
  exit 0
  fi
done
while getopts "bdsrh"  opts; do
  case  "${opts}" in
  b)  "${SCRIPT_DIR}"/build.sh ;;
  d)  "${SCRIPT_DIR}"/deploy.sh ;;
  s) "${SCRIPT_DIR}"/stop.sh ;;
  r) "${SCRIPT_DIR}"/stop.sh rm ;;
  h) usage ;;
  ?) no_opts ;;
 esac
done
if [[ $# -eq 0 ]]; then
  usage
  exit 1
fi

