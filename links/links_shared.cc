#include <iostream>

#include "first.h"
#include "second.h"

int shared_usage() {
  std::cout << "first: " << first(5) << std::endl;
  std::cout << "second: " << second(3) << std::endl;

  return 0;
}
