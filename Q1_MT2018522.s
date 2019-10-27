 area fibseries, CODE, READONLY
       EXPORT __main
       ENTRY 
__main  FUNCTION		 
        mov r5, #8         ; counter = 10, Compute fibonacci(8) 
        mov r1, #0         ; fibonacci(0) = 0 
        mov r2, #1         ; fibonacci(1) = 1 
		
fibonacci
        add r3, r1, r2    ; fibonacci(n) = fibonacci(n-1) + fibonacci(n-2) 
        mov r1, r2        ; fibonacci(n-1) = fibonacci(n-2) 
        mov r2, r3        ; fibonacci(n-2) = fibonacci(n)   
        subs r5, r5, #1   ;  decrementing counter valuue by 1
        beq end           ; If 'Z' flag is set, branch to 'end' 
        bal fibonacci           ; Branch always to 'fibonacci' label
		
end
        mov r0, r3        ; Final result is in R3 
        
stop B stop ; stop program
     ENDFUNC
     END	
		 
		
       



