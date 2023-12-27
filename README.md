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
cd dotfiles
git checkout personal/TerryH/wip
cd -
ln --symbolic --relative --force dotfiles/.bashrc .bashrc
source .bashrc
mkdir .config
ln --symbolic --relative dotfiles/configurations/git .config/git
ln --symbolic --relative dotfiles/configurations/hypr .config/hypr
ln --symbolic --relative dotfiles/configurations/lazygit .config/lazygit
ln --symbolic --relative dotfiles/configurations/vimfiles .config/vim
ln --symbolic --relative dotfiles/configurations/waybar .config/waybar
sudo ln --symbolic --relative dotfiles/configurations/vimfiles/vimrc /root/.vimrc
ln --symbolic --relative dotfiles/tools tools
```
