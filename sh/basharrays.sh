#!/bin/bash


comargs=(
    --center
    --borders=10
    --title="Exploring BASH Arrays"
    --text="\
This long text string is included in order to test and demonstrate
how an inconvenient array a multi-line string can be safely saved
and restored.  Including a text option after the comargs array will
override this default text."
    --button="Done":1
)


# Using the 'bell' character as the element delimiter:
COMARGS=$( printf "%s\a" "${comargs[@]}" )


using_exported()
{
    IFS=$'\a' lcomargs=( $COMARGS )
    echo "lcomargs has ${#lcomargs[@]} arguments:"
    printf "'%s'\n" "${lcomargs[@]}"
}

combining_arrays()
{
    IFS=$'\a' lcomargs=( $COMARGS )
    form_cmd=(
        --text="Complete the following form to get a prize."
        --form
        --field="Birthday":DT "1966/09/18"
        --field="First Name" ""
        --field="Last Name" ""
    )

    yad "${lcomargs[@]}" "${form_cmd[@]}"
}

commenting_array_elements()
{
    cmd=(
        --title="Commenting Array Elements"
        # --text="Please fill out the following survey for a prize."
        --text="Our legal department advised against asking for a birthdate."
        --form
        --field="First Name" ""
        --field="Last Name" ""
        # --field="Birthday":DT "1960/04/21"
        --button="Done":1
    )

    yad "${cmd[@]}"
}

commenting_escaped_newlines()
{
    yad \
        --title="Commenting Escaped Newlines" \
        # --text="Please fill out the following survey for a prize." \
        --text="Our legal department advised against asking for a birthdate." \
        --form \
        --field="First Name" "" \
        --field="Last Name" "" \
        # --field="Birthday":DT "1960/04/21" \
        --button="Done":1
}

cmd=(
    "${comargs[@]}"
    --fixed
    --text="\
This text replaces the long default text.  The text option is part of a new array that begins
with the contents of the previous array.  We used the extended array to generate the dialog.
Also, if you look at the script, you will see that this YAD dialog is at a global scope within
the script, so it can use the comargs array directly.  Other examples that follow will be YAD
calls to exported functions, which will be in a different scope and thus unable to access comargs.
For these dialogs, we'll have to export the array and reconstruct it before using it.
Also note that the --fixed option is included in the YAD command to prevent the excessive height
of the dialog."
)

yad "${cmd[@]}"

cmdf=(
    "${comargs[@]}"
    --text="\
Calling a function in the same script, exported to make
it available to YAD."
    --form
    --field="Call Exported Internal Function":BTN "bash -c using_exported"
    --field="Combining Arrays":BTN "bash -c combining_arrays"
    --field="Commenting Array Elements":BTN "bash -c commenting_array_elements"
    --field="Commenting Escaped Newlines":BTN "bash -c commenting_escaped_newlines"
)

export COMARGS
export -f using_exported
export -f combining_arrays
export -f commenting_array_elements
export -f commenting_escaped_newlines

yad "${cmdf[@]}"

unset commenting_escaped_newlines
unset commenting_array_elements
unset combining_arrays
unset using_exported
unset COMARGS

