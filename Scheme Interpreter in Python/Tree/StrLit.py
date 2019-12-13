# StLit -- Parse tree node class for representing string literals

import sys
from Tree import Node
from Print import Printer

class StrLit(Node):
    printQuotes = True

    def __init__(self, s):
        self.strVal = s

    def print(self, n, p=False):
        if(self.printQuotes):
            Printer.printStrLit(n, self.strVal)
        else:
            for _ in range(n):
                sys.stdout.write(' ')

            sys.stdout.write(self.strVal)

    def isString(self):
        return True

    def getStrVal(self):
        return self.strVal

    def eval(self, env):
        return self

if __name__ == "__main__":
    id = StrLit("foo")
    id.print(0)
