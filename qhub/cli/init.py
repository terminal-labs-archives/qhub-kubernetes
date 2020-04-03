from qhub.render import render_default_template, render_template


def create_init_subcommand(parser):
    subparser = parser.add_subparsers(help="Initialize QHub repository")
    subparser = subparser.add_parser("init")
    subparser.add_argument("-i", "--input", help="input directory")
    subparser.add_argument("-o", "--output", default=".", help="output directory")
    subparser.add_argument("-c", "--config", help="cookiecutter configuration")
    subparser.set_defaults(func=handle_render)


def handle_render(args):
    if args.input is None:
        render_default_template(args.output, args.config)
    else:
        render_template(args.input, args.output, args.config)
