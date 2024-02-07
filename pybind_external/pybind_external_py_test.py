import unittest
from pybind import pybind as regular
from pybind import pybind_copy as regular_copy
import pybind.pybind
import pybind.pybind_copy
from pybind.pybind import _EXTRA_SYMBOL


class PybindTest(unittest.TestCase):
  def test_pybind_first(self):
    print("1: regular.first_func")
    self.assertEqual(regular.first_func(1), 2)
    print("2: pybind.pybind.second_func")
    self.assertEqual(pybind.pybind.second_func(1), 2)
    print("3: regular.third_func")
    self.assertEqual(regular.third_func(1), 1)
    print("4: pybind.pybind_copy.first_func")
    self.assertEqual(pybind.pybind_copy.first_func(1), 4)
    print("5: regular_copy.second_func")
    self.assertEqual(regular_copy.second_func(1), 4)
    print("6: regular_copy.third_func")
    self.assertEqual(regular_copy.third_func(1), 1)

    print("7: _EXTRA_SYMBOL")
    self.assertEqual(_EXTRA_SYMBOL, 123)

if __name__ == '__main__':
  unittest.main()
