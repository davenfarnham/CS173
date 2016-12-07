#!/usr/bin/env python2.7

#
# Check naming precedence
#

# define a Class A; variable 'a' comes before method 'a'
class A:
  a = 1

  def a(self):
    return "I'm in A"

# define a Class B; method 'b' comes before variable 'b'
class B:
  def b(self):
    return "I'm in B"

  b = 1

def main():
  o1 = A()
  print o1.a

  o2 = B()
  print o2.b

if __name__ == '__main__':
  main()
