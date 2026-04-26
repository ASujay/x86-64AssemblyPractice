            option casemap:none

nl      =   10

            .const
titleStr    byte    "Listing 4-8", 0
fmtStr      byte    "aString: maxLen: %d, len: %d, string data: '%s'"
            byte    nl, 0

strDesc     struct
maxLen      dword   ?
len         dword   ?
strPtr      qword   ?
strDesc     ends

            .data
; Here is the string that will initialize the string descriptor 
charData    byte    "Initial String Data", 0
len     =   lengthof charData   ; includes zero byte
aString     strDesc {len, len, offset charData}

            .code
            externdef printf:proc

            public getTitle
getTitle    proc
            lea     rax, titleStr
            ret
getTitle    endp

            public asmMain
asmMain     proc
            sub     rsp, 56

            ; display the fields of the string descriptor
            lea     rcx, fmtStr
            mov     edx, aString.maxLen
            mov     r8d, aString.len
            mov     r9, aString.strPtr
            call printf

            add     rsp, 56
            ret
asmMain     endp    
            end