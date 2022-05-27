#!/bin/bash

function delete_table() {
    read -p "what is the table name 
    ==>" tb_name

    if ! synatax_checker $tb_name; then
        return 1 #1 for false
    fi
    if ! db_checker "./$tb_name" "$tb_name"; then
        echo -e " ${RED}The name doesn't exists${NC}"
        return 1 #1 for false
    fi
    
    while true; do
        read -p "Table found
        are you sure you want to delete $tb_name table (y/n) ?
        ==> " answer
        if [[ $answer == [Yy] ]]; then
            echo "deleting in progress"
            sed -i '4,$d' $tb_name
            echo -e " ${BGreen}Table $tb_name has been deleted successfully${NC}"
            break
        elif [[ $answer == [Nn] ]]; then
            echo "Ok, Goodbye!"
            break
        else
            echo -e " ${RED}Invalid Option${NC}"
            continue
        fi
    done
    echo "
    -------------------------------------------------------------
    "
}
