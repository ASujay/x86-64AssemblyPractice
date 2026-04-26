                option casemap:none
nl          =   10
maxLen      =   256
true        =   1
false       =   0
bool            typedef ptr byte
                .const
titleStr        byte    "Listing 4-7", 0
fmtStr          byte    "Sortme[%d] = %d", nl, 0

                .data
sortMe          label   dword
                dword   1,  2,  16, 14
                dword   3,  9,  4,  10
                dword   5,  7,  15, 12
                dword   8,  6,  11, 13
sortSize    =   ($ - sortMe) / sizeof dword
; didSwap - a boolean that indicates that swap occurred in the last loop iteration
didSwap         bool    false

                .code
                externdef   printf:proc

; sort(dword *array, qword count);
; array - address passed in rcx
; count - element count passed in RDX.
sort            proc
                push    rax     ; In pure assmebly language
                push    rbx     ; it is a good idea to 
                push    rcx     ; preserve all the registers tha we are going to modify
                push    rdx     ;
                push    r8

                ; we need the final index to iterate
                dec     rdx     ; this give us numElements - 1

; Outer loop
outer:          mov     didSwap, false
                xor     rbx, rbx        ; this will be our inner counter
inner:          cmp     rbx, rdx        ; check if rbx < rdx (rdx = numElements - 1)
                jnb     xInner
                ; here is the inner loop
                mov     eax, [rcx + rbx * 4]
                cmp     eax, [rcx + rbx * 4 + 4]
                jna     dontSwap

                mov     r8d, [rcx + rbx * 4 + 4]
                mov     [rcx + rbx * 4 + 4], eax
                mov     [rcx + rbx * 4], r8d
                mov     didSwap, true

dontSwap:       inc     rbx
                jmp     inner

xInner:         cmp     didSwap, true
                je      outer

                pop     r8
                pop     rdx
                pop     rcx
                pop     rbx
                pop     rax
                ret
sort            endp

                public getTitle
getTitle        proc
                lea     rax, titleStr
                ret
getTitle        endp

                public asmMain
asmMain         proc
                push    rbx
                sub     rsp, 48

                mov     rcx, offset sortMe
                mov     rdx, sortSize
                call    sort

                ; we need to display the elements
                xor     rbx, rbx
printLoop:      lea     rcx, fmtStr
                lea     r9, sortMe
                mov     rdx, rbx
                mov     r8d, [r9 + rbx * 4]
                call    printf

                inc     rbx
                cmp     rbx, sortSize
                jb      printLoop 

                add     rsp, 48
                pop     rbx
                ret
asmMain         endp
                end