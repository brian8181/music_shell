#!/usr/bin/sed -nf

# delete all (leading) blanks
/./!d

# get here: so there is a non empty
:x

# print it
p

# get next
n

# got chars? print it again, etc...
/./bx

# no, don’t have chars: got an empty line
:z

# get next, if last line we finish here so no trailing
# empty lines are written
n

# also empty? then ignore it, and get next... this will
# remove ALL empty lines
/./!bz

# all empty lines were deleted/ignored, but we have a non empty. As
# what we want to do is to squeeze, insert a blank line artificially
i\
bx
