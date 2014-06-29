#!/usr/bin/python
import argparse


def filter(data, newitem):
    for item in data:
        if item.endswith(newitem):
            return data
    data.append(newitem)
    return data


def parseargs():
    parser = argparse.ArgumentParser(
        description='Convert list of ad domains to appease squid')
    parser.add_argument('filename', type=str, nargs=1,
                        help='File to manipulate')

    args = parser.parse_args()
    # Simplify access to filename
    args.filename = args.filename[0]
    return args


if __name__ == "__main__":
    args = parseargs()
    data = []

    with open(args.filename) as fh:
        for newline in fh:
            data = filter(data, newline)

    with open(args.filename, 'w') as fh:
        fh.writelines(data)
