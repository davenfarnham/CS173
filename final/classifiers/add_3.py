#!/usr/bin/env python2.7

#
# Modify the instantiation of Class A, then see if the next object
# instantiated from Class A reflects these changes.
#

# define a Class A
class A:
  a = []

  def p(self):
    return "I'm in A"

def main():
  o1 = A()

  # add attributes to o1
  o1.b = "hi"
  o1.c = 1 == 1

  # create another object from Class A
  o2 = A()

  print o2.b

if __name__ == '__main__':
  main()
