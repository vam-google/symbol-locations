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

    expected_relative_wheel_locations = {
      "/pywrap_external/pybind.so": "/pybind/pybind.so",
      "/pybind/pybind.py": "",
      "/pywrap_external/pybind_copy.so": "/pybind/pybind_copy.so",
      "/pybind/pybind_copy.py": "",
      "/pywrap_external/pybind_cc_only.so": "",
      "/pywrap_external/pybind_with_starlark_only.so": "",
      "/pybind/pybind_with_starlark_only.py": "",
      "/pywrap_external/libframework.so.2": "/pybind/libframework.so.2",
      "/pywrap_external/libpywrap_external_aggregated_internal.so": "/pywrap_external/libpywrap_external_aggregated_internal.so",
      "/pywrap_external/libpywrap_external_aggregated__starlark_only_internal.so": ""
    }

    for rel_src, rel_dest in expected_relative_wheel_locations.items():
      matched_srcs = None
      for src, dest in wheel_locations.items():
        if not src.endswith(rel_src):
          continue
        self.assertEqual(dest[-len(rel_dest):], rel_dest)
        del wheel_locations[src]
        matched_srcs = src
        break
      self.assertTrue(matched_srcs)

    self.assertEqual(wheel_locations, {})

if __name__ == '__main__':
  PywrapExternalAggregatedBinariesTest().test_pywrap_binaries()
