# Cond -- Parse tree node strategy for printing the special form cond

from Tree import BoolLit
from Tree import Nil
#from Tree import Unspecific
from Print import Printer
from Special import Special

class Cond(Special):
    def __init__(self):
        pass

    def print(self, t, n, p):
        Printer.printCond(t, n, p)

    def eval(self, exp, env):
        if(Special.util.length(exp) != 2):
            self._error('invalid expression: incorrect number of arguments')
            return Nil.getInstance()
        expressions = exp.getCdr()
        while(not (expressions.isNull())):
            clause = expressions.getCar()
            if(Special.util.length(clause)<1):
                self._error('invalid expression: invalid cond clause')
                return Nil.getInstance()
            test = clause.getCar()
            body = clause.getCdr()
            first = body.getCar()
            if(first == '=>'):
                body = body.getCdr().getCar().eval(env)
            else:
                body = body.eval(env)
            if(test.isSymbol()):
                if(test.getName()=='else'):
                    return body.apply(test)
            test = test.eval(env)
            if(test == BoolLit(True)):
                return body.apply(test)
            expressions = expressions.getCdr()
        return Nil.getInstance()
