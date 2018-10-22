#include <stdio.h>

struct linked_list
{
  struct linked_list *next;
  char                buffer[15];
};


int main(int argc, char const *argv[])
{
  setvbuf(stdout, NULL, 2, 0);
  setvbuf(stdin, NULL, 2, 0);

  puts("");
  nononode();
  return 0;
}

void nononode()
{
  struct linked_list node1; // @ rbp-0x20
  struct linked_list node2; // @ rbp-0x40
  node1.next = &node1;

  puts("");

  readline(node1.buffer, 15);

  puts("");

  readline(node2.buffer, 15);

  puts("");
  printNode(&node1);

  goodbye();
}

void readline(char *s, size_t len)
{
  size_t n;
  char *line = NULL;
  getline(&line, &n, stdin);

  strncpy(s, line, len);
}

void printNode(struct linked_list *node)
{
  printf("node.next: %p\nnode.buffer: %s\n", node->next, node->buffer);
}

void goodbye()
{
  puts("What are your initials?");
  char line[3];
  fgets(line, 0x20, stdin); // error
  printf("%s\n", line);
}
