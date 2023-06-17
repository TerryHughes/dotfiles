```
MKDIR "tools" 2> NUL
CD "tools"
curl -LJOs "https://raw.githubusercontent.com/TerryHughes/dotfiles/master/tools/{update-user-path}.bat"
CD ..
```
```
RMDIR /S /Q "tools"
EXIT 0
```
