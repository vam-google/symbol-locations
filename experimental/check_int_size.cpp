#include <iostream>
#include <cstdint>
#include <vector>

void foo(const intptr_t* factorSizes) {
  std::cout << factorSizes[0] << std::endl;
  std::cout << factorSizes[1] << std::endl;
}

int main() {
  std::cout << "sizeof(int): " << sizeof(int) << std::endl;
  std::cout << "sizeof(long): " << sizeof(long) << std::endl;
  std::cout << "sizeof(long long): " << sizeof(long long) << std::endl;
  std::cout << "sizeof(int64_t): " << sizeof(int64_t) << std::endl;
  std::cout << "sizeof(intptr_t): " << sizeof(intptr_t) << std::endl;

  std::vector<intptr_t> factorIndices;

  factorIndices.push_back(123L);
  factorIndices.push_back(456L);

  foo(factorIndices.data());

  return 0;
}

