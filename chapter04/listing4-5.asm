            option  casemap:none

nl          =       10
maxLen      =       256

            .const
titleStr    byte    "Listing 4-5"
prompt      byte    "Input a string: ", 0
fmtStr      byte    "%d: Hex value of char read: %x", nl, 0

            .data
bufPtr      qword   ?
bytesRead   qword   ?

            .code
            externdef   readLine: proc
            externdef   printf:proc
            externdef   malloc:proc
            externdef   free:proc

            public  getTitle
getTitle    proc
            lea     rax, titleStr
            ret
getTitle    endp

            public asmMain
asmMain     proc
            push    rbx
            sub     rsp, 48

            mov     rcx, maxLen
            call    malloc
            mov     bufPtr, rax

            ; Read a line of text from the user and place in the newlu allocated buffer
            lea     rcx, prompt
            call    printf

            mov     rcx, bufPtr
            mov     rdx, maxLen
            call    readLine
            cmp     rax, -1
            je      allDone
            mov     bytesRead, rax

            ; Now we are going to print each character line by line
            xor     rbx, rbx    ; We set the rbx to zero
display:    lea     rcx, fmtStr
            mov     rdx, rbx
            mov     r9, bufPtr
            mov     r8, [r9 + 1 * rbx]
            call    printf

            inc     rbx
            cmp     rbx, bytesRead
            jb      display


allDone:    mov     rcx, bufPtr
            call    free

            add     rsp, 48
            pop     rbx
            ret
asmMain     endp
            end