###wargames doc and notes?

for wargames the username dictates the level im trying to login

how to login with ssh
```shell
ssh {username}@{address} -p {port}
```

piping with grep to look for one specific file thats human readable
```shell
file ./* | grep ASCII
```

finding specific sizes (bytes wise)
the C is for byte, but it can be replaced with k, M, G for kilo, mega, giga
```shell
find ./* -size {byte value}c
```

finding a file that is 1033 bytes, 
that is not executable
run the file command
filter out items that are ASCII
```shell
find ./* -size 1033c ! -executable | xargs file | grep ASCII
```

find user bandit7 
size 33 bytes
group banidt 6
execute file on the path found
filter with ascii
the /* hits EVERYTHING in the server
```shell
find /* -user bandit7 -size 33c -group bandit6 | xargs file | grep ASCII
<!-- for more direct read -->
find /* -user bandit7 -size 33c -group bandit6 | xargs cat
```

finding a data.txt file
value is next to the word millionth
```shell
find *data.txt | xargs cat | grep millionth
```

sorting output
finding unique
```shell
cat data.txt | sort -f | uniq -u
```


string command apparently prints out printable characters
```shell
cat data.txt | strings | grep ==
```

base64 decode the output
```shell
cat data.txt | base64 --decode
```

translation or tr example
```shell
Gur cnffjbeq vf 5Gr8L4qetPEsPk8htqjhRK8XSP6x2RHh
cat data.txt | tr 'a-z' 'n-za-m' | tr 'A-Z' 'N-ZA-M'
<!-- first tr param will select range of items that gets translated -->
<!-- second tr param defines how it gets translated -->

cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
<!-- this also works as a solution -->
```





