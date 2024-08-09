#include <iostream>
#include <cstdint>

int main() {
  std::cout << "sizeof(int): " << sizeof(int) << std::endl;
  std::cout << "sizeof(long): " << sizeof(long) << std::endl;
  std::cout << "sizeof(long long): " << sizeof(long long) << std::endl;
  std::cout << "sizeof(int64_t): " << sizeof(int64_t) << std::endl;
  std::cout << "sizeof(intptr_t): " << sizeof(intptr_t) << std::endl;

  return 0;
}