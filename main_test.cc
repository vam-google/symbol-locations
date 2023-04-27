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