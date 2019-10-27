  area  myfirst, CODE, READONLY
       EXPORT __main
       ENTRY 
__main  FUNCTION		 
        MOV R0, #6         ; Number to be check for even or odd
        MOV R3, #2		   ; temperory reg to store 2
        udiv R1, R0, R3    ; udiv and mls instruction are used to perform modulus operation  
        MLS R1,R1, R3, R0  ; mod value stored in R1 it is either 0 or 1 since div by 2 
		CMP R1, #0         ; compared with 0
		ITE EQ             ; if then else loop  
	    MOVEQ R2, #0       ; if r1 contains 0 means even no. so flag is set as r2=0  
        MOVNE R2, #1	   ; if odd no. then r2=1
stop B stop ; stop program  
     ENDFUNC
     END
