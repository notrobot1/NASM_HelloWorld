Программа получает количество передаваемых аргументов в командной строке + первый аргумент командной строки.
<p> Сборка: </p>
```.\nasm.exe -fwin32 .\arg.asm``` 
```.\GoLink.exe /entry:Start /console kernel32.dll user32.dll ucrtbased.dll shell32.dll arg.obj```
