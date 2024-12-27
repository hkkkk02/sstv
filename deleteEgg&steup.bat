@echo off

echo Start delete

:: 删除指定目录下的文件
del /F /Q "D:\programfiles\python\lib\site-packages\sstv-0.1-py3.11.egg"

echo Change derectory to sstv

:: 切换到目标目录 
cd /d "D:\Workspace\7.Satellite\科技馆项目\project\sstv"

echo Start setup

:: 执行Python安装
python setup.py install

:: pause