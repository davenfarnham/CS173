# Python 2.7

## Intro

Just a brief disclaimer that it's been a number of years since I programmed in either Python or an OO language, so as far 
as OO convention goes, much of what I think comes from examples from class.

Unlike some of the examples in class, you don't really cast objects to different classes in Python. You can cast things,
like if I'm given an int `i` I can cast it to a string with `str(i)`, or if I'm given an object I can cast it to a string,
but it doesn't seem like you cast between classes or objects.

Since you never really explicitly declare the type of variables like you do in C, I realized I didn't know python's
built-in types. If you run `basic_1.py`, you get a dynamic type error at runtime noting you can't add a `str` to an `int`.
