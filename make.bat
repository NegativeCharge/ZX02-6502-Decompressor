cd .\tests\
for %%x in (*.zx0) do del "%%x" 
for %%x in (*.bin) do ..\tools\zx02.exe "%%x" "%%~nx.bin.zx02"

cd ..
cmd /c "BeebAsm.exe -v -i zx02_test.s.asm -do zx02_test.ssd -opt 3"