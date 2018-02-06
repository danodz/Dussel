import preprocessorLib
import os
import re

files = os.listdir()
sources = [];
for i in files:
    if re.search("^scenario_", i):
        sources.append(i.split("scenario_"))
for i in sources:
    if i[1] in files:
        preprocessorLib.preprocess(i[1], "scenario_" + i[1]);
