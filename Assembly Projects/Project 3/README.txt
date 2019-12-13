This function will check whether the given cache stores the data at the given memory address. If
the cache stores the data at the given memory address (i.e., cache hit), this function will return
the stored data. Otherwise (i.e., cache miss), this function will return 0xFF. Here are important
assumptions about the function.
- Memory addresses are 8 bits wide (m=8). Therefore, we use unsigned char to store
memory addresses.
- Memory accesses are to 1-byte words (not to 4-byte words). Therefore, the return type of
the function is unsigned char.
- The cache is directed-mapped (E=1), with a 4-byte block size (B=4) and four sets (S=4).
- A cache line is defined using struct as follows. valid can store only 0 or 1. If the
number of tag bits (i.e., t) is less than 8 bits (the size of char), t low-order bits of tag
will be used to store the tag bits, and the unused bits will be zero.
typedef struct {
 char valid;
 char tag;
 char block[4];
} line;
- Cache blocks do not store byte data 0xFF because it is used for indicating cache miss in
this function.