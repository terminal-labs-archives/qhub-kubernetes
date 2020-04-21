import yaml
from jinja2.ext import Extension


class YamlifyExtension(Extension):
    """Jinja2 extension to convert a Python object to YAML."""

    def __init__(self, environment):
        """Initialize the extension with the given environment."""
        super().__init__(environment)

        def yamlify(obj):
            return yaml.dump(obj)

        environment.filters["yamlify"] = yamlify
