import csv

with open('/var/cache/fetch/search/packages-split.csv', 'r') as f:
    csv_reader = csv.reader(f, delimiter=',')
    for line in csv_reader:
        print(', '.join(line))
