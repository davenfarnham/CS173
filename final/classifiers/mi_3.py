#!/usr/bin/env python2.7

#
# Check the order of inheritance in cases of multiple inheritance;
# should be depth first
#

# define a Class A
class A:
  a = 29

  def p(self):
    return "I'm in A"

# define a Class B that inherits from A
class B(A):
  pass

# define a Class C with the same field names and method names as B
class C:
  a = 173

  def p(self):
    return 173

# define a Class D that inherits from both B and C
class D(B, C):
  pass

def main():
  o = D()
  print o.p()

if __name__ == '__main__':
  main()
