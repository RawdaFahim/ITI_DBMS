#!/bin/bash
function insert_row() {

    read -p "what is the table name 
    ==>" tb_name

    if ! synatax_checker $tb_name; then
        return 1 #1 for false
    fi
    if ! db_checker "./$tb_name" "$tb_name"; then
        echo -e " ${RED}The name doesn't exists${NC}"
        return 1 #1 for false
    fi
    line1=$(sed -n '1p' $tb_name) # line1 contains the column names
    line2=$(sed -n '2p' $tb_name) # line2 contains the columns datatype
    line3=$(sed -n '3p' $tb_name) # line3 contains constraints

    old_ifs="$IFS"
    IFS=";"

    col_names_arr=($line1)
    col_metadata_arr=($line2)
    col_constraints_arr=($line3)
    IFS="$old_ifs"

    chmod +w $tb_name
    line_value=""
    for ((i = 0; i < ${#col_names_arr[@]}; i++)); do
        while true; do
            read -p "enter value of ${col_names_arr[$i]} column: " col_value

            if ! syntax_validation "$col_value"; then #Checking for no special characters!
                continue
            fi

            if ! null_validation "$col_value" "${col_constraints_arr[$i]}"; then
                continue
            fi

            if ! value_validation "$col_value" "${col_metadata_arr[$i]}"; then
                continue
            fi

            if ((i == 0)); then
                if ! unique_value $tb_name $col_value; then
                    continue
                fi
            fi

            line_value+="$col_value;"
            break
        done

    done
    line_value=${line_value::-1}

    echo $line_value >>$tb_name
    echo -e " ${BGreen}Value has been added sucessfully${NC}"
    echo "
    -------------------------------------------------------------
    "

}
