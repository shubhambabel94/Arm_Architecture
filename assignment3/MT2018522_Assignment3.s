;The program calculates the logic value according to the given inputs 
;sigmoid value is also calculated in reg S9
;final logic output is printed on print viewer window

	area     NEURALN, CODE, READONLY
       IMPORT printMsg1
	   EXPORT __main
       ENTRY 
__main  FUNCTION		 
        MOV R5, #20 	   ;No. of itterations
        MOV R6 , #1		   ;counter
        VLDR.F32 S0,=1 	   ;initial 1 and result
		VLDR.F32 S1,=1     ;intermediate vals
        ;VLDR.F32 S2,=5    ;holding x 
		VLDR.F32 S3,=1     ;to calculate factorial 
		VLDR.F32 S5,=1
		VLDR.F32 S6,=1     ;intermediate val
		VLDR.F32 S7,=1		; hold 1 always
        VLDR.F32 S8,=1		;hold 1+ exp(x)
		VLDR.F32 S9,=1		; result of sigmoid fn
		MOV R4, #2		;This is for which logic u want to immplement
		BAL options
		
options					; switch-case equivalent
		CMP R4,#0		;branch to and operation 
		BEQ logicand
		CMP R4,#1		;branch to or operation
		BEQ logicor
		CMP R4,#2		;branch to not operation
		BEQ logicnot
		CMP R4,#3		;branch to nand operation
		BEQ logicnand
		CMP R4,#4		;branch to nor operation
		BEQ logicnor
		CMP R4,#5       ;branch to xor operation 
		BEQ logicxor
		CMP R4,#6		;branch to xnor operation
		BEQ logicxnor
		

epowerx 
       
	    CMP R5, R6;			; when counter R1 becomes equal to R2(No. of itterations) then stops
		beq sigmoid 
		;VADD.F32 s0,s0,s2
		B numerator			
        
		
				
numerator 
        VMUL.F32 S1,S1,S2	; t = t*x
        B denominator 

		
denominator					; calculate factorial value or denominator of exponential series
        
		VMOV.F32 S4, R6;
		VCVT.F32.U32 S4,S4	;Convertion of TRUE Value of a  number to IEEE FP standards and back to TRUE value.
		VMUL.F32 S5,S5,S4;		
		ADD R6,R6,#1
		B divide

divide 
        VDIV.F32 S6,S1,S5	; divide numerator and denominator
		VADD.F32 S0,S0,S6
        B epowerx			; branch back to epowerx for next itteration
		
		
sigmoid
		VADD.F32 S8,S0,S7
		VDIV.F32 S9,S0,S8
		B result
		
		
		
	
result
		VLDR.F32 S21, =0.5
		VCMP.F32 S9, S21
		VMRS APSR_NZCV, FPSCR
		MOVGT R0, #1
		MOVLT R0, #0
		;MOV R0, R1 
		BL printMsg1
		B stop
		
logicand
		VLDR.F32 S10,=-0.1
		VLDR.F32 S11,=0.2
		VLDR.F32 S12,=0.2
		VLDR.F32 S13,=-0.2
		B	dataset
		
logicor
		VLDR.F32 S10,=-0.1
		VLDR.F32 S11,=0.7
		VLDR.F32 S12,=0.7
		VLDR.F32 S13,=-0.1
		B	dataset
		
logicnot
		VLDR.F32 S10,=0.5
		VLDR.F32 S11,=-0.7
		VLDR.F32 S12,=0
		VLDR.F32 S13,=0.1
		B	dataset
		
logicnand
		VLDR.F32 S10,=0.6
		VLDR.F32 S11,=-0.8
		VLDR.F32 S12,=-0.8
		VLDR.F32 S13,=0.3
		B	dataset
		
logicnor
		VLDR.F32 S10,=0.5
		VLDR.F32 S11,=-0.7
		VLDR.F32 S12,=-0.7
		VLDR.F32 S13,=0.1
		B  	dataset
		
logicxor		
		VLDR.F32 S10,=-5
		VLDR.F32 S11,=20
		VLDR.F32 S12,=10
		VLDR.F32 S13,=1
		B	dataset

logicxnor
		VLDR.F32 S10,=-5
		VLDR.F32 S11,=20
		VLDR.F32 S12,=10
		VLDR.F32 S13,=1
		B	dataset
		
dataset
		VLDR.F32 S14,=1
		VLDR.F32 S15,=0
		VLDR.F32 S16,=0
		B computation
		
computation
		VMUL.F32 S17,S10,S14;
		VMUL.F32 S18,S11,S15;
		VMUL.F32 S19,S12,S16;
		VADD.F32 S20,S17,S18
		VADD.F32 S20,S20,S19
		VADD.F32 S20,S20,S13      ;now x is ready
		VMOV.F32 S2, S20;
		B epowerx
		

stop B stop ; stop program
     ENDFUNC
     END