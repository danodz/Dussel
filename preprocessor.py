import sys

file = open( sys.argv[1], "r")
mainScript = file.read()
file.close()

newScript = ""

for i in mainScript.split("--[[{{"):
    block = i.split("}}]]--")
    if len(block) == 2:
        file = open( block[0], "r" )
        newScript += file.read()
        newScript += block[1]
        file.close()
    else:
        newScript += block[0]

file = open( sys.argv[2], "w")
file.write(newScript);
