import re
import sys

#regex constants
omit_comment = r"^\s*(?!--)"
#omit_comment = r"^\s*(?!--).*"

#filein = open("axil_regs.vhd", "r")
#filein = open(str(sys.argv[0]), "r")
filein = open(str(sys.argv[1]), "r")
filetext = filein.read()
filein.close()
inst = open("inst.vhd", "w")

m = re.search(r"entity.*?architecture",filetext, re.MULTILINE | re.DOTALL)
a = m.group(0)
a = re.sub(r"--.*","",a)   #remove all comments 
a = re.sub(r"\s*\n","\n",a)   #remove all spaces before a newline
a = re.sub(r"^\s*$","",a)   #remove all empty spaces lines
a = re.sub(r"architecture","",a)

entity = re.sub(r"entity\s*\w+", "entity "+sys.argv[2], a)
entity = re.sub(r"end\s*\w+", "end "+sys.argv[2], entity)
entity = entity + "\narchitecture arch of " + sys.argv[2] + " is\n"
ent = open("entity.vhd", "w")
ent.write(entity)
ent.close()

numports = 0
counter = 0
a = re.sub(r"\s*:\s*integer\s*:=", "    =>", a)
numports = a.count(':')
while True:
  g = re.search(r"\s*(\w+)\s*:", a)
  if g is not None :
      if counter < numports-1:  
        a = re.sub(r":.*?(in|out)\s*", "=> %s,   --" % (g.group(1)), a, count =1)
        counter = counter+1
      else:
        a = re.sub(r":.*?(in|out)\s*", "=> %s    --" % (g.group(1)), a, count =1)
        counter = counter+1
  else :
    break
m = re.sub(r"entity ", "inst_name: entity work.", a)
j = re.sub(r"\(\s.", "  ", m)
l = re.sub(r"port", "port map \n(\n", j)
l = re.sub("generic", "generic map \n(\n", l)
z = re.sub("is", "", l)
z = re.sub("end.*", "\n", z)
z = re.sub(r"(?<==>)(\s*\d*);", r"\1,", z) #match any "=>" followed by spaces and numbers and ";" and replace with the spaces and numbers and comma new line 
z = re.sub(r";(?=.*port map)", "", z, flags=re.MULTILINE | re.DOTALL) #match any ";" only if it is eventually followed by a "port map"
a = re.sub(r"^\s*$",r"",a)   #remove all spaces before a newline
inst.write(z)
inst.close()

#Signals Generation
#z = re.sub(r".*port","",z, flags=re.MULTILINE | re.DOTALL)
z = re.sub(r".*port.*?\(","",z, flags=re.MULTILINE | re.DOTALL)
#z = re.sub(r"inst_name.+","",z)
z = re.sub(r".+=>", "signal", z)
#z = re.sub(omit_comment+r"--", ":  ", z)
#z = re.sub(r"--(?=.*;)", ":  ", z) #match any "--" only if it is eventually followed by a ";"
z = re.sub(r"--", ":  ", z) 
z = re.sub(r",", " ", z)
z = re.sub(r"\s+\)", '', z)
z = re.sub(r";", "", z) #delete all the semicolons
z = re.sub(r"^\n*","",z)   #remove all empty spaces lines
z = re.sub(r"\n+","\n",z)   #remove any double new lines
z = re.sub(r"\n", ";\n", z) #add semicolons to every line
#z = re.sub(r"\s+$", ";\n", z)
z = re.sub("^(?:(?!signal).)*$","aahhh",z) #delete every line that doesnt contain signal **FIX ME**
sigs = open("sigs.vhd", "w")
sigs.write(z)
sigs.close()

