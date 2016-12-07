#!/usr/bin/env python2.7

#
# Check the order of inheritance in cases of multiple inheritance
#

# define a Class A
class A:
  a = 29

  def p(self):
    return "I'm in A"

# define a Class B with the same field names and method names as A
class B:
  a = 173

  def p(self):
    return 173

# define a Class C that inherits from both A and B
class C(A, B):
  c = 42

  def h(self):
    return 1 == 1

def main():
  o = C()

  # check methods and variables; should all come from A
  print o.p()
  print o.a

if __name__ == '__main__':
  main()
