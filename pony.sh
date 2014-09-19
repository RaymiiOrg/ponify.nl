#!/bin/bash
# Copyright (C) 2014 Remy van Elst <https://raymii.org>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# Usage: curl -L http://ponify.nl/pony.sh | bash

PONYURL="http://ponify.nl/my-little-pony.jpg"

is_osx() {
  # [ `/usr/bin/sw_vers -productVersion 2>/dev/null` ]
  [[ $(uname -s) == "Darwin" ]]
}

is_linux() {
    [[ $(uname -s) == "Linux" ]]
}

download_pony() {
    # if you don't want to get ponified, place a nice picture in your
    # home folder named .pony.jpg. I won't overwrite it.
    if [[ ! -f "${HOME}/pony.jpg" ]]; then
        if [[ -f "$(which curl)" ]]; then
        	curl --silent --location --output "${HOME}/pony.jpg" "${PONYURL}"
        elif [[ -f "$(which wget)" ]]; then
            wget --output-document "${HOME}/pony.jpg" --quiet "${PONYURL}"
        else
            echo "Could not download Pony picture. wget or curl not found."
            exit 1
        fi
    fi
}

if is_osx; then

    OS_VER_MAJ=$(sw_vers -productVersion | cut -d . -f 1)
    OS_VER_MIN=$(sw_vers -productVersion | cut -d . -f 2)

    download_pony
    
    if [[ "${OS_VER_MIN}" == "9" ]]; then
        echo "OS X 10.9 Mavericks Ponify by raymii.org"
    	osascript -e "tell application \"System Events\" to set picture of every desktop to \"${HOME}/pony.jpg\"";
    fi
    
    if [[ "${OS_VER_MIN}" = 8 ]]; then
            echo "OS X 10.8 Mountain Lion Ponify by raymii.org"
            echo -e "#!/usr/bin/osascript\nset desktopImage to POSIX file \"${HOME}/pony.jpg\"\ntell application \"Finder\" \n set desktop picture to desktopImage as alias \n end tell" > /tmp/wall.osa
            osascript /tmp/wall.osa
    fi
    
    if [[ "${OS_VER_MIN}" == "7" ]]; then
    	echo "OS X 10.7 Lion Ponify by raymii.org"
    	defaults write com.apple.desktop Background "{default = {ImageFilePath = \"${HOME/pony.jpg\"; };}"
    fi
    
fi

if is_linux; then
    
    download_pony

    if [[ -f $(which gnome-session) ]]; then
        if [[ $(ps aux | grep -v grep | grep gnome-session) ]]; then
            if [[ $(gnome-session --version | grep -o -e "[[:digit:]]" | grep "^3") ]]; then
                echo "Probably GNOME 3 or Unity. Ponifying with gsettings." 
                gsettings set org.gnome.desktop.background picture-uri "file://${HOME}/pony.jpg"
            fi
        fi
    fi
fi

# via https://github.com/mbasaglia
read -r -d '' Heredoc_var <<'Heredoc_var'
\x1b[0m                                                                  
                                         \x1b[33;1m_\x1b[33;1m_  \x1b[35;1m_\x1b[35;1m.\x1b[35;1m-\x1b[35;1m-\x1b[35;1m'\x1b[35;1m'\x1b[35;1m`\x1b[35;1m`\x1b[35;1m'\x1b[35;1m'\x1b[35;1m-\x1b[35;1m-\x1b[35;1m.\x1b[35;1m.       
                                        \x1b[33;1m/  \x1b[33;1m\\\x1b[35;1m/              \x1b[35;1m`\x1b[35;1m.     
                                       \x1b[33;1m( \x1b[33;1m/  \x1b[33;1m\\\x1b[33;1m_\x1b[35;1m_\x1b[35;1m_             \x1b[35;1m\\    
                                       \x1b[33;1m| \x1b[33;1m|      \x1b[35;1m`\x1b[35;1m'\x1b[35;1m-\x1b[35;1m.    \x1b[35;1m_\x1b[35;1m_    \x1b[35;1m\\   
                         \x1b[33;1m_\x1b[33;1m_\x1b[33;1m_           \x1b[33;1m( \x1b[33;1m'\x1b[33;1m.       \x1b[37;22m_\x1b[37;22m_\x1b[35;1m`\x1b[35;1m.\x1b[35;1m'\x1b[35;1m` \x1b[33;1m\\\x1b[35;1m`\x1b[35;1m.   \x1b[35;1m\\  
                  \x1b[33;1m_\x1b[33;1m_\x1b[33;1m_   \x1b[33;1m(   \x1b[33;1m`\x1b[33;1m.         \x1b[35;1m/\x1b[33;1m\\    \x1b[37;22m,\x1b[37;22m. \x1b[37;22m.\x1b[37;22m'\x1b[36;22m_\x1b[36;22m_\x1b[37;22m\\  \x1b[37;22m/ \x1b[37;22m`\x1b[37;22m:\x1b[37;22m_\x1b[35;1m\\   \x1b[35;1m\\ 
                 \x1b[33;1m(   \x1b[33;1m`\x1b[33;1m-\x1b[33;1m. \x1b[33;1m`\x1b[33;1m.   \x1b[33;1m`\x1b[33;1m.      \x1b[35;1m/  \x1b[33;1m\\\x1b[33;1m_ \x1b[37;22m_\x1b[37;22m_\x1b[37;22m.\x1b[37;22m` \x1b[36;22m/ \x1b[30;1m.\x1b[30;1m-\x1b[37;22m| \x1b[37;22m|\x1b[36;22m'\x1b[36;22m.\x1b[37;22m|\x1b[37;22m= \x1b[35;1m\\   \x1b[35;1m|
                  \x1b[33;1m`\x1b[33;1m-\x1b[33;1m.   \x1b[33;1m`\x1b[33;1m-\x1b[33;1m.\x1b[33;1m`\x1b[33;1m.   \x1b[33;1m`\x1b[33;1m.   \x1b[35;1m:    \x1b[35;1mr\x1b[37;22m_\x1b[37;22m_\x1b[37;22m,\x1b[37;22m' \x1b[36;22m( \x1b[30;1m(\x1b[30;1mW\x1b[30;1mW\x1b[37;22m| \x1b[37;22m\\\x1b[30;1mW\x1b[36;22m)\x1b[37;22mj   \x1b[35;1m|  \x1b[35;1m|
                     \x1b[33;1m`\x1b[33;1m.    \x1b[33;1m`\x1b[33;1m.\x1b[33;1m\\   \x1b[33;1m_\x1b[33;1m\\  \x1b[35;1m|    \x1b[35;1m|    \x1b[37;22m\\\x1b[37;22m_\x1b[36;22m\\\x1b[37;22m_\x1b[30;1m`\x1b[37;22m/   \x1b[33;1m`\x1b[33;1m`\x1b[33;1m-\x1b[33;1m. \x1b[35;1m/  \x1b[35;1m/ 
            \x1b[35;1m.\x1b[35;1m-\x1b[35;1m-\x1b[35;1m'\x1b[35;1m'\x1b[35;1m'\x1b[35;1m`\x1b[35;1m`\x1b[35;1m`\x1b[35;1m-\x1b[33;1m_\x1b[33;1m`\x1b[33;1m-\x1b[33;1m,   \x1b[33;1m`  \x1b[33;1m(  \x1b[33;1m| \x1b[35;1m|    \x1b[35;1m|            \x1b[33;1m\\\x1b[33;1m_\x1b[33;1m_\x1b[33;1m/\x1b[35;1m.\x1b[35;1m` \x1b[35;1m.\x1b[35;1m`  
           \x1b[35;1m/         \x1b[33;1m( \x1b[33;1m`\x1b[33;1m`\x1b[33;1m`    \x1b[33;1m_\x1b[33;1m_ \x1b[33;1m\\  \x1b[33;1m\\\x1b[35;1m|    \x1b[35;1m\\    \x1b[33;1m-\x1b[33;1m,\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m.\x1b[33;1m-\x1b[33;1m'\x1b[35;1m/  \x1b[35;1m/    
          \x1b[35;1m/           \x1b[33;1m`\x1b[33;1m-\x1b[33;1m.\x1b[33;1m_   \x1b[33;1m(  \x1b[33;1m`\x1b[33;1m.\x1b[33;1m\\  \x1b[35;1m'\x1b[35;1m.    \x1b[35;1m\\      \x1b[33;1m/\x1b[35;1m'\x1b[35;1m.   \x1b[35;1m.\x1b[35;1m' \x1b[35;1m.\x1b[35;1m'     
         \x1b[35;1m/         \x1b[35;1m,\x1b[35;1m.\x1b[35;1m-\x1b[35;1m-\x1b[35;1m'\x1b[35;1m'\x1b[35;1m>\x1b[33;1m`\x1b[33;1m-\x1b[33;1m. \x1b[33;1m`\x1b[33;1m-\x1b[33;1m. \x1b[33;1m`   \x1b[35;1m|     \x1b[35;1m`\x1b[35;1m.   \x1b[33;1m(  \x1b[35;1m|  \x1b[35;1m/  \x1b[35;1m/   \x1b[35;1m_   
        \x1b[35;1m(         \x1b[35;1m|     \x1b[33;1m/ \x1b[35;1m8\x1b[36;22mY\x1b[35;1m8\x1b[33;1m`\x1b[33;1m_\x1b[33;1m: \x1b[33;1m`\x1b[33;1m_\x1b[33;1m:\x1b[33;1m. \x1b[35;1m|       \x1b[35;1m\\   \x1b[33;1m\\ \x1b[35;1m| \x1b[35;1ml  \x1b[35;1m( \x1b[35;1m,\x1b[35;1m:\x1b[35;1m' \x1b[35;1m\\  
        \x1b[35;1m|        \x1b[35;1m.\x1b[35;1m'    \x1b[33;1m|     \x1b[33;1m(   \x1b[33;1m(    \x1b[35;1m(        \x1b[35;1m\\   \x1b[33;1m|\x1b[35;1m\\ \x1b[35;1m|   \x1b[35;1m\\  \x1b[35;1m)  \x1b[35;1m) 
        \x1b[35;1m|       \x1b[35;1m.\x1b[35;1m'     \x1b[33;1m| \x1b[35;1m8\x1b[36;22mY\x1b[35;1m8  \x1b[33;1m`\x1b[33;1m-\x1b[33;1m-\x1b[33;1m-\x1b[33;1m:\x1b[33;1m.\x1b[33;1m_\x1b[33;1m_\x1b[33;1m-\x1b[35;1m\\        \x1b[35;1m\\  \x1b[33;1m| \x1b[35;1m`\x1b[35;1m.    \x1b[35;1m`\x1b[35;1m` \x1b[35;1m.\x1b[35;1m'  
        \x1b[35;1m|       \x1b[35;1m|      \x1b[33;1m|     \x1b[35;1m8\x1b[36;22mY\x1b[35;1m8        \x1b[35;1m\\        \x1b[35;1m\\ \x1b[33;1mj   \x1b[35;1m`\x1b[35;1m'\x1b[35;1m-\x1b[35;1m.\x1b[35;1m.\x1b[35;1m-\x1b[35;1m'    
        \x1b[35;1m|       \x1b[35;1m'\x1b[35;1m.    \x1b[33;1m/ \x1b[33;1m\\        \x1b[33;1m/       \x1b[35;1m|        \x1b[35;1m|               
        \x1b[35;1m|        \x1b[35;1m|\x1b[33;1m.\x1b[33;1m-\x1b[33;1m-\x1b[33;1m'   \x1b[33;1m|      \x1b[33;1m/\x1b[33;1m-\x1b[33;1m,\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[35;1m|        \x1b[35;1m|               
        \x1b[35;1ml        \x1b[35;1m|     \x1b[33;1m_\x1b[33;1m/      \x1b[33;1m/     \x1b[35;1m.\x1b[35;1m-\x1b[35;1m. \x1b[35;1m|       \x1b[35;1m/ \x1b[33;1m\\              
         \x1b[35;1m\\       \x1b[35;1m'\x1b[35;1m.   \x1b[33;1m/       \x1b[33;1m/     \x1b[35;1m( \x1b[35;1m(\x1b[35;1m` \x1b[35;1m/      \x1b[35;1m/   \x1b[33;1m\\             
      \x1b[35;1m_\x1b[35;1m_  \x1b[35;1m\\       \x1b[35;1m|   \x1b[33;1m|      \x1b[33;1m|      \x1b[33;1m|\x1b[35;1m\\ \x1b[35;1m`\x1b[35;1m`    \x1b[35;1m_\x1b[35;1m.\x1b[35;1m'     \x1b[33;1ml            
    \x1b[35;1m.\x1b[35;1m' \x1b[35;1m/   \x1b[35;1m\\      \x1b[35;1m|\x1b[33;1m_\x1b[33;1m_\x1b[33;1m/\x1b[33;1m|      \x1b[33;1m|      \x1b[33;1m| \x1b[35;1m`\x1b[35;1m-\x1b[35;1m.\x1b[35;1m_\x1b[35;1m.\x1b[35;1m-\x1b[35;1m'\x1b[33;1m(       \x1b[33;1m|            
    \x1b[35;1m| \x1b[35;1m(\x1b[35;1m_    \x1b[35;1m|      \x1b[35;1m|  \x1b[33;1m|      \x1b[33;1m|      \x1b[33;1m|      \x1b[33;1m|  \x1b[33;1m\\      \x1b[33;1m|            
    \x1b[35;1m'   \x1b[35;1m`\x1b[35;1m'\x1b[35;1m-\x1b[35;1m`       \x1b[35;1m|  \x1b[33;1m|       \x1b[33;1m\\     \x1b[33;1m|       \x1b[33;1m\\  \x1b[33;1m`\x1b[33;1m.\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m/             
     \x1b[35;1m`\x1b[35;1m-\x1b[35;1m.\x1b[35;1m.\x1b[35;1m_\x1b[35;1m_\x1b[35;1m_\x1b[35;1m_\x1b[35;1m_\x1b[35;1m_\x1b[35;1m_\x1b[35;1m_\x1b[35;1m_\x1b[35;1m/    \x1b[33;1m\\\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m)     \x1b[33;1m\\\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m_\x1b[33;1m)                    
                                                                  
                                                                  
\x1b[0m
Heredoc_var
echo -e "$Heredoc_var"
