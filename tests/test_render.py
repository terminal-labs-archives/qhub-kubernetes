import pytest

from qhub.render import render_default_template


@pytest.mark.parametrize('config_filename', [
    'tests/assets/config_aws.json',
    'tests/assets/config_gcp.json',
    'tests/assets/config_do.json',
])
def test_render(config_filename, tmp_path):
    output_directory = tmp_path / 'test'
    output_directory.mkdir()

    render_default_template(str(output_directory), config_filename)
