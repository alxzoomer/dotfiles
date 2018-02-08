# Replace arrays to file load

```sh
declare -a array1
# Load file as array. New line and spaces will separate array elements
array1=( `sed -e 's/#.*$//' -e '/^$/d' $inputFile | tr '\n' ' '`)
echo ${array1[@]}
```