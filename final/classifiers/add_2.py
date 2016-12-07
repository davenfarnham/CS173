#!/usr/bin/env python2.7

#
# Python allows you to essentially add elements to the instantiation
# of an object after its creation. Here, create an object o1 of class A, add new
# attributes to it, then update its class variable. Next, create another
# instantiation of A, o2, and see if both o1 and o2 refer to the same class variable
# even though o1 no longer conforms to the blueprint of Class A.
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

  # change class variable
  o1.a.append(30)

  o2 = A()

  print o1.a
  print o2.a

if __name__ == '__main__':
  main()
