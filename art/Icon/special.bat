@echo off
set INPUT=icon_256.png

magick %INPUT% -define icon:auto-resize=192 icon_192.png

echo Готово.
