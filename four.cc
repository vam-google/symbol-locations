#include "four.h"

const char EXTERN_TOKEN[] = "find_me_in_hexdump";

const char* staticallylinked() {
  return EXTERN_TOKEN;
}

const char* inline_staticallylinked() {
  return INLINE_TOKEN;
}