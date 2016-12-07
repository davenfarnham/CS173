#!/usr/bin/env python2.7

#
# Check naming precedence using instance variables, class variables, and methods.
# Here, instance variables always take precedence over methods with the same name
#

# define a Class A; variable 'a' comes before method 'a'
class A:
  a = 1

  def __init__(self, num):
    self.b = num

  def b(self):
    return 173

def main():
  o1 = A(10)
  print o1.b

if __name__ == '__main__':
  main()
