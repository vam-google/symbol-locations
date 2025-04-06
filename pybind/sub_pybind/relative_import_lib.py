from .nested_pybind import nested_pybind_func
from ..pybind.sub.sub_sub import _sub_sub_private_func

def call_nested_pyind_func(x):
  return nested_pybind_func(x)

def sub_sub_private_func(x):
  return _sub_sub_private_func(x)