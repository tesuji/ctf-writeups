void vuln()
{
   char buf[BUFSIZE];
   memset(buf, 0, 0x20);
   system("echo input your message:");

   read(STDIN_FILENO, buf, 127);
   printf(buf);
   puts("");
   puts("Thanks for sending the message!");
}

int main(int argc, char **argv)
{
  setvbuf(stdout, NULL, _IONBF, 0);

  // Set the gid to the effective gid
  // this prevents /bin/sh from dropping the privileges
  gid_t gid = getegid();
  setresgid(gid, gid, gid);
  vuln();
  return 0;
}
