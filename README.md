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
git clone https://github.com/TerryHughes/dotfiles.git
cp /home/terryh/dotfiles/.bashrc /home/terryh/
ln -s /home/terryh/dotfiles/configurations/git/ /home/terryh/.config/git/
ln -s /home/terryh/dotfiles/configurations/hypr/ /home/terryh/.config/hypr/
ln -s /home/terryh/dotfiles/configurations/lazygit/ /home/terryh/.config/lazygit/
ln -s /home/terryh/dotfiles/configurations/vimfiles/ /home/terryh/.config/vim/
ln -s /home/terryh/dotfiles/configurations/waybar/ /home/terryh/.config/waybar/
ln -s /home/terryh/dotfiles/tools/ /home/terryh/tools/
```
