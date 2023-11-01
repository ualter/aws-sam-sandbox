import json
import segno
import jinja2


def handler_qrcode(event, context):
    qrcode = segno.make("Ualter Otoni Pereira")
    html = render_jinja_html("./templates", "example.html", qrcode=qrcode)
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "text/html",
        },
        "body": html,
    }


def handler_hello(event, context):
    return {
        "statusCode": 200,
        "body": json.dumps(
            {
                "message": "hello world!",
                # "location": ip.text.replace("\n", "")
            }
        ),
    }


def render_jinja_html(template_loc, file_name, **context):
    return (
        jinja2.Environment(loader=jinja2.FileSystemLoader(template_loc + "/")).get_template(file_name).render(context)
    )
