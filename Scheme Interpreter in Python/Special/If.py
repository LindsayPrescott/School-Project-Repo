# If -- Parse tree node strategy for printing the special form if

from Tree import BoolLit
from Tree import Nil
#from Tree import Unspecific
from Print import Printer
from Special import Special

class If(Special):
    def __init__(self):
        pass

    def print(self, t, n, p):
        Printer.printIf(t, n, p)

    def eval(self, exp, env):
        n = Special.util.length(exp)
        # Test for a valid if statement
        if(n<3 or n>4):
            self._error('invalid expression, incorrect number of arguments for if statement')
            return Nil.getInstance()
        # extract the conditional test from the if statement
        testExp = exp.getCdr().getCar()
        # extract the expression to evaluate if the conditional evaluates to true
        trueExp = exp.getCdr().getCdr().getCar()
        # extract the expression to evaluate if the conditional evaluates to false
        if(n==3):
            elseExp = Nil.getInstance() # Else expression is unspecified, return Unspecified if implemented
        else:
            elseExp = exp.getCdr().getCdr().getCdr().getCar()
        # evaluate the test and return the desired expression 
        if(testExp.eval(env) == BoolLit.getInstance(True)):
            return trueExp.eval(env)
        else:
            return elseExp.eval(env)
        
