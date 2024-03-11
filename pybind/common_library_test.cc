#include "first_library.h"
#include "second_library.h"

#include <iostream>
#include "gtest/gtest.h"


TEST(CommonLibraryTest, CommonLibraryTest) {
  std::cout << "1: first_func" << std::endl;
  EXPECT_EQ(first_func(1), 2);
  std::cout << "2: second_func" << std::endl;
  EXPECT_EQ(second_func(1), 2);
  std::cout << "4: first_func" << std::endl;
  EXPECT_EQ(first_func(1), 4);
  std::cout << "5: second_func" << std::endl;
  EXPECT_EQ(second_func(1), 4);
  std::cout << "7: second_global_func" << std::endl;
  EXPECT_EQ(second_global_func(), 1);
  std::cout << "8: second_global_func" << std::endl;
  EXPECT_EQ(second_global_func(), 1);
}

