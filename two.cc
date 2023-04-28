#include "two.h"

int b() {
  return 2;
}

int b_duplicate() {
  return 2;
}

BClass::BClass(int v) : my_var(v) {
}

int BClass::b_method() {
  return 2 + this->my_var;
}