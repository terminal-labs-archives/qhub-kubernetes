import argparse
import sys

from qhub.cli.init import create_init_subcommand


def cli(args):
    parser = argparse.ArgumentParser(description="QHub command line")
    parser.set_defaults(func=None)
    create_init_subcommand(parser)
    args = parser.parse_args(args)

    if args.func is None:
        parser.print_help(sys.stderr)
        sys.exit(1)

    args.func(args)
