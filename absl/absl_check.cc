#include "absl_check.h"
#include "absl/container/flat_hash_map.h"

int flat_hash_map_check(int val) {
  absl::flat_hash_map<std::string, int> map;
  map["one"] = val;
  return map["one"];
}