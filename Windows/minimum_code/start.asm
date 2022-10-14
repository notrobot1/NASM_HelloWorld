
;https://www.nasm.us/xdoc/2.11.08/html/nasmdoc6.html


NULL EQU 0
;EXTERN Импорт символов из других модулей
extern _ExitProcess@4

;Экспорт символов в другие модули
global Start 


;инициализированные данные
section .data
 ;DB - Define Byte. 8 bits
 ;DW - Define Word. Generally 2 bytes on a typical x86 32-bit system
 ;DD - Define double word. Generally 4 bytes on a typical x86 32-bit system
 array   dd 89, 10, 67, 1, 4, 27, 12, 34, 86, 3

;неинициализированные данные
section .bss

;Code
section .text
    ; Главная функция
	Start:
	
	; Завершение программы
	exit:
        push    NULL
        call    _ExitProcess@4
