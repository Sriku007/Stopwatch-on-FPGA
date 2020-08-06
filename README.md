# Stopwatch-on-FPGA
Implementation of a Stopwatch on Basys FPGA

Members: P.SURYA SRIKAR, KARTIKAEYA KUMAR, D.SAI CHETHAN

STOPWATCH CONTROLLER:
The objective of this project is to design digital logic for general purpose stopwatch and implement it on FPGA .

OVERVIEW:
A 4 digit 7segment display is used for the output , 16 slide switches are used to load the data , and 2 push button switches are used to give the following command :

load ( push button switch 1 )

Start ( push button switch 2 )

Stop ( push button switch 2 )

Reset ( push button switch 1 )

LOAD :- load command is given to load the data from the slide switches .

Slide Switches :-
16 Slide switches are used to load the 4 vectors AB:CD .

START :- If the load is 00:00 then it will work as a Stopwatch and start counting else it will work as a Timer and start down counting .

STOP :-
while pressing the corresponding push button switch it will stop the counting and and the output on the 4Digit 7 segment display freezes .

RESET :-
It will reset the counter to the load at that instant .
