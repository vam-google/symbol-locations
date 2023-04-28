#ifndef _ONE_H_
#define _ONE_H_

#include "two.h"

int a();
int sum();

class AClass : public BClass {
 private:
  int my_var_a;

 public:
  AClass(int v) : BClass(v), my_var_a(v) {}
  virtual ~AClass() {}

  virtual inline int b_method_inline() {
    return BClass::b_method_inline() + my_var_a + 1;
  }

  inline int b_method_inline_non_virtual() {
    return 111;
  }

  virtual int b_method();
};

#endif  // _ONE_H_
