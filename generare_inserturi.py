#open date.in for reading and replace every quote with nothing
#open date.out for writing


with open('date.in', 'r') as f:
    with open('date.out', 'w') as f1:
        for line in f:
            f1.write(line.replace('"', ''))