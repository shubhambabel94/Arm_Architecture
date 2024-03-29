;this program calculates the value of tanx 
;as tanx=sinx/cosx so I have calculated sinx in s0 reg and cosx in s13 reg
;final result tanx value will be stored in s14 reg 
;give value of angle in raddians
  
  area     tanx, CODE, READONLY
       EXPORT __main
       ENTRY 
__main  FUNCTION		 
        MOV R0, #13		;No. of itterations
		MOV R10, #2
        MOV R1 , #1		   		  ;for sin counter
		MOV R2 , #1				  ;for cos counter
		MOV R5 , #1
		
		;MOV R8 , #1              ; stores factorial 
		MOV R9 , #1 
        VLDR.F32 S0,=4.1867 ; result of sinx
		VLDR.F32 S1,=4.1867  ;holding x and intermediate vals
        VLDR.F32 S2,=4.1867 ;holding x 
		
		VLDR.F32 S6,=1		
		VLDR.F32 S7,=-2.355
		VLDR.F32 S13,=1
		
		VLDR.F32 S17,=0
		VLDR.F32 S5,=0
		VLDR.F32 S15,=1
		VLDR.F32 S16,=2
		
		;VLDR.F32 S11,=2
		MOV R12 , #2 
		
		
		VLDR.F32 S3,=1       		;to calculate factorial 
		
		VLDR.F32 S6,=1 				 ;intermediate val
		B sinx

sinx    					
		CMP R0, R1;
		beq cosx 
		ADD R9, R9,#2 
		B numerator
		

evenodd		
	   ; MOV R0, #7        ; Number to be check for even or odd R5
	    MOV R5, R10
        MOV R3, #2		   ; temperory reg to store 2
        udiv R6, R5, R3    ; udiv and mls instruction are used to perform modulus operation  
        MLS R6,R6, R3, R5  ; mod value stored in R6 it is either 0 or 1 since div by 2 
		CMP R6, #0         ; compared with 0
		BEQ subt
		BNE addition

fact
		MOV R8 , #1         ; for factorial
		B factorial
		
		
factorial					; to calculate factorial for denominator
		
		MUL R8, R8, R7		;fact = fact* no.
		SUB R7, R7, #1		;no.= no.-1
		CMP R7, #0
		BGT factorial
        BLE divide 			; branch to divide

numerator 								; to prefor numerator of sin series
		VMUL.F32 S1,S1,S2;  t = t*x
		VMUL.F32 S1,S1,S2;
		B denominator					; branch to denominator of sin
		
denominator						; to calculate denominator of sine series
		MOV R7, R9
		B fact					; branch to calculate factorial
		
divide							; divide numerator and denominator of sine series
		 VMOV.F32 S3, R8;		
		 VCVT.F32.U32 S3,S3
		 VDIV.F32 S4,S1,S3		; sine value is calculated in s4 reg
		; VADD.F32 s0,s0,s4
		 ADD R1,R1,#1
		 B evenodd 
		 
addition 						; this block is for alternate addition and subtraction in sine series
		 VADD.F32 s0,s0,s4
		 ADD R10, #1
		 B sinx					;branch back to sin for next itteration
		 
subt
		VSUB.F32 s0,s0,s4
		ADD R10, #1
		B sinx					;branch back to sin for next itteration
		
		
		

cosx							; to calculate COS
		CMP R0, R2;				; for no. of itteration
		beq tan 				; branch to calculate tanx
		VADD.F32 S5,S16; 
		B numeratorcos			; branch to calculate numerator of cosx
		
numeratorcos					; to calculater numerator of cos series
		VMUL.F32 S6,S6,S7;  t = t*x
		VMUL.F32 S6,S6,S7;
		B denominatorcos
		
denominatorcos					; to calculate denominator of cos series
		VMOV.F32 S8, S5;
		B factcos
		
factcos
		VMOV.F32 S9, S15;        ; for factorial
		B factorialcos
		

factorialcos		
		VMUL.F32 S9,S9,S8
		VSUB.F32 S8, S8, S15
		VMOV.F32 R11, S8
		CMP R11,#0    ;VCMP.F32 S8, #0.0
		BGT factorialcos
        BLE dividecos

dividecos						; to finally divide numerator and denominator of cos
		VDIV.F32 S10,S6,S9
		ADD R2,R2,#1
		B evenoddcos 

evenoddcos						
	    MOV R5, R12
		;VCVT.F32.U32 S3,S3
        MOV R3, #2		   ; temperory reg to store 2
        udiv R6, R5, R3    ; udiv and mls instruction are used to perform modulus operation  
        MLS R6,R6, R3, R5  ; mod value stored in R1 it is either 0 or 1 since div by 2 
		CMP R6, #0         ; compared with 0  
		BEQ subtcos
		BNE additioncos

subtcos								;this block is for alternate addition and subtraction in cos series
		VSUB.F32 s13,s13,s10
		;VADD.F32 S11, S15
		ADD R12, #1
		B cosx
		
additioncos		
		 VADD.F32 s13,s13,s10
		 ;VADD.F32 S11, S15
		 ADD R12, #1
		 B cosx
		 
		 
tan								; to calculate tan value as tanx = sinx/cosx
	VDIV.F32 S14,S0,S13
	CMP R0, R2;
	beq stop 


stop B stop ; stop program
     ENDFUNC
     END
