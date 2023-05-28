#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char **argv) {
  int parent2child[2], child2parent[2];

  pipe(parent2child);
  pipe(child2parent);

  char byte = 'A';

  int pid = fork();
  if (pid == 0) {
    close(parent2child[1]);
    read(parent2child[0], &byte, 1);
    close(parent2child[0]);
    printf("%d: received ping\n", getpid()); 

    close(child2parent[0]);
    write(child2parent[1], &byte, 1);
    close(child2parent[1]);
  } else if (pid > 0) {
    close(parent2child[0]);
    write(parent2child[1], &byte, 1);
    close(parent2child[1]);

    close(child2parent[1]);
    read(child2parent[0], &byte, 1);
    close(child2parent[0]);
    printf("%d: received pong\n", getpid());
  } else {
    fprintf(2, "oops, something went wrong!\n");
    exit(-1);
  }

  exit(0);
}
