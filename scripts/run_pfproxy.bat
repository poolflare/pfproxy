:loop

pfproxy.exe run -L tls://:6443 -R please-fill-remote-address
timeout /t 1 >NUL

goto loop
