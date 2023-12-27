```
MKDIR "tools" 2> NUL
CD "tools"
curl -LJOs "https://raw.githubusercontent.com/TerryHughes/dotfiles/personal/TerryH/wip/tools/{update-user-path}.bat"
CD ..
MKDIR "installs"
CD "installs"
curl -LJOs "https://raw.githubusercontent.com/TerryHughes/dotfiles/personal/TerryH/wip/installs/{git,vim,microsoft-build-tools-2022,chrome,7-zip,everything,windirstat}.bat"
CD ..
curl -LJOs "https://raw.githubusercontent.com/TerryHughes/dotfiles/personal/TerryH/wip/{install,configure}.bat"
"install.bat"

```
```
"configure.bat"
DEL "configure.bat"
DEL "install.bat"
RMDIR /S /Q "installs"
RMDIR /S /Q "tools"
EXIT 0

```
```
git clone dotfiles
mkdir bin
cp dotfiles/aliases/fstr bin/
cp dotfiles/aliases/fs bin/
cp dotfiles/aliases/v bin/
chmod +x bin/fstr
chmod +x bin/fs
chmod +x bin/v
export PATH=$PATH:$HOME/bin
cp -r dotfiles/configurations/vimfiles/ .vim

```
