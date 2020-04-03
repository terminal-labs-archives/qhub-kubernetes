import pathlib
import json

from cookiecutter.main import cookiecutter


def render_default_template(output_directory, config_filename=None):
    import qhub

    input_directory = pathlib.Path(qhub.__file__).parent / "template"
    render_template(input_directory, output_directory, config_filename)


def render_template(input_directory, output_directory, config_filename=None):
    # would be nice to remove assumption that input directory
    # is in local filesystem
    input_directory = pathlib.Path(input_directory)
    if not input_directory.is_dir():
        raise ValueError(f"input directory={input_directory} is not a directory")

    output_directory = pathlib.Path(output_directory)
    if not output_directory.is_dir():
        raise ValueError(f"output directory={output_directory} is not a directory")

    prompt_filename = input_directory / "hooks" / "prompt_gen_project.py"

    if config_filename is not None:
        filename = pathlib.Path(config_filename)

        if not filename.is_file():
            raise ValueError(f"cookiecutter configuration={filename} is not filename")

        with filename.open() as f:
            config = json.load(f)

        cookiecutter(
            str(input_directory),
            no_input=True,
            extra_context=config,
            output_dir=str(output_directory),
        )
    elif prompt_filename.is_file():
        with prompt_filename.open() as f:
            content = f.read()

        global_context = {}
        exec(content, global_context, global_context)
        config = global_context["COOKIECUTTER_CONFIG"]

        cookiecutter(
            str(input_directory),
            no_input=True,
            extra_context=config,
            output_dir=str(output_directory),
        )
    else:
        cookiecutter(str(input_directory), output_dir=str(output_directory))
