import argparse
import re
import json
from typing import List, Pattern, Dict, Any

def filter_def_file(def_file: str, filter_file: str,
    filtered_file: str) -> None:
  with open(filter_file, 'r', encoding='utf-8') as filter:
    filter_json: Dict[str, Any] = json.load(filter)
    inclusion_patterns: List[str] = filter_json["global"] + [
        "EXPORTS", "*;*"
    ]

    incl_patterns: List[Pattern] = [
      re.compile(re.escape(p).replace("\\*", ".*")) for p in inclusion_patterns
    ]
    exclusion_patterns: List[str] = filter_json["local"]
    excl_patterns: List[Pattern] = [
      re.compile(re.escape(p).replace("\\*", ".*")) for p in exclusion_patterns
    ]

  with open(def_file, 'r') as orig_file, open(filtered_file, 'w') as filt_file:
    for l in orig_file:
      if not matches_any(excl_patterns, l) or matches_any(incl_patterns, l):
        filt_file.write(l)


def matches_any(patterns: List[Pattern], line: str) -> bool:
  stripped_line = line.strip()
  for pattern in patterns:
    if pattern.match(stripped_line):
      return True
  return False


def parse_args() -> argparse.Namespace:
  parser = argparse.ArgumentParser()
  parser.add_argument("--def-file", required=True)
  parser.add_argument("--def-file-filter", required=True)
  parser.add_argument("--filtered-def-file", required=True)

  return parser.parse_args()


def main():
  args = parse_args()
  filter_def_file(args.def_file, args.def_file_filter, args.filtered_def_file)


if __name__ == '__main__':
  main()
