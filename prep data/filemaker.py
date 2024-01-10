import os

components = []
with open('Components.txt', 'r') as f:
    data = str(f.read())
    print(data)
for i in data.split('\n'):
    print(i)
    with open(f'{i}.fx', 'w') as nf:
        nf.close()
f.close()