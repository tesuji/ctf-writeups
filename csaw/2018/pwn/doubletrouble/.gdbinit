# break after inputing double array
break *0x08049620
# break after finding and increasing array size
break *0x08049702
# break after sorting array
break *0x0804973b

continue
printf "============ frame info of game func ============\n"
info frame
printf "\n"

printf "============ Our array in stack ============\n"
set $arr = (double *)($ebp - 0x210)
set $arr_size_ptr = (int *)($ebp - 0x21c)
x/70xg $arr
printf "\n"

printf "============ First 8 double in array ============\n"
x/8fg $arr
printf "\n"

printf "============ Canary ============\n"
x/xw $ebp - 0xc
printf "\n"

printf "============ Double from canary pass eip ============\n"
x/4fg $ebp - 0x10
printf "\n"

continue
printf "============ New array size ============\n"
x/dw $arr_size_ptr
printf "\n"

continue
printf "============ After sorting ============\n"
x/70xg $arr
printf "\n"

continue
