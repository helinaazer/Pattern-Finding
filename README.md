# Pattern-Finding
A program in 68k assembly language that accepts a one-byte value from the user and stores it.

The program starts at the memory location $1000.
It accepts a one-byte value from the user and saves that value into a Byte variable called oneByte(not hardcoded).
Written using a loops that reads each byte of data between $6000 an $8000 inclusive and compares it with oneByte.

A longword variable called foundAt is defined. The program searches the memory from $6000 to $8000 inclusive.
If a byte equal to oneByte is found, store the match address into foundAt. If a match is not found, then foundAt is set to $6000.
A word variable called sum is defined. The pogram adds the bytes stored in the 512 consecutive memory locations beginning at foundAt. The sum value should get stored into sum.

If the sum exceeds $FFFF(an overflow occurs), store the carry bit into a Byte variable called carryBit.

The program should print oneByte, foundAt, sum, and carryBit in the output window.
