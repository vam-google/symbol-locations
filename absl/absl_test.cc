#include <iostream>
#include "gtest/gtest.h"
#include "absl/absl_check.h"
#include "absl/container/flat_hash_map.h"

TEST(AbslTest, AbslTest) {
  std::cout << "AbslTest START" << std::endl;
  EXPECT_EQ(17, flat_hash_map_check(17));

  std::cout << "AbslTest 1" << std::endl;
  absl::flat_hash_map<std::string, int> map;
  std::cout << "AbslTest 2" << std::endl;
  map["one"] = 18;
  std::cout << "AbslTest 3" << std::endl;
  EXPECT_EQ(18, map["one"]);
  std::cout << "AbslTest 4" << std::endl;

  std::cout << "AbslTest END" << std::endl;
}

