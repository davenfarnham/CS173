#!/usr/bin/env python2.7

#
# Casting; limitations to instance variables
#

# define a Class A
class A:
  a = 1

  def __init__(self, str):
    self.h = str

  def announce(self):
    print self.h

class B:
  b = 2

def main():
  o1 = B()
  print o1.b

  o2 = A("hello")
  o2.announce()

  # recast o1 to Class A
  o1.__class__ = A
  print o1.announce()


if __name__ == '__main__':
  main()
