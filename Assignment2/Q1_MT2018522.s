  area     exponentialSeries, CODE, READONLY
       EXPORT __main
       ENTRY 
__main  FUNCTION		 
        MOV R0, #20 	   ;No. of itterations
        MOV R1 , #1		   ;counter
        VLDR.F32 S0,=1 	   ;initial 1 and result
		VLDR.F32 S1,=1     ;intermediate vals
        VLDR.F32 S2,=19    ;holding x 
		VLDR.F32 S3,=1     ;to calculate factorial 
		VLDR.F32 S5,=1
		VLDR.F32 S6,=1     ;intermediate val
		BAL epowerx

epowerx 
       
	    CMP R0, R1;			; when counter R1 becomes equal to R0(No. of itterations) then stops
		beq stop 
		;VADD.F32 s0,s0,s2
		B numerator			
        
		
				
numerator 
        VMUL.F32 S1,S1,S2	; t = t*x
        B denominator 

		
denominator					; calculate factorial value or denominator of exponential series
        
		VMOV.F32 S4, R1;
		VCVT.F32.U32 S4,S4
		VMUL.F32 S5,S5,S4;		
		ADD R1,R1,#1
		B divide

divide 
        VDIV.F32 S6,S1,S5	; divide numerator and denominator
		VADD.F32 s0,s0,s6
        B epowerx			; branch back to epowerx for next itteration

stop B stop ; stop program
     ENDFUNC
     END