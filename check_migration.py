def check_migrations():
    f = open("/home/rawda/logs.txt", "r")
    # f.readline()
    #print("here")
    for line in f:
        fields= line.split()
        if fields[0] == '[ ]':
            print("here")


check_migrations()