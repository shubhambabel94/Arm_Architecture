; Final output is stored in register S8
; S10 contains final x value
	 AREA     neuralNetwork, CODE, READONLY
     EXPORT __main
	 IMPORT printMsg
     ENTRY 
__main  FUNCTION	
	 VLDR.F32 S1,=1     ; contains 1
	 VLDR.F32 S23,=0.5  ; used for containing threshold value
	 MOV R4, #1		   
	 MOV R5, #0
	 MOV R6, #0		    ;contains logic selection
	 BAL selection
	 
selection					; switch case 
		CMP R6,#0		;branch to AND operation 
		BEQ ANDOPERATION
		CMP R6,#1		;branch to OR operation
		BEQ OROPERATION
		CMP R6,#2		;branch to NOT operation
		BEQ NOTOPERATION
		CMP R6,#3		;branch to NAND operation
		BEQ NANDOPERATION
		CMP R6,#4		;branch to NOR operation
		BEQ NOROPERATION
		CMP R6,#5       ;branch to XOR operation 
		BEQ XOROPERATION
		CMP R6,#6		;branch to XNOR operation
		BEQ XNOROPERATION
	
ANDOPERATION
		VLDR.F32 S14,=-0.1  ; W1 - given in python code for AND gate
		VLDR.F32 S11,=0.2   ; W2
		VLDR.F32 S12,=0.2   ; W3
		VLDR.F32 S13,=-0.2  ; Bias
		CMP R5, #0
		BEQ input1
		CMP R5, #1
		BEQ input2
		CMP R5, #2
		BEQ input3
		CMP R5, #3
		BEQ input4
		
OROPERATION
		VLDR.F32 S14,=-0.1 ; W1 
		VLDR.F32 S11,=0.7 ; W2
		VLDR.F32 S12,=0.7 ; W3
		VLDR.F32 S13,=-0.1 ; Bias
		CMP R5, #0
		BEQ input1
		CMP R5, #1
		BEQ input2
		CMP R5, #2
		BEQ input3
		CMP R5, #3
		BEQ input4
		
NOTOPERATION
		VLDR.F32 S14,=0.5 ; W1 
		VLDR.F32 S11,=-0.7 ; W2
		VLDR.F32 S12,=0 ; W3
		VLDR.F32 S13,=0.1 ; Bias
		CMP R5, #0
		BEQ input1
		CMP R5, #1
		BEQ input2
		CMP R5, #2
		BEQ input3
		CMP R5, #3
		BEQ input4
		
NANDOPERATION
		VLDR.F32 S14,=0.6 ; W1 
		VLDR.F32 S11,=-0.8 ; W2
		VLDR.F32 S12,=-0.8 ; W3
		VLDR.F32 S13,=0.3 ; Bias
		CMP R5, #0
		BEQ input1
		CMP R5, #1
		BEQ input2
		CMP R5, #2
		BEQ input3
		CMP R5, #3
		BEQ input4
		
NOROPERATION
		VLDR.F32 S14,=0.5 ; W1 
		VLDR.F32 S11,=-0.7 ; W2
		VLDR.F32 S12,=-0.7 ; W3
		VLDR.F32 S13,=0.1 ; Bias
		CMP R5, #0
		BEQ input1
		CMP R5, #1
		BEQ input2
		CMP R5, #2
		BEQ input3
		CMP R5, #3
		BEQ input4
		
XOROPERATION		
		VLDR.F32 S14,=-5 ; W1 
		VLDR.F32 S11,=20 ; W2
		VLDR.F32 S12,=10 ; W3
		VLDR.F32 S13,=1 ; Bias
		CMP R5, #0
		BEQ input1
		CMP R5, #1
		BEQ input2
		CMP R5, #2
		BEQ input3
		CMP R5, #3
		BEQ input4

XNOROPERATION
		VLDR.F32 S14,=-5 ; W1 
		VLDR.F32 S11,=20 ; W2
		VLDR.F32 S12,=10 ; W3
		VLDR.F32 S13,=1 ; Bias
		CMP R5, #0
		BEQ input1
		CMP R5, #1
		BEQ input2
		CMP R5, #2
		BEQ input3
		CMP R5, #3
		BEQ input4	
	
input1    ; input values given i.e X1,X2,X3
		VLDR.F32 S15,=1 ; X1
		VLDR.F32 S16,=0 ; X2
		VLDR.F32 S17,=0 ; X3
		B OPERATION
		
input2    
		VLDR.F32 S15,=1 ; X1
		VLDR.F32 S16,=0 ; X2
		VLDR.F32 S17,=1 ; X3
		B OPERATION		
		
input3    
		VLDR.F32 S15,=1 ; X1
		VLDR.F32 S16,=1 ; X2
		VLDR.F32 S17,=0 ; X3
		B OPERATION
		
input4    
		VLDR.F32 S15,=1 ; X1
		VLDR.F32 S16,=1 ; X2
		VLDR.F32 S17,=1 ; X3
		B OPERATION
	
OPERATION
		VMUL.F32 S18,S15,S14 ; W1X1
		VMUL.F32 S19,S11,S16 ; W2X2
		VMUL.F32 S20,S12,S17 ; W3X3
		VADD.F32 S21,S19,S18 ; W1X1+W2X2
		VADD.F32 S21,S21,S20 ; W1X1+W2X2+W3X3
		VADD.F32 S21,S21,S13 ; final x is stored in S21
		VMOV.F32 S10, S21    
		BL EXPONENTIAL		          ; branch to calculate e^x
		
		VADD.F S22,S4,S1 ; (1+e^x)
		VDIV.F S6,S4,S22 ; sigmoid function i.e (e^x/(1+e^x)) value is stored in S6
		VMOV.F S8,S6       
		VCMP.F S6,S23
		vmrs APSR_nzcv,FPSCR
		BLT logic0
		BGT logic1
FINAL
        MOV R1,R6
	    VCVT.U32.F32 S16,S16
	    VMOV R2,S16
	    VCVT.U32.F32 S17,S17
	    VMOV R3,S17 	    
		BL printMsg  ; branch to print message
		ADD R5,R5,R4
		CMP R5,#4
		BNE selection
		MOV R5, #0
		ADD R6,R6,R4
		CMP R6,#5
		BNE selection
		BEQ STOP
		
		
logic0 LDR R0,= 0x00000000  
       B FINAL
	   
	   
	   
logic1 LDR R0,= 0x00000001
       B FINAL

				
EXPONENTIAL				;implementation of e^x
	   VMOV.F S7,S10
	   VMOV.F S9,S10 ;
	   LDR r8,= 0x00000001 ;
       
       VMOV.F S0,S10
	   LDR r1,= 0x00000030 ; no. of itterations	   
	   LDR r2,= 0x00000001 ; used for factorial  
	   VLDR.F S4,= 1      
       VLDR.F S5,= 1 ; used to store factorial result
	   
loop     
       VMOV.F S7,S9
       CMP r8,r2
	   BNE pow
loop2
       VMOV.F S0,S7
       VDIV.F S3,S0,S5
	   VADD.F S4,S4,S3
	   LDR r8,= 0x00000001 
	   ADD r2,#0x00000001
	   VMOV.F S2,r2
	   VCVT.F32.U32 S2,S2
	   VMUL.F S5,S5,S2 ; to calculate factorial
	   CMP r2,r1
       BNE loop
       BX lr
	  

      ; this loop finds x^n
pow     
       VMUL.F S7,S7,S9  
	   ADD r8,#0x00000001
	   CMP r8,r2
	   BNE pow
	   BEQ loop2
	   
STOP B STOP ; stop program
     ENDFUNC
     END