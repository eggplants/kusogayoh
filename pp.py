import csv
import time

data = []
with open('kusogayoh.csv') as f:
	r = csv.reader(
		f, delimiter=",", doublequote=True,
		lineterminator="\r\n", quotechar='"', skipinitialspace=True
	)
	for row in r:
		row[-3] = row[-3].replace("\n", "<br>")
		# print(str(row))
		data.append(row)
		# time.sleep(1)
with open('kusogayoh_breakless.csv', 'w') as f:
	w = csv.writer(f, quoting=csv.QUOTE_ALL)
	w.writerow(data[0])
	[w.writerow(row) for row in data[1:]]
