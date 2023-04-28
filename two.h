#ifndef _TWO_H_
#define _TWO_H_

int b();
int b_duplicate();

class BClass {
 private:
  int my_var;

 public:
  BClass(int v);
  virtual ~BClass() {}

  virtual inline int b_method_inline() {
    return 22 + my_var;
  }

  inline int b_method_inline_non_virtual() {
    return 222;
  }

  virtual int b_method();
};

#endif  // _TWO_H_
