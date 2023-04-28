#include "one.h"
#include "two.h"
#include "three.h"
#include "four.h"

int AClass::b_method() {
  return BClass::b_method() + my_var_a + BClass::b_method_inline();
}

int a() {
  staticallylinked();
  inline_staticallylinked();
  BClass b(0);
  int v = b.b_method() + b.b_method_inline();
  AClass a(1);
  return 1 + v - b.b_method() - b.b_method_inline();
}

int sum() {
  return a() + b() + c();
}
