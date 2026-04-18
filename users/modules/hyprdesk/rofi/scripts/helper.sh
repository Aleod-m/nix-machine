#!/usr/bin/env bash
# Defines functions to use inside rofi scripts 
# the run rofi will call the folowing functions declared inside a rofi script:
# - init
# - on_select
# - on_custom 
# - init

export OUT=""

# Allow to set options for the mode and row
#
# Mode option list:
# - prompt: Update the prompt text.
# - message: Update the message text.
# - markup-rows: If 'true' renders markup in the row.
# - urgent: Mark rows as urgent. (for syntax see the urgent option in dmenu mode)
# - active: Mark rows as active. (for syntax see the active option in dmenu mode)
# - delim: Set the delimiter for for next rows. Default is '\n' and this option should finish with this. Only call this on first call of script, it is remembered for consecutive calls.
# - no-custom: If set to 'true'; only accept listed entries, ignore custom input.
# - use-hot-keys: If set to true, it enabled the Custom keybindings for script. Warning this breaks the normal rofi flow.
# - keep-selection: If set, the selection is not moved to the first entry, but the current position is maintained. The filter is cleared.
# - keep-filter: If set, the filter is not cleared.
# - new-selection: If keep-selection is set, this allows you to override the selected entry (absolute position).
# - data: Passed data to the next execution of the script via ROFI_DATA.
# - theme: Small theme snippet to f.e. change the background color of a widget.
# - switch-mode: Switches to the given mode if enabled, otherwise ignored.
#
# Row option list:
# - icon: Set the icon for that row. Multiple fallback icons can be specified using comma-separated values.
# - display: Replace the displayed string. (Original string will still be used for filtering)
# - meta: Specify invisible search terms used for filtering.
# - nonselectable: If true the row cannot activated.
# - permanent: If true the row always shows, independent of filter.
# - info: Info that, on selection, gets placed in the ROFI_INFO environment variable. This entry does not get searched for filtering.
# - urgent: Set urgent flag on entry (true/false)
# - active: Set active flag on entry (true/false)
set_opt () {
	OUT="$OUT\0$0\x1f$1\n"
}

# Add a row to the selection
row () {
	OUT="$OUT$1"; shift;
    local delim='\0';
    while [ $# -ge 2 ]; do
		OUT="$OUT$delim$1\x1f$2";
        shift 2;
        delim='\x1f';
    done
	OUT="$OUT\n"
}


# Run the correct function for the rofi action.
# Note: scripts should pass "$@" to this function.
run_rofi() {
	case "$ROFI_RETV" in
		0) init "$@";;
		1) on_select "$@";;
		2) on_custom "$@";;
		3) on_delete "$@";;
	esac
	echo -en "$OUT";
}

