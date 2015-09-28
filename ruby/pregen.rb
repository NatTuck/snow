


# A module (= a source file) contains top-level bindings.
#
# Mods and Funs both have scopes.
#
# They need pointers to their parent scopes.
# 
# Each scope (= stack frame) is just a heap-allocated struct.
#
# Each struct has a name -> offset map for the associated keys.
# This is used during compilation, and is kept around in case
# we're doing instrospection of some sort.

class Mod

end

class Var

end

class Fun

end

class Type

end

class Call

end



