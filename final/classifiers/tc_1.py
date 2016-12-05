#!/usr/bin/env python2.7

#
# If I have two classes A and B, I can pass either of those classes
# to function f() as long as they have a method p. This is an example
# of duck-typing.
#

# define a Class A
class A:
  def p(self):
    return "I'm in A"

# define Class
class B:
  def p(self):
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
