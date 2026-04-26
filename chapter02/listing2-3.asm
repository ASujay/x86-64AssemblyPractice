            option  casemap:none
nl          =       10
maxLen      =       256

            .data
titleStr    byte    "Listing 2-30", 0

prompt1     byte    "Enter an integer between 0 and 127: ", 0
fmtStr1     byte    "Value in hexadecimal: %x", nl, 0
fmtStr2     byte    "Invert all the bts (hexadecimal): %x", nl, 0
fmtStr3     byte    "Add 1 (hexadecimal): %x", nl, 0
fmtStr4     byte    "Output as signed integer: %d", nl, 0
fmtStr5     byte    "Using neg as instruction: %d", nl, 0

intValue    sqword  ?
input       byte    maxLen  dup (?)

            .code
            externdef   printf:proc
            externdef   readLine:proc
            externdef   atoi:proc

            public      getTitle
getTitle    proc
            lea     rax,    titleStr
            ret
getTitle    endp

            public      asmMain
asmMain     proc
            sub     rsp,    56

            lea     rcx,    prompt1
            call    printf

            ; call readLine
            lea     rcx,    input
            mov     rdx,    maxLen
            call    readLine

            ; call atoi
            lea     rcx,    input
            call    atoi
            and     rax,    0ffh        ; we are only interested in the lower 8 bits
            mov     intValue,  rax

            lea     rcx,    fmtStr1
            mov     rdx,    intValue
            call    printf

            lea     rcx,    fmtStr2
            mov     rdx,    intValue
            not     rdx
            and     rdx,    0ffh
            call    printf

            lea     rcx,    fmtStr3
            mov     rdx,    intValue
            add     rdx,    1
            call    printf

            lea     rcx,    fmtStr4
            mov     rdx,    intValue
            not     rdx
            add     rdx,    1
            call    printf

            ; negate using neg instruction
            lea     rcx,    fmtStr5
            mov     rdx,    intValue
            neg     rdx
            call    printf

            add     rsp,    56
            ret
asmMain     endp
            
            end