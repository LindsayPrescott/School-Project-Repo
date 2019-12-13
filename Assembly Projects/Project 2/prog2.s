.globl prog2

# your full name: Lindsay Prescott
# your LSU ID number: 895317904

prog2:
	pushl	%ebp					# Setup: Save old %ebp address
	movl	%esp, %ebp				# Setup: Move %ebp pointer to current %esp
	pushl	%ebx					# Setup: Store old %ebx value
	pushl	%esi					# Setup: Store old %esi value
	pushl	%edi					# Setup: Store old %ebi value
	movl	12(%ebp), %eax			# Store value j in register %eax
	subl	8(%ebp), %eax			# Subtract value i from value j and store in register %eax
	movl	16(%ebp), %ebx			# move the address for the k value into register %ebx
	movl	(%ebx), %esi			# get the k value stored at the address in %ebx and store it in %esi
	leal	(%esi, %esi, 4), %esi	# 5 * the k value stored in register %esi
	movl 	%esi, (%ebx)			# moves the 5 * k value back into the address where k was originally stored
	movl	20(%ebp), %ebx			# Retrieves the address for the first element in the array
	movl	$0, %esi				# Sets initial index value for the array
	movl	$0, %edi				# Resets %edi to 0

.L:
	addl	(%ebx, %esi, 4), %edi	# Adds element at index %esi to value %edi and stores at %edi
	addl	$1, %esi				# Increments index by 1
	cmpl	$5, %esi				# Compare index with 5
	jne		.L						# if index is not equal to 5, go to loop

	movl	24(%ebp), %esi			# Retrieves the address for l
	movl	%edi, (%esi)			# Stores sum of elements of array at l
	popl	%edi					# Finish: Restore old %edi value
	popl	%esi					# Finish: Restore old %esi value
	popl	%ebx					# Finish: Restore old %ebx value
	popl	%ebp					# Finish: Restore old %ebp address
	ret								# Finish: Return from the program
