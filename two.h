#ifndef _TWO_H_
#define _TWO_H_

int b();
int b_duplicate();

class BClass {
 public:
  BClass() {
  }

  int b_method_inline() {
    return 2;
  }

  int b_method();
};

#endif  // _TWO_H_
