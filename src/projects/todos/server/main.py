from typing import Union

from fastapi import FastAPI

app = FastAPI()


todos = {
    "1": {
        "title": "todo 1",
        "isCompleted": False
    },
    "2": {
        "title": "todo 2",
        "isCompleted": False
    },
    "3": {
        "title": "todo 3",
        "isCompleted": False
    },
    "4": {
        "title": "todo 4",
        "isCompleted": False
    },
    "5": {
        "title": "todo 5",
        "isCompleted": False
    },
}

max_index = 6

@app.get("/todos")
def read_root():
    return todos


@app.post("/todos")
def read_item(title):
    global max_index
    key = str(max_index)
    max_index += 1

    todos[key] = {
        "title": title,
        "isCompleted": False
    }
    
    return todos