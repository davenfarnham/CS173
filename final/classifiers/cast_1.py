#!/usr/bin/env python2.7

#
# Casting
#

# define a Class A
class A:
  a = 1

  def p(self):
    return "I'm in A"

class B:
  b = 2

def main():
  o1 = B()
  print o1.b

  # recast o1 to Class A
  o1.__class__ = A
  print o1.p()


if __name__ == '__main__':
  main()
