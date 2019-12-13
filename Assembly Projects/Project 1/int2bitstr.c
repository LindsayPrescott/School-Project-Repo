void int2bitstr(int I, char *str) {
	str[32] = '\0'; // This null terminates the string.
	int i=0; //Declaring and setting the index value.
	for(i=0; i<=32; i++) { //for loop to cycle through the bits of the integer.
		if(I & (1<<i)) { //Checks to see if the bit at spot i from the right is 1.  Returns true if the desired bit is 1, returns false if the desired bit is 0
			str[31-i] = '1'; //Sets the bit String array to 1 if the comparison returns true
		} //Ends the if statement
		else {//Tells us what to do if the statement returns false
			str[31-i] = '0';//Sets the bit String array to 0 if the comparison returns false
		}//Ends the else statement.
	}//Ends the for loop.
}//Ends the function definition.

int get_exp_value(float f) {
	unsigned f2u(float f);
	unsigned int ui = f2u(f);//This returns the unsigned integer 
	ui=ui<<1U;//Removes the Sign Bit
	ui=ui>>24U;//Removes the Fraction Bits
	if(ui==0) {//Tests the exponent bits to be "Denormalized"
		return -126;//Return to match the exponent value for denormalized values.
	}//Ends the if statement
	if(!(~ui)) {//Tests if the exponent bits are representing "Special" values (aka all 1's)
		return -128; //Return to match the desired output for special values
	}//Ends the if statement.
	return ui-127;//Return the exponent value for all normalized floating point numbers
}//Ends the function definition.
