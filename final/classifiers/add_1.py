#!/usr/bin/env python2.7

#
# Basic classifier dealing with modifying objects
# after instantiation
#

# define a Class A
class A:
  a = 1

  def p(self):
    return "I'm in A"

def f(o):
  return o.b

def main():
  o1 = A()

  # add attributes to o1
  o1.b = "hi"
  o1.c = 1 == 1

  # pass updated object to function that expects an attribute
  # not in Class A
  print f(o1)

if __name__ == '__main__':
  main()
