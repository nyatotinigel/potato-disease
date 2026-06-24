

from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
import numpy as np
from io import BytesIO
from PIL import Image
import tensorflow as tf
import os

app = FastAPI()

# Add CORS middleware - allow all origins so Vercel frontend can reach Railway backend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

MODEL = None
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(BASE_DIR, "..", "saved_models", "2", "potato_disease_detection.keras")
CLASS_NAMES = ["Early Blight", "Late Blight", "Healthy"]

def load_model():
    global MODEL
    if MODEL is None:
        try:
            MODEL = tf.keras.models.load_model(MODEL_PATH)
            print("✓ Model loaded successfully")
        except FileNotFoundError:
            print(f"✗ Model file not found: {MODEL_PATH}")
            raise
        except Exception as e:
            print(f"✗ Error loading model: {e}")
            raise

@app.on_event("startup")
async def startup():
    if os.path.exists(MODEL_PATH):
        print(f"✓ Model file exists: {MODEL_PATH}")
    else:
        print(f"✗ Model file NOT found: {MODEL_PATH}")
        print(f"  Expected location: {MODEL_PATH}")
        raise FileNotFoundError(f"Model file not found at {MODEL_PATH}")

@app.get("/ping")
async def ping():
    return "Hello, I am alive"

def read_file_as_image(data) -> np.ndarray:
    image = np.array(Image.open(BytesIO(data)))
    return image

@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    load_model()
    image = read_file_as_image(await file.read())
    img_batch = np.expand_dims(image, 0)
    predictions = MODEL.predict(img_batch)
    predicted_class = CLASS_NAMES[np.argmax(predictions[0])]
    confidence = np.max(predictions[0])
    return {
        'class': predicted_class,
        'confidence': float(confidence)
    }

if __name__ == "__main__":
    load_model()  # Load model on startup
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)
