# if using GNU screen, let the zsh tell screen what the title and hardstatus
# of the tab window should be.
if [[ $_GET_PATH == '' ]]; then
	# _GET_PATH='echo $PWD | sed "s/^\/Users\//~/;s/^\/home\//~/;s/^~$USER/~/"'
	_GET_PATH='basename $PWD | sed "s/alyptik/~/"'
fi
if [[ $_GET_HOST == '' ]]; then
	_GET_HOST='echo $HOST | sed "s/\..*//"'
fi

# use the current user as the prefix of the current tab title
TAB_TITLE_PREFIX='"$(basename $PWD | sed -r "s!alyptik!~!; s!^([[:alnum:]]+).*!\1!")""$PROMPT_CHAR"'
# TAB_TITLE_PREFIX='"$(basename $PWD | sed -r "s!alyptik!~!; s!^([[:alnum:]]{1,7}).*!\1!")""$PROMPT_CHAR"'
# TAB_TITLE_PREFIX='"`'$_GET_PATH' | sed "s:..*/::"`$PROMPT_CHAR"'

# when at the shell prompt, show a truncated version of the current path (with
# standard ~ replacement) as the rest of the title.
TAB_TITLE_PROMPT='$SHELL:t'
# when running a command, show the title of the command as the rest of the
# title (truncate to drop the path to the command)
TAB_TITLE_EXEC='$cmd[1]:t'

# use the current path (with standard ~ replacement) in square brackets as the
# prefix of the tab window hardstatus.
TAB_HARDSTATUS_PREFIX='"[`'$_GET_PATH'`] "'
# when at the shell prompt, use the shell name (truncated to remove the path to
# the shell) as the rest of the title
TAB_HARDSTATUS_PROMPT='$SHELL:t'
# the title
# when running a command, show the command name and arguments as the rest of
TAB_HARDSTATUS_EXEC='$cmd'

# tell GNU screen what the tab window title ($1) and the hardstatus($2) should be
function screen_set ()
{
	# set the tab window title (%t) for screen
	print -nR $'\033k'$1$'\033'\\\

	# set hardstatus of tab window (%h) for screen
	print -nR $'\033]0;'$2$'\a'
}
# called by zsh before executing a command
function screen_preexec ()
{
	local PS_FORMAT REPORTTIME
	REPORTTIME=-1
	# [[ "$TERM" == screen* ]] || return
	# tty | grep -vq 'tty' || return
	# [[ -n "$STY" && -z "$TMUX" ]] || return
	if ps -p "$PPID" | grep -iqw 'screen'; then
		local -a cmd; cmd=(${(z)1}) # the command string
		# eval "tab_title=$TAB_TITLE_EXEC"
		eval "tab_title=$TAB_TITLE_PREFIX:$TAB_TITLE_EXEC"
		# eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX:$TAB_HARDSTATUS_EXEC"
		eval "tab_hardstatus=$TAB_HARDSTATUS_EXEC"
		screen_set $tab_title $tab_hardstatus
	fi
}

# called by zsh before showing the prompt
function screen_precmd ()
{
	local PS_FORMAT REPORTTIME
	REPORTTIME=-1
	# [[ "$TERM" == screen* ]] || return
	# tty | grep -vq 'tty' || return
	# [[ -n "$STY" && -z "$TMUX" ]] || return
	if ps -p "$PPID" | grep -iqw 'screen'; then
		# eval "tab_title=$TAB_TITLE_PROMPT"
		eval "tab_title=$TAB_TITLE_PREFIX:$TAB_TITLE_PROMPT"
		# eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX:$TAB_HARDSTATUS_PROMPT"
		eval "tab_hardstatus=$TAB_HARDSTATUS_PROMPT"
		screen_set $tab_title $tab_hardstatus
	fi
}

preexec_functions+=(screen_preexec)
precmd_functions+=(screen_precmd)
