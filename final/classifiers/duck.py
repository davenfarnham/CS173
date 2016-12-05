#!/usr/bin/env python2.7

#
# Example of duck typing
#

def f(a, b):
  return a * b

def main():
  print f(1, 2)
  print f([1, 2], 2)

if __name__ == '__main__':
  main()
