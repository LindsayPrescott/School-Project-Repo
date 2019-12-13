# Regular -- Parse tree node strategy for printing regular lists

from Tree import Nil
from Print import Printer
from Special import Special

class Regular(Special):
    def __init__(self):
        pass

    def print(self, t, n, p):
        Printer.printRegular(t, n, p)

    def eval(self, exp, env):
        length = Special.util.length(exp)
        if(length>=1):
            function = exp.getCar().eval(env)
            args = Special.util.mapeval(exp.getCdr(), env)
            return function.apply(args)
        else:
            self._error('invalid expression')
            return Nil.getInstance()
