# Buttons - Points: 250 - (Solves: 768)

 We found a hidden flag server hiding behind a proxy,
 but the proxy has some... _interesting_ ideas of what
 qualifies someone to make HTTP requests.
 Looks like you'll have to do this one by hand.
 Try connecting via nc 2018shell2.picoctf.com 16047,
 and use the proxy to send HTTP requests to `flag.local`.
 We've also recovered a username and a password for you to
 use on the login page: `realbusinessuser`/`potoooooooo`.


## Hint

_Be the browser._ When you navigate to a page, how does your browser send HTTP requests? How does this change when you submit a form?

---

Server shell

```sh
POST /flag.local HTTP/1.1
Host: 2018shell2.picoctf.com:16047
Referer: http://2018shell2.picoctf.com:22430/
Content-Type: application/x-www-form-urlencoded
Content-Length: 27
Connection: keep-alive

username=realbusinessuser&password=potoooooooo

```
