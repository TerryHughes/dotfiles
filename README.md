```
MKDIR "tools" 2> NUL
CD "tools"
curl -LJOs "https://raw.githubusercontent.com/TerryHughes/dotfiles/master/tools/{update-user-path}.bat"
CD ..
curl -LJOs "https://raw.githubusercontent.com/TerryHughes/dotfiles/master/{install}.bat"
"install.bat"
```
```
DEL "install.bat"
RMDIR /S /Q "tools"
EXIT 0
```
