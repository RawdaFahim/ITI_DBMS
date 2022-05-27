#!/bin/bash
function db_delete() {
    read -p "what is the database name 
    ==>" db_name
    echo "$db_name"
    if ! synatax_checker $db_name; then
        return 1 #1 for false
    fi
    if ! db_checker "./database" "$db_name"; then
        echo -e " ${RED}The name doesnt exists${NC}"
        return 1 #1 for false
    fi
    
    while true; do
    read -p "Database found
     are you sure you want to delete $db_name database (y/n)?
     ==> " answer
    
        if [[ $answer == [Yy] ]]; then
            echo "Deleting in progress"
            rm -r database/"$db_name"
            break
        elif [[ $answer == [Nn] ]]; then
            echo "Ok, Goodbye!"
            break
        else
            echo -e " ${RED}Invalid Input${NC}"
            continue
        fi
    done
    echo -e " ${BGreen}Database $db_name has been deleted successfully${NC}"
    echo "
    -------------------------------------------------------------
    "
}
