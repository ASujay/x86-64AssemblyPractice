                    option  casemap:none

nl          =       10

            .data
i           qword   1
j           qword   123
k           qword   456789

titleStr    byte    "Listing 2-1", 0

fmtStr1     byte    "i=%d converted to hex=%x", nl, 0
fmtStr2     byte    "j=%d converted to hex=%x", nl, 0
fmtStr3     byte    "k=%d converted to hex=%x", nl, 0

            .code 
            externdef   printf:proc

            public  getTitle
getTitle    proc
            lea     rax,    titleStr
            ret
getTitle    endp

            public asmMain
asmMain     proc
            sub     rsp,    56
            
            lea     rcx,    fmtStr1
            mov     rdx,    i
            mov     r8,     rdx
            call    printf

            lea     rcx,    fmtStr2
            mov     rdx,    j
            mov     r8,     rdx
            call    printf

            lea     rcx,    fmtStr3
            mov     rdx,    k
            mov     r8,     rdx
            call    printf

            add     rsp,    56
            ret
asmMain     endp
            end