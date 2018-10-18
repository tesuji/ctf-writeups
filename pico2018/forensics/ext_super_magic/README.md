# Ext Super Magic - Points: 250 - (Solves: 47)

We salvaged a ruined Ext SuperMagic II-class mech recently and pulled
the [filesystem][7] out of the black box.
It looks a bit corrupted, but maybe there's something interesting in there.
You can also find it in /problems/ext-super-magic_4_f196e59a80c3fdac37cc2f331692ef13
on the shell server.

## Hint

- Are there any [tools][1] for diagnosing corrupted filesystems? What do they say if you run them on this one?
- How does a linux machine know what [type][2] of file a [file][3] is?
- You might find this [doc][4] helpful.
- Be careful with [endianness][5] when making edits.
- Once you've fixed the corruption, you can use /sbin/[debugfs][6] to pull the flag file out.

[1]: https://en.wikipedia.org/wiki/Fsck
[2]: https://www.garykessler.net/library/file_sigs.html
[3]: https://linux.die.net/man/1/file
[4]: http://www.nongnu.org/ext2-doc/ext2.html
[5]: https://en.wikipedia.org/wiki/Endianness
[6]: https://linux.die.net/man/8/debugfs
[7]: https://2018shell2.picoctf.com/static/216c0a3d1c6517055035a3a95b78d9fe/ext-super-magic.img

---

Download another disk dump to compare:

```sh
wget https://github.com/ctfs/write-ups-2015/raw/master/opentoall-ctf-2015/forensics/gone/gone.img.tar.bz2
tar -xf gone.img.tar.bz2
xxd 1fdb86c25131bb3aa247bada29b29115.img > o
xxd ext-super-magic.img > p
```

Cut the header and compare

```sh
head -n100 o > a
head -n100 p > b
diff b a > diff.patch
```

Change `diff.patch` to name to `o` and `p` and apply patch:

```sh
patch < diff.patch
```

Reverse the patch `p`

```sh
xxd -r p > m.img
```

Fix and get all the file

```sh
% fsck.ext2 -v ./m.img
e2fsck 1.44.1 (24-Mar-2018)
ext2fs_check_desc: Corrupt group descriptor: bad block for block bitmap
fsck.ext2: Group descriptors look bad... trying backup blocks...
fsck.ext2: Attempt to read block from filesystem resulted in short read while using the backup blocksfsck.ext2: going back to original superblock
Superblock has an invalid journal (inode 8).
Clear<y>? yes
*** journal has been deleted ***

The filesystem size (according to the superblock) is 10240 blocks
The physical size of the device is 5120 blocks
Either the superblock or the partition table is likely to be corrupt!
Abort<y>? yes

m.img: ***** FILE SYSTEM WAS MODIFIED *****
% binwalk -e ./m.img
```

Or use `debugfs` to get the `flag.jpg`:

```sh
% printf 'dump <182> flag.jpg\nquit\n' | debugfs new.img
debugfs 1.44.1 (24-Mar-2018)
debugfs:  dump <182> flag.jpg
debugfs:  quit
```

Flag in flag.jpg

picoCTF{a7DB29eCf7dB9960f0A19Fdde9d00Af0}
