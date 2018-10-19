# Aca-Shell-A - Points: 150 - (Solves: 250)

It's never a bad idea to brush up on those linux skills or
even learn some new ones before you set off on this adventure!
Connect with
nc 2018shell2.picoctf.com 6903.

---

```sh
nc 2018shell2.picoctf.com 6903
```

```sh
ls -l
cd secret
ls -l
rm intel_1
rm intel_2
rm intel_3
rm intel_4
rm intel_5
echo 'Drop it in!'
cd

cd executables
./dontLookHere

whoami

cd
cp /tmp/TopSecret passwords

cd passwords
cat TopSecret
/passwords$ cat TopSecret
Major General John M. Schofield's graduation address to the graduating class of 1879 at West Point is as follows: The discipline which makes the soldiers of a free country reliable in battle is not to be gained by harsh or tyrannical treatment.On the contrary, such treatment is far more likely to destroy than to make an army.It is possible to impart instruction and give commands in such a manner and such a tone of voice as to inspire in the soldier no feeling butan intense desire to obey, while the opposite manner and tone of voice cannot fail to excite strong resentment and a desire to disobey.The one mode or other of dealing with subordinates springs from a corresponding spirit in the breast of the commander.He who feels the respect which is due to others, cannot fail to inspire in them respect for himself, while he who feels,and hence manifests disrespect towards others, especially his subordinates, cannot fail to inspire hatred against himself.
picoCTF{CrUsHeD_It_dddcec58}
```
