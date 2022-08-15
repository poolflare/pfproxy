:loop

pfproxy.exe run -L :4443 -R relay+tls://vps-ip:4443 -V
timeout /t 1 >NUL

goto loop
