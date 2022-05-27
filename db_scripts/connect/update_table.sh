#!/bin/bash
function update_row() {

    read -p "what is the table name 
    ==>" tb_name

    if ! synatax_checker $tb_name; then
        return 1 #1 for false
    fi
    if ! db_checker "./$tb_name" "$tb_name"; then
        echo -e " ${RED}The name doesn't exists${NC}"
        return 1 #1 for false
    fi

    read -p "what is the primary key's value
    ==>" pri_value

    if ! cut -f1 -d";" "$tb_name" | tail -n+4 | grep -w "$pri_value" >/dev/null; then
        echo -e " ${RED}The value doesn't exists${NC}"
        return 1
    fi

    line1=$(sed -n '1p' $tb_name)
    line2=$(sed -n '2p' $tb_name)
    line3=$(sed -n '3p' $tb_name)

    old_ifs="$IFS"
    IFS=";"

    row_number=$(awk -v var=$pri_value -F";" \
        '{if($1==var && NR>3)\
    {print NR}}' $tb_name)

    user_data=$(awk -v row=$row_number -F";" \
        '{if(NR==row)\
    {print $0}}' $tb_name)

    col_names_arr=($line1)
    col_metadata_arr=($line2)
    col_constraints_arr=($line3)
    data_array=($user_data)
    IFS="$old_ifs"

    chmod +w $tb_name
    line_value=""
    for ((i = 0; i < ${#col_names_arr[@]}; i++)); do
        while true; do
            echo "The value of ${col_names_arr[$i]} column is ${data_array[$i]} "
            read -p "Would you like to change it (y/n)
            ==>" answer
            if [[ $answer == [Yy] ]]; then
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
            elif [[ $answer == [Nn] ]]; then
                line_value+="${data_array[$i]};"
            else
                echo -e " ${RED}The name doesn't exists${NC}"
                continue

            fi
            break
        done

    done
    line_value=${line_value::-1}
    sed -i "${row_number}d" $tb_name
    echo $line_value >>$tb_name
    echo -e " ${BGreen}Values has been updated successfully${NC}"
    echo "
    -------------------------------------------------------------
    "
}
