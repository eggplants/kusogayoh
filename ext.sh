#!/bin/bash

awk -F, 'NR>1{print$5}' kusogayoh_breakless.csv |
  grep '<br>'                                   |
    tr -d \"                                    |
      sed -r 's_(893413).*$_\1_g'               > sentences

mecab -Owakati                                  <(
  sed 's/<br>//g;s_https://shindanmaker.com/893413__g' sentences
                                                )> sentences_wakati
