#!/usr/bin/env python2.7

#
# Check the types of classes, objects, and how different
# objects and classes relate to eachother
#

# define a Class A
class A:
  def p(self):
    return "I'm in A"

# define a Class B; different from A
class B:
  i = 10

  def k(self):
    return "I'm in B"

def main():
  # instantiate objects
  o1 = A()
  o2 = A()
  o3 = B()

  # print types of class and object
  print type(A)
  print type(o1)

  # check equivalence of different objects
  print type(o1) == type(o2)
  print type(o1) == type(o3)
  print type(B) == type(A)

if __name__ == '__main__':
  main()
