
;https://www.nasm.us/xdoc/2.11.08/html/nasmdoc6.html


NULL EQU 0
;EXTERN Импорт символов из других модулей
extern _ExitProcess@4

;Экспорт символов в другие модули
global Start 


;инициализированные данные
section .data

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
