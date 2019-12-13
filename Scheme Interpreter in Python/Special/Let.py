# Let -- Parse tree node strategy for printing the special form let

from Tree import Nil
from Tree import Environment
from Print import Printer
from Special import Special

class Let(Special):
    def __init__(self):
        pass

    def print(self, t, n, p):
        Printer.printLet(t, n, p)

    def eval(self, exp, env):
        if(Special.util.length(exp) < 3):
            self._error('invalid expression: not enough arguments')
            return Nil.getInstance()
        bindings = exp.getCdr().getCar()
        body = exp.getCdr().getCdr().getCar()
        if(Special.util.length(bindings)<1):
            self._error('invalid expression: invalid bindings')
            return Nil.getInstance()
        letEnv = Environment(env)
        while(not (bindings.isNull())):
            bind = bindings.getCar()
            if(Special.util.length(bind)<1):
                self._error('invalid expression: invalid binding')
                return Nil.getInstance()
            varName = bind.getCar()
            varBody = bind.getCdr().getCar()
            varBody = varBody.eval(env)
            letEnv.define(varName, varBody)
            bindings = bindings.getCdr()
        return Special.util.begin(body, letEnv)
