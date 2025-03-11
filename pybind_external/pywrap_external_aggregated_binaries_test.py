import os
import unittest
import json
import argparse


def parse_args() -> argparse.Namespace:
  parser = argparse.ArgumentParser()
  parser.add_argument("--wheel-locations", required=True)
  return parser.parse_args()


class PywrapExternalAggregatedBinariesTest(unittest.TestCase):
  def test_pywrap_binaries(self):
    args = parse_args()
    with open(args.wheel_locations) as f:
      wheel_locations = json.load(f)

    relative_wheel_locations = [
        ("/pywrap_external/pybind.{pyextension}",
         "/pybind/pybind.{pyextension}"),
        ("/pybind/pybind.py", ""),
        ("/pywrap_external/pybind_copy.{pyextension}",
         "/pybind/pybind_copy.{pyextension}"),
        ("/pybind/pybind_copy.py", ""),
        ("/pywrap_external/pybind_cc_only.{pyextension}", ""),
        ("/pywrap_external/pybind_with_starlark_only.{pyextension}", ""),
        ("/pybind/pybind_with_starlark_only.py", ""),
        ("/pywrap_external/libframework.so.2", "/pybind/libframework.so.2"),
        ("/pywrap_external/{lib}pywrap_external_aggregated_common.{extension}",
         "/pywrap_external/{lib}pywrap_external_aggregated_common.{extension}"),
        (
            "/pywrap_external/{lib}pywrap_external_aggregated__starlark_only_common.{extension}",
            ""),
    ]

    pyextension = "so"
    extension = "so"
    lib_prefix = "lib"
    if "nt" in os.name:
      relative_wheel_locations.extend([
          ("/pywrap_external/libframework.so.2.if.lib", "/pybind/libframework.so.2.if.lib"),
          ("/pywrap_external/pywrap_external_aggregated__starlark_only_common.if.lib", ""),
          ("/pywrap_external/pywrap_external_aggregated_common.if.lib", "/pywrap_external/pywrap_external_aggregated_common.if.lib"),
      ])
      pyextension = "pyd"
      extension = "dll"
      lib_prefix = ""

    expected_relative_wheel_locations = {}
    for k, v in relative_wheel_locations:
      new_k = k.format(pyextension=pyextension, extension=extension,
                       lib=lib_prefix)
      new_v = v.format(pyextension=pyextension, extension=extension,
                       lib=lib_prefix)
      expected_relative_wheel_locations[new_k] = new_v

    for rel_src, rel_dest in expected_relative_wheel_locations.items():
      matched_srcs = None
      for src, dest in wheel_locations.items():
        if not src.endswith(rel_src):
          continue
        self.assertEqual(dest[-len(rel_dest):], rel_dest)
        del wheel_locations[src]
        matched_srcs = src
        break
      self.assertTrue(matched_srcs, msg="Could not find "" + rel_src + """)

    self.assertEqual(wheel_locations, {})


if __name__ == "__main__":
  PywrapExternalAggregatedBinariesTest().test_pywrap_binaries()
