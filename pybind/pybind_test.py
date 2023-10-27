import unittest
from pybind import cc_binary_pybind as lib_so
from pybind import cc_binary_pybind_copy as lib_so_copy

class PymoduleTest(unittest.TestCase):
  def test_pybind_first(self):
    print("1: test_pybind_first")
    self.assertEqual(lib_so.pybind_first(1), 2)
    print("2: test_pybind_second")
    self.assertEqual(lib_so.pybind_second(1), 2)
    print("3: test_pybind_first_copy")
    self.assertEqual(lib_so_copy.pybind_first(1), 4)
    print("4: test_pybind_second_copy")
    self.assertEqual(lib_so_copy.pybind_second(1), 4)

if __name__ == '__main__':
  unittest.main()
