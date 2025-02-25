#!/bin/bash
#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH="/lib/cw:$PATH"

## shell functions backup

# function pwait () { [[ "$1" =~ ^[0-9][0-9]*$ ]] && tail --pid="$1" -f /dev/null || return 1; }
#
# function si () {
#         printf '%s' "$* $(fasd -l | fzf +s --tac)" | \
#                 perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }'
# }
#
# function sd () {
#         printf '%s' "$* $(fasd -ld | fzf +s --tac)" | \
#                 perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }'
# }
#
# function sf () {
#         printf '%s' "$* $(fasd -lf | fzf +s --tac)" | \
#                 perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }'
# }
#
# function j () {
#         local dir
#         dir="$(fasd -Rld "$*" 2>&1 | fzf -1 -0 --no-sort +m)" && \
#                 cd "$dir" || cd "$(fasd -Rld 2>&1 | fzf +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
#         unset dir
# }
#
# function v () {
#         local file
#         file="$(fasd -Rlf "$*" 2>&1 | fzf -1 -0 --no-sort +m)" && \
#                 vim "$file" || vim "$(fasd -Rlf 2>&1 | fzf +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
#         unset file
# }
#
# # function z () {
# #         [ "${#}" -gt 0 ] && { _z "$*" && return; }
# #         cd "$(_z -l 2>&1 | fzf-tmux +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
# # }
# function z () {
#         if [[ -z "$*" ]]; then
#                 cd "$(fasd -ld 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
#         else
#                 local cwd="$PWD"
#                 _last_z_args=("$@")
#                 fasd_cd "$@"
#                 [[ "$cwd" == "$PWD" ]] && cd "$(fasd -Rld 2>&1 | fzf +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
#                 unset cwd
#         fi
# }
#
# function zz () { cd "$(fasd -Rld 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"; }
#
# function hithemes () (
#         cd /usr/share/highlight/themes || return 1
#         for i in *; do
#                 printf '\n%s\n\n' "$i"
#                 highlight --style="${i/.theme}" --out-format=xterm256 "${*:-/usr/include/stdlib.h}" | tail
#         done | less -FJRMXs
# )
#
# function ytdl () {
#         if [[ "$#" -eq 0 ]]; then
#                 youtube-dl --help | less -FJRMXs
#                 return 1
#         fi
#         youtube-dl --get-url "$@" | paste -sd' ' | perl -pe 'chomp if eof' | tee >(xsel -ib)
# }
#
# function rmtorrents () {
#         local -a list
#         local dir
#         echo ${(@0)$( transmission-remote -l | perl -ne '
#                 s/.*Stopped[[:space:]]*// && chomp && print "\0/hdd/torrents/".$_."\0"."\0a/store/torrents/".$_."\0" if /Stopped/
#                 ' )} | \
#                 sed 's/   */\n/g' | while read -r dir; do
#                         [[ -d "$dir" ]] && list+=( "$dir" )
#                 done
#         printf '%s\n' "$list[@]"
#         printf "$(tput setaf 11)%s$(tput sgr0)\n" "Remove these directories? [y/N] "
#         read -qrs answer
#         case $answer in
#                 (y) rm -rv "$list[@]" && \
#                                 printf "$(tput setaf 10)%s$(tput sgr0)\n" "Directories removed." || \
#                                 printf "$(tput setaf 9)%s$(tput sgr0)\n" "Unable to remove directories." ;;
#                 (n) printf "$(tput setaf 2)%s$(tput sgr0)\n" "Nothing to be done." ;;
#         esac
#         unset list dir
# }
#
# # function rorphans () {
# #         local pkgs="$( pacman -Qdtq | paste -sd' ' | perl -pe 'chomp if eof' | tee >(xsel -ib) )"
# #         printf '\n %s\n\n' "$pkgs"
# #         sudo pacman -Rs "$pkgs"
# #         unset pkgs
# # }
#
# function xo () { xsel -ob "$@" 2>/dev/null; }
#
# function xs () { xsel "$@" 2>/dev/null; }
#
# function cue () {
#         if [[ -e "image.toc" ]] || [[ -e "image.bin" ]] || [[ -e "image.cue" ]]; then
#                 printf " \033[31m %s\n\033[0m" 'Error: image.(toc|bin|cue) exists!'
#                 return 1
#         else
#                 cdrdao read-cd \
#                         --datafile image.bin \
#                         --driver generic-mmc:0x20000 \
#                         --device /dev/cdrom \
#                         --read-raw image.toc && \
#                 toc2cue image.toc image.cue
#         fi
# }
#
# function myt () { mpv --no-video --ytdl-format=bestaudio "ytdl://ytsearch10:$*"; }
#
# function act () {
#         awk 'BEGIN{
#                 s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
#                 for (colnum = 0; colnum<77; colnum++) {
#                         r = 255-(colnum*255/76);
#                         g = (colnum*510/76);
#                         b = (colnum*255/76);
#                         if (g>255) g = 510-g;
#                         printf "\033[48;2;%d;%d;%dm", r,g,b;
#                         printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
#                         printf "%s\033[0m", substr(s,colnum+1,1);
#                 }
#                 printf "\n";
#         }'
# }
#
# function color () {
#         for c in "$@"; do
#                 printf '\e[48;5;%dm%03d' "$c" "$c"
#         done
#         printf '\e[0m \n'
# }
#
# function mode2colors () {
#         #### For 16 Million colors use \e[0;38;2;R;G;Bm each RGB is {0..255}
#         ## reset the colors.
#         printf '\e[0m%59s\n' "Some samples of colors for r;g;b. Each one may be 000..255"
#         printf '\e[0m%59s\n' " for the ansi option: \e[0;38;2;r;g;bm or \e[0;48;2;r;g;bm :"
#         ## foreground or background (only 3 or 4 are accepted)
#         local fb
#         [[ "$1" =~ ^(fg|38?)$ ]] && fb=3 || fb=4
#         # [[ $fb != 3 ]] && fb=4
#         local samples=(0 63 127 191 255)
#         for r in "${samples[@]}"; do
#                 for g in "${samples[@]}"; do
#                         for b in "${samples[@]}"; do
#                                 printf '\t\e[0;%s8;2;%s;%s;%sm%03d;%03d;%03d ' "$fb" "$r" "$g" "$b" "$r" "$g" "$b"
#                         done; printf '\e[m\n'
#                 done; printf '\e[m'
#         done; printf '\e[m Reset\n'
# }
#
# function truecolor () {
#         if [[ "$#" -eq 0 ]]; then
#                 printf '%s\n' '\x1b[38;5;<R>;<G>;<B>m'
#                 return 1
#         fi
#         local hex r g b
#         hex="${*// }"
#         hex="${hex#\#}"
#         r=$(printf '0x%0.2s' "$hex")
#         g=$(printf '0x%0.2s' ${hex#??})
#         b=$(printf '0x%0.2s' ${hex#????})
#         # r="$( <<<$(( r & 0x99 [#16] )) | sed 's/16#/0x/' )"
#         # g="$( <<<$(( g & 0x99 [#16] )) | sed 's/16#/0x/' )"
#         # b="$( <<<$(( b & 0x99 [#16] )) | sed 's/16#/0x/')"
#         r="$(( r [#10] ))"
#         g="$(( g [#10] ))"
#         b="$(( b [#10] ))"
#         printf "\x1b[38;5;${r};${g};${b}m#${hex} = \n\033[0m%s\n" "\\x1b[38;5;${r};${g};${b}m"
#         printf "\x1b[48;5;${r};${g};${b}m#${hex} = \n\033[0m%s\n" "\x1b[48;5;${r};${g};${b}m"
# }
#
# # fromhex A52A2A
# # fromhex "#A52A2A"
# # BLUE_VIOLET=$(fromhex "#8A2BE2")
# # http://unix.stackexchange.com/a/269085/67282
# function fromhex () {
#         local hex r g b
#         hex=${1#"#"}
#         r=$(printf '0x%0.2s' "$hex")
#         g=$(printf '0x%0.2s' ${hex#??})
#         b=$(printf '0x%0.2s' ${hex#????})
#         printf '%03d' "$(( (r<75?0:(r-35)/40)*6*6 +
#                         (g<75?0:(g-35)/40)*6 +
#                         (b<75?0:(b-35)/40) + 16 ))" | \
#                 tee >(xsel -ib)
#         echo
# }
#
# function tohex () {
#         # for i in $(seq 0 255); do
#         #         tohex ${i}
#         # done
#         local -a colors
#         local dec base mul a b c
#         [[ "$#" -eq 0 ]] && colors=( $(seq 0 255) ) || colors=("$1")
#         while [[ "${#colors[@]}" -ne 0 ]]; do
#                 dec=$((${colors[1]}%256))   ### input must be a number in range 0-255.
#                 if [[ "$dec" -lt "16" ]]; then
#                         bas=$(( dec%16 ))
#                         mul=128
#                         [[ "$bas" -eq "7" ]] && mul=192
#                         [[ "$bas" -eq "8" ]] && bas=7
#                         [[ "$bas" -gt "8" ]] && mul=255
#                         a="$((  (bas&1)	*mul ))"
#                         b="$(( ((bas&2)>>1)*mul ))"
#                         c="$(( ((bas&4)>>2)*mul ))"
#                         printf 'dec= %3s basic= #%02x%02x%02x\n' "$dec" "$a" "$b" "$c"
#                 elif [[ "$dec" -gt 15 ]] && [[ "$dec" -lt 232 ]]; then
#                         b=$(( (dec-16)%6  )); b=$(( b==0?0: b*40 + 55 ))
#                         g=$(( (dec-16)/6%6)); g=$(( g==0?0: g*40 + 55 ))
#                         r=$(( (dec-16)/36 )); r=$(( r==0?0: r*40 + 55 ))
#                         printf 'dec= %3s color= #%02x%02x%02x\n' "$dec" "$r" "$g" "$b"
#                 else
#                         gray=$(( (dec-232)*10+8 ))
#                         printf 'dec= %3s  gray= #%02x%02x%02x\n' "$dec" "$gray" "$gray" "$gray"
#                 fi
#                 shift colors
#         done
# }
#
# function bptpb () {
#         for c in "$@"; do
#                 printf "\n$ %s\n" "$c" && eval "$c"
#         done 2>&1 | \
#                 tee >(curl -sF'c=@-' 'https://ptpb.pw/?u=1' | xsel -ib) >&2
# }
#
# function eptpb () {
#         cat <(printf '%s ' '$ ' "$@" $'\n\n') <(eval "$@" 2>&1) | \
#                 tee >(curl -sF'c=@-' 'https://ptpb.pw/?u=1' | xsel -ib) >&2
# }
#
# function arec () {
#         asciinema rec -y "/tmp/$$.json"
#         asciinema upload "/tmp/$$.json" | \
#                 grep --line-buffered -o 'http.*' | \
#                 tee >(perl -pe 'chomp if eof' | \
#                 xsel -ib)
# }
#
# ## fix for broken cgmanager
# function cgfix () {
#         while :; do
#                 if mount | grep -wq cgmfs; then
#                         #sudo umount /sys/fs/cgroup || sudo umount /run/cgmanager/fs
#                         sudo umount "$(mount | awk '/cgmfs/ { print $3 }' | sed -n '$ p')" || sudo umount /sys/fs/cgroup
#                         sleep 1
#                 else
#                         sudo mount -t tmpfs cgmfs /sys/fs/cgroup
#                         break
#                 fi
#         done
# }
#
# function ll () {
#         local -a args=( ${@:-.} )
#         if [[ "$#args" -gt 1 ]]; then
#                 local -a dirs=( ${(@f)"$(file -L $args[@] | sed '/directory$/ !d; s/\(^.*\)\/: .*/\1/')"} )
#                 local -a files=( ${(@f)"$(file -L $args[@] | sed '/directory$/ d; :l; s/\(.*\): .*/\1/; t l')"} )
#         else
#                 local -a files=( ${args[@]} )
#         fi
#         [[ "$#dirs" -ne 0 ]] && \ls --color=auto -d $dirs[@]
#         [[ "$#files" -ne 0 ]] && \ls --color=auto $files[@]
# }
#
# function ttable () {
#         [[ "$#" -gt 2 ]] && return 1
#         ## duplicate arg or set both to zero
#         [[ "$#" -eq 1 ]] && set -- "$1" "$1"
#         [[ "$#" -eq 0 ]] && set -- 0 0
#         local -A op
#         op[NOT]='!$1, ~$1 :: !$2, ~$2'
#         op[AND]='$1 & $2'
#         op[OR]='$1 | $2'
#         op[XOR]='$1 ^ $2'
#         op[NAND]='~($1 & $2)'
#         op[NOR]='~($1 | $2)'
#         op[XNOR]='~($1 ^ $2)'
#         echo
#         ## calculate operations and normalize with !!
#         for i in "${(k)op[@]}"; do
#                 ## handle the special NOT case
#                 if [[ "$i" == NOT ]]; then
#                         printf '%s\n' "${(e)op[$i]}"
#                         printf '%s' "$i $(( [#2] $1 )), COMPLEMENT $(( [#2] $2 )) = "
#                         printf '%s, %s\n' "$(( [#2] !$1 ))" "$(( [#2] ~$1 ))"
#                         printf '%s' "$i $(( [#2] $1 )), COMPLEMENT $(( [#2]$2 )) = "
#                         printf '%s, %s\n\n' "$(( [#2] !$2 ))" "$(( [#2] ~$2 ))"
#                 else
#                         printf '%s\n%s' "${(e)op[$i]}" "$(( [#2] $1 )) $i $(( [#2]$2 )) = "
#                         printf '%s (normalized: %s)\n\n' "$(( [#2] ${(e)op[$i]} ))" "$(( [#2] !! ${(e)op[$i]} ))"
#                 fi
#         done
# }
#
# ## base64 encode a file to store in an env variable
# function gzencode () {
#         [[ -z "$*" ]] && local fname="/dev/stdin" || local fname="$*"
#         gzip -c --best "$*" | base64 | perl -pe 'chomp if eof'
# }
#
# ## decode a base64 string to plaintext
# function gzdecode () {
#         [[ -z "$*" ]] && local str="$(</dev/stdin)" || local str="$*"
#         <<<"$str" base64 -d | gzip -d
#         #<<<"$str" tr '-' '\n' | base64 -d | gzip -d
# }
#
# function hgdb () { vim -c "tab h gdbmgr.txt | tabn | q"; }
#
# ## Open vim help page
# function :h () { for i in "$@"; do vim +"help $i" -c 'bunload! 1'; done; }
# function :help () { for i in "$@"; do vim +"help $i" -c 'bunload! 1'; done; }
#
# function rmv () {
#         [[ "$#" -eq 0 ]] && return 1
#         local -a src flags cmd
#         local dest num
#         cmd=( "rsync" )
#         for i in "$@"; do case "$i" in
#                 --) shift
#                         break ;;
#                 -???*) printf "\033[31m%s\033[0m\n" 'Error: malformed flags';
#                         return 4 ;;
#                 -*) shift
#                         flags+=( "${(s::@u)${i//-/}//[^nt]/}" ) ;;
#                         # if [[ "$i" =~ t ]]; dest="${@[-1]}" && shift -p; fi ;;
#         esac; done
#         [[ "$flags[@]" =~ n ]] && cmd=( "echo" "$cmd[@]" )
#         if [[ "$flags[@]" =~ t ]]; then
#                 dest="$1" && shift
#         else
#                 dest="${@[-1]}" && shift -p
#         fi
#         if [[ ! -e "$dest" ]]; then
#                 printf "\033[31m%s\033[0m\n" 'Error: target file/directory not found!'
#                 return 2
#         elif ( [[ -d "$dest" ]] && [[ ! -x "$dest" ]] ) || ( [[ -f "$dest" ]] && [[ ! -w "$dest" ]] ); then
#                 printf "\033[31m%s\033[0m\n" 'Error: target file/directory not writeable!'
#                 return 3
#         fi
#         num="$#"
#         for ((i=0; i<num; i++)); do
#                 if [[ ! -e "$1" ]]; then
#                         printf "\033[31m%s\033[0m\n" 'Error: one or more source files/directories not found!'
#                         return 4
#                 elif ( [[ -d "$1" ]] && [[ ! -x "$1" ]] ) || ( [[ -f "$1" ]] && [[ ! -r "$1" ]] ); then
#                         printf "\033[31m%s\033[0m\n" 'Error: one or more source files/directories not readable!'
#                         return 5
#                 fi
#                 # test -d "$1" && src+=( "$1/" ) || src+=( "$1" )
#                 src+=( "$1" )
#                 shift
#         done
#         # test -d "$dest" && dest="$dest/"
#         for d in "${src[@]}"; do
#                 "$cmd[@]" -avP --remove-source-files --info=progress2 "$d" "$dest"
#         done
# }
#
# function rchgrep () {
#         if [[ "$1" =~ ^[0-9][0-9]*$ ]]; then
#                 local context="$1"
#                 shift
#         else
#                 local context=0
#         fi
#         grep --group-separator=$'\n\n' -wRC"$context" "$*" /usr/include/ 2>/dev/null | \
#                 highlight --syntax=c --out-format=ansi | \
#                 less -FJRMXs
# }
#
# function chgrep () {
#         if [[ "$1" =~ ^[0-9][0-9]*$ ]]; then
#                 local context="$1"
#                 shift
#         else
#                 local context=0
#         fi
#         grep --group-separator=$'\n\n' -wC"$context" "$*" /usr/include/* 2>/dev/null | \
#                 highlight --syntax=c --out-format=ansi | \
#                 less -FJRMXs
# }
#
# function cptpb () {
#         local pchar
#         [[ "$EUID" -eq 0 ]] && pchar='# ' || pchar='$ '
#         if [[ -n "$ZSH_NAME" ]]; then
#                 cat <(printf "\n%s\n" "${pchar}${history[$HISTCMD]}" | sed "s/ *| *cptpb.*//") - <(echo) | \
#                         tee /dev/stderr | \
#                         curl -F"c=@-" https://ptpb.pw 2>/dev/null | \
#                         tee >(awk '/https/ {sub("url: ",""); print}' | \
#                         awk 'NR>1{print PREV} {PREV=$0} END{printf("%s",$0)}' | \
#                         xsel -ib)
#         elif [[ -n "$BASh" ]]; then
#                 cat <(printf "\n%s\n" "${pchar}$(history 1 | sed "s/[0-9]* *\(.*[^ ]\) *| *cptpb.*/\1/")") - <(echo) | \
#                         tee /dev/stderr | \
#                         curl -F"c=@-" https://ptpb.pw 2>/dev/null | \
#                         tee >(awk '/https/ {sub("url: ",""); print}' | \
#                         awk 'NR>1{print PREV} {PREV=$0} END{printf("%s",$0)}' | \
#                         xsel -ib)
#         else
#                 printf "$(tput setaf 9)$(tput bold)%s$(tput sgr0)\n" 'Error: bash/zsh not found!'
#                 return 1
#         fi
#                 # TODO: history doesn't work right with "$shell" -c; figure out how to fix
#                 # local bashcmd zshcmd shell
#                 # shell="$(sh -c 'type -P zsh' || sh -c 'type -P bash')"
#                 # zshcmd='cat <(printf "%s\n" "${pchar}${history[$HISTCMD]}" | sed "s/ *| *cptpb.*//") - <(echo) | \
#                 #         tee /dev/stderr | \
#                 #         curl -F"c=@-" https://ptpb.pw 2>/dev/null | \
#                 #         tee >(awk '\''/https/ {sub("url: ",""); print}'\'' | \
#                 #         awk '\''NR>1{print PREV} {PREV=$0} END{printf("%s",$0)}'\'' | \
#                 #         xsel -ib)'
#                 # bashcmd='cat <(printf "%s\n" "${pchar}$(history 1 | sed "s/[0-9]* *\(.*[^ ]\) *| \
#                 #         *cptpb.*/\1/")") - <(echo) | \
#                 #         tee /dev/stderr | \
#                 #         curl -F"c=@-" https://ptpb.pw 2>/dev/null | \
#                 #         tee >(awk '\''/https/ {sub("url: ",""); print}'\'' | \
#                 #         awk '\''NR>1{print PREV} {PREV=$0} END{printf("%s",$0)}'\'' | \
#                 #         xsel -ib)'
#                 # case "$shell" in
#                 #         *zsh) "$shell" -c "$zshcmd" ;;
#                 #         *bash) "$shell" -c "$bashcmd" ;;
#                 #         *) printf "\033[31m%s\033[0m\n" 'Error: bash/zsh not found!'; return 1;;
#                 # esac
# }
#
# ## newpl - creates a basic Perl script file and opens it with $EDITOR
# function newpl () {
#         [[ -z "$*" ]] && return 1
#         ## if the file exists, just open it
#         ## if it doesn't, make it, and open it
#         [[ -r "$1" ]] && \
#                 printf '%s\n' "$1"' exists; not modifying.' || \
#                 printf '%s\n' '#!/usr/bin/env perl' $'\n' 'use strict;' 'use warnings;' > "$1"
#         "${EDITOR:-vim}" "$1"
# }
#
# ## Perl grep, because 'grep -P' is terrible. Lets you work with pipes or files.
# function prep () { perl -nle 'print if /'"$1"'/;' "$2"; }
#
# function quote () {
#         printf '$*:\t'; printf '"%s" ' $*; echo
#         printf '"$*":\t'; printf '"%s" ' "$*"; echo
#         printf '$@:\t'; printf '"%s" ' $@; echo
#         printf '"$@":\t'; printf '"%s" ' "$@"; echo
# }
#
# function cdg () {
#         pushd "${CONF:-/store/config}" >/dev/null
# }
#
# function gcd () {
#         cd "${HOME}/git" || return
#         local clonedir
#         clonedir="${*##*/}"
#         clonedir="${clonedir%%.git}"
#         git clone "$*" && pushd "$clonedir" >/dev/null
#         unset clonedir
# }
#
# ## dotfiles
# function l. () { ls -dCX --color=auto "${*:-./}/".*; }
#
# ## all dirs
# function ldr () { ls -dCX --color=auto "${*:-./}/"*/; }
#
# function empty () {
#         (
#         local arg
#         arg="$1"
#         cd "$arg" || return 77
#         # if [[ "$0" == ?zsh ]]; then setopt nullglob; elif [[ "$0" == ?bash ]]; then shopt nullglob; else return 64; fi
#         if [[ -n "$ZSH_NAME" ]]; then setopt nullglob; elif [[ -n "$BASH" ]]; then shopt nullglob; else return 64; fi
#         if [[ -n "$2" ]]; then printf "$(tput setaf 9)%s\n$(tput sgr0)" "Too many arguments!" && return 64; fi
#         set --  * .[\!.]* ..?*
#         if [[ -n "$4" ]] || ! for i; do test -e "$i" && break; done; then
#                 printf "$(tput setaf 9)%s\n$(tput sgr0)" "$arg is not empty!" && return 1
#         else
#                 printf "$(tput setaf 10)%s\n$(tput sgr0)" "$arg is empty!"
#         fi
#         )
# }
#
# function isempty () {
#         (
#         # if [[ "$0" == ?zsh ]]; then setopt nullglob; elif [[ "$0" == ?bash ]]; then shopt nullglob; else return 64; fi
#         if [[ -n "$ZSH_NAME" ]]; then setopt nullglob; elif [[ -n "$BASH" ]]; then shopt nullglob; else return 64; fi
#         cd "$1" || return 77
#         set -- * .[\!.]* ..?*
#         [[ -n "$4" ]] && return 1
#         for i; do test -f "$i" && return 1; done
#         )
# }
#
# ## (replace W, H, X, Y, file)
# function xrec () {
#         local comp
#         comp=1
#         pidof compton >/dev/null && killall compton || comp=0
#         ffmpeg -probesize 512M -s 2160x1440 -r "${2:-25}" \
#                 -f x11grab -i :0.0 \
#                 -an -framerate "${2:-25}" -video_size cif \
#                 -c:v libx264 -crf 0 -preset ultrafast -pix_fmt yuv420p -y "${1:-/tmp/out.mkv}"
#                 # -c:v libx265 -crf 0 -preset ultrafast -pix_fmt yuv420p -y "${1:-/tmp/out.mkv}"
#         # [[ "$comp" -ne 0 ]] && compton -cCGfF -b -i 0.85
#         [[ "$comp" -ne 0 ]] && compton -b
# }
#
# function news_short () {
#         echo -e "$(echo $(curl -m 5 -s ${1:-'https://www.archlinux.org/feeds/news/'} | \
#                 sed -e ':a;N;$!ba;s/\n/ /g') | \
#                         sed -e '
#                         s/&amp;/\&/g
#                         s/&lt;\|&#60;/</g
#                         s/&gt;\|&#62;/>/g
#                         s/<\/a>/£/g
#                         s/href\=\"g/§/
#                         s/<title>/\\e[01;29m \\n   ::\\e[01;31m /g; s/<\/title>/ \\e[00m:: \\e[00m\\n/g
#                         s/<link>/ [ \\e[01;36m/g; s/<\/link>/\\e[00m ]\\e[00m/g
#                         s/<description>/\\n\\n\\e[00;37m/g; s/<\/description>/\\e[00m\\n\\n/g
#                         s/<p\( [^>]*\)\?>\|<br\s*\/\?>/\n/g
#                         s/<b\( [^>]*\)\?>\|<strong\( [^>]*\)\?>/\\e[01;30m/g; s/<\/b>\|<\/strong>/\\e[00;37m/g
#                         s/<i\( [^>]*\)\?>\|<em\( [^>]*\)\?>/\\e[41;37m/g; s/<\/i>\|<\/em>/\\e[00;37m/g
#                         s/<u\( [^>]*\)\?>/\\e[4;37m/g; s/<\/u>/\\e[00;37m/g
#                         s/<code\( [^>]*\)\?>/\\e[00m/g; s/<\/code>/\\e[00;37m/g
#                         s/<a[^§|t]*§\([^\"]*\)\"[^>]*>\([^£]*\)[^£]*£/\\e[01;31m\2\\e[00;37m \\e[01;34m[\\e[00;37m \\e[04m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g
#                         s/<li\( [^>]*\)\?>/\n \\e[01;34m*\\e[00;37m /g
#                         s/<!\[CDATA\[\|\]\]>//g
#                         s/\|>\s*<//g
#                         s/ *<[^>]\+> */ /g
#                         s/[<>£§]//g
#                 ')\n\n" | \
#                 grep --line-buffered -E '^(   :| \[)' | \
#                 sed 's/^.*\(:.*::\)/:\1/g' | \
#                 awk '{ line[NR] = $0 } END { for (i = NR; i > 0; i -= 2) { print line[i-1]; print line[i] } }'
# }
#
# function news_long () {
#         echo -e "$(echo $(curl -m 5 -s ${1:-'https://www.archlinux.org/feeds/news/'} | \
#                 sed -e ':a;N;$!ba;s/\n/ /g') | \
#                         sed -e '
#                         s/&amp;/\&/g
#                         s/&lt;\|&#60;/</g
#                         s/&gt;\|&#62;/>/g
#                         s/<\/a>/£/g
#                         s/href\=\"g/§/
#                         s/<title>/\\e[01;29m \\n   ::\\e[01;31m /g; s/<\/title>/ \\e[00m:: \\e[00m\\n/g
#                         s/<link>/ [ \\e[01;36m/g; s/<\/link>/\\e[00m ]\\e[00m/g
#                         s/<description>/\\n\\n\\e[00;37m/g; s/<\/description>/\\e[00m\\n\\n/g
#                         s/<p\( [^>]*\)\?>\|<br\s*\/\?>/\n/g
#                         s/<b\( [^>]*\)\?>\|<strong\( [^>]*\)\?>/\\e[01;30m/g; s/<\/b>\|<\/strong>/\\e[00;37m/g
#                         s/<i\( [^>]*\)\?>\|<em\( [^>]*\)\?>/\\e[41;37m/g; s/<\/i>\|<\/em>/\\e[00;37m/g
#                         s/<u\( [^>]*\)\?>/\\e[4;37m/g; s/<\/u>/\\e[00;37m/g
#                         s/<code\( [^>]*\)\?>/\\e[00m/g; s/<\/code>/\\e[00;37m/g
#                         s/<a[^§|t]*§\([^\"]*\)\"[^>]*>\([^£]*\)[^£]*£/\\e[01;31m\2\\e[00;37m \\e[01;34m[\\e[00;37m \\e[04m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g
#                         s/<li\( [^>]*\)\?>/\n \\e[01;34m*\\e[00;37m /g
#                         s/<!\[CDATA\[\|\]\]>//g
#                         s/\|>\s*<//g
#                         s/ *<[^>]\+> */ /g
#                         s/[<>£§]//g
#                 ')\n\n" | \
#                 grep --line-buffered '' | \
#                 awk '{ line[NR] = $0 } END { for (i = NR; i > 0; i--) { print line[i]; } }' | \
#                 sed '/^$/d'
# }
#
# function genchee () {
#         #awk -F'\t' $'$3 ~ /^what if/ {print $3}' $HOME/.weechat/logs/irc.znc.\#archlinux-offtopic.weechatlog
#         [[ "${#}" -lt 2 ]] && return 1
#         local logfile="$1"
#         shift
#         awk -F'\t' $'$3 ~ /^'"${*}"$'/ {print $3}' "$logfile"
# }
#
# function gnpm () { npm -g install --prefix "${HOME}/.node_modules" "$@"; }
#
# function gt () {
#         chromium "https://translate.google.com/#auto/en/$(<<<${*} sed 's/http:\/\//☃/g
#                 s/https:\/\//⛇/g
#                 s/\//∞/g
#                 s/%/%25/g
#                 s/ /%20/g
#                 s/ /%09/g
#                 s/!/%21/g
#                 s/"/%22/g
#                 s/#/%23/g
#                 s/\$/%24/g
#                 s/\&/%26/g
#                 s/'\''/%27/g
#                 s/(/%28/g
#                 s/)/y%29/g
#                 s/\*/%2a/g
#                 s/+/%2b/g
#                 s/,/%2c/g
#                 s/-/%2d/g
#                 s/\./%2e/g
#                 s/\//%2f/g
#                 s/:/%3a/g
#                 s/;/%3b/g
#                 s//%3e/g
#                 s/?/%3f/g
#                 s/@/%40/g
#                 s/\[/%5b/g
#                 s/\\/%5c/g
#                 s/\]/%5d/g
#                 s/\^/%5e/g
#                 s/_/%5f/g
#                 s/`/%60/g
#                 s/{/%7b/g
#                 s/|/%7c/g
#                 s/}/%7d/g
#                 s/~/%7e/g
#                 s/	  /%09/g
#                 s/☃/http:\/\//g
#                 s/⛇/https:\/\//g
#                 s/∞/\//g')"
# }
#
# # sspc () { { pacman -Ss --color="always" "$@"; cower -s --color="always" "$@"; } 2>&1 | less -FJRMXs; }
# function pspc () { pacaur -Ss --color="always" "${@/-S/-}" 2>&1 | less -FJRMXs; }
#
# # l () { less -JRMs "$@"; }
# function l () { less -FJRMXs "$@"; }
#
# function wttr() { curl "wttr.in/${*}"; }
#
# # high() { printf "$(sed 's/'"${*}"'/\\e[1;35m&\\e[0m/g')"; }
# function high () {
#         local args="$#" syn out file
#         if [[ "$args" -gt 2 ]]; then
#                 local syn="$1" && shift
#                 local out="$1" && shift
#         elif [[ "$args" -eq 2 ]]; then
#                 local syn="$1" && shift
#         fi
#         [[ -t 0 ]] && file="/dev/stdin" || file="$1"
#         [[ "$file" == - ]] && file="/dev/stdin"
#         highlight --syntax="${syn:-conf}" --out-format="${out:-ansi}" "$file"
# }
#
# function lstput () {
#         local text="
#                 $(tput sgr0)	creset - [sgr0]
#                 $(tput setaf 1)	cred - [setaf 1]
#                 $(tput setaf 4)	cblue - [setaf 4]
#                 $(tput setaf 2)	cgreen - [setaf 2]
#                 $(tput setaf 0)	cblack - [setaf 0]
#                 $(tput setaf 1)	cred - [setaf 1]
#                 $(tput setaf 2)	cgreen - [setaf 2]
#                 $(tput setaf 3)	cyellow - [setaf 3]
#                 $(tput setaf 4)	cblue - [setaf 4]
#                 $(tput setaf 5)	cviolet - [setaf 5]
#                 $(tput setaf 6)	ccyan - [setaf 6]
#                 $(tput setaf 7)	cwhite - [setaf 7]
#                 $(tput setaf 8)	cindigo - [setaf 8]
#                 $(tput setaf 9)	cmaroon - [setaf 9]"
#         printf '%s\n' "${text//	/}"
# }
#
# function mobi () {
#         ebook-convert "$1" .mobi --enable-heuristics &
#         [[ -z "$2" ]] && return 0
#         shift
#         mobi "$@"
# }
#
# function epub () {
#         ebook-convert "$1" .epub --enable-heuristics &
#         [[ -z "$2" ]] && return 0
#         shift
#         epub "$@"
# }
#
# function pdf () {
#         ebook-convert "$1" .pdf --enable-heuristics &
#         [[ -z "$2" ]] && return 0
#         shift
#         pdf "$@"
# }
#
# function kpdf () {
#         <<<$'\n' k2pdfopt -bpc 1 -dev kp2 -x "$1" >/dev/null 2>&1 &
#         [[ -z "$2" ]] && return 0
#         shift
#         kpdf "$@"
# }
#
# function ckpdf () {
#         <<<$'\n' k2pdfopt -c -bpc 1 -dev kp2 -x "$1" >/dev/null 2>&1 &
#         [[ -z "$2" ]] && return 0
#         shift
#         ckpdf "$@"
# }
#
# function dkpdf () {
#         <<<$'\n' k2pdfopt -bpc 1 -d- -dev kp2 -x "$1" >/dev/null 2>&1 &
#         [[ -z "$2" ]] && return 0
#         shift
#         dkpdf "$@"
# }
#
# function imgurredirect () {
#         url="$(curl "$1" | grep '<meta property="og:image"')"
#         url="${url/*content=\"/}"
#         url="${url/*\" \/>$/}"
#         feh "$url"
#         [[ -z "$2" ]] && return 0
#         shift
#         imgurredirect "$@"
# }
#
# function mpvcmd () { notify-send "mpv: loading..." "$@"; mpv --loop=inf "$@"; }
#
# function plu () {
#         case "$1" in
#                 *://nibbler*/*) /usr/bin/chromium "$1" ;;
#                 *://i.imgur.com/*.gifv|*://imgur.com/*.gifv) mpvcmd "${1/.gifv/.gif}" ;;
#                 *.webm|*.gif|*.gifv|*.mp4|*.avi|*.mkv|*.mov|*.flv) mpvcmd "$1" ;;
#                 #*://ptpb.pw/*/text) pyb.py "$1" ;;
#                 *://i.imgur.com/*) feh "$1" ;;
#                 *://imgur.com/*) imgurredirect "$1" ;;
#                 *.jpg|*.jpeg|*.png) feh "$1" ;;
#                 *://dpaste.de/*) pyb.py "$1" ;;
#                 *://*youtube.com/*) mpvcmd "$1" ;;
#                 *://*youtu.be/*) mpvcmd "$1" ;;
#                 #*://alyp.tk/pb|*://ptpb.pw|*://alyp.tk/pb/|*://ptpb.pw/) /usr/bin/chromium "$1" ;;
#                 *://alyp.tk/pb/*.sh|*://alyp.tk/pb/*.bash|*://alyp.tk/pb/*.zsh) gvim -c "setf sh" -p "${1%/*}" ;;
#                 *://ptpb.pw/*.sh|*://ptpb.pw/*.bash|*://ptpb.pw/*.zsh) gvim -c "setf sh" -p "${1%/*}" ;;
#                 *://alyp.tk/pb/*.sh|*://ptpb.pw/*.sh) gvim -c "setf sh" -p "${1%/*}" ;;
#                 *://alyp.tk/pb/*.*|*://ptpb.pw/*.*) /usr/bin/chromium "$1" ;;
#                 *://alyp.tk/pb/*/text|*://alyp.tk/pb/*/sh|*://alyp.tk/pb/*/bash) gvim -c "setf sh" -p "${1%/*}" ;;
#                 *://ptpb.pw/*/text*|*://ptpb.pw/*/sh|*://ptpb.pw/*/bash) gvim -c "setf sh" -p "${1%/*}" ;;
#                 *://alyp.tk/pb/\~*|*://ptpb.pw/\~*) /usr/bin/chromium "$1" ;;
#                 *://alyp.tk/pb/*|*://ptpb.pw/*) gvim -c "setf sh" -p "${1%/*}" ;;
#                 *://alyp.tk/pb/*/*|*://ptpb.pw/*/*|*://alyp.tk/pb/*/|*://ptpb.pw/*/) gvim -c "setf ${1##*/}" -p "${1%/*}" ;;
#                 # *://alyp.tk/pb/*|*://ptpb.pw/*) pyb.py "$1" ;;
#                 *://pastebin.com/raw*) gvim -c "setf sh" -p "$1" ;;
#                 *://) /usr/bin/chromium "$1" ;;
#                 *) xdg-open "$1" ;;
#         esac
#         [[ -z "$2" ]] && return 0
#         shift
#         plu "$@"
# }
#
# function dco () { mkdir "/tmp/aur" && cower -t "/tmp/aur" -dd "$@" && pushd "/tmp/aur/$1" >/dev/null 2>&1; }
#
# function __fzf_readline () {
#         builtin eval "
#                 builtin bind ' \
#                         \"\C-x3\": $(
#                                 builtin bind -l | command fzf +s +m --toggle-sort=ctrl-r
#                         ) \
#                 '
#         "
# }
#
# function __fzf_history () { __ehc $(history | fzf --tac --tiebreak=index | perl -ne 'm/^\s*([0-9]+)/ and print "!$1"'); }
#
# function __ehc () {
#         if [[ -n $1 ]]; then
#                 bind '"\er": redraw-current-line'
#                 bind '"\e^": magic-space'
#                 READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${1}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
#                 READLINE_POINT=$(( READLINE_POINT + ${#1} ))
#         else
#                 bind '"\er":'
#                 bind '"\e^":'
#         fi
# }
#
# function __fzf-edit-history () {
#         builtin history -a
#         builtin history -c
#         builtin history -r
#         builtin typeset \
#                 READLINE_LINE_NEW="$(
#                         HISTTIMEFORMAT= builtin history |
#                         command fzf +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r |
#                         command sed '
#                                 /^ *[0-9]/ {
#                                         s/ *\([0-9]*\) .*/!\1/;
#                                         b end;
#                                 };
#                                 d;
#                                 : end
#                         '
#                 )"
#         if [[ -n $READLINE_LINE_NEW ]]; then
#                 builtin bind '"\er": redraw-current-line'
#                 builtin bind '"\e^": magic-space'
#                 READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
#                 READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
#         else
#                 builtin bind '"\er":'
#                 builtin bind '"\e^":'
#         fi
# }
#
# ## fs [FUZZY PATTERN] - Select selected tmux session
# ##   - Bypass fuzzy finder if there's only one match (--select-1)
# ##   - Exit if there's no match (--exit-0)
# function fs () {
#         local session
#         session=$(tmux list-sessions -F "#{session_name}" | \
#         fzf --query="$1" --select-1 --exit-0) && \
#         tmux switch-client -t "$session"
# }
#
# ## ftpane - switch pane (@george-b)
# ## In tmux.conf
# ## bind-key 0 run "tmux split-window -l 12 'bash -ci ftpane'"
# function ftpane () {
#         local panes current_window current_pane target target_window target_pane
#         panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
#         current_pane=$(tmux display-message -p '#I:#P')
#         current_window=$(tmux display-message -p '#I')
#         target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return
#         target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
#         target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)
#         if [[ $current_window -eq $target_window ]]; then
#                 tmux select-pane -t ${target_window}.${target_pane}
#         else
#                 tmux select-pane -t ${target_window}.${target_pane} && \
#                         tmux select-window -t $target_window
#         fi
# }
#
# ## fh - repeat history
# function fh () { print -z $( ( [[ -n "$ZSH_NAME" ]] && fc -l 1 || history ) | fzf +s --tac | sed 's/ *[0-9]* *//'); }
# # fh () { ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | runcmd; }
#
# ## fhe - repeat history edit
# function fhe () { ( [[ -n "$ZSH_NAME" ]] && fc -l 1 || history ) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | writecmd; }
#
# function runcmd () { perl -e 'ioctl STDOUT, 0x5412, $_ for split //, <>'; }
#
# function writecmd () { perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }'; }
#
# ## Modified version where you can press
# ##   - CTRL-O to open with `open` command,
# ##   - CTRL-E or Enter key to open with the $EDITOR
# function fo () {
#         local out file key
#         IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
#         key=$(head -1 <<< "$out")
#         file=$(head -2 <<< "$out" | tail -1)
#         if [[ -n "$file" ]]; then
#                 [[ "$key" == ctrl-o ]] && xdg-open "$file" || ${EDITOR:-vim} "$file"
#         fi
# }
#
# ## vf - fuzzy open with vim from anywhere
# ## ex: vf word1 word2 ... (even part of a file name)
# ## zsh autoload function
# function vf () {
#         local files
#         files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})
#         if [[ -n "$files" ]]; then
#                 vim -- $files
#                 print -l $files[1]
#         fi
# }
#
# ## cf - fuzzy cd from anywhere
# ## ex: cf word1 word2 ... (even part of a file name)
# ## zsh autoload function
# function cf () {
#         local file
#         file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"
#         if [[ -n $file ]]
#         then
#                 if [[ -d $file ]]
#                         then
#                         cd -- $file
#                 else
#                         cd -- ${file:h}
#                 fi
#         fi
# }
#
# ## fkill - kill process
# function fkill () { local pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}'); [ -n "$pid" ] && kill -"${1:-15}" "$pid"; }
#
# ## ftags - search ctags
# function ftags () {
#         local line
#         [ -e tags ] && \
#         line=$(awk 'BEGIN {FS="\t"} !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags | cut -c1-80 | fzf --nth=1,2) && \
#         ${EDITOR:-vim} $(cut -f3 <<< "$line") -c "set nocst" -c "silent tag $(cut -f2 <<< "$line")"
# }
#
# ## fshow - git commit browser
# function fshow () {
#         git log --graph --boundary --all --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" | \
#         fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort --bind "ctrl-m:execute:
#                 (grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R') \
#                 < <(printf '\n%s\n' {})"
# }
#
# # fshow () {
# #          git log --graph --color=always \
# #           --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" | \
# #          fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
# #                   --bind "ctrl-m:execute:
# #                                 (grep -o '[a-f0-9]\{7\}' | head -1 |
# #                                 xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
# #                                 {}
# # FZF-EOF"
# # }
#
# ## fbr - checkout git branch (including remote branches)
# function fbr () {
#         local branches branch
#         branches=$(git branch --all | grep -v HEAD) && \
#         branch=$(echo "$branches" | \
#                 fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) && \
#         git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
# }
#
# ## fco - checkout git branch/tag
# function fco () {
#         local tags branches target
#         tags=$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
#         branches=$(git branch --all | grep -v HEAD | \
#         sed "s/.* //" | sed "s#remotes/[^/]*/##" | \
#         sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
#         target=$({ echo "$tags"; echo "$branches"; } | \
#         fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
#         git checkout $(echo "$target" | awk '{print $2}')
# }
#
# ## fcs - get git commit sha
# function fcs () {
#         ## example usage: git rebase -i `fcs`
#         local commits commit
#         commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) && \
#         commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) && \
#         printf '%s' $(echo "$commit" | sed "s/ .*//") | tee >(xclip -i -selection clipboard)
# }
#
# # fstash - easier way to deal with stashes
# # type fstash to get a list of your stashes
# # enter shows you the contents of the stash
# # ctrl-d shows a diff of the stash against your current HEAD
# # ctrl-b checks the stash out as a branch, for easier merging
# function fstash () {
#         local out q k sha
#         while out=$(git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" | \
#                 fzf --ansi --no-sort --query="$q" --print-query \
#                 --expect=ctrl-d,ctrl-b
#         ); do
#         mapfile -t out <<<"$out"
#         q="${out[0]}"
#         k="${out[1]}"
#         sha="${out[-1]}"
#         sha="${sha%% *}"
#         [[ -z "$sha" ]] && continue
#         if [[ "$k" == 'ctrl-d' ]]; then
#                 git diff $sha
#         elif [[ "$k" == 'ctrl-b' ]]; then
#                 git stash branch "stash-$sha" $sha
#                 break
#         else
#                 git stash show -p $sha
#         fi
#         done
# }
#
# ## c(crf) - browse chrome history
# function crf () {
#         local cols sep
#         cols=$(( COLUMNS / 3 ))
#         sep='{{::}}'
#         # Copy History DB to circumvent the lock
#         # - See http://stackoverflow.com/questions/8936878 for the file path
#         cp -f "${HOME}/.config/chromium/Default/History" "/tmp/h"
#         sqlite3 -separator "$sep" /tmp/h \
#         "select substr(title, 1, $cols), url
#         from urls order by last_visit_time desc" | \
#         awk -F "$sep" '{ printf "%-'$cols's  \x1b[36m%s\n", $1, $2 }' | \
#         fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs xdg-open
# }
#
# # v - open files in ~/.viminfo
# function fv () {
#         local files
#         files=$(grep '^>' ~/.viminfo | cut -c3- | \
#                 while read line; do [ -f "${line/\~/$HOME}" ] && echo "$line"; done | \
#                 fzf-tmux -d -m -q "$*" -1) && vim "${files//\~/$HOME}"
# }
#
# function fmpc () {
#         local song_position
#         song_position=$(mpc -f "%position%) %artist% - %title%" playlist | \
#         fzf-tmux --query="$1" --reverse --select-1 --exit-0 | \
#         sed -n 's/^\([0-9]\+\)).*/\1/p') || return 1
#         [ -n "$song_position" ] && mpc -q play "$song_position"
# }
#
# function ix () {
#         local opts
#         local OPTIND
#         [ -f "$HOME/.netrc" ] && opts='-n'
#         while getopts ":hd:i:n:" x; do
#         case $x in
#                 h) echo "ix [-d ID] [-i ID] [-n N] [opts]"; return;;
#                 d) curl $opts -X DELETE ix.io/$OPTARG; return;;
#                 i) opts="$opts -X PUT"; local id="$OPTARG";;
#                 n) opts="$opts -F read:1=$OPTARG";;
#         esac
#         done
#         shift $(($OPTIND - 1))
#         [[ -t 0 ]] && {
#         local filename="$1"
#         shift
#         [[ -n "$filename" ]] && {
#                 eval "curl -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) \
#                         AppleWebKit/537.36 (KHTML, like Gecko) \
#                         Chrome/44.0.2403.89 Safari/537.36' --progress-bar $opts -F f:1=@$filename $* ix.io/$id"
#                 return
#         }
#         echo "^C to cancel, ^D to send."
#         }
#         eval "curl -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) \
#                         AppleWebKit/537.36 (KHTML, like Gecko) \
#                         Chrome/44.0.2403.89 Safari/537.36' --progress-bar $opts -F f:1='<-' $* ix.io/$id"
# }
#
# function ccffmpeg () {
#         local input output
#         local -a ext
#         if [[ -z "$2" ]]; then
#                 [[ "${1##*.}" == "gif" ]] && ext=('gif') || ext=('copy')
#                 input="${1##*.}"
#                 output="$1"
#         else
#                 if [[ "${2##*.}" == "$1" ]]; then
#                         ext=('copy')
#                 else
#                         [[ "${2##*.}" == "gif" ]] && ext=('gif') || ext=('hevc' '-preset' 'ultrafast')
#                 fi
#                 input="${1##*.}"
#                 output="$2"
#         fi
#         ffmpeg -safe 0 -f concat \
#                 -i <(find . -name "*.$input" -printf "file '${PWD}/%P'\n") \
#                 -c:v "${ext[@]}" -c:a copy \
#                 "$output" -threads 0
# }
#
# function pdeps () {
#         pacaur --color=never -Si "$@" | \
#                 sed -r '/Optional/,/Conflicts/!d
#                         /Conflicts/d
#                         s/Optional[^:]*://
#                         s/:.*//' | \
#                 paste -sd' ' | \
#                 sed -r 's/[^a-z0-9-]+/ /g
#                         s/^ //
#                         s/18 //g;' | xargs -n1 | sort -u
#                 # sed '/Optional/,/Conflicts/!d; /Conflicts/d; s/Optional[^:]*://; s/:.*//' | \
#                 # perl -ne 'chomp
#                 #         push @a, $_;
#                 #         END { my $b = join " ", @a
#                 #         $b =~ s/[^a-z-]+/ /g
#                 #         $b =~ s/(?<= )[[:alnum:]] //g
#                 #         $b =~ s/^ //
#                 #         print $b }' | xargs -n1 | sort -u
# }
#
# function pwns () { pacman -Qo "$@" || pacman -Qo $(which "$@" 2>/dev/null); }
#
# function .. () { cd ../; }
# function ... () { cd ../../; }
# function .... () { cd ../../../; }
# function ..... () { cd ../../../../; }
#
# function sgm () { gm import -window ${1:-root} /tmp/$$.png && <<<"/tmp/$$.png" xclip -i -selection clipboard; }
#
# function fman () {
#         local width pager query page section
#         if [[ "$1" =~ ^([0-9lnpx]|3p|3pe|3per|3perl)$ ]]; then
#                 section="$1"
#                 shift
#         else
#                 # section="$(man -w bash 2>/dev/null | sed -r 's@^[^/]*/[^\.]*\.([^\.]*)(\.gz|)$@\1@')"
#                 section="$(man -w bash 2>/dev/null | sed -r 's@^.*/man(.)/[^/]*$@\1@')"
#         fi
#         width="$(tput cols)" pager="less" page="$1"
#         shift
#         [[ -z "$1" ]] && query= || query="p$(<<<"$*" tr '[[:upper:]]' '[[:lower:]]' | \
#                         tr -d '\n' | \
#                         od -tx1 | \
#                         sed 's/^[0-9]* //;$ d;s/^/ /;s/ /\\x/g; s/^ //; s/\\x20/&\*/g')"
#         env \
#                 PAGER="$pager" \
#                 MANWIDTH="$width" \
#                 LESS="JMRXs${query}" \
#                 GROFF_NO_SGR=1 \
#                 LESS_TERMCAP_se=$'\E[0m' \
#                 LESS_TERMCAP_me=$'\E[0m' \
#                 LESS_TERMCAP_us=$'\E[4;32;4;132m' \
#                 LESS_TERMCAP_ue=$'\E[0m' \
#                 LESS_TERMCAP_so=$'\E[30;43m' \
#                 LESS_TERMCAP_md=$'\E[1;31m' \
#                 man "$section" "$page"
#         unset width pager query page section
# }
#
# function favicon () {
#         local ico
#         touch "./favicon.ico" && ico="./favicon.ico" || ico="/tmp/favicon.ico"
#         convert -resize x16 -gravity center -crop 16x16+0+0 \
#         <(curl -H "User-Agent: Mozilla/5.0 \
#                 (Macintosh; Intel Mac OS X 10_10_3) \
#                 AppleWebKit/537.36 (KHTML, like Gecko) \
#                 Chrome/44.0.2403.89 Safari/537.36" \
#                 --progress-bar "http://www.google.com/s2/favicons?domain=${*:?No URL specified!}") \
#         -background transparent -flatten -colors 256 \
#         "$ico"
#         <<<"$ico" tee >(xclip -i -selection clipboard)
# }
#
# function jpg2ico () {
#         convert -resize x16 -gravity center -crop 16x16+0+0 \
#         "${1:?Error: no input file specified!}" \
#         -transparent white -colors 256 \
#         "${2:-${1%.*}.ico}"
# }
#
# function png2ico () {
#         convert -resize x16 -gravity center -crop 16x16+0+0 \
#         "${1:?Error: no input file specified!}" \
#         -flatten -colors 256 \
#         "${2:-${1%.*}.ico}"
# }
#
# function ico () {
#         if [[ "${1##*.}" =~ ^jp[e]?g$ ]]; then
#         convert -resize x16 -gravity center -crop 16x16+0+0 \
#                 "${1:?Error: no input file specified!}" \
#                 -transparent white -colors 256 \
#                 "${2:-${1%.*}.ico}"
#         else
#         convert -resize x16 -gravity center -crop 16x16+0+0 \
#                 "${1:?Error: no input file specified!}" \
#                 -background transparent -flatten -colors 256 \
#                 "${2:-${1%.*}.ico}"
#         fi
# }
#
# function gif () { ffmpeg -i "${1:?Error: no input file specified!}" "${2:-${1%.*}.gif}" -threads 0; }
#
# function yay () {
#         mpv --lavfi-complex="[aid1] asplit [ao], afifo, \
#         showcqt=fps=60:size=2160x1280:count=2:bar_g=2:sono_g=4:sono_v=9:text=1:tc=0.33:tlength='st(0,0.17); \
#         384*tc / (384 / ld(0) + tc*f /(1-ld(0))) + 384*tc / (tc*f / ld(0) + 384 /(1-ld(0)))', \
#         format=yuv420p [vo]" "$@"
# }
#
# function xlog () { grep -i --color "$*" /var/log/Xorg.0.log; }
#
# function urlencode () {
#         <<<$* sed 's/http:\/\//☃/g
#                 s/https:\/\//⛇/g
#                 s/\//∞/g
#                 s/%/%25/g
#                 s/ /%20/g
#                 s/ /%09/g
#                 s/!/%21/g
#                 s/"/%22/g
#                 s/#/%23/g
#                 s/\$/%24/g
#                 s/\&/%26/g
#                 s/'\''/%27/g
#                 s/(/%28/g
#                 s/)/y%29/g
#                 s/\*/%2a/g
#                 s/+/%2b/g
#                 s/,/%2c/g
#                 s/-/%2d/g
#                 s/\./%2e/g
#                 s/\//%2f/g
#                 s/:/%3a/g
#                 s/;/%3b/g
#                 s//%3e/g
#                 s/?/%3f/g
#                 s/@/%40/g
#                 s/\[/%5b/g
#                 s/\\/%5c/g
#                 s/\]/%5d/g
#                 s/\^/%5e/g
#                 s/_/%5f/g
#                 s/`/%60/g
#                 s/{/%7b/g
#                 s/|/%7c/g
#                 s/}/%7d/g
#                 s/~/%7e/g
#                 s/	  /%09/g
#                 s/☃/http:\/\//g
#                 s/⛇/https:\/\//g
#                 s/∞/\//g'
# }
#
# function urldecode () {
#         <<<$* sed 's/%25/%/gi
#                 s/%20/ /gi
#                 s/%09/ /gi
#                 s/%21/!/gi
#                 s/%22/"/gi
#                 s/%23/#/gi
#                 s/%24/\$/gi
#                 s/%26/\&/gi
#                 s/%27/'\''/gi
#                 s/%28/(/gi
#                 s/%29/)/gi
#                 s/%2a/\*/gi
#                 s/%2b/+/gi
#                 s/%2c/,/gi
#                 s/%2d/-/gi
#                 s/%2e/\./gi
#                 s/%2f/\//gi
#                 s/%3a/:/gi
#                 s/%3b/;/gi
#                 s/%3d/=/gi
#                 s/%3e//gi
#                 s/%3f/?/gi
#                 s/%40/@/gi
#                 s/%5b/\[/gi
#                 s/%5c/\\/gi
#                 s/%5d/\]/gi
#                 s/%5e/\^/gi
#                 s/%5f/_/gi
#                 s/%60/`/gi
#                 s/%7b/{/gi
#                 s/%7c/|/gi
#                 s/%7d/}/gi
#                 s/%7e/~/gi
#                 s/%09/	  /gi'
# }
#
# function mp () { chromium "https://metacpan.org/search?size=50&q=$(<<<"$*" tr ' ' '+')" >/dev/null 2>&1; }
# function rd () { chromium "https://www.google.com/search?q=site:reddit.com+$(<<<"$*" tr ' ' '+')" >/dev/null 2>&1; }
# function wi () { chromium " https://en.wikipedia.org/w/index.php?search=$(<<<"$*" tr ' ' '+')" >/dev/null 2>&1; }
# function gg () { chromium "https://www.google.com/search?q=$(<<<"$*" tr ' ' '+')" >/dev/null 2>&1; }
# function book () { chromium "https://www.duckduckgo.com/?q=%21bzz+$(<<<"$*" tr ' ' '+')" >/dev/null 2>&1; }
# function ddg () { chromium "https://www.duckduckgo.com/?q=$(<<<"$*" tr ' ' '+')" >/dev/null 2>&1; }
# function gh () { chromium "https://github.com/search?q=$(<<<"$*" tr ' ' '+')" >/dev/null 2>&1; }
# function so () { chromium "https://www.google.com/search?q=site:stackexchange.com+$(<<<"$*" tr ' ' '+')" >/dev/null 2>&1; }
# # so() { chromium "http://stackoverflow.com/search?q=$(<<<"$*" tr ' ' '+')" >/dev/null 2>&1; }
#
# function search () {
#         declare -A urls
#         urls[so]="https://stackoverflow.com/search?q="
#         urls[stack]="https://stackoverflow.com/search?q="
#         urls[ddg]="https://www.duckduckgo.com/?q="
#         urls[duckduckgo]="https://www.duckduckgo.com/?q="
#         urls[bzz]="https://www.duckduckgo.com/?q=%21bzz+"
#         urls[g]="https://www.google.com/search?q="
#         urls[google]="https://www.google.com/search?q="
#         urls[github]="https://github.com/search?q="
#         urls[reddit]="https://www.google.com/search?q=site:reddit.com+"
#         urls[bing]="https://www.bing.com/search?q="
#         urls[yahoo]="https://search.yahoo.com/search?p="
#         urls[yandex]="https://yandex.ru/yandsearch?text="
#         urls[baidu]="https://www.baidu.com/s?wd="
#         urls[ecosia]="https://www.ecosia.org/search?q="
#         if [[ "$#" -eq 1 ]]; then
#                 /usr/bin/chromium "https://google.com/?q=$1" >/dev/null 2>&1
#         elif [[ "$#" -eq 0 ]]; then
#                 /usr/bin/chromium "https://google.com" >/dev/null 2>&1
#         else
#                 if [[ -z "$urls[$1]" ]]
#                 then
#                         echo "Search engine $1 not supported."
#                         return 1
#                 else
#                         url="${urls[$1]}"
#                         shift
#                         url="${url}${*}"
#                         url="${url/ /+}"
#                 fi
#                 /usr/bin/chromium "$url" >/dev/null 2>&1
#         fi
# }
#
# function zsearch () {
#         [[ ! "$0" =~ ^.*zsh$ ]] || return 1
#         emulate -L zsh
#         typeset -A urls
#         urls[so]="https://stackoverflow.com/search?q="
#         urls[stack]="https://stackoverflow.com/search?q="
#         urls[ddg]="https://www.duckduckgo.com/?q="
#         urls[duckduckgo]="https://www.duckduckgo.com/?q="
#         urls[bzz]="https://www.duckduckgo.com/?q=%21bzz+"
#         urls[g]="https://www.google.com/search?q="
#         urls[google]="https://www.google.com/search?q="
#         urls[github]="https://github.com/search?q="
#         urls[reddit]="https://www.google.com/search?q=site:reddit.com+"
#         urls[bing]="https://www.bing.com/search?q="
#         urls[yahoo]="https://search.yahoo.com/search?p="
#         urls[yandex]="https://yandex.ru/yandsearch?text="
#         urls[baidu]="https://www.baidu.com/s?wd="
#         urls[ecosia]="https://www.ecosia.org/search?q="
#         if [[ -z "$urls[$1]" ]]
#         then
#                 echo "Search engine $1 not supported."
#                 return 1
#         fi
#         if [[ "$#" -gt 1 ]]
#         then
#                 url="${urls[$1]}${(j:+:)@[2,-1]}"
#         else
#                 url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
#         fi
#         open_command "$url"
# }
#
# function wordcloud () {
#         [[ -z "$*" ]] && return 1
#         local logf="${1?No log specified}"
#         local target="${2:-aot}"
#         wordcloud_cli.py --fontfile ~/.local/share/fonts/FiraCode-Light.otf \
#                         --width 4320 --height 2880 --text \
#                         <(grep ' alyptik ' "${logf}" | sed 's/alyptik//g') \
#                         --imagefile /tmp/${target}.png && \
#                         scp /tmp/${target}.png root@arch:/srv/http/${target}-wordcloud.png && \
#                         ssh rarch chown http:http /srv/http/${target}-wordcloud.png
# }
#
# function smaim () {
#         local comp id
#         comp=1
#         pidof compton >/dev/null && killall compton || comp=0
#         [[ -z "$*" ]] && id="/tmp/$$.png" || id="$*"
#         maim --nokeyboard -s "$id" && \
#                 curl --progress-bar -F"c=@$id" https://ptpb.pw/ | \
#                         tee >(awk '/https/ {sub("url: ",""); print}' | \
#                         awk 'NR>1{print PREV} {PREV=$0} END{printf("%s",$0)}' | \
#                         xsel -ib)
#         [[ "$comp" -ne 0 ]] && compton -cCGfF -b -i 0.85
# }
#
# function fptpb () {
#         #curl https://0x0.st/ \
#         curl --progress-bar -F"c=@${*}" https://ptpb.pw/ | \
#                 tee >(awk '/https/ {sub("url: ",""); print}' | \
#                 awk 'NR>1{print PREV} {PREV=$0} END{printf("%s",$0)}' | \
#                 xsel -ib)
# }
#
# function xfptpb () {
#         curl https://ptpb.pw/ \
#                 -H "User-Agent: Mozilla/5.0 \
#                 (Macintosh; Intel Mac OS X 10_10_3) \
#                 AppleWebKit/537.36 (KHTML, like Gecko) \
#                 Chrome/44.0.2403.89 Safari/537.36" \
#                 --progress-bar -F"c=@${*}" | \
#                 tee >(awk '/https/ {sub("url: ",""); print}' | \
#                 awk 'NR>1{print PREV} {PREV=$0} END{printf("%s",$0)}' | \
#                 xclip -i -selection clipboard)
# }
#
# function sprintf () {
#         local sep=$'\n'
#         [[ ! -z "$2" ]] && { local sep="$1"; shift; }
#         [[ -z "${1?Error: No arguments}" ]] && return 1
#         printf "%s${sep}" "$@"
# }
#
# function flacsplit () {
#         local cuef="$1"
#         local flacf="$2"
#         [[ -z "${1?Error: No cue file specifed}" || -z "${2?Error: No flac file specified}" ]] && return 1
#         cuebreakpoints "$cuef" | shnsplit -o flac "$flacf" -f "$cuef" -t '%n.%t' && \
#                 cuetag.sh "$cuef" [0-9]*.*.flac && \
#                 kid3-cli -c 'select [0-9]*.*.flac' -c 'fromtag "%{artist} - %{title}" 2' -c 'ls' -c 'save'
# }
#
# function ppid () { sudo ps -p ${1:-$$} -o ppid=; }
#
# function mcd () { [ -d "$*" ] || mkdir -p "$*"; pushd "$*"; }
#
# function homepushdcheck () {
#         if [[ "${EUID}" -ne 0 ]]; then
#         [[ "${PWD}" != ${HOME} ]] && {
#         echo -n '[Move to home folder? (y/N)] '; read -r
#         case ${REPLY} in
#                 [Nn]*| [Nn]*|'' ) return 1;;
#                 [Yy]*| [Yy]* ) { pushd .; pushd ${HOME}; } >/dev/null; return 0;;
#                 * ) { pushd .; pushd ${HOME}; } >/dev/null; return 130;;
#         esac
#         }
#         fi
# }
#
# function set_prompt () {
#         Last_Command=$? # Must come first!
#
#         White='\[\e[1;37m\]'
#         Red='\[\e[0;31m\]'
#         Green='\[\e[0;32m\]'
#         Blue='\[\e[1;34m\]'
#         Reset='\[\e[00m\]'
#         FancyX='\342\234\227'
#         Checkmark='\342\234\223'
#
#         #PS1='\[\e[0;32m\]\u@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
#
#         # Add a bright white exit status for the last command
#         PS1="$White\$? "
#         # If it was successful, print a green check mark. Otherwise, print
#         # a red X.
#         if [[ $Last_Command == 0 ]]; then
#                 PS1+="$Green$Checkmark "
#         else
#                 PS1+="$Red$FancyX "
#         fi
#         # If root, print the host in red. Otherwise, print the current user
#         # and host in green.
#         if [[ $EUID == 0 ]]; then
#                 #PS1+='\[\e[0;31m\]\u@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
#                 PS1+="$Red\\u@\\h "
#         else
#                 #PS1+='\[\e[0;32m\]\u@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
#         PS1+="$Green\\u@\\h "
#         fi
#         # Print the working directory and prompt marker in blue, and reset
#         # the text color to the default.
#         PS1+="$Blue\\w \\\$$Reset "
# }
#
# function showfingerprint () {
#         openssl s_client -connect ${1?No IP specified!}:${2?No IP specified!} -showcerts 2>&1 | \
#                 openssl x509 -sha1 -noout -fingerprint 2>&1 | \
#                 sed -e ' s/^.*=//p; 1 s/://g; $ y/ABCDEF/abcdef/'
# }
#
# function cmixxx () {
#         pump scons asmlib=0 virtualize=0 localecompare=1 qt_sqlite_plugin=0 opus=1 faad=1 wv=1 ffmpeg=1 \
#                 optimize=native build=release battery=1 perftools=0 perftools_profiler=0 modplug=1 \
#                 qtdir=/usr/lib/qt4  install_root="${1:-/opt/mixxx}" prefix="${2:-/opt/mixxx}"
# }
#
# function calc () { bc -l <<<"${*}"; }
#
# function lpman () { man -t "${1?Error: No manpage provided.}" | groff -man -Tps | lpr; }
#
# function zhelp () {
#         [ ! -z "$@" ] || return 1
#         for i in "${@}"; do
#                 [ -r "${ZSH:-/usr/share/oh-my-zsh}/plugins/${i}/" ] && \
#                 pushd "${ZSH:-/usr/share/oh-my-zsh}/plugins/${i}/" >/dev/null 2>&1 || \
#                 return 2
#                 [ -r README* ] && \
#                 less -R ./README* 2>/dev/null || \
#                 vim --servername VIM "${i}.plugin.zsh" 2>/dev/null || \
#                 vim --servername VIM ./* 2>/dev/null
#                 popd >/dev/null 2>&1
#         done
# }
#
# function vkfix () {
#         #amp; becomes & (ampersand)
#         #quot; becomes " (double quote)
#         ##039; becomes ' (single quote)
#         #lt; becomes < (less than)
#         #gt; becomes > (greater than)
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf "'%s' " "${first}"
#         printf \"
#         printf "${first}" | sed -n '
#                 y/\[\]/()/
#                 s/\<[a-z]/\u&/g
#                 s/[#&]*039[\;]*/'\''/g
#                 s/[#&]*[Aa]mp[\;]*/\&/g
#                 s/ [ ]*/ \& /g
#                 s/\<[Aa]nd\>/\&/g
#                 s/\<[Ff][Ee][Aa][Tt]\>/ft/g
#                 s/\<[Pp][Rr][Ee][Ss][Ee][Nn][Tt][Ss]\>/pres/g
#                 s/\<[Ff][Tt]\>/ft/g
#                 s/\<[Vv][Ss]\>/vs/g
#                 s/\<[Pp][Rr][Ee][Ss]\>/pres/g
#                 s/ \(ft\)[\.]* / \1. /g
#                 s/ \(vs\)[\.]* / \1. /g
#                 s/ \(pres\)[\.]* / \1. /g
#                 s/\<M[Pp]3\>/mp3/g
#                 s/'\''[A-Z]/\L&/g
#                 p'
#         printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}' | \
#         sed 's/ "\(.*\)"$/ '\''\1'\''/' | \
#         while read -r final; do eval "mv --verbose ${final}" 2> /dev/null; done
# }
#
# function 0x0 () {
#         curl -H "User-Agent: Mozilla/5.0 \
#         (Macintosh; Intel Mac OS X 10_10_3) \
#         AppleWebKit/537.36 (KHTML, like Gecko) \
#         Chrome/44.0.2403.89 Safari/537.36" https://0x0.st --progress-bar -F"file=@-"
# }
#
# function f0x0 () {
#         curl -H "User-Agent: Mozilla/5.0 \
#         (Macintosh; Intel Mac OS X 10_10_3) \
#         AppleWebKit/537.36 (KHTML, like Gecko) \
#         Chrome/44.0.2403.89 Safari/537.36" https://0x0.st --progress-bar -F"file=@${*}"
# }
#
# function u0x0 () {
#         curl -H "User-Agent: Mozilla/5.0 \
#         (Macintosh; Intel Mac OS X 10_10_3) \
#         AppleWebKit/537.36 (KHTML, like Gecko) \
#         Chrome/44.0.2403.89 Safari/537.36" https://0x0.st --progress-bar -F"shorten=${*}"
# }
#
# function dirlinks () {
#         [[ -z "$1" ]] && dlist=( "${PWD}" ) || dlist=( "${@}" )
#         for ((i=1;i<$((${#dlist[@]}+1));i++)); do
#                 echo find "$dlist[$i]" -maxdepth 1 -type l -exec ls {} \;
#         done
# }
#
# function rpt () {
#         local pidlist
#         pidlist=$(for i in "$@"; do
#                         ps -C "$i" -o pid=
#                         #ps c -u ${USER} -o pid= | uniq
#                 done)
#         if [[ `<<<"$pidlist" wc -w` -eq 0 ]]; then
#                 echo "No PIDs found."
#         elif [[ `<<<"$pidlist" wc -w` -eq 1 ]]; then
#                 echo sudo reptyr -T "$pidlist"
#         else
#                 echo `<<<"$pidlist" wc -w`" PIDs found:"
#                 printf '\n%s\n' "$pidlist"
#         fi
# }
#
# function sdbus () {
#         [[ ! -z "$XDG_RUNTIME_DIR" ]] || export XDG_RUNTIME_DIR="/run/user/$UID"
#         [[ ! -z "$DBUS_SESSION_BUS_ADDRESS" ]] || export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"
# }
#
# function echocat () { eval cat $( printf '%s' `eval "{ <<<"${@}" sed 's/\<\([a-zA-Z0-9]*\)\>/<(<<<\"\1\")/g;s@\-@/dev/stdin@g' }"`); }
#
# function tunssh () { sshuttle -r "${1?Erro: no host specified.}"  "${2:-0.0.0.0/0}" -vv --dns; }
#
# ## Usage: kvm <disk.img> <(cd.iso|-)>[- for no CD image] <#>[memory (MB)] <#>[number of CPUs] <vgatype>[e.g. std]
# function kvm () {
#         local -a args
#         args=("$1" "$1" "${@:3}")
#         [[ "$(file -Lb "${args[2]}")" == data ]] && \
#                 args[2]="raw" || \
#                 args[2]="qcow2,l2-cache-size=4M"
#         [[ -z "$2" || "$2" =~ '^(-|[Nn]|[Nn][Uu][Ll][Ll])$' ]] && \
#                 args+=("-boot" "order=d") || \
#                 args+=("-cdrom" "$2")
#         qemu-system-x86_64 \
#                 -drive file="${args[1]?No image specified!}",format="${args[2]}",aio=native,cache.direct=on \
#                 -m "${args[3]:-2048}" -smp "${args[4]:-4}" -vga "${args[5]:-virtio}" "${args[6]}" "${args[7]}" \
#                 -boot menu=on -enable-kvm -machine type=pc,accel=kvm -show-cursor -usbdevice tablet \
#                 -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -soundhw hda \
#                 -net nic -net bridge,br=virbr0 -monitor stdio -monitor pty
#                 # -net nic -net bridge,br=virbr0,smb=/mnt/shared -device intel-iommu -monitor stdio -monitor pty
# }
#
# ## Usage: uefi-kvm <disk.img> <(cd.iso|-)> <#>[memory (MB)] <#>[number of CPUs] <vgatype> <firmware>[optional]
# function uefi-kvm () {
#         local -a args
#         args=("$1" "$1" "${@:3}")
#         [[ "$(file -Lb "${args[2]}")" == data ]] && \
#                 args[2]="raw,aio=native,cache.direct=on" || \
#                 args[2]="qcow2,l2-cache-size=4M"
#         [[ -z "$2" || "$2" =~ '^(-|[Nn]|[Nn][Uu][Ll][Ll])$' ]] && \
#                 args+=("-boot" "order=d") || \
#                 args+=("-cdrom" "$2")
#         qemu-system-x86_64 \
#                 -drive file="${args[1]?No image specified!}",format="${args[2]}" \
#                 -m "${args[3]:-2048}" -smp "${args[4]:-4}" -vga "${args[5]:-virtio}" "${args[6]}" "${args[7]}" \
#                 -boot menu=on -enable-kvm -machine type=pc,accel=kvm -show-cursor -usbdevice tablet \
#                 -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -soundhw hda \
#                 -net nic -net bridge,br=virbr0 -monitor stdio -monitor pty \
#                 -bios "${8:-/usr/share/ovmf/x64/ovmf_x64.bin}"
#                 # -net nic -net bridge,br=virbr0,smb=/mnt/shared -device intel-iommu -monitor stdio -monitor pty
# }
#
# ## Usage: spice-kvm <disk.img> <(cd.iso|-)> <#>[memory (MB)] <#>[number of CPUs] <(#|tmp)>[spice port or tmp for socket]
# function spice-kvm () {
#         local -a args
#         args=("$1" "$1" "${@:3}")
#         [[ "$(file -Lb "${args[2]}")" == data ]] && \
#                 args[2]="raw" || \
#                 args[2]="qcow2,l2-cache-size=4M"
#         [[ -z "$2" || "$2" =~ '^(-|[Nn]|[Nn][Uu][Ll][Ll])$' ]] && \
#                 args+=("-boot" "order=d") || \
#                 args+=("-cdrom" "$2")
#         [[ "${args[5]:-tmp}" =~ ^[0-9*]$ ]] && \
#                 args[5]="port=${args[5]}" || \
#                 args[5]="unix,addr=/tmp/vm_spice.socket,playback-compression=off"
#         qemu-system-x86_64 \
#                 -drive file="${args[1]?No image specified!}",format="${args[2]}",aio=native,cache.direct=on \
#                 -m "${args[3]:-2048}" -smp "${args[4]:-4}" -vga qxl "${args[6]}" "${args[7]}" \
#                 -boot menu=on -enable-kvm -machine type=pc,accel=kvm -show-cursor -usbdevice tablet \
#                 -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -soundhw hda \
#                 -net nic -net bridge,br=virbr0 -monitor stdio -monitor pty \
#                 -spice "${args[5]}",disable-ticketing -device virtio-serial-pci \
#                 -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
#                 -device ich9-usb-ehci1,id=usb \
#                 -device ich9-usb-uhci1,masterbus=usb.0,firstport=0,multifunction=on \
#                 -device ich9-usb-uhci2,masterbus=usb.0,firstport=2 \
#                 -device ich9-usb-uhci3,masterbus=usb.0,firstport=4 \
#                 -chardev spicevmc,name=usbredir,id=usbredirchardev1 \
#                 -device usb-redir,chardev=usbredirchardev1,id=usbredirdev1 \
#                 -chardev spicevmc,name=usbredir,id=usbredirchardev2 \
#                 -device usb-redir,chardev=usbredirchardev2,id=usbredirdev2 \
#                 -chardev spicevmc,name=usbredir,id=usbredirchardev3 \
#                 -device usb-redir,chardev=usbredirchardev3,id=usbredirdev3 \
#                 -chardev spicevmc,id=spicechannel0,name=vdagent
#                 # -net nic -net bridge,br=virbr0,smb=/mnt/shared -device intel-iommu -monitor stdio -monitor pty \
# }
#
# function spice-uefi-kvm () {
#         local -a args
#         args=("$1" "$1" "${@:3}")
#         [[ "$(file -Lb "${args[2]}")" == data ]] && \
#                 args[2]="raw" || \
#                 args[2]="qcow2,l2-cache-size=4M"
#         [[ -z "$2" || "$2" =~ '^(-|[Nn]|[Nn][Uu][Ll][Ll])$' ]] && \
#                 args+=("-boot" "order=d") || \
#                 args+=("-cdrom" "$2")
#         [[ "${args[5]:-tmp}" =~ ^[0-9*]$ ]] && \
#                 args[5]="port=${args[5]}" || \
#                 args[5]="unix,addr=/tmp/vm_spice.socket,playback-compression=off"
#         qemu-system-x86_64 \
#                 -drive file="${args[1]?No image specified!}",format="${args[2]}",aio=native,cache.direct=on \
#                 -m "${args[3]:-2048}" -smp "${args[4]:-4}" -vga qxl "${args[6]}" "${args[7]}" \
#                 -boot menu=on -enable-kvm -machine type=pc,accel=kvm -show-cursor -usbdevice tablet \
#                 -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -soundhw hda \
#                 -net nic -net bridge,br=virbr0 -monitor stdio -monitor pty \
#                 -spice "${args[5]}",disable-ticketing -device virtio-serial-pci \
#                 -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
#                 -chardev spicevmc,id=spicechannel0,name=vdagent \
#                 -device ich9-usb-ehci1,id=usb \
#                 -device ich9-usb-uhci1,masterbus=usb.0,firstport=0,multifunction=on \
#                 -device ich9-usb-uhci2,masterbus=usb.0,firstport=2 \
#                 -device ich9-usb-uhci3,masterbus=usb.0,firstport=4 \
#                 -chardev spicevmc,name=usbredir,id=usbredirchardev1 \
#                 -device usb-redir,chardev=usbredirchardev1,id=usbredirdev1 \
#                 -chardev spicevmc,name=usbredir,id=usbredirchardev2 \
#                 -device usb-redir,chardev=usbredirchardev2,id=usbredirdev2 \
#                 -chardev spicevmc,name=usbredir,id=usbredirchardev3 \
#                 -device usb-redir,chardev=usbredirchardev3,id=usbredirdev3 \
#                 -bios "${8:-/usr/share/ovmf/x64/ovmf_x64.bin}"
#                 # -net nic -net bridge,br=virbr0,smb=/mnt/shared -device intel-iommu -monitor stdio -monitor pty \
# }
#
# function x86kvm () {
#         local -a args
#         args=("$1" "$1" "${@:3}")
#         [[ "$(file -Lb "${args[2]}")" == data ]] && \
#                 args[2]="raw" || \
#                 args[2]="qcow2,l2-cache-size=4M"
#         [[ -z "$2" || "$2" =~ '^(-|[Nn]|[Nn][Uu][Ll][Ll])$' ]] && \
#                 args+=("-boot" "order=d") || \
#                 args+=("-cdrom" "$2")
#         qemu-system-x86_64 \
#                 -drive file="${args[1]?No image specified!}",format="${args[2]}",aio=native,cache.direct=on \
#                 -m "${args[3]:-2048}" -smp "${args[4]:-4}" -vga "${args[5]:-virtio}" "${args[6]}" "${args[7]}" \
#                 -boot menu=on -enable-kvm -machine type=pc,accel=kvm -show-cursor -usbdevice tablet \
#                 -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -soundhw hda \
#                 -net nic -net bridge,br=virbr0 -monitor stdio -monitor pty
#                 # -net nic -net bridge,br=virbr0,smb=/mnt/shared -device intel-iommu -monitor stdio -monitor pty
# }
#
# function csox () {
#         [[ "$#" -gt 3 || ! "$3" =~ ^[0-9]$ ]] && return 1
#         sox "$1" -C ${3:-10} "${1%.*}.${2:-ogg}"
# }
#
# function test256 () {
#         (
#         x=`tput op` y=`printf %76s`
#         for i in {0..256}; do
#                 o=00"$i"
#                 echo -e "${o:${#o}-3:3} `tput setaf $i; tput setab $i`${y// /=}$x"
#                 done
#         )
# }
#
# function hexc () {
#         local input="$(cat "${@:-/dev/stdin}")"
#         printf '%s' "$input" | \
#                 od -tx1 | \
#                 sed 's/^[0-9]* //;$ d;s/^/ /;s/ /\\x/g;s/\\/ 0/g;s/^ //' | \
#                 perl -pe 's/$/ / if not eof; chomp'
# }
#
# function hex () {
#         local input="$(cat "${@:-/dev/stdin}")"
#         printf '%s' "$input" | \
#                 od -tx1 | \
#                 sed 's/^[0-9]* //;$ d;s/^/ /;s/ /\\x/g;s/^ //' | \
#                 tr -d '\n'
# }
#
# function lsupd () { checkupdates; cower -ub; }
#
# function ytconv () {
#         if [[ "$#" -lt 2 ]]; then
#                 printf "\n %s \n" 'Usage: ytconv <image> <audio> <extension> (Extension is optional: defaults to .mkv)'
#                 return 1
#         else
#                 # ffmpeg -loop 1 -i "$1" -i "$2" \
#                 #         -c:a copy -c:v libx264 \
#                 #         -preset ultrafast -pix_fmt yuv420p -tune stillimage \
#                 #         -b:a 192k -strict experimental -threads 0 -shortest "out.${3:-mkv}"
#                 ffmpeg -loop 1 -i "$1" -i "$2" \
#                         -c:a copy -c:v hevc \
#                         -preset ultrafast  -pix_fmt yuv420p -tune psnr \
#                         -b:a 192k -strict experimental -threads 0 -shortest "out.${3:-mkv}"
#         fi
# }
#
# function dloader () { node /@media/microSDXC/deezloader/app.js & disown; }
#
# function tpanning () {
#         #xrandr -q | grep "eDP1" | grep "panning"
#         #xrandr --fb 4096x2560 --output eDP1 --mode 2160x1440 --panning 4096x2560+0+0/4096x2560+0+0/0/0/0/0
#         local vres
#         ## check if force arg is given
#         [[ ! -z "$1" ]] && {
#         [[ "$1" -ne 1 ]] && vres=2160x1440 || vres=4096x2560; } || {
#         ## if not currently using panning enable it with xrandr
#         xrandr -q | awk 'BEGIN {f=0} /eDP1/ && /2160x1440/ {f=1} END {exit f}' && vres=2160x1440 || vres=4096x2560; }
#         xrandr --fb "$vres" --output eDP1 --panning "${vres}+0+0/${vres}+0+0/0/0/0/0/"
#         #xrandr --fb 2160x1440 --output eDP1 --panning 2160x1440+0+0/2160x1440+0+0/0/0/0/0/
# }
#
# function eurl () {
#         local LC_ALL=C c
#         while IFS= read -r -n1 -d '' c
#         do
#                 if [[ $c = [[:alnum:]] ]]
#                 then
#                         printf %s "$c"
#                 else
#                         printf %%%02x "'$c"
#                 fi
#         done
# }
#
# function vkfix2 () {
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf '"%s" ' "${first}"; printf \"; printf "${first}" | sed  -n 's/\bem\([A-Za-z0-9\;\#]*\)em\b/\1/gp'; printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}'  | while read -r final; do eval "mv --verbose ${final}"
#         done
#
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf '"%s" ' "${first}"; printf \"; printf "${first}" | sed  -n 's/\bem\([A-Za-z0-9\;\#]*\)em/\1/gp'; printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}'  | while read -r final; do eval "mv --verbose ${final}"
#         done
#
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf '"%s" ' "${first}"; printf \"; printf "${first}" | sed -n 's/\<[Ff][Ee][Aa][Tt][\.]*\>/ft\./gp'; printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}'  | while read -r final; do eval "mv --verbose ${final}"
#         done
#
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf '"%s" ' "${first}"; printf \"; printf "${first}" | sed -n 's/\<[Vv]S[\.]*\>/vs\./gp'; printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}'  | while read -r final; do eval "mv --verbose ${final}"
#         done
#
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf '"%s" ' "${first}"; printf \"; printf "${first}" | sed -n 's/\<V[Ss][\.]*\>/vs\./gp'; printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}'  | while read -r final; do eval "mv --verbose ${final}"
#         done
#
#
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf '"%s" ' "${first}"; printf \"; printf "${first}" | sed -n 's/\<presents\>/pres\./gp'; printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}'  | while read -r final; do eval "mv --verbose ${final}"
#         done
#
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf '"%s" ' "${first}"; printf \"; printf "${first}" | sed -n 's/\<\(ft\)\>/\1./gp'; printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}'  | while read -r final; do eval "mv --verbose ${final}"
#         done
#
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf '"%s" ' "${first}"; printf \"; printf "${first}" | sed -n 's/\<\(vs\)\>/\1./gp'; printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}'  | while read -r final; do eval "mv --verbose ${final}"
#         done
#
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf '"%s" ' "${first}"; printf \"; printf "${first}" | sed -n 's/ \[MP3FY\.COM\]//gp'; printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}'  | while read -r final; do eval "mv --verbose ${final}"
#         done
#
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf '"%s" ' "${first}"; printf \"; printf "${first}" | sed -n 's/  / \& /gp'; printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}'  | while read -r final; do eval "mv --verbose ${final}"
#         done
#
#         #&amp; becomes & (ampersand)
#         #&quot; becomes " (double quote)
#         #&#039; becomes ' (single quote)
#         #&lt; becomes < (less than)
#         #&gt; becomes > (greater than)
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf '"%s" ' "${first}"; printf \"; printf "${first}" | sed -n 's/\#039\;/'\''/gp'; printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}'  | while read -r final; do eval "mv --verbose ${final}"
#         done
#
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf '"%s" ' "${first}"; printf \"; printf "${first}" | sed -n 's/amp\;/\&/gp'; printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}'  | while read -r final; do eval "mv --verbose ${final}"
#         done
#
#         find . -maxdepth 1 -name "*.mp3" -print0 | while IFS= read -r -d '' first; do
#         printf '"%s" ' "${first}"; printf \"; printf "${first}" | sed -n 's/\<\(.\)/\u\1/gp'; printf "\"\n"
#         done | \
#         awk '! /\"\"/ {print}'  | while read -r final; do eval "mv --verbose ${final}"
#         done
# }
#
# function ajack () {
#         #alsa_out -j DeckA_Out -d "hw:2,0" &> /dev/null &
#         #alsa_in -j DeckA_In -d "hw:2,0" &> /dev/null &
#         #alsa_out -j DeckB_Out -d "hw:3,0" &> /dev/null &
#         #alsa_in -j DeckB_In -d "hw:3,0" &> /dev/null &
#         #alsa_out -j Cue_Out -d "hw:4,0" &> /dev/null &
#         #alsa_in -j Cue_In -d "hw:4,0" &> /dev/null &
#
#         alsa_out -j DeckA_Out -d "hw:2" &>/dev/null &
#         alsa_out -j DeckB_Out -d "hw:3" &>/dev/null &
#         #alsa_out -j Cue_Out -d "hw:4,0" &>/dev/null &
#         #alsa_out -j Cue_Out -d "hw:5,0" &>/dev/null &
#         alsa_in -j DeckA_In -d "hw:2" &>/dev/null &
#         alsa_in -j DeckB_In -d "hw:3" &>/dev/null &
#         #alsa_in -j Cue_In -d "hw:4,0" &>/dev/null &
#         #alsa_in -j Cue_In -d "hw:5,0" &>/dev/null &
# }
#
# function tgv () {
#         [[ -z "$(pgrep -fx "gvim --servername GVIM")" ]] || gvim --servername GVIM
#         [[ -z "$1" ]] || gvim --servername GVIM --remote-tab-silent "${@}"
# }
#
# function conf-setup () {
#         local orig="$PWD"
#         [[ "$orig" != "${CONF:-/store/config}" ]] && pushd "${CONF:-/store/config}" >/dev/null 2>&1 || local dirvar=1
#         git init .
#         git remote add origin "git+ssh://git@github.com/alyptik/config.git" 2>/dev/null || \
#                 git remote set-url origin "git+ssh://git@github.com/alyptik/config.git"
#         #(($dirvar)) || popd &>/dev/null
#         [[ "$dirvar" -eq 0 ]] && pushd "$orig" >/dev/null 2>&1 || return 0
# }
#
# function pscg () {
#         local orig="$PWD"
#         [[ "$orig" != "${CONF:-/store/config}" ]] && pushd "${CONF:-/store/config}" >/dev/null 2>&1 || local dirvar=1
#         if git pull -S 2>/dev/null; then
#                 printf '\n \033[32m %s \n\033[0m' "Pull successful!"
#         else
#                 git stash && git pull -S && \
#                         printf '\n \033[32m %s \n\033[0m' "Stash and pull successful!" || \
#                         printf '\n \033[31m %s \n\033[0m' "Error during pull..."
#         fi
#         #(($dirvar)) || popd >/dev/null 2>&1
#         [[ "$dirvar" -eq 0 ]] && pushd "$orig" >/dev/null 2>&1
# }
#
# function scg () {
#         local orig="$PWD"
#         [[ "$orig" != "${CONF:-/store/config}" ]] && pushd "${CONF:-/store/config}" >/dev/null 2>&1 || local dirvar=1
#         git add .
#         #git commit -a -S -m "Configuration backup on $(date +'%a %d %b %I:%M:%S%P %Z %Y-%m-%d')" && {
#         if [[ -z "$1" ]]; then
#                 git commit -a -S && {
#                         git push && \
#                                 printf '\n \033[32m %s \n\033[0m' "Commit successful!" || \
#                                 printf '\n \033[31m %s \n\033[0m' "Error during push..."
#                 } || {
#                         printf '\n \033[31m %s \n\033[0m' "Nothing to commit..."
#                 }
#         else
#                 git commit -a -S -m "${*}" && {
#                         git push && \
#                                 printf '\n \033[32m %s \n\033[0m' "Commit successful!" || \
#                                 printf '\n \033[31m %s \n\033[0m' "Error during push..."
#                 } || {
#                         printf '\n \033[31m %s \n\033[0m' "Nothing to commit..."
#                 }
#         fi
#         [[ "$dirvar" -eq 0 ]] && pushd "$orig" >/dev/null 2>&1
# }
#
# function par () {
#         pulseaudio --check && pulseaudio --kill
#         sleep 1
#         [ $# -eq 0 ] && {
#                 pulseaudio --start
#                 printf '\n \033[32m %s \n\033[0m' "Realtime: Disabled"
#                 return 0
#                 } || {
#                 pulseaudio --start --realtime
#                 printf '\n \033[31m %s \n\033[0m' "Realtime: Enabled"
#                 return 1
#                 }
# }
#
# function kattach () {
#         ( printf "%s\n" \
#                 "Subject: " \
#                 "To: alyptik@kindle.com" \
#                 "Content-Type: application/${1##*.}" \
#                 "Content-Disposition: attachment; filename=${1?No file specified.}" \
#                 "Content-Transfer-Encoding: base64" \
#                 ""; base64 ${1} ) | sendmail "alyptik@kindle.com"
# }
#
# function dbr () {
#         find /@media/microSDXC/audio -maxdepth 1 -name "*TSL*" -type d -print | \
#                 sed 's/^.*\/\(TSL.*\)$/\1/' | \
#                 while read -r; do
#                         rclone move "/@media/microSDXC/audio/${REPLY}" dropbox:/EDM/TSL/${REPLY} && \
#                         rmdir "/@media/microSDXC/audio/${REPLY}"
#                 done
#         find /@media/microSDXC/audio -maxdepth 1 -name "*alyptik*" -type d -print | \
#                 sed 's/^.*\/alyptik - \(.*\)$/\1/' | \
#                 while read -r; do
#                         rclone move "/@media/microSDXC/audio/alyptik - ${REPLY}" \
#                         "dropbox:/edm/audio/$(<<<${REPLY/*- /} \
#                         sed 's/./\l&/g;s/ (.*//')" && \
#                         rmdir "/@media/microSDXC/audio/alyptik - ${REPLY}"
#                 done
#         #rclone sync /@media/microSDXC/audio/ dropbox:/EDM/audio/
#         rclone sync "/@media/microSDXC/Music/djzomg/" "dropbox:/EDM/djzomg/"
#         rclone move "/@media/microSDXC/Practice Mixes/" "dropbox:/EDM/practice/"
#         #rclone move /@media/microSDXC/Practice\ Mixes/ dropbox:/EDM/practice/
# }
#
# function gs-pdf () {
#         printf '%b' "Input file: $1\nOutput file: ${1/.pdf/-gs.pdf}\n"
#         gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen \
#                 -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${1/.pdf/-gs.pdf}" "$1"
# }
#
# function vk () {
#         local search="$1"
#         while [[ ! -z "$2" ]]; do shift && search="$search+$1"; done
#         local vkurl='http://vk.com/audios361427414?act=popular&q='"$search"
#         #xdg-open "$vkurl"
#         open_command "$vkurl"
# }
#
# function colortput () {
#         local colorcount=${1:-25}
#         for ((i=0;i<${colorcount};i++)); do
#                 #[[ "$colorcount" -lt 10 ]] && {
#                         #printf "\e[38;4;29m[%d]$(tput sgr0)$(tput setaf $i)%s\t" "$i" "derp"
#                         #printf '%s' "\e[38;4;29m[%d]$(tput sgr0)$(tput setaf $i)%s" "$i" "derp"; } || {
#                         printf "\e[38;4;29m\n[%d]$(tput sgr0)$(tput setaf $i) %s" "$i" "derp"
#                         printf '\t%s' "\e[38;4;29m\n[%d]$(tput sgr0)$(tput setaf $i)%s"
#         done
# }
#
# function ctput () {
#         ## List Termcap colors'
#         local colorcount=${1:-16}
#         printf "Listing %s colors:\n" "$colorcount"
#         for ((i=0;i<=colorcount;i++)); do
#                 printf "$(tput setaf $i)(tput setaf [%d])$(tput sgr0) $(tput setaf $i)%s$(tput sgr0)\n" "$i" "moretest"
#         done
# }
#
# function ldas () {
#                 [[ "${#}" -ne 3 ]] && { printf " \033[31m %s \n\033[0m" "Need 3 arguments..."; return 1; } || {
#                                 nasm -f elf64 "$1" -o "$2"
#                 ld -m elf_x86_64 "$2" -o "$3"
#                                 printf " \033[32m %s \033[0m\n" "Assembling \"${1}\" into \"${2}\"..."
#                                 printf " \033[32m %s \033[0m\n" "Linking \"${2}\" into \"${3}\"..."
#                                 printf " \033[32m %s \033[0m\n" "Done, created \"${PWD}/${3}\""'!'
#                                 return 0
#         }
# }
#
# function ldas () {
#                 [[ "${#}" -ne 3 ]] && { printf " \033[31m %s \n\033[0m" "Need 3 arguments..."; return 1; } || {
#                                 as "$1" -o "$2"
#                                 ld --dynamic-linker="/lib64/ld-linux-x86-64.so.2" \
#                                                 /usr/lib/crt1.o /usr/lib/crti.o \
#                                                 -lc "$2" /usr/lib/crtn.o -o "$3"
#                                 printf " \033[32m %s \033[0m\n" "Assembling \"${1}\" into \"${2}\"..."
#                                 printf " \033[32m %s \033[0m\n" "Linking \"${2}\" into \"${3}\"..."
#                                 printf " \033[32m %s \033[0m\n" "Done, created \"${PWD}/${3}\""'!'
#                                 return 0
#         }
# }
#
# function shcurl () {
#         if [[ "${#}" -lt 1 ]]; then
#                 printf "\033[31m %s \n\033[0m" "Error: no arguments..."
#                 return 1
#         else
#                 local url="${1}"
#                 printf " \033[32m %s \033[0m" "[Continue executing script at: \"${url}\"? (Y/n)] "; read -r
#                 #read -r -n 1 -p "${1:-Continue?} [y/n]: " REPLY
#                 case "$REPLY" in
#                         [Yy]*|'') : ;; ## Continue
#                         [Nn]*) printf " \033[31m %s \n\033[0m" "Exiting..."; return 1 ;;
#                         *) printf " \033[31m %s \n\033[0m" "Invalid input..."; return 1 ;;
#                 esac
#                 sh -c "$(curl --progress-bar -fsSL "${url}")"
#                 return 0
#         fi
# }
#
# ## Btrfs balance with -dusage filter
# function bd-btrfs () {
#         [[ ${#} -ge 1 ]] && local dpercent="$1" || local dpercent=100
#         [[ ${#} -ge 2 ]] && local mpercent="$2" || local mpercent=0
#         [[ ${#} -ge 3 ]] && local target="$3" || local target='/'
#         echo "Running balance on \"${target}\" with -dusage=${dpercent} and -musage=${mpercent}..."
#         sudo btrfs balance start -v -dusage="${dpercent}" -musage="${mpercent}" "${target}"
#         return 0
# }
#
# function certfp () {
#         pushd . &>/dev/null
#         cd "${HOME}/certs/irc"
#         local nick="${1:-alyptik}"
#         openssl req -newkey rsa:2048 -days 730 -x509 -keyout ${nick}.key -out ${nick}.cert
#         #touch "./${nick}"'.pem'
#         cat "${nick}.cert" "${nick}.key" >"${nick}.pem"
#         #openssl x509 -sha1 -noout -fingerprint -in "$1" | sed -e 's/^.*=//;s/://g;y/ABCDEF/abcdef/'
#         openssl x509 -sha1 -noout -fingerprint -in "${nick}.pem" | \
#                 sed -e 's/^.*=//;s/://g;y/ABCDEF/abcdef/'## sed is optional
#         popd &>/dev/null
# }
#
# ## Alternate man functions
# # function aman () {
# #         local width=$(tput cols)
# #         [[ "$width" -gt "$MANWIDTH" ]] || width="$MANWIDTH"
# #         env MANWIDTH="$width" \
# #                 LESS='-FRMsw' \
# #                 GROFF_NO_SGR=1 \
# #                 LESS_TERMCAP_se=$'\E[0m' \
# #                 LESS_TERMCAP_so=$'\E[38;5;35m' \
# #                 LESS_TERMCAP_md=$'\E[1;31m' \
# #                 LESS_TERMCAP_me=$'\E[0m' \
# #                 LESS_TERMCAP_us=$'\E[4;32;4;132m' \
# #                 LESS_TERMCAP_ue=$'\E[0m' \
# #                 LESS_TERMCAP_so=$'\E[30;43m' \
# #                 LESS_TERMCAP_md=$'\E[1;31m' \
# #                         man "$@"
# #         # env MANWIDTH="$width" \
# #         #         LESS="-sMNR" \
# #         #         LESS_TERMCAP_mb=$'\E[01;31m' \
# #         #         LESS_TERMCAP_md=$'\E[01;31;5;74m' \
# #         #         LESS_TERMCAP_me=$'\E[0m' \
# #         #         LESS_TERMCAP_se=$'\E[0m' \
# #         #         LESS_TERMCAP_so=$'\E[38;5;246m' \
# #         #         LESS_TERMCAP_ue=$'\E[0m' \
# #         #         LESS_TERMCAP_us=$'\E[04;33;146m' \
# #         #         GROFF_NO_SGR=1
# #         #                 man "$@"
# # }
#
# function sslpkeygen () {
#         echo -n '[input directory to store certificates:] ' ; read keydir
#                         #([~.]|${HOME})/*[^/]+ ) echo 'using '"${keydir}"'/private.'  | sed -r 's@\/\/+@\/@g' ;;
#                         #([~.]|${HOME}|[^/)* ) echo 'using '"${keydir}"'/private.' | sed -r 's@\/\/+@\/@g' ;;
#                         #[^/]* ) echo 'using "'"${keydir}"'/private".' ;;
#                         #"" ) echo 'nothing entered. Using '"${keydir:-$PWD/private}"'.' ;;
#                         #* ) echo 'please run "pushd '"${keydir}"'" first.'  ;;
#         case "${keydir}" in
#                         "/"* ) printf '%s\n' 'please run '"'pushd ${keydir}'"' first.'  ;;
#                         ""|[\~\.]|${HOME}* ) echo 'using "'${keydir:-"$PWD"}'/private".' | sed -r 's@\/\/+@\/@g' ;;
#         esac
#         [[ ${keydir} =~ ^[^\/].*  ]] || \
#                         { echo 'please run "pushd '"${keydir}"'" first.'; echo "$keydir"; return 1; }
#         echo 'using "'"${keydir}"'/private".'
#
#         pushd ${keydir}
#         [[ -d private ]] || mkdir -m0700 private
#         touch private/key.pem
#         chmod 0600 private/key.pem
#
#         sslvar='
#                                 List of Available SSL Options:
#                         [1] - 	Self-signed root certificate
#                                 $ openssl req -x509 -newkey rsa:2048 -keyout key.pem -out req.pem
#                         [2] -  Create a private key and then generate a certificate request from it
#                                 $ openssl genrsa -out private/key.pem 2048
#                                 $ openssl req -new -key key.pem -out req.pem
#                                 $ openssl req -newkey rsa:2048 -keyout key.pem -out req.pem
#                                 $ openssl req -new -sha256 -key private/key.pem -out req.csr
#                                 $ openssl req -key private/key.pem -x509 -new -days 3650 -out cacert.pem
#                         [3] - 	Remove password / encryption
#                                 $ openssl req -new -key server.key -out server.csr
#                                 cp server.key server.key.org
#                                 $ openssl rsa -in server.key.org -out server.key
#                                 $ openssl genpkey -aes-256-cbc -algorithm RSA \
#                                         -out private/key.pem -pkeyopt rsa_keygen_bits:4096
#                         [5] -  Examine and verify certificate request:
#                                 $ openssl req -in req.pem -text -verify -noout
#                                 $ openssl x509 -req -days 365 -in req.csr -signkey server.key -out server.crt
#                                 [6] -  Convert from PEM to DER for browsers
#                                         $ openssl x509 -in ca.pem -outform DER -out ca.der
#                         [7] - 	Generate an RSA private key using default parameters:
#                                 $ openssl genpkey -algorithm RSA -out key.pem
#                                 Encrypt output private key using 128 bit AES and the passphrase "hello":
#                                 $ openssl genpkey -algorithm RSA -out key.pem -aes-128-cbc -pass pass:hello
#                                 Generate a 2048 bit RSA key using 3 as the public exponent:
#                                 $ openssl genpkey -algorithm RSA -out key.pem -pkeyopt rsa_keygen_bits:2048 \
#                                         -pkeyopt rsa_keygen_pubexp:3
#                         [8] - 	 Generate 1024 bit DH parameters:
#                                 $ openssl genpkey -genparam -algorithm DH -out dhp.pem \
#                                         -pkeyopt dh_paramgen_prime_len:1024
#                                 Output RFC5114 2048 bit DH parameters with 224 bit subgroup:
#                                 $ openssl genpkey -genparam -algorithm DH -out dhp.pem -pkeyopt dh_rfc5114:2
#
#                                 Generate DH key from parameters:
#                                 $ openssl genpkey -paramfile dhp.pem -out dhkey.pe
#                         [9] - 	 Generate EC parameters:
#                                 $ openssl genpkey -genparam -algorithm EC -out ecp.pem \
#                                                 -pkeyopt ec_paramgen_curve:secp384r1 \
#                                         -pkeyopt ec_param_enc:named_curve
#                                 Generate EC key from parameters:
#                                 $ openssl genpkey -paramfile ecp.pem -out eckey.pem
#                                 Generate EC key directly:
#                                 $ openssl ecparam -name secp256k1 -genkey -noout -out secp256k1-key.pem'"\n"
#                         #tee /dev/tty "${sslvar}"
#                         echo "${sslvar}"
#                         echo -n '[enter option #:(1-9)] ' ; read choice
#         case "${choice}" in
#                         1) echo 1 ;;
#                         2) echo 2 ;;
#                         3) echo 3 ;;
#                         4) echo 4 ;;
#                         5) echo 5 ;;
#                         6) echo 6 ;;
#                         7) echo 7 ;;
#                         8) echo 8 ;;
#                         9) echo 9 ;;
#                         "") echo 'no option number entered.' ;;
#                 *) echo 'Option "'${choice}'" not found.'  ;;
#         esac
#         ls -l "${keydir}"
#         popd
# }
#
# function chud () {
#         #killall conky && sleep 2
#         #conky -c /home/alyptik/.conky/.clockconky
#         #conky -c /home/alyptik/.conky/.netconky
#         #conky -c /home/alyptik/.conky/.mainconky
#         #conky -c /home/alyptik/.conky/.conkyrc2
#         #[[ pidof -x $(basename $0) > /dev/null ]] && killall conky;
#         [[ ! -z "$(pgrep conky)" ]] && killall conky;
#         sleep 2;
#         conky -c /home/alyptik/.conky/.clockconky;
#         conky -c /home/alyptik/.conky/.netconky;
#         conky -c /home/alyptik/.conky/.mainconky;
#         conky -c /home/alyptik/.conky/.conkyrc2;
#
# }
#
# function vbinit () {
#         sudo modprobe vboxnetadp vboxnetflt vboxpci vboxdrv
#         sudo vboxreload
#         #VBoxManage hostonlyif create
#         #VBoxManage natnetwork start --netname vbnat
# }
#
# function szexpac () {
#         echo -n "$@" '[perform size-sorted search for:] '; read -r
#         expac -s "%-30n %m" | sort -hk 2 | awk '{printf "%s %.0f MiB\n", $1, $2/1024/1024}' | column -t | grep "$REPLY"
#         #case "$ans" in
#                         #*) return 1 ;;
#                         #) return 0 ;;
#         #esac
# }
#
# function dtexpac () {
#         echo -n "$@" '[# of recently installed entries to list:] '; read -r
#         expac --timefmt='%y-%m-%d %T' '%l\t%n' | sort | tail "-$REPLY"
#         #expac --timefmt=%s '%l\t%n' | sort -n | tail -20 | grep "$ans"
# }
#
# function abexpac () {
#         echo -n "$@" '[perform alphabetical search for:] '; read -r
#         expac -s "%-25n %v" | grep "$REPLY"
# }
#
# function dsgenkey () {
#         if [[ -z "${1}" ]]; then
#                 printf '%s\n' 'No zone specified!'
#         else
#                 pushd /etc/bind
#                 sudo dnssec-keygen -a NSEC3RSASHA1 -b 2048 \
#                         -K /etc/bind/private -n ZONE "$1"
#                 sudo dnssec-keygen -f KSK -a NSEC3RSASHA1 \
#                         -b 4096  -K /etc/bind/private -n ZONE "$1"
#                 #sudo find /etc/bind/private/ -maxdepth 1 -name "K$1*.key" \
#                         #-exec echo "\$INCLUDE /etc/bind/private/"{} \; >> "/etc/bind/db.${1}"
#                 for i in /etc/bind/private/K${1}*.key; do echo "\$INCLUDE ${i}" | sudo tee -a "/etc/bind/db.${1}"; done
#                 sudo dnssec-signzone -A -3 \
#                         $(head -c 1000 /dev/random | sha1sum | cut -b 1-16) \
#                         -N INCREMENT -K ./private -o "$1" -S -t db."$1"
#         popd
#         fi
# }
#
# function dssign () {
#         [[ ${PWD} != /etc/bind ]] && pushd . >/dev/null 2>&1
#         cd "/etc/bind"
#         if [[ -z "${1}" ]]; then
#                         printf '%b' 'no zone specified!\nsign "alyp.tk"? (Y/n)' ; read ans
#                         [[ ${ans} =~ ([ \t]*[Yy].*|) ]] && { popd >/dev/null 2>&1; dssign 'alyp.tk'; return 0; }
#                         echo -n "\r\nenter zone(s) to sign: "
#         read -r ans2
#         [[ -z "${ans2}" ]] && {
#                 echo "exiting..."
#                 return 2
#         } || {
#                 zarray=( $ans2 )
#                 popd >/dev/null 2>&1
#                 dssign "$zarray[@]"
#                 return 0
#         }
#         else
#                 IFSold=${IFS}
#                 IFS=$'\n'
#                 printf '%b\n\t' \
#                         'signing zone(s): ' "${@}" '\rstarting script...'
#                 IFS=${IFSold}
#                 #echo -en "\r"
#                 printf '%b' "\r"
#         fi
#         for i in "${@}" ; do
#                 SERIAL=$(named-checkzone "${i}" "db.${i}" | \
#                         egrep --color="never" -ho '[0-9]{10}')
#                         #sed 's/.*K\([[:digit:]]{10}\).*/\1/')
#                 sudo sed -i 's/'"${SERIAL}"'/'"$((SERIAL+1))"'/' "db.${i}"
#                 sudo dnssec-signzone -A -3 \
#                         $(head -c 1000 /dev/random | sha1sum | cut -b 1-16) \
#                         -N INCREMENT -K ./private -o "${i}" -S -t "db.${i}"
#         done
#         popd >/dev/null 2>&1
#         return 0
# }
#
# function snft () {
#         if [[ -e "/tmp/nft" ]]; then
#                 printf '%s\n' '/tmp/nft exists!'
#         else
#                 printf '%s\n' 'Writing nftables ruleset to /tmp/nft.'
#                 sudo printf '%s\n' "nft flush ruleset" >/tmp/nft
#                 sudo nft list ruleset -annn >>/tmp/nft
#                 sudo vim /tmp/nft
#         fi
# }
#
# function csu () {
#         [[ ${#} -ge 1 ]] && {
#                 echo " [running:] su -c \""${*}"\" ";
#                 sudo su -c "$*" && return 0 || echo " error: multiple or incorrect commands entered."; }
#         echo -ne " [please enter \";\" delimited root commands:] (i.e.: \`cmd1; cmd2...\`) "; read -r
#         ## IFS safety net
#         IFSbackup=${IFS}
#         cstring=$(sed -r '
#                 :loop
#                 s_[; \t]*(;)[; \t]* _\1_g
#                 s_[ \t]*(;)[ \t]* _\1_g
#                 /$/!b loop' <<< ${REPLY})
#         ## Set temporary IFS and convert ${cstring} to ${carray[@]}
#         IFS=; read -r -A carray <<< ${cstring}
#         echo -ne "\n"
#         printf '%s\n' 'running the following commands as root:' \
#                 `tr ';' '\n' <<< ${carray[@]} | sed -r 's/^(..*)/ \1/'`
#         printf '%b' 'starting "su -c" command execution...\n\n'
#                 { for i in $carray[@]; do sudo su -c ${i}; done; } && return 0 || return 1
#
#         ## Old commands
#         if true; then
#                 return 10
#         else
#                 [[ ! -z ${*} && ${#} -eq 1 ]] && {
#                 echo -e " running: 'su -c \"${*}\"'";
#                 sudo su -c "$*";
#                 return 10; }
#                 [[ ${#} -ge 2 ]] && printf '%b' ' command input too ambiguous!\n continuing script....\n'
#                 while IFS=';' read -r cmd; do sudo su -c '"'${cmd}'"'; done <<< "${ans}"
#                 carray=( printf '%s' "$*" )
#                 for i in "${carray[@]}" ; do
#                         command='"'${i}'"'
#                         sudo su -c "${command}"
#                         done
#                 carray=(`printf '%s' "${rcom}" | sed -r '
#                 :loop
#                 s_(;)[; \t]* _\1_g
#                 s_[ \t]*(;)[ \t]* _\1_g
#                 /$/!b loop' | tr ';' '\n'`)
#                 for i in "${carray[@]}" ; do
#                 command='"'${i}'"'
#                 sudo su -c "${command}"
#                 done
#                 for i in ${carray[@]}; do
#                         scommand="sudo su -c \""${i}"\""
#                 #scommand=${scommand}${i}
#                 #scommand=${scommand}'"'
#                 #[[ -x $(which bash) ]] && bash -c ${scommand} || sh -c ${scommand}
#                 done
#                 return 20
#         fi
# }
#
# ## Fix zsh annoying history behavior
# function h () { if [[ -z "$*" ]]; then history; else egrep "$*" <(fc -l 1); fi; }
# # h() { if [ -z "$*" ]; then tail ${HISTFILE}; else egrep --color=auto "$*" "${HISTFILE}"; fi; }
#
# function scrs () {
#         sudo systemctl restart "${@}"
#         { systemctl status --full --no-pager "${@}"; echo; } | \
#                 less -FJKRMXs
# }
#
# function pscrs () { { sudo parallel systemctl ::: restart status ::: "${@}"; } | less -FJKRMXs; }
#
# function uscrs () {
#         systemctl --user restart "${@}"
#         { systemctl --user status --full --no-pager "${@}"; echo; } | \
#                 less -FJKRMXs
# }
#
# function puscrs () { { parallel systemctl --user ::: restart status ::: "${@}"; } | less -FJKRMXs; }
#
# ## Resume a background job
# function bfg () { if [ "${#1}" -ne 1 ]; then echo 'attempting to resume job "%1"'; local j=1; else local j="${1}"; fi; %"${j}" & }
#
# # which() { (alias; declare -f) | /bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@; }
#
# function odkms () {
#         # for i in /var/lib/dkms/*/[^k]*/source; do [ -e "$i" ] || printf '%s\n' "$i"; done
#         find /var/lib/dkms/ \
#                 \( \
#                 -regextype egrep \
#                 -regex '^.*/dkms/[^k]*/source$' \
#                 \! -exec test -e {} \; \
#                 \) \
#                 -exec ls -Al --color=always {} \;
# }
#
# ## Btrfs recursive filesystem defragment
# function dgbtrfs () { find / -xdev -type d -print -exec sudo btrfs filesystem defragment -r -v -clzo "{}" \; ; }
#
# function colortest () {
#                 local fgc bgc vals seq0
#                 printf "Color escapes are %s\n" '\e[${value};...;${value}m'
#                 printf "Values 30..37 are \e[33mforeground colors\e[m\n"
#                 printf "Values 40..47 are \e[43mbackground colors\e[m\n"
#                 printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"
#                 # foreground colors
#                 for fgc in {30..37}; do
#                                 # background colors
#                                 for bgc in {40..47}; do
#                                                 fgc=${fgc#37} # white
#                                                 bgc=${bgc#40} # black
#                                                 vals="${fgc:+$fgc;}${bgc}"
#                                                 vals=${vals%%;}
#                 printf "  %-9s" "${seq0:-(default)}"
#                                                 printf " ${seq0}TEXT\e[m"
#                                                 printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
#                                 done
#                                 echo; echo
#                 done
# }
#
# function prompt_confirm () {
#         while true; do
#         echo -n "${1:-Continue?} [y/n]: "; read -r -q REPLY
#         case $REPLY in
#                 [Yy]) echo ; return 0;;
#                 [Nn]) echo ; return 1;;
#                 *) printf " \033[31m %s \n\033[0m" "invalid input" ;;
#         esac
#         done
#         return 2 # Nothing executed past this point
#
#         ## Example usage
#         # command prompt_confirm "Overwrite File?" || exit 0
#         #
#         # ## For Bash >= version 3.2:
#         # [[ $REPLY =~ ^([yY][eE][sS]|[yY])$ ]] && true || false
#         # ## For Bash 4.x:
#         # REPLY=${REPLY,,}	# to lower
#         # [[ $REPLY =~ ^(yes|y)$ ]] && true || false
# }
#
# ## Safety nets - originally commented out to build good habits
# function safetytoggle () {
#         ## usage variable containing help/command usage
#         usagedoc='Usage: safetytoggle [option(s)]
#         Toggle or set/unset "safety" aliases (toggle by default)
# Options:
#         -s --safe		Force enable all safety aliases.
#         -n --notsafe		Force disnable all safety aliases.
#         -h --help -u --usage	View this help/usage examples (overrides other options.)
# Examples:
#         safetytoggle
#         safetytoggle -s|--set
#         safetytoggle -n|--noset
#         safetytoggle -h|--help|-u|--usage
# List of aliases toggled: [rm,wget,mv,cp,ln,chown,chmod,chgrp]
#         rm -I --preserve-root
#         wget -c
#         mv -i
#         cp -i
#         ln -i
#         chown --preserve-root
#         chmod --preserve-root
#         chgrp --preserve-root'
#         ## Parse options
#         [[ "$*" =~ ^([\-]$|\-[0-9]+|\-[hu]+[snhu]*|\-\-help|\-\-usage)+.*$ ]] && { printf "$usagedoc"; return 0; }
#         [[ "$*" =~ ^(\-s[snhu]*|\-\-set)+.*$ ]] && { unalias rm wget mv cp ln chown chmod chgrp &>/dev/null; }
#         [[ "$*" =~ ^(\-n[snhu]*|\-\-noset)+.*$ ]] && { alias rm='rm -I ' &>/dev/null; }
#         ## Set/unset aliases
#         (( `(alias; declare -f) | egrep -q '^rm=.*$'`$? )) && {
#                 ## start from scratch
#                 unalias rm wget mv cp ln chown chmod chgrp &>/dev/null
#                 ## do not delete / or prompt if deleting more than 3 files at a time
#                 alias rm='rm -I --preserve-root '
#                 ## this one saved by butt so many times
#                 alias wget='wget -c '
#                 ## confirmatiob
#                 alias mv='mv -i '
#                 alias cp='cp -i '
#                 alias cp='cp -i --reflink=auto '
#                 alias ln='ln -i '
#                 ## Parenting changing permissions on root
#                 alias chown='chown --preserve-root '
#                 alias chmod='chmod --preserve-root '
#                 alias chgrp='chgrp --preserve-root '
#                 printf "\n \033[31m %s \033[0m\n" 'Safety aliases: [Enabled]'
#         } || {
#                 unalias rm wget mv cp ln chown chmod chgrp &>/dev/null
#                 alias cp='cp --reflink=auto '
#                 printf "\n \033[32m %s \033[0m\n" 'Safety aliases: [Disabled]'
#         }
# }
