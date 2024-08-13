#include <iostream>
#include <cstdint>
#include <vector>

void foo(const intptr_t* factorSizes) {
  std::cout << factorSizes[0] << std::endl;
  std::cout << factorSizes[1] << std::endl;
}

void foo1(const intptr_t* factorSizes) {
  std::cout << factorSizes[0] << std::endl;
  std::cout << factorSizes[1] << std::endl;
}

int main() {
  std::cout << "sizeof(int): " << sizeof(int) << std::endl;
  std::cout << "sizeof(long): " << sizeof(long) << std::endl;
  std::cout << "sizeof(long long): " << sizeof(long long) << std::endl;
  std::cout << "sizeof(int64_t): " << sizeof(int64_t) << std::endl;
  std::cout << "sizeof(intptr_t): " << sizeof(intptr_t) << std::endl;
  std::cout << "std::is_same_v<int64_t, intptr_t>: " << std::is_same_v<int64_t, intptr_t> << std::endl;
  std::cout << "std::is_same_v<int64_t, long>: " << std::is_same_v<int64_t, long> << std::endl;
  std::cout << "std::is_same_v<int64_t, long long>: " << std::is_same_v<int64_t, long long> << std::endl;
  std::cout << "std::is_same_v<intptr_t, long>: " << std::is_same_v<intptr_t, long> << std::endl;
  std::cout << "std::is_same_v<intptr_t, long>: " << std::is_same_v<intptr_t, long long> << std::endl;



//  std::vector<intptr_t> factorIndices;
//  factorIndices.push_back(123L);
//  factorIndices.push_back(456L);
//  foo(factorIndices.data());

//  std::vector<int64_t> factorIndices1;
//  factorIndices1.push_back(1230L);
//  factorIndices1.push_back(4560L);
//  foo1(static_cast<const intptr_t*>(factorIndices1.data()));


  return 0;
}

