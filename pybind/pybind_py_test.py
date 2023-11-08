import unittest
from pybind import pybind as regular
from pybind import pybind_copy as regular_copy

class PybindTest(unittest.TestCase):
  def test_pybind_first(self):
    print("1: regular.first_func")
    self.assertEqual(regular.first_func(1), 2)
    print("2: regular.second_func")
    self.assertEqual(regular.second_func(1), 2)
    print("3: regular_copy.first_func")
    self.assertEqual(regular_copy.first_func(1), 4)
    print("4: regular_copy.second_func")
    self.assertEqual(regular_copy.second_func(1), 4)

if __name__ == '__main__':
  unittest.main()
