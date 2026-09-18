from pathlib import Path
from jinja2 import FileSystemLoader, Environment


class JinjaRenderer:
    def __init__(self, templates_path):
        self.env = Environment(
            loader=FileSystemLoader(templates_path),
            variable_start_string="<",
            variable_end_string=">"
        )
        
    def render_template(
        self,
        template_name: str,
        render_args: dict,
        output_path: Path | str
    ) -> None:
        # argument parsing
        output_path = Path(output_path)
        template=self.env.get_template(template_name)

        # template rendering
        render_output = template.render(**render_args)
        output_path.write_text(render_output)

        print(f"Wrote render output to {output_path}.")