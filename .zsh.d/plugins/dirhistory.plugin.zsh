##
#   Navigate directory history using ALT-LEFT and ALT-RIGHT. ALT-LEFT moves back to directories
#   that the user has changed to in the past, and ALT-RIGHT undoes ALT-LEFT.
#


declare -a dirsetopts
export dirhistory_past=("$PWD")
export dirhistory_future=()
export DIRHISTORY_SIZE=30
export zdirstore=${HOME}/.zdirstore
diropts="$(setopt | grep '\(autopushd\|pushdminus\|pushdsilent\|pushdtohome\|pushdignoredups\)' | paste -sd' ')"
dirpattern="$(<<<"$diropts" sed 's@^@\\(@;s@ @\\|@g;s@$@\\)@')"
dirsetopts=($(<<<'autopushd pushdignoredups pushdminus pushdsilent pushdtohome' tr ' ' $'\n' | grep -v "$dirpattern"| paste -sd' '))

function dirpersiststore () {
	[ -z "$dirsetopts" ] || setopt "$dirsetopts[@]"
	dirs -p | perl -e \
		'foreach (reverse <STDIN>) {chomp;s/([& ])/\\$1/g ;print "if [ -d $_ ]; then pushd -q $_; fi\n"}' > "$zdirstore"
	[ -z "$dirsetopts" ] || unsetopt "$dirsetopts[@]"
}

function dirpersistrestore () {
	[ -z "$dirsetopts" ] || setopt "$dirsetopts[@]"
	[ ! -r $zdirstore ] || . "$zdirstore"
	[ -z "$dirsetopts" ] || unsetopt "$dirsetopts[@]"
}

## Called by zsh when directory changes
chpwd_functions+=(chpwd_dirhistory)
#chpwd_functions+=(dirpersiststore)

#dirpersistrestore

# Pop the last element of dirhistory_past.
# Pass the name of the variable to return the result in.
# Returns the element if the array was not empty,
# otherwise returns empty string.
function pop_past() {
  eval "$1='$dirhistory_past[$#dirhistory_past]'"
  if [[ "$#dirhistory_past" -gt 0 ]]; then
    dirhistory_past[$#dirhistory_past]=()
  fi
}

function pop_future() {
  eval "$1='$dirhistory_future[$#dirhistory_future]'"
  if [[ "$#dirhistory_future" -gt 0 ]]; then
    dirhistory_future[$#dirhistory_future]=()
  fi
}

# Push a new element onto the end of dirhistory_past. If the size of the array
# is >= DIRHISTORY_SIZE, the array is shifted
function push_past() {
  if [[ "$#dirhistory_past" -ge "$DIRHISTORY_SIZE" ]]; then
    shift dirhistory_past
  fi
  if [[ "$#dirhistory_past" -eq 0 || "$dirhistory_past[$#dirhistory_past]" != "$1" ]]; then
    dirhistory_past+=("$1")
  fi
}

function push_future() {
  if [[ "$#dirhistory_future" -ge "$DIRHISTORY_SIZE" ]]; then
    shift dirhistory_future
  fi
  if [[ "$#dirhistory_future" -eq 0 || "$dirhistory_futuret[$#dirhistory_future]" != "$1" ]]; then
    dirhistory_future+=("$1")
  fi
}

function chpwd_dirhistory() {
  push_past "$PWD"
  # If DIRHISTORY_CD is not set...
  if [[ -z "${DIRHISTORY_CD+x}" ]]; then
    # ... clear future.
    dirhistory_future=()
  fi
}

function dirhistory_cd(){
  DIRHISTORY_CD="1"
  cd "$1"
  unset DIRHISTORY_CD
}

# Move backward in directory history
function dirhistory_back() {
  local cw=""
  local d=""
  # Last element in dirhistory_past is the cwd.

  pop_past cw
  if [[ "" == "$cw" ]]; then
    # Someone overwrote our variable. Recover it.
    dirhistory_past=("$PWD")
    return
  fi

  pop_past d
  if [[ "" != "$d" ]]; then
    dirhistory_cd "$d"
    push_future "$cw"
  else
    push_past "$cw"
  fi
}


# Move forward in directory history
function dirhistory_forward() {
  local d=""

  pop_future d
  if [[ "" != "$d" ]]; then
    dirhistory_cd "$d"
    push_past "$d"
  fi
}


# Bind keys to history navigation
function dirhistory_zle_dirhistory_back() {
  # Erase current line in buffer
  zle kill-buffer
  dirhistory_back
  zle accept-line
}

function dirhistory_zle_dirhistory_future() {
  # Erase current line in buffer
  zle kill-buffer
  dirhistory_forward
  zle accept-line
}

zle -N dirhistory_zle_dirhistory_back
# xterm in normal mode
#bindkey "\e[3D" dirhistory_zle_dirhistory_back
#bindkey "\e[1;3D" dirhistory_zle_dirhistory_back
# Putty:
#bindkey "\e\e[D" dirhistory_zle_dirhistory_back
# GNU screen:
#bindkey "\eO3D" dirhistory_zle_dirhistory_back

zle -N dirhistory_zle_dirhistory_future
#bindkey "\e[3C" dirhistory_zle_dirhistory_future
#bindkey "\e[1;3C" dirhistory_zle_dirhistory_future
#bindkey "\e\e[C" dirhistory_zle_dirhistory_future
#bindkey "\eO3C" dirhistory_zle_dirhistory_future

bindkey "\e[" dirhistory_zle_dirhistory_back
bindkey "\e]" dirhistory_zle_dirhistory_future
