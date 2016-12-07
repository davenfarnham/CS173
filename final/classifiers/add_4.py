#!/usr/bin/env python2.7

#
# Does adding things to an object squash previous attributes?
#

# define a Class A
class A:
  a = []

  def p(self):
    return "I'm in A"

def main():
  o1 = A()

  # change attributes
  o1.p = "hi"
  o1.a = "there"

  print o1.p
  print o1.a

if __name__ == '__main__':
  main()
