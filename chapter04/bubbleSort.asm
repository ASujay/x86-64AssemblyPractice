            option  casemap:none
nl          =       10
maxLen      =       256

            .const
titleStr    byte    "Bubble Sort", 0
arrPrintFmt byte    "%d ", 0
infoHeader  byte    "Array:", nl, 0
newLine     byte    nl, 0
            
            .data
array       label   byte
            byte    20, 32, 55, 7
            byte    8,  88, 97, 33
            byte    81, 69, 42, 0
            byte    4,  6,  2,  1
arraySize   =    ($-array)
didSwap     byte    0

            .code
            externdef   printf:proc

            public getTitle
getTitle    proc
            lea     rax, titleStr
            ret
getTitle    endp

            public  asmMain
asmMain     proc
            sub     rsp, 56
            call    printArr

            lea     rcx, array
            mov     rdx, arraySize
            call    sort

            call    printArr  
            add     rsp, 56
            ret
asmMain     endp

; sort(dword *array, qword count)
; array - address passed in rcx
; count - element count passed in rdx
sort        proc
            push    rax
            push    rbx
            push    rcx
            push    rdx
            push    r8

            ; bubble sort
outer:      dec     rdx             ; This will make rdx = length - 1
            mov     didSwap, 0      ; We will make didSwap false here
            xor     rbx, rbx        ; initialize the counter
inner:      mov     al, byte ptr [rcx + rbx * 1]
            cmp     al, byte ptr [rcx + rbx * 1 + 1]
            jbe     noSwap
            mov     didSwap, 1
            movzx   r8, byte ptr [rcx + rbx * 1 + 1]
            mov     byte ptr [rcx + rbx * 1 + 1], al
            mov     byte ptr [rcx + rbx * 1], r8b
noSwap:     inc     rbx
            cmp     rbx, rdx
            jb      inner

            cmp     didSwap, 1
            jne     endOuter

            cmp     rdx, 1
            ja      outer 

endOuter:
            pop     r8
            pop     rdx
            pop     rcx
            pop     rbx
            pop     rax
            ret
sort        endp

printArr    proc
            push    rbx
            sub     rsp, 48
            ; first we need to print some information
            lea     rcx, infoHeader
            call    printf
            ; we iterate through the array and print all the elements
            ; Counter will be rbx
            lea     rsi, offset array       ; load the address of the first element
            mov     r12, arraySize          ; load the size of the array
            xor     rbx, rbx                ; prepare the counter
printLoop:  lea     rcx, arrPrintFmt        ; load the fmt string
            ; now we prepare the second argument
            movzx   edx, byte ptr [rsi + rbx * 1]
            call    printf
            inc     rbx                     ; we increment the counter
            cmp     rbx, r12
            jb      printLoop
            
            lea     rcx, newLine
            call    printf

            add     rsp, 48
            pop     rbx
            ret
printArr    endp
            end