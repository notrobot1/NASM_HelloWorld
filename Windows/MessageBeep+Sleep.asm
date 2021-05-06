;программа 2 раза подаст сигнал при помощи системного динамика. 
;задержка между сигналами 2 секунды

extern _MessageBeep@4 ; USER32.LIB
extern _Sleep@4


section .text
	Start:
	  push 0xFF
		call _MessageBeep@4 ; Call messagebeep function
		push 0
		
		push 2000 ;устанавливаем 2 секунды задержки
    call _Sleep@4      ; call sleep
    
		push 0xFF
		call _MessageBeep@4 ; Call messagebeep function
		xor eax, eax
		ret 
