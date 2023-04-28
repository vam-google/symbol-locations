#include "gtest/gtest.h"
#include "one.h"
#include "two.h"
#include "four.h"

TEST(OneTest, Sum) {
  EXPECT_EQ(sum(), 6);
}

TEST(OneTest, BDuplicate) {
  EXPECT_EQ(b_duplicate(), 3);
}

TEST(OneTest, staticallylinked) {
  EXPECT_EQ(staticallylinked(), EXTERN_TOKEN);
}

TEST(OneTest, inline_staticallylinked) {
  EXPECT_NE(inline_staticallylinked(), INLINE_TOKEN);
}

TEST(OneTest, BMethod) {
  BClass b(1);
  b.b_method();

  EXPECT_EQ(b.b_method(), 3);
  EXPECT_EQ(b.b_method_inline(), 23);
}

TEST(OneTest, AMethod) {
  AClass a(1);
  a.b_method();

  EXPECT_EQ(a.b_method(), 27);
  EXPECT_EQ(a.b_method_inline(), 25);

  EXPECT_EQ(a.b_method_inline_non_virtual(), 111);
}

TEST(OneTest, AMethodPointer) {
  BClass *a = new AClass(1);
  a->b_method();

  EXPECT_EQ(a->b_method(), 27);
  EXPECT_EQ(a->b_method_inline(), 25);
  EXPECT_EQ(a->b_method_inline_non_virtual(), 222);

  delete a;
}