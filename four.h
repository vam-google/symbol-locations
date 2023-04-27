#ifndef _FOUR_H_
#define _FOUR_H_

extern const char EXTERN_TOKEN[];
const char INLINE_TOKEN[] = "find_me_in_hexdump_inline";

const char* staticallylinked();
const char* inline_staticallylinked();
#endif  // _FOUR_H_
