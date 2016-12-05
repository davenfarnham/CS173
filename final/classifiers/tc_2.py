#!/usr/bin/env python2.7

#
# This will no longer work since class B no longer has a method p
#

# define a Class A
class A:
  def p(self):
    return "I'm in A"

# define Class
class B:
  def b(self):
    return 173

# define a function that takes an object 'o'
def f(o):
  print o.p()

def main():
  o1 = A()
  f(o1)

  o2 = B()
  f(o2)

if __name__ == '__main__':
  main()
