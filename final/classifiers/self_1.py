#!/usr/bin/env python2.7

#
# Look at argument self in methods
#

# define a Class A
class A:
  def p():
    return "I'm in A"

def main():
  o1 = A()
  print o1.p()

if __name__ == '__main__':
  main()
