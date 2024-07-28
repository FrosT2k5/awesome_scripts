# This file contains bash aliases and functions that I commonly
# use to make my life easier.
# Some of them are for termux specific

# Ignore these commands from spamming bash history
HISTIGNORE="&:ls:[bf]g:exit:ud:pwd:clear:mount:umount:cl:c:l:sd:q:shrc:u:motd"                                              

#Aliases
alias l="ls"
alias c="cd /sdcard/termux"
alias sd="cd /sdcard"
alias nuke="rm -rf"
alias "shrc=nano $HOME/../usr/etc/bash.bashrc && source $HOME/../usr/etc/bash.bashrc" # Used to edit bashrc in termux
alias "cl=clear"
alias "q=exit 0"
alias "tkn=cat $HOME/priv/*.token" # My secrets are stored here, plaintext implementation can be avoided
alias "adm=cd /sdcard/ADM"
alias "size=du -sh ./* 2>/dev/null | grep -e \"[0-9][M|G]\" | sort -hr" # Used to list out files with their sizes in current folder, sorted high to low
alias "u=pkg upgrade -y && pkg autoclean && apt autoremove -y" # Upgrade and clean redundant packages in termux
alias "f=cmatrix -abr" # A little bit of flexing :p
alias "motd=nano $HOME/../usr/etc/motd" # edit the motd file in termux, motd contains text that's displayed on terminal startup
alias "ud=python3 ~/pyurbandict/urban_app.py " # urban dictionary in cli, usage: ur word. need to clone the relevant repo
alias "vnc=vncserver -localhost" # Used for termux GUI
alias "playlist=cp /sdcard/Music/FrosT.m3u8 $c; vim /sdcard/music/FrosT.m3u8" # edit my playlist file, also keep a backup

#git aliases
alias "commit=git commit -s"
alias "amend=git commit --amend"
alias "clone=git clone"
alias "add=git add"
alias "ada=git add ."
alias "push=git push"
alias "pushf=git push --force"
alias "rev=git revert"
alias "pick=git cherry-pick"
alias "fetch=git fetch"
alias "pull=git pull"
alias "pullf=git pull -f"
alias "rebase=git rebase"
alias "hard=git reset --hard"
alias "remote=git remote"
alias "gurl=git remote get-url"
alias "stats=git status"
alias "brn=git branch"

# My Vars
export c="/sdcard/termux" # The termux internal storage folder that I use

# Termux GUI
export DISPLAY=":1"

# AES symmetric key encrypted file to store secret stuff in
# Usage: car - decrypt the file and print it's output
# caw - decrypt, open it in nano and write changes back
# ca.gpg is the file storing encrypted text, it's backup is
# made in ~/priv/ca.gpg.bak on every execution of caw
alias "car=gpg -d ~/ca.gpg"
alias "caw=cp ~/ca.gpg ~/priv/ca.gpg.bak && gpg -o ~/priv/ca -d ~/ca.gpg && nano ~/priv/ca && rm ~/ca.gpg && gpg -o ~/ca.gpg -e -r priv ~/priv/ca && rm ~/priv/ca"

#Paths
export PATH=$PATH:/data/data/com.termux/files/home/priv/bin
export PATH="/data/data/com.termux/files/home/.deta/bin:$PATH"
export PATH="/data/data/com.termux/files/home/.detaspace/bin:$PATH"

# my functions

# This function is used to send yourself message to telegram via
# a simple command. your_telegram_id can be your userid or group id
# Usage: tg "hii"
tg(){
        bot_api=123456:abcdefgh # Your tg bot api, dont use my one haha
        your_telegram_id=123456 # No need to touch
        msg=$1
        curl -s "https://api.telegram.org/bot${bot_api}/sendmessage" --data "text=$msg&chat_id=${your_telegram_id}"
}


# This function is used to open a c file in vim, and compile and
# execute it on closing. All the c files are stored in ~/c folder.
# Newly created files also contain basic minimal boilerplate C main()
cc() {
        intend="    "
        cud=$(pwd)
        cd ~/c
        if [ -f "$1.c" ]; then
                vim +4 $1.c
        else
                touch $1.c
                echo "#include <stdio.h>" > $1.c
                echo "" >> $1.c
                echo "int main() {" >> $1.c
                echo "" >> $1.c
                echo -e "${intend}return 0;" >> $1.c
                echo "}" >> $1.c
                vim +4 $1.c
        fi

        clang $1.c -lm -o out/$1
        echo -e "\nOutput of ${1}.c :\n"
        ./out/$1
        echo ""
        cd $cud
}

# This function is similar to the C implementation, but for cpp
cpp() {
        intend="    "
        cud=$(pwd)
        cd ~/cpp
        if [ -f "$1.cpp" ]; then
                vim +4 $1.cpp
        else
                touch $1.cpp
                echo "#include <iostream>" > $1.cpp
                echo "using namespace std;" >> $1.cpp
                echo "" >> $1.cpp
                echo "int main() {" >> $1.cpp
                echo "" >> $1.cpp
                echo -e "${intend}return 0;" >> $1.cpp
                echo "}" >> $1.cpp
                vim +4 $1.cpp
        fi

        clang++ $1.cpp -lm -o out/$1
        echo -e "\nOutput of ${1}.cpp :\n"
        ./out/$1
        echo ""
        cd $cud
}


