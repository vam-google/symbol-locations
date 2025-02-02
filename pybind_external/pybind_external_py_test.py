import unittest
from pybind import pybind as regular
from pybind import pybind_copy as regular_copy
import pybind.pybind
import pybind.pybind_copy
from pybind.pybind import _EXTRA_SYMBOL as REGULAR_EXTRA_SYMBOL
from pybind.pybind_copy import _EXTRA_SYMBOL as REGULAR_COPY_EXTRA_SYMBOL


class PybindTest(unittest.TestCase):
  def _read_file(self, filename, mode="r"):
    with open(filename, mode) as file:
      file_content = file.read()
    return file_content

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
    print("7: regular.second_global_func")
    self.assertEqual(regular.second_global_func(), 2)
    print("8: regular_copy.second_global_func")
    self.assertEqual(regular.second_global_func(), 2)
    print("9: REGULAR_EXTRA_SYMBOL")
    self.assertEqual(REGULAR_EXTRA_SYMBOL, 123)
    print("10: REGULAR_COPY_EXTRA_SYMBOL")
    self.assertEqual(REGULAR_COPY_EXTRA_SYMBOL, 123)

    print("11: binary resource size")
    self.assertTrue(self._read_file("data/data_binary", "rb"))
    print("12: data/static_resource")
    self.assertEqual(self._read_file("data/static_resource.txt"),
                     "A static resource file under data dir")
    print("13: pybind/static_resource.txt")
    self.assertEqual(self._read_file("pybind/static_resource.txt"),
                     "A static resource file under pybind dir")


if __name__ == '__main__':
  unittest.main()
