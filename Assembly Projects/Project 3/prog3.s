# Lindsay Prescott
# 895317904

.global check_cache

check_cache:
	pushl	%ebp					# Setup: Save old %ebp address
	movl	%esp, %ebp				# Setup: Move %ebp pointer to current %esp
	pushl	%ebx					# Setup: Store old %ebx value
	pushl	%esi					# Setup: Store old %esi value
	pushl	%edi					# Setup: Store old %ebi value

	movl	8(%ebp), %edx			# Retrieve Cache Line array starting memory address
	movb	12(%ebp), %ah			# Retrieve Address

	movb	%ah, %bh				# Copy address to register %bh
	shrb	$4, %bh					# Retrieve the tag bits by using a logical right shift by 4 bits
	movb	%ah, %bl				# Copy address to register %bl
	shrb	$2, %bl					# Shift right by 2 bits
	andb	$0x03, %bl				# Retrieve the set index bits
	movzbl	%bl, %esi				# Convert 1 byte size set index bits to 4 byte size
	movl	$6, %edi				# Set initial value of %edi to 6
	imull	%esi, %edi				# Retrieve the offset value for the cache block
	movb	1(%edi, %edx), %bl		# Retrieve the tag byte
	andb	$0x03, %bl				# Retrieve the set index bits
	cmpb	%bl, %bh				# Compare tag bits from cache block to tag bits of address
	jne		.M						# If tag bits do not match, jump to Cache Miss
	movb	(%edi, %edx), %bl		# Retrieve the valid byte
	cmpb	$0x1, %bl				# Compare if cache block is valid
	jne		.M						# If not valid, jump to Cache Miss
	
	movb	%ah, %bl				# Copy address to register %bl
	andb	$0x3, %bl				# Retrieve the block offset bits
	movzbl	%bl, %esi				# Convert 1 byte size block offset bits to 4 byte size
	addl	%esi, %edi				# get block offset for cache block
	movb	2(%edi, %edx), %al		# Get the cached data
	movb	$0x0, %ah				# Zero out %ah
	jmp		.E						# Jump to the end of the program.

.M:	movl	$0xFF, %eax				# Set return value for Cache Miss

.E:	popl	%edi					# Finish: Restore old %edi value
	popl	%esi					# Finish: Restore old %esi value
	popl	%ebx					# Finish: Restore old %ebx value
	popl	%ebp					# Finish: Restore old %ebp address
        ret
