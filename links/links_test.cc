#include "gtest/gtest.h"
#include "first.h"
#include "second.h"

TEST(FirstTest, First) {
  EXPECT_EQ(first(2), 21);
}

TEST(SecondTest, Second) {
  EXPECT_EQ(second(2), 7);
}
