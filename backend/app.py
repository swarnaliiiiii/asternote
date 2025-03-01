from flask import Flask
from blueprints.upload import upload_bp

app = Flask(__name__)

app.register_blueprint(upload_bp, url_prefix="/api")

if(__name__ == '__main__'):
    app.run(debug=True)