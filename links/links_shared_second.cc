#include <iostream>

#include "second.h"

int shared_usage() {
  std::cout << "second: " << second(3) << std::endl;
  return 0;
}
