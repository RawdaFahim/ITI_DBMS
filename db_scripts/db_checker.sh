#! /bin/bash
shopt -s extglob
LC_ALL=C

function synatax_checker() {
    case $* in
    [0-9]*)
        echo -e " ${RED}The database's name mustn't start with number${NC}"
        return 1 #1 for false

        ;;
    +([a-zA-Z0-9 ]))
        return 0 #0 for true
        ;;
    *)
        echo -e " ${RED}Invalid input you can't enter empty name nor special characters${NC}"
        return 1 #1 for false

        ;;
    esac

}
function db_checker() {
    if ls $1 | grep -w "$2" >/dev/null ;then
        return 0 #0 for true
    else
        return 1 #1 for false
    fi
}

function null_validation() {

    if [[ -z $1 && (($2 == 3)) ]]; then # 3: null values allowed
        return 0
    elif [[ ! -z $1 && (($2 == 3)) ]]; then # 3: non null values are allowed
        return 0
    elif [[ ! -z $1 && (($2 == 4)) ]]; then # 4: null values are not allowed
        return 0
    else
        echo -e " ${RED}The value can't be null${NC}"
        return 1
    fi

}
function syntax_validation() {

    if [[ $1 == +([a-zA-Z0-9]) ]]; then
        echo -e " ${BGreen}Valid Syntax${NC}"
        return 0 # Alphanumic returns True/0
    elif [[ $1 == "" ]]; then
        echo -e " ${BGreen}Valid Syntax${NC}"
        return 0 # newline returns True/0
    else
        echo -e " ${RED}No special characters are allowed!${NC}"
        return 1 # Space only & wildcards return False/1
    fi

}

function value_validation() {

    if [[ (($2 == 1)) ]]; then           # 1: strings values allowed
        if [[ $1 == +([a-zA-Z]) ]]; then # 1: null values allowed
            return 0
        elif [[ $1 == "" ]]; then
            return 0
        else
            echo -e " ${RED}Value must be string${NC}"
            return 1

        fi
    fi

    if [[ (($2 == 2)) ]]; then # 2: numric values only allowed
        if [[ $1 == +([0-9]) ]]; then
            return 0
        elif [[ $1 == "" ]]; then
            return 0
        else
            echo -e " ${RED}Value must be numeric${NC}"
            return 1

        fi
    fi

}

function unique_value() {
    if (($(wc -l $1 | cut -d" " -f1) == 3)); then #checking if the table is empty!
        return 0
    fi

    if cut -f1 -d";" "$1" | tail -n+4 | grep -w "$2" >/dev/null; then #To avoid printing
        echo -e " ${RED}Value must be unique${NC}"
        return 1
    fi

}
