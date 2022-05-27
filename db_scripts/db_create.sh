#!/bin/bash

function create_database() {
    read -p "what is the database name 
    ==> " db_name
    if ! synatax_checker $db_name; then
        return 1 #1 for false
    fi
    if db_checker "./database/" "$db_name"; then
        echo -e " ${RED}The already name exists!${NC}"
        return 1 #1 for false
    fi
    echo "valid name creating "$db_name" database"
    mkdir ./database/"$db_name"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    "
    echo -e " ${BGreen}\t\tDatabase $db_name has been created successfully\n${NC}"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    "
}
