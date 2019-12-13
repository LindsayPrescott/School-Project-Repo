# Define -- Parse tree node strategy for printing the special form define

from Tree import Ident
from Tree import Nil
from Tree import Cons
#from Tree import Void
from Print import Printer
from Special import Special

class Define(Special):
    def __init__(self):
        pass

    def print(self, t, n, p):
        Printer.printDefine(t, n, p)
    
    def eval(self, exp, env):
        length = Special.util.length(exp)
        if(length != 3):
            self._error('invalid number of arguments for define')
            return Nil.getInstance()
        args = exp.getCdr().getCar()
        body = exp.getCdr().getCdr()
        if(args.isPair()):
            funcName = args.getCar()
            args = args.getCdr()
            if(not (funcName.isSymbol)):
                self._error('invalid function name')
                return Nil.getInstance()
            params = args
            while(params.isPair()):
                if(not (params.getCar().isSymbol())):
                    self._error('invalid parameter')
                    return Nil.getInstance()
                params = params.getCdr()
            function = Cons(Ident('lambda'), Cons(args, body))
            function = function.eval(env)
            env.define(funcName, function)
            return Nil.getInstance()
        if(args.isSymbol):
            env.define(args, body.getCar().eval(env))
            return Nil.getInstance()
        self._error('invalid expression with define')

