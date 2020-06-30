#!/bin/bash

readonly FILE="sentences"
readonly SAVE="data"

function _extract(){
  SAVEPATH="${SAVE}/${2}"
  if [[ -f "${SAVEPATH}" ]]
  then
    echo -n 'overwhite ok?(y/n):' >&2
    read -r f
    [[ "${f}" -eq 'y' ]] && {
      grep -oP "${1}" "${FILE}" | sed -r 's/[　 ]//g' | sort | uniq > "${SAVEPATH}"
    } || {
      echo 'skipped.'
    }
  else
    grep -oP "${1}" "${FILE}" | sed -r 's/[　 ]//g' | sort | uniq > "${SAVEPATH}"
  fi
}

function _chooser(){
  case "${1}" in
  user       ) _extract '[^<]+?(が代)(?=<br><br>作詞:)'                     user       ;;
  person     ) _extract '(?<=:)[^/]+?(?=<br>)'                              person     ;;
  occupation ) _extract '(?<=<br>)[^(作詞)(作曲)(https):]+(?=:)'            occupation ;;
  era        ) _extract '((?<=<br><br>)([^代]+)(?=代に)|^([^代]+)(?=代に))' era        ;;
  kuso       ) _extract '' kuso                                                        ;;
  trans      ) _extract '(?<=<br><br>)[^<]+?(?=となりて<br><br>)'           trans      ;;
  conqueror  ) _extract '' conqueror                                                   ;;
  till       ) _extract '' till                                                        ;;
  *          ) return 1                                                                ;;
esac
}

function main(){
  mkdir -p "${SAVE}"
  local val
  val=(user person occupation era kuso trans conqueror till)
  for v in "${val[@]}"
  {
    echo "Now: ${v}" >&2
    _chooser "${v}"
  }
}

main
exit $?
