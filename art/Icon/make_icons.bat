@echo off
set INPUT=icon_256.png

rem Список требуемых размеров, через пробел
for %%S in (16 32 48 64 128 256) do (
    magick %INPUT% -define icon:auto-resize=%%S icon_%%S.png
)

echo Готово.
