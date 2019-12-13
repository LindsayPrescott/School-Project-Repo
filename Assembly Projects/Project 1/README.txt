1) For the function int2bitstr in which I is input and str is output, you need to store the
bit pattern of the 32-bit integer I in str as a 32-length string of 0s and 1s (remember that strings
are null-terminated so you should put a null character like str[32] = '\0'). The first
character in the string will be the most significant bit from I, and the last non-NULL character
will be the least significant. You must use bit-level operations to determine whether a character
should be a zero or one. The only allowed integer arithmetic is either increment (++) or
decrement (--) in the loop.
Forbidden operations for int2bitstr:
• Switch statements, function calls, and macro invocations.
• Addition, subtraction, division, modulus, and multiplication.
2) For the function get_exp_value in which f is input, you need to calculate and return the
exponent value of f. You may want to use the provided function f2u to get the bit pattern of f.
The bias of float (single precision) is 127, and you can return -128 for special values such as
infinity.
Forbidden operations for get_exp_value:
• Loops, switch statements, function calls (except unsigned f2u(float f)), and
macro invocations.
• Division, modulus, and multiplication. You can use subtraction. 
• Relative comparison operators (<, >, <=, and >=). You can use Equality (==) and
inequality (!=) tests