#!/usr/bin/env python2.7

#
# A quick example of multiple inheritance. Class C inherits from both A and B,
# meaning methods and variables in both classes are available to it.
#

# define a Class A
class A:
  a = 29

  def p(self):
    return "I'm in A"

# define a Class B
class B:
  b = 173

  def k(self):
    return 173

# define a Class C that inherits from both A and B
class C(A, B):
  c = 42

  def h(self):
    return 1 == 1

def main():
  o = C()

  # check methods and variables
  print o.p()
  print o.k()
  print o.h()
  print o.a
  print o.b
  print o.c

if __name__ == '__main__':
  main()
