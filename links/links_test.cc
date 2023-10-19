#include "gtest/gtest.h"
#include "first.h"
#include "second.h"

TEST(FirstTest, First) {
  EXPECT_EQ(first(1), 2);
}

TEST(SecondTest, Second) {
  EXPECT_EQ(second(1), 2);
}
