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

    
    