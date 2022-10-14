
;https://www.nasm.us/xdoc/2.11.08/html/nasmdoc6.html


NULL EQU 0
;EXTERN Импорт символов из других модулей
extern _ExitProcess@4

;Экспорт символов в другие модули
global Start 


;инициализированные данные
section .data
 ;;;DB - Define Byte. 8 bits
 ;DW - Define Word. Generally 2 bytes on a typical x86 32-bit system
 ;DD - Define double word. Generally 4 bytes on a typical x86 32-bit system
 ;DB allocates in chunks of 1 byte.
 ;DQ allocates in chunks of 8 bytes.
 ;array   dd 89, 10, 67, 1, 4, 27, 12, 34, 86, 3

;неинициализированные данные
section .bss
 ;RESB 1 allocates 1 byte.
 ;RESW 1 allocates 2 bytes.
 ;RESD 1 allocates 4 bytes.
 ;RESQ 1 allocates 8 bytes.
 ;varname resd 1

;Code
section .text
    ; Главная функция
	Start:
	
	; Завершение программы
	exit:
        push    NULL
        call    _ExitProcess@4
