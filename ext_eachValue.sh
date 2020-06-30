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
  title      ) _extract '^(?!が代).*?(が代)(?=<br><br>)'                    title      ;;
  person     ) _extract '(?<=:)[^/]+?(?=<br>)'                              person     ;;
  occupation ) _extract '(?<=<br>)[^(作詞)(作曲)(https):]+(?=:)'            occupation ;;
  era1       ) _extract '(?<=<br><br>)[^(作詞)]*?(?=が代は )'               era1       ;;
  era2       ) _extract '((?<=<br><br>)([^代]+)(?=代に)|^([^代]+)(?=代に))' era2       ;;
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
  val=(title person occupation era1 era2 kuso trans conqueror till)
  for v in "${val[@]}"
  {
    echo "Now: ${v}" >&2
    _chooser "${v}"
  }
}

main
exit $?
