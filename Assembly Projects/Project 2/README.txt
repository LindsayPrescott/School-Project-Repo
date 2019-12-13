This function will do three things:
1. Return j - i
2. Set *k = 5 * (*k);
 - It is NOT allowed to use any multiplication or division instructions.
3. Set *l = a[0] + a[1] + a[2] + a[3] + a[4];
 - You are not required to use conditional jumping for this task, but you may get
extra credits for using conditional jumping.
 - Note that, when you modify any callee-save register (%ebx, %esi, or
%edi), you need to save and restore its old value. 