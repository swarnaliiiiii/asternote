from flask import Blueprint, request, jsonify
from PIL import Image
import pytesseract
import requests

upload_bp = Blueprint('upload', __name__)
google_base_endpoint = "https://www.googleapis.com/books/v1/volumes"

@upload_bp.route('/upload', methods=['POST'])
def upload():
    if "image" not in request.files:
        return jsonify({"error": "No image provided"})
    image = request.files["image"]
    image.save("image.jpg")
    text = pytesseract.image_to_string(Image.open("image.jpg"))
    response = requests.get(google_base_endpoint, params={"q": text})
    book_data = response.json()

    return jsonify({"query": text, "data": book_data})

    
    