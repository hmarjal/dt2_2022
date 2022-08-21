sed -e 's/^[ \t]*//' -e 's/[[:space:]]*$//' < $1 | gawk -F '[ \t,]*' -f input/asm.awk  > input/machinecode.inc
cat input/machinecode.inc
