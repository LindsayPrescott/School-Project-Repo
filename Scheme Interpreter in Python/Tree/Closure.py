# Closure -- the data structure for function closures

# Class Closure is used to represent the value of lambda expressions.
# It consists of the lambda expression itself, together with the
# environment in which the lambda expression was evaluated.

# The method apply() takes the environment out of the closure,
# adds a new frame for the function call, defines bindings for the
# parameters with the argument values in the new frame, and evaluates
# the function body.

import sys
from Tree import Node
from Tree import StrLit
from Tree import Environment
from Tree import Nil

class Closure(Node):
    util = None

    @classmethod
    def setUtil(cls, u):
        cls.util = u

    def __init__(self, f, e):
        self.fun = f                    # a lambda expression
        self.env = e                    # the environment in which
                                        # the function was defined

    def getFun(self):
        return self.fun

    def getEnv(self):
        return self.env

    def isProcedure(self):
        return True

    def print(self, n, p=False):
        for _ in range(n):
            sys.stdout.write(' ')
        sys.stdout.write("#{Procedure")
        if self.fun != None:
            self.fun.print(abs(n) + 4)
        for _ in range(abs(n)):
            sys.stdout.write(' ')
        sys.stdout.write(" }\n")
        sys.stdout.flush()

    # TODO: The method apply() should be defined in class Node
    # to report an error.  It should be overridden only in classes
    # BuiltIn and Closure.
    def apply(self, args):
        params = self.fun.getCdr().getCar()
        body = self.fun.getCdr().getCdr()
        functionEnv = Environment(self.env)
        while(not (params.isNull())):
            if(args.isNull()):
                self._error('invalid expression: arguments do not match parameters')
                return Nil.getInstance()
            if(params.isSymbol()):
                functionEnv.define(params, args)
            elif(not (params.isPair())):
                self._error('invalid expression: invalid parameters')
                return Nil.getInstance()
            elif(args.isPair()):
                if(params.getCar().getName() == '.'):
                    params = params.getCdr()
                    if(not params.isSymbol()):
                        self._error('invalid expression: invalid parameter')
                        return Nil.getInstance()
                functionEnv.define(params.getCar(), args.getCar())
            else:
                self._error('invalid expression')
                return Nil.getInstance()
            args = args.getCdr()
            params = params.getCdr()
        return Closure.util.begin(body, functionEnv)
