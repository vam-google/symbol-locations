#include "one.h"
#include "two.h"
#include "three.h"
#include "four.h"

int a() {
  staticallylinked();
  inline_staticallylinked();
  return 1;
}

int sum() {
  return a() + b() + c();
}
