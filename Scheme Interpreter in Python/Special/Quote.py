# Quote -- Parse tree node strategy for printing the special form quote

from Tree import Nil
from Print import Printer
from Special import Special

class Quote(Special):
    def __init__(self):
        pass

    def print(self, t, n, p):
        Printer.printQuote(t, n, p)

    def eval(self, exp, env):
        if(Special.util.length(exp) == 2):
            return exp.getCdr().getCar()
        else:
            self._error('invalid expression')
            return Nil.getInstance()
