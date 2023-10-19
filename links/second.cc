#include "second.h"

static int my_global = 0;

int second(int x) {
  return x + my_global++;;
}