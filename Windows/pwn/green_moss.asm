;https://www.nasm.us/xdoc/2.11.08/html/nasmdoc6.html
;http://www.club155.ru/x86cmd/REPNE rep movsb
;.\GoLink.exe /entry:Start /console kernel32.dll user32.dll ucrtbased.dll shell32.dll msvcrt.dll arg.obj
NULL EQU 0
;EXTERN Импорт символов из других модулей
extern _ExitProcess@4
extern _GetCommandLineA@16
extern _GetCommandLineW@0
extern _GetStdHandle@4
extern _WriteFile@20
;shell32.dll
extern _CommandLineToArgvW@8


; msvcrt.dll
extern sprintf


;Экспорт символов в другие модули
global Start 


;инициализированные данные
section .data
    flag         db "You'r flag is: flag{%s}", 0x0
	mrflag db 0x72, 0x66, 0x31, 0x76, 0x6f, 0x64, 0x72, 0x75, 0x6b, 0x33, 0x71, 0x67, 0x33, 0x33, 0x34, 0x28, 0x6f, 0x79, 0x31, 0x25, 0x39, 0x74, 0x29, 0x71, 0x29, 0x71, 0x2f, 0x2e, 0x24, 0x25, 0x2e, 0x36, 0x7e, 0x2e, 0x39, 0x27, 0x2e, 0x22
	key db 0x22, 0x3f, 0x3f,0x3f, 0x3f, 0x3f, 0x27, 0x7e, 0x3c, 0x2c, 0x2e, 0x5c, 0x2f, 0x3f, 0x21, 0x40, 0x23, 0x24, 0x25, 0x5e, 0x26, 0x2a, 0x28, 0x29, 0x2d, 0x2b, 0x30, 0x39, 0x38, 0x37, 0x36, 0x35, 0x34, 0x33, 0x32, 0x31, 0x71, 0x77, 0x65, 0x72, 0x74, 0x79, 0x75, 0x69, 0x6f, 0x70, 0x61, 0x73, 0x64, 0x66, 0x67, 0x68, 0x6a, 0x6b, 0x6c, 0x7a, 0x78, 0x63, 0x76, 0x62, 0x6e, 0x6d, 0x5f

;неинициализированные данные
section .bss
	array resb 50
	;RESB 1 allocates 1 byte.
	;RESW 1 allocates 2 bytes.
	;RESD 1 allocates 4 bytes.
	;RESQ 1 allocates 8 bytes.
	;varname resd 1
	;std_addr resb 10
	arg resb 100
	mrflagend resb 40
	StandardHandle resd 1
	Replace resd 16 ;попробуй заменить это
	Written resd 1
 
 


;Code
section .text


; функция возвращает длину передаваемой переменной
	Len:
	
		push  ebx
		push  ecx
		mov   ebx, edi            
		xor   al, al                               
		mov   ecx, 0xffffffff     
		repne scasb               ; Повторить следующую строковую операцию, если не равно 
		sub   edi, ebx            ; sub приемник, источник (приемник = приемник - источник) length = offset of (edi - ebx)
		mov   eax, edi            
		pop   ebx
		pop   ecx
		ret             



	; Функция выводит на экран
	Print:
		push  edi
		push  ecx
		push -11
        call _GetStdHandle@4
        mov dword [StandardHandle], EAX
	    push 0x0
        push Written
        push ecx ;длина текста для вывода на экран
        push edi ;текст для вывода на экран
        push dword [StandardHandle]
        call _WriteFile@20
		pop   ebx
		pop   ecx
		ret



    ;функция не печатает флаг
	Finish0:
		push ebx
		
		
		mov eax, [arg]
		mov [mrflagend], eax
		
		pop ebx
		ret
	
	;https://ravesli.com/assembler-usloviya/
	;функция напечатает флаг
    Finish1:
		push ebx
		;необходимо отчистить переменную
		mov ecx, 0x32 ;сколько итерация сделает команда rep movsb
		mov edi, mrflagend ;откуда начинаем заполнение
		mov esi, mrflagend+0x100 ;чем заполняем (указатель на 00)
        rep movsb ;делаем 0x32 циклов помещая 00 в edi++
		
		mov esi, 0x0 ;i
		
		jmp F0 ;начинаем цикл
		
		
		I:
			add esi, 0x01 ; добавляем итерацию i+1
		    jmp F0
			
		F0:
			mov al, byte[mrflag+esi] ;в al кладем байт для сравнения
			mov edi, key ;в edi кладем массив по котором пройдемся командой repne scasb
			mov ecx, 0x3f ;размер массива key кладем в ecx
			
			;edi хранит адресс на строку 
			;в регист al кладем байт с которым надо сравнить
			;repne scasb сравнивает значение al и edi 
			;если не равняется то к edi добавляется 1 а из ecx отнимается 1 
			;повторяем цикл пока ecx != 0 или байты не совпадут.
			repne scasb
			
			add edi, esi ;смещение на количество циклов
			;push dword[edi]
			mov dl, byte [edi]
			
			mov byte[mrflagend+esi], dl
			
			cmp esi, 0x25 ;25 длина массива mrflag		
			jb I
			
			
			
			pop ebx
			ret
	
	
	
	; utf16 to ascii
	; _CommandLineToArgvW возвращает массив аргументов командной строки в utf16 60 00 61..
	; необходимо преобразовать utf16 в ascii
	; После преобразования аргументы с кирилицей отобразятся не корректно
	Encoding:
		push  ebx
		push  ecx
        
		mov ebx, Finish0 ;кладем адресс функции 0 в ebx
		mov [Replace], ebx ;помещаем  адрес в переменную Replace
		
		
		mov ebx, arg ; переменная с аргументом из CommandLineToArgv
		jmp M0
		M1:
		  mov [ebx], al ; помещаем в ebx один байт arg
		  add ebx, 0x1 ;  ebx хранит отформатированую строку
		  jmp M0 ;смотрим следующий символ аргумента
		M0:
			mov al, byte [esi] ;помещаем 1 байт arg; esi хранит аргумент в формате utf16 l.o.l..
			add esi, 1 ;следующий байт аргумента 
			cmp al, 0x00 ;если помещенный символ != 0
			ja M1
			
		cmp byte [esi], 0x00 ;если два 0 подряд то конец строки
		ja M0 ;если после 0 идет не 0 значит строка продолжается
			
			
	   
		pop   ebx
		pop   ecx
		ret       



    ; Главная функция
	Start:
		push    ebp
		mov     ebp, esp
		
		sub     esp, 4

		call    _GetCommandLineW@0 ;получаем текущий процесс

		lea     ecx, [ebp - 4]          ; need the address of local
		push    ecx                     ; указатель на номер элемента массива
		push    eax                     ; указатель на строку "D:\\arg.exe" arg
		call    _CommandLineToArgvW@8 ;получаем первый элемент командной строки

		push    dword [ebp - 4]     ; кладем в стек количество аргументов
		mov dword [ebp-30], eax
		mov eax, 4
		mov ecx, dword [ebp-30]
		mov edx, dword [ecx+eax] ;сюда помещаем второй элемент массива
		
		
		mov esi, edx
		call Encoding ;преобразование аргумента в ascii
		
		
		call [Replace] ;
		
		
		push mrflagend ;аргумент который вставить в паттерн (флаг)
		push flag ;паттерн флага
		push array ;буфер куда помещаем отформатированную строку
		call sprintf ;форматируем строку
		
		
		mov edi, [esp] ;кладем финальную строку в edi 
		call Len ;узнаем длину финальной строки
		mov ecx, eax ; помещаем результат Len в eсx и передаем ее в print
		mov edi, [esp] ;строка которую нужно вывести
		call Print ;выводим флаг
		
			
	; Завершение программы
	exit:
        push    NULL
        call    _ExitProcess@4
