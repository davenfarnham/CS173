#!/usr/bin/env python2.7

""" A simple example class from 2.7 manual """
class MyClass:
    i = 12345

    def hi(self):
      return 'hello world'

def main():
  """ create class and call one of its methods """
  x = MyClass()
  print x.hi()

if __name__ == '__main__':
  main()
