# Set -- Parse tree node strategy for printing the special form set!

from Tree import Nil
#from Tree import Unspecific
from Print import Printer
from Special import Special

class Set(Special):
    def __init__(self):
        pass
    
    def print(self, t, n, p):
        Printer.printSet(t, n, p)

    def eval(self, exp, env):
        length = Special.util.length(exp)
        if(length != 3):
            self._error('invalid expression: invalid number of arguments')
            return Nil.getInstance()
        varName = exp.getCdr().getCar()
        varValue = exp.getCdr().getCdr().getCar()
        env.assign(varName, varValue.eval(env))
        return Nil.getInstance()
