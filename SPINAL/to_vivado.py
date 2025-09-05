import re
import os

# make directory "vivado" if it does not exist
if not os.path.exists("vivado"):
    os.makedirs("vivado")
else:
    # remove all .v .dat files in the vivado folder
    os.system("rm vivado/*.v")
    os.system("rm vivado/*.dat")

file_names = ["ACCELERATOR.v", "ACCELERATOR_bb.v"]

# read each line, if it contains readmem, then extract it

# for example:
# initial begin
#     $readmemh("C:/projects/AAAProjects/PROJ14_LLM/SPINAL/src/main/verilog/ROPE_QK_QUANT/ROPE_QK_QUANT_stage1_preprocess_p_ZL11ROPE_THETAS_0_ROM_AUTO_1R.dat", rom0);
# end

# use regex to match, get the file name, and replace the path, target is
# $readmemh("./ROPE_QK_QUANT_stage1_preprocess_p_ZL11ROPE_THETAS_0_ROM_AUTO_1R.dat", rom0);

# read the file
for file_name in file_names:
    contents = []
    with open(file_name, "r") as f:
        lines = f.readlines()
        # iterate each line
        for line in lines:
            # use regex to match
            match = re.search(r'\$readmemh\("(.*?)"', line)
            if match:
                # get the file name
                file_path = match.group(1)
                # replace the path
                new_file_path = file_path.split("/")[-1]
                new_line = line.replace(file_path, "./"+new_file_path)
                contents.append(new_line)
            else:
                contents.append(line)
    # create a new file
    new_file_name = "vivado/" + file_name.replace(".v", "_replaced.v")
    # write the file, overwrite the original file
    with open(new_file_name, "w") as f:
        f.writelines(contents)

# copy all the dat files to vivado folder, from "./src/main/verilog/*/" to "./vivado/"
os.system("cp src/main/verilog/*/*.dat vivado/")