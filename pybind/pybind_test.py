import unittest
from pybind import libbinary_pybind_pyext as lib_so

class PymoduleTest(unittest.TestCase):
  def test_pybind_first(self):
    self.assertEqual(lib_so.pybind_first(1), 2)

  def test_pybind_second(self):
    self.assertEqual(lib_so.pybind_second(1), 2)


if __name__ == '__main__':
  unittest.main()
