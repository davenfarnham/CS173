#!/usr/bin/env python2.7

#
# Example of duck typing: f can take either two ints and return
# an int, or a list and an int and return a list
#

def f(a, b):
  return a * b

def main():
  print f(1, 2)
  print f([1, 2], 2)

if __name__ == '__main__':
  main()
