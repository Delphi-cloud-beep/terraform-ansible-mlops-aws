from fastapi import FastAPI

app = FastAPI(title="MLOps Model API")

@app.get("/")
def read_root():
    return {"status": "online", "message": "API MLOps opérationnelle !"}

@app.post("/predict")
def predict(data: dict):
    # Simulation d'une prédiction
    return {"input": data, "prediction": "Class A", "confidence": 0.95}