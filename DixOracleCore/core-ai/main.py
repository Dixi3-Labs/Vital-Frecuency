from fastapi import FastAPI, UploadFile, File
import sentry_sdk
import uvicorn
from ultralytics import YOLO
import numpy as np
import cv2

sentry_sdk.init(dsn="YOUR_SENTRY_DSN")
app = FastAPI(title="Dix Oracle Core AI")

model = YOLO("yolov8n.pt")  # Usa tu modelo entrenado

@app.post("/analyze-image/")
async def analyze_image(file: UploadFile = File(...)):
    contents = await file.read()
    image = np.frombuffer(contents, np.uint8)
    img = cv2.imdecode(image, cv2.IMREAD_COLOR)
    results = model(img)
    return {"detections": results[0].boxes.data.tolist()}

if __name__ == '__main__':
    uvicorn.run(app, host="0.0.0.0", port=8080)
