# BuiltIn -- the data structure for built-in functions

# Class BuiltIn is used for representing the value of built-in functions
# such as +.  Populate the initial environment with
# (name, BuiltIn(name)) pairs.

# The object-oriented style for implementing built-in functions would be
# to include the Python methods for implementing a Scheme built-in in the
# BuiltIn object.  This could be done by writing one subclass of class
# BuiltIn for each built-in function and implementing the method apply
# appropriately.  This requires a large number of classes, though.
# Another alternative is to program BuiltIn.apply() in a functional
# style by writing a large if-then-else chain that tests the name of
# the function symbol.

import sys
from Parse import *
from Tree import Node
from Tree import BoolLit
from Tree import IntLit
from Tree import StrLit
from Tree import Ident
from Tree import Nil
from Tree import Cons
from Tree import TreeBuilder
#from Tree import Unspecific

class BuiltIn(Node):
    env = None
    util = None

    @classmethod
    def setEnv(cls, e):
        cls.env = e

    @classmethod
    def setUtil(cls, u):
        cls.util = u

    def __init__(self, s):
        self.symbol = s                 # the Ident for the built-in function

    def getSymbol(self):
        return self.symbol

    def isProcedure(self):
        return True

    def print(self, n, p=False):
        for _ in range(n):
            sys.stdout.write(' ')
        sys.stdout.write("#{Built-In Procedure ")
        if self.symbol != None:
            self.symbol.print(-abs(n) - 1)
        sys.stdout.write('}')
        if n >= 0:
            sys.stdout.write('\n')
            sys.stdout.flush()

    # TODO: The method apply() should be defined in class Node
    # to report an error.  It should be overridden only in classes
    # BuiltIn and Closure.
    def apply(self, args):
        # Retrive the length of the argument
        length = BuiltIn.util.length(args)
        
        # Error check for invalid number of arguments
        if(length>2):
            self._error('invalid expression: too many arguments')
            return Nil.getInstance()
        
        # Extract the name
        name = self.symbol.getName()
        
        # Apply for arguments of length 0
        if(length==0):
            if(name == "read"): 
                scanner = Scanner(sys.stdin)
                builder = TreeBuilder()
                parser = Parser(scanner, builder)

                result = parser.parseExp()
                if(result != None):
                    return result
                return Ident('end-of-file')
            if(name == "newline"):
                sys.stdout.write('\n')
                sys.stdout.flush()
                return Nil.getInstance()
            if(name == "interaction-environment"):
                return self.env
            self._error('unknown built-in function')
            return Nil.getInstance()

        # Apply for arguments of length 1
        if(length==1):
            # Retrieve the argument
            arg1 = args.getCar()

            # Apply for load
            if(name == "load"):
                if(not arg1.isString()):
                    self._error("wrong type of argument")
                    return Nil.getInstance()
                filename = arg1.getStrVal()
                try:
                    scanner = Scanner(open(filename))
                    builder = TreeBuilder()
                    parser = Parser(scanner, builder)

                    root = parser.parseExp()
                    while root != None:
                        root.eval(BuiltIn.env)
                        root = parser.parseExp()
                except IOError:
                    self._error("could not find file " + filename)
                return Nil.getInstance() # or Unspecific, if implemented

            # Apply for car
            if(name == "car"):
                return arg1.getCar()

            # Apply for cdr
            if(name == "cdr"):
                return arg1.getCdr()

            # Apply for number?
            if(name == "number?"):
                return BoolLit.getInstance(arg1.isNumber())

            # Apply for symbol?
            if(name == "symbol?"):
                return BoolLit.getInstance(arg1.isSymbol())

            # Apply for null?
            if(name == "null?"):
                return BoolLit.getInstance(arg1.isNull())

            # Apply for pair?
            if(name == "pair?"):
                return BoolLit.getInstance(arg1.isPair())

            # Apply for procedure?
            if(name == "procedure?"):
                return BoolLit.getInstance(arg1.isProcedure())

            # Apply for write
            if(name == "write"):
                arg1.print(-1)
                return Nil.getInstance()

            # Apply for display
            if(name == "display"):
                StrLit.printQuotes = False
                arg1.print(-1)
                StrLit.printQuotes = True
                return Nil.getInstance()
            
            self._error('unknown built-in function')
            return Nil.getInstance()

        # Apply for arguments of length 2
        if(length==2):
            # Retrieve the two arguments
            arg1 = args.getCar()
            arg2 = args.getCdr().getCar()

            if(name == "eq?"):
                if(arg1.isSymbol()):
                    if(arg2.isSymbol()):
                        name1 = arg1.getName()
                        name2 = arg2.getName()
                        return BoolLit.getInstance(name1==name2)
                    else:
                        return BoolLit.getInstance(False)
                return BoolLit.getInstance(arg1==arg2)
            if(name == "cons"):
                return Cons(arg1, arg2)
            if(name == "set-car!"):
                arg1.setCar(arg2)
                return Nil.getInstance()
            if(name == "set-cdr!"):
                arg1.setCdr(arg2)
                return Nil.getInstance()
            if(name == "eval"):
                return arg1.eval(arg2)
            if(name == "apply"):
                return arg1.apply(arg2)
            if(name[0] == 'b'):
                if(arg1.isNumber()):
                    if(arg2.isNumber()):
                        arg1 = arg1.getIntVal()
                        arg2 = arg2.getIntVal()
                        if(name == 'b+'):
                            return IntLit(arg1 + arg2)
                        if(name == 'b-'):
                            return IntLit(arg1 - arg2)
                        if(name == 'b*'):
                            return IntLit(arg1 * arg2)
                        if(name == 'b/'):
                            return IntLit(arg1 / arg2)
                        if(name == 'b='):
                            return BoolLit.getInstance(arg1 == arg2)
                        if(name == 'b<'):
                            return BoolLit.getInstance(arg1 < arg2)
                        self._error('unknown built-in function')
                        return Nil.getInstance()
                    else:
                        self._error('invalid argument type')
                        return Nil.getInstance()
                else:
                    self._error('invalid argument type')
                    return Nil.getInstance()
            self._error('unknown built-in function')
            return Nil.getInstance()
            

        ## The easiest way to implement BuiltIn.apply is as an
        ## if-then-else chain testing for the different names of
        ## the built-in functions.  E.g., here's how load could
        ## be implemented:
 
        # if name == "load":
        #     if not arg1.isString():
        #         self._error("wrong type of argument")
        #         return Nil.getInstance()
        #     filename = arg1.getStrVal()
        #     try:
        #         scanner = Scanner(open(filename))
        #         builder = TreeBuilder()
        #         parser = Parser(scanner, builder)

        #         root = parser.parseExp()
        #         while root != None:
        #             root.eval(BuiltIn.env)
        #             root = parser.parseExp()
        #     except IOError:
        #         self._error("could not find file " + filename)
        #     return Nil.getInstance()  # or Unspecific.getInstance()
