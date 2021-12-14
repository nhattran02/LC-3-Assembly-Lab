# LC3-Assembly Problems

**Author: Tran Minh Nhat (HCM University of Technology)**

**Quiz 1**
Write a complete assembly language program that does the following:
- Enter two numbers (from 0 to 9) from the keyboard.

- Calculate the sum of these two numbers and print to the screen according to the syntax: "Tong cua hai so la: XX".
Where XX corresponds to the result.

- Save this result in 3 memory cells at address x4000, x4001, x4002 in order: number of first input
first, second input number, sum of 2 numbers.

```
.ORIG x3000
IN 
LD R1,ASCII_0 
NOT R1,R1
ADD R1,R1,#1
ADD R2,R0,R1 
IN
ADD R3,R0,R1 
ADD R4,R2,R3 
LD R0,DIA_CHI_LUU 
STR R2,R0,#0 
STR R3,R0,#1
STR R4,R0,#2
LEA R0,STROUT 
PUTS 
LD R1,ASCII_0
ADD R5,R4,#-10 
BRzp XUAT_2_CHU_SO
ADD R0,R4,R1 
OUT
BR KET_THUC
XUAT_2_CHU_SO ADD R0,R1,#1 
ADD R0,R5,R1 
OUT
KET_THUC HALT
ASCII_0 .FILL #48
DIA_CHI_LUU .FILL x4000
STROUT .STRINGZ "Tong cua hai so la:"
.END

```

***

**Quiz 2** Write a program to input 2 numbers (from 0 to 9) from the keyboard, calculate the difference of 2 numbers
this and print to the screen.

>*Instruction:* We see that the difference of two 1-digit numbers is definitely only 1-digit. However, 
this can be a negative number, so a branch statement is required. In case of negative numbers, we print
sign “-“, then convert the result to a positive number (2's complement) and print it to the screen.

```
.ORIG x3000
LD R4, ASCII_0M
IN
ADD R1, R0, R4
IN
ADD R2, R0, R4
NOT R3, R2
ADD R3, R3, #1  ;R3=-R2
LD R4, ASCII_0
ADD R5, R1, R3  ;R5=R1+R3=R1-R2
BRn NEGATIVE
ADD R0, R5, R4
OUT
BR KETTHUC
NEGATIVE
    LD R0, MINUS_SIGN
    OUT
    NOT R5, R5
    ADD R5, R5, #1
    ADD R0, R5, R4
    OUT
KETTHUC HALT
MINUS_SIGN  .FILL #45
ASCII_0     .FILL #48
ASCII_0M    .FILL #-48
.END

```

***

**Quiz 3** Write a program to input 2 numbers (from 0 to 9) from the keyboard, calculate the product of these two numbers
and print to the screen.

>*Instruction* There are 2 main algorithms that need to be implemented in this article:
>- Use iteration knowing the number of times to calculate the product of two numbers
>- Use an unknown number of iterations to split any number into two digits, tens and units

```
        .ORIG x3000
        LD R1, ASCII_0M
        IN 
        ADD R2, R0, R1  ;R2: FIRST NUM
        IN 
        ADD R3, R0, R1  ;R3: SECOND NUM

        ;CALCULATE
        AND R4, R4, #0  ;INITALIZE R4
LOOP    ADD R2, R2, #-1
        BRn TACH_SO
        ADD R4, R4, R3
        BR LOOP 

TACH_SO AND R2, R2, #0  ;INITALIZE R2
LOOP2   ADD R4, R4, #-10
        BRn NEXT
        ADD R2, R2, #1
        BR LOOP2
NEXT    ADD R3, R4, #10
        LD R1, ASCII_0
        ADD R2, R2, #0
        BRz DON_VI
        ADD R0, R2, R1
        OUT
DON_VI  ADD R0, R3, R1
        OUT
        HALT
ASCII_0     .FILL #48
ASCII_0M    .FILL #-48
.END
```

***

**Quiz 4** Compares two 1-digit numbers entered from the keyboard (entered a and b respectively)
- If a > b, then print to the screen: “A be hon B”
- If a < b, print to the screen: “A lon hon B”
- If a = b, print the screen: "Hai so bang nhau"

```
.ORIG x3000
LD R4, ASCII_0M
IN
ADD R1, R0, R4
IN
ADD R2, R0, R4
NOT R3, R2
ADD R3, R3, #1
ADD R5, R1, R3
BRn SMALLER
BRp GREATER
LEA R0, STR_OUT_3
BR PRINT
GREATER  LEA R0, STR_OUT_2
         BR PRINT
SMALLER  LEA R0, STR_OUT_1
PRINT    PUTS
STR_OUT_1 .STRINGZ "A be hon B"
STR_OUT_2 .STRINGZ "A lon hon B"
STR_OUT_3 .STRINGZ "Hai so bang nhau"
ASCII_0     .FILL #48
ASCII_0M     .FILL #-48

.END
```

***

**Quiz 5**
Expanding the ```Quiz 4```, print the maximum value, the minimum value of the 3 numbers obtained
input from the keyboard.

>*Instruction* Using a known iteration, it is possible to expand the number 3 by any number. Since comparisons are subtractions, they can be used directly without the need to convert from code ASCII to number. Functions of variables in the program:
>- R1: save the number of repetitions remaining
>- R2: store the minimum value
>- R3: store the maximum value

```
.ORIG x3000
;R1: save the number of repetitions remaining
;R2: store the minimum value
;R3: store the maximum value
LD R1, SO_LAN_LAP
LD R2, INIT_MIN
LD R3, INIT_MAX

LOOP1   IN
        NOT R4, R0
        ADD R4, R4, #1
        ADD R5, R2, R4
        BRnz NEXT1
        ADD R2, R0, #0
NEXT1   ADD R5, R3, R4
        BRzp    NEXT2
        ADD R3, R0, #0
NEXT2   ADD R1, R1, #-1
        BRp LOOP1
        LEA R0, STR_MIN
        PUTS
        ADD R0, R2, #0
        OUT
        LEA R0, STR_MAX
        PUTS
        ADD R0, R3, #0
        OUT
HALT
STR_MAX .STRINGZ "So lon nhat la: "
STR_MIN .STRINGZ "\nSo be nhat la: "
SO_LAN_LAP .FILL #3
INIT_MIN .FILL #57
INIT_MAX .FILL #48
.END
```

***

**Quiz 6** Enter a sequence of single-digit numbers from the keyboard, ending when the ```#``` character is entered.
Print to the screen the sum of the entered numbers (assuming that the sum of this sequence is less than 100).
Stores the numbers just entered into memory from the address ```x4000```, ending with the value ```"#"```. Indicates that the ASCII code of the character ```"#"``` is x23.

```
.ORIG x3000
LD R1,ASCII_#M
LD R2,ASCII_0M
LD R3,DIA_CHI_DAU
AND R4,R4,#0 
LAP IN
ADD R5,R0,R1
BRz NGUNG_LAP
ADD R5,R0,R2
STR R5,R3,#0 
ADD R3,R3,#1 
ADD R4,R4,R5 
BR LAP
NGUNG_LAP STR R0,R3,#0 
LEA R0,STR_OUT
PUTS
AND R2,R2,#0 
LAP2 ADD R4,R4,#-10
BRn TIEP
ADD R2,R2,#1 
BR LAP2
TIEP ADD R3,R4,#10 
LD R1,ASCII_0
ADD R2,R2,#0 
BRz XUAT_DON_VI
ADD R0,R2,R1
OUT
XUAT_DON_VI ADD R0,R3,R1
OUT
HALT
ASCII_0 .FILL #48 ;"0"
ASCII_0M .FILL #-48
ASCII_#M .FILL x-23 ;"#"
DIA_CHI_DAU .FILL x4000
STR_OUT .STRINGZ "Tong cua day so la: "
.END

```
---
>>>>>>>THE END 
---