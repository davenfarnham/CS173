#!/usr/bin/env python2.7

#
# Similar to add classifiers; here, instead of adding attributes to an object
# after its instantiation, delete from a Class definition and check new object instantiation
#

# define a Class A
class A:
  a = 29

  def p(self):
    return "I'm in A"

def main():
  # original Class A
  o1 = A()
  print o1.a

  # delete attribute a from Class A
  del A.a

  o2 = A()
  print o2.a

if __name__ == '__main__':
  main()
