            option      casemap:none

nl          =           10      ; ASCII code for newline
maxlen      =           256     ; Maximum string size + 1

            .data
titleStr    byte        "asm1-8.asm", 0
prompt      byte        "Enter a string: ", 0
fmtStr      byte        "User entered: %s", nl, 0


; The maxlen dup(?) operand tells masm to make "maxlen"
; duplicate copies of a byte, each of which is uninitialized
; input is the buffer of length maxlen .
; We will read the string into this buffer.
input       byte        maxlen dup (?)
            
            .code
            externdef   printf:proc
            externdef   readLine:proc

            public      getTitle
getTitle    PROC
            lea         rax,    titleStr ; RAX register holds the return value of the function
            ret
getTitle    ENDP

            public      asmFunc
asmFunc     PROC 
            sub         rsp,    56
            
            ; This print the prompt(Enter a string: )
            lea         rcx,    prompt
            call        printf
            ; Make sure the input string is zero terminated
            mov         input,  0
            ; Read from the stdin
            lea         rcx,    input
            mov         rdx,    maxlen
            call        readLine
            ; Print the string input by user
            lea         rcx,    fmtStr
            lea         rdx,    input
            call        printf
            add         rsp,    56
            ret                         ; Return to called
asmFunc     ENDP

END
