import math
import os 
from os import join

CONSTANTS = 654

class SomeClass(object):
    def __init__(self, var1: str=None, var2: float=None)-> None:
        self.var1 = var1
        self.var2 = var2

    @decorator
    def sm_fn(self) -> None:
        return self.var1 * self.var2



