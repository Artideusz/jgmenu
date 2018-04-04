#!/bin/sh

# 'jgmenu init' creates/updates jgmenurc

tmp_jgmenurc=$(mktemp)
jgmenurc=~/.config/jgmenu/jgmenurc
jgmenurc_bak=${jgmenurc}.$(date +%Y%m%d%H%M)
theme=

regression_items="max_items min_items ignore_icon_cache color_noprog_fg \
color_title_bg show_title search_all_items ignore_xsettings arrow_show \
read_tint2rc tint2_rules tint2_button multi_window"

usage () {
	printf "usage: jgmenu init [<options>]\n"
	printf "Create/amend config files\n"
	printf "Options include:\n"
	printf "    --config-file=<file>  Specify config file\n"
	printf "    --theme=<theme>       Create config file with a particular theme\n"
	printf "                          Valid themes include: bunsenlabs\n\n"
}

populate_tmp_file () {
cat <<'EOF' >>"${tmp_jgmenurc}"
stay_alive          = 1
hide_on_startup     = 0
csv_cmd             = pmenu
tint2_look          = 1
at_pointer          = 0
terminal_exec       = x-terminal-emulator
terminal_args       = -e
monitor             = 0
menu_margin_x       = 0
menu_margin_y       = 32
menu_width          = 200
menu_padding_top    = 5
menu_padding_right  = 5
menu_padding_bottom = 5
menu_padding_left   = 5
menu_radius         = 1
menu_border         = 0
menu_halign         = left
menu_valign         = bottom
sub_spacing         = 1
sub_padding_top     = -1
sub_padding_right   = -1
sub_padding_bottom  = -1
sub_padding_left    = -1
sub_hover_action    = 1
item_margin_x       = 3
item_margin_y       = 3
item_height         = 25
item_padding_x      = 4
item_radius         = 1
item_border         = 0
item_halign         = left
sep_height          = 5
font                =
font_fallback       = xtg
icon_size           = 22
icon_text_spacing   = 10
icon_theme          =
icon_theme_fallback = xtg
arrow_string        = ▸
arrow_width         = 15
color_menu_bg       = #000000 70
color_menu_fg       = #eeeeee 20
color_menu_border   = #eeeeee 8
color_norm_bg       = #000000 00
color_norm_fg       = #eeeeee 100
color_sel_bg        = #ffffff 20
color_sel_fg        = #eeeeee 100
color_sel_border    = #eeeeee 8
color_sep_fg        = #ffffff 20
csv_name_format     = %n (%g)
EOF
}

backup_jgmenurc () {
	test -e ${jgmenurc} && cp -p ${jgmenurc} ${jgmenurc_bak}
}

# strstr <needle> <haystack>
strstr () {
	! test -z "$2" && test -z "${2##*$1*}"
}

# insert_after <file> <after> <insert_string>
insert_after () {
	local tmp=$(mktemp)
	local done="n"
	if ! grep "$2" "$1" >/dev/null 2>&1
	then
		printf "%b\n" "BUG: cannot find 'after' pattern $2"
		return
	fi
	while IFS= read -r line
	do
		printf "%b\n" "${line}" >>${tmp}
		if strstr "$2" "$line" && test "$done" == "n"
		then
			printf "%b\n" "$3" >>${tmp}
			done="y"
		fi
	done <${1}
	mv -f ${tmp} $1
}

amend_jgmenurc () {
	local prefix="      - "
	while IFS= read -r line
	do
		key=$(echo ${line%%=*} | tr -d ' ')
		test -z "${key}" && continue
		if ! grep "^${key}[\ =]\|[\ #]${key}[\ =]" "${jgmenurc}" >/dev/null 2>&1
		then
			printf "${prefix}%b\n" "${line}"
			insert_after "${jgmenurc}" "$prev" "#$line"
		fi
		prev=${key}
	done <${tmp_jgmenurc}
}

# START OF SCRIPT

while test $# != 0
do
	case "$1" in
	--config-file=*)
		jgmenurc="${1#--config-file=}" ;;
	--theme=*)
		theme="${1#--theme=}" ;;
	--help)
		usage
		exit 0
		;;
	*)
		printf "fatal: unknown option: '%s'\n" $1
		usage
		exit 1
		;;
	esac
	shift
done

mkdir -p ~/.config/jgmenu
backup_jgmenurc

if ! test -z ${theme}
then
	JGMENU_EXEC_DIR=$(jgmenu_run --exec-path)
	if test "${theme}" = "bunsenlabs"
	then
		. ${JGMENU_EXEC_DIR}/jgmenu-init--bunsenlabs.sh
		set_theme_bunsenlabs
	else
		printf "warn: cannot find theme '${theme}'\n"
	fi
else
	populate_tmp_file
	amend_jgmenurc
	rm -f ${tmp_jgmenurc}
fi

# Check for jgmenurc items which are no longer valid
for r in ${regression_items}
do
	if grep ${r} ${jgmenurc} >/dev/null 2>&1
	then
		printf "%b\n" "warning: ${r} is no longer a valid key"
	fi
done
