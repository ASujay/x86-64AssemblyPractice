; Listing 4-2
; Pointer constant demonstration

            option  casemap:none

nl          =       10

            .const
titleStr    byte    "Listing 4-2", 0
fmtStr      byte    "pb's value is %ph", nl
            byte    "*pb's value is %d", nl, 0

            .data
b           byte    0
            byte    1, 2, 3, 4, 5, 6, 7

            ; Whenever we use pb, it just means that we are using the pointer to the addr(b) + 2
pb          textequ <offset b[2]>

            .code
            externdef   printf:proc

            public  getTitle
getTitle    proc    
            lea     rax, titleStr
            ret
getTitle    endp

            public  asmMain
asmMain     proc
            sub     rsp, 56

            lea     rcx, fmtStr
            mov     rdx, pb
            movzx   r8, byte ptr [rdx]
            call    printf

            add     rsp, 56 
            ret
asmMain     endp
            end

