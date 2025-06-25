@echo off
cd /d "C:\Users\Alexe\Documents\Godot\Projects\Dodge the Slippers"

echo Добавляем все файлы...
git add .

echo Создаем коммит...
git commit -m "Новая версия проекта"

echo Отправляем на GitHub...
git push origin main

echo Готово!
pause
