from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List

app = FastAPI()

items = {}

class Item(BaseModel):
    id: int
    name: str
    description: str = None

@app.get("/")
def read_root():
    return {"message": "Hello from FastAPI!"}

@app.post("/items/", response_model=Item)
def create_item(item: Item):
    if item.id in items:
        raise HTTPException(status_code=400, detail="Item already exists")
    items[item.id] = item
    return item

@app.get("/items/", response_model=List[Item])
def read_items():
    return list(items.values())

@app.get("/items/{item_id}", response_model=Item)
def read_item(item_id: int):
    if item_id not in items:
        raise HTTPException(status_code=404, detail="Item not found")
    return items[item_id]

@app.put("/items/{item_id}", response_model=Item)
def update_item(item_id: int, item: Item):
    if item_id not in items:
        raise HTTPException(status_code=404, detail="Item not found")
    items[item_id] = item
    return item

@app.delete("/items/{item_id}")
def delete_item(item_id: int):
    if item_id not in items:
        raise HTTPException(status_code=404, detail="Item not found")
    del items[item_id]
    return {"detail": "Item deleted"}

# To run: uvicorn app:app --host 0.0.0.0 --port 3000
