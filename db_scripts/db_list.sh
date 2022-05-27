#!/bin/bash
function listing_database() {
    if (($(ls database | wc -w) == 0)); then
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        "
        echo -e "${BBlue}There are no tables to display\n${NC}"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        "
        return 1 # 1 for false
    fi

    echo "Listing all databases:"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    "
    echo -e "${BBlue}$(ls database)\n${NC}"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    "
}
