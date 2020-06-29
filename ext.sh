awk -F, 'NR>1{print$5}' kusogayoh_breakless.csv | grep '<br>' | tr -d \" > sentences
