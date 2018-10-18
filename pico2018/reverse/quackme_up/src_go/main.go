package main

import (
	"fmt"
	"math/bits"
)

func main() {
	var enc_flag = []byte("\x11\x80\x20\xe0\x22\x53\x72\xa1\x01\x41\x55\x20\xa0\xc0\x25\xe3\x35\x40\x55\x30\x85\x55\x70\x20\xc1")
	var rs = decrypt(enc_flag)
	var s = string(rs[:])
	fmt.Println(s)
}

func decrypt(buf []byte) []byte {
	var rs []byte
	var buf_len = len(buf)
	for i := 0; i < buf_len; i++ {
		var x = bits.RotateLeft8(buf[i], 8) ^ 0x16
		var y = bits.RotateLeft8(x, -4)
		rs = append(rs, y)
	}
	return rs
}
