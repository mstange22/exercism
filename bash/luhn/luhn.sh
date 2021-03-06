#!/usr/bin/env bash

main () {
  stripped=${1// /}
  len=${#stripped}
  (( len <= 1 )) && { echo "false"; return 0; }

  sum=0

  for (( i=0; i<len; i++)); do
    digit=${stripped:$len-1-i:1}
    [[ $digit != [0-9] ]] && { echo "false"; return 0; }
    (( digit != 9 && i % 2 == 1 )) && (( sum+=(digit*2)%9 )) || (( sum+=digit ))
  done
  (( sum % 10 == 0 )) && echo "true" || echo "false" 
}

main "$@"
