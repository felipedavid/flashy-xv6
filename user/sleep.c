#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char **argv) {
  if (argc != 2) {
    fprintf(2, "Usage: ./sleep <n_ticks>\n");
    exit(-1);
  }
  int n_ticks = atoi(argv[1]);
  sleep(n_ticks);
  exit(0);
}
