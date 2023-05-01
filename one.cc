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
  BClass* b = new BClass(0);
  BClass* a = new AClass(1);
  int v = b->b_method() + b->b_method_inline() + a->b_method() - a->b_method_inline();
  v = 1 - v + v + b->b_method_inline_non_virtual() - ((AClass*) a)->b_method_inline_non_virtual();
  v -= b->b_method_inline_non_virtual() - ((AClass*) a)->b_method_inline_non_virtual();
  delete b;
  delete a;
  return v;
}

int sum() {
  return a() + b() + c();
}
