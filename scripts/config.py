# -*- coding: utf-8 -*-
import yaml
import os
import json

config_path = os.path.join(os.getcwd(), "configs")
model_file = os.path.join(config_path, "nfsw-classifier", "model.yaml")
inference_file = os.path.join(config_path, "nfsw-classifier", "v1-inference.yaml")

# Load model.yaml file
with open(model_file, "r") as stream:
    model_data = yaml.safe_load(stream)

# Load v1-inference.yaml
with open(inference_file, "r") as stream:
    v1_inference_data = yaml.safe_load(stream)

# id2label
id2label = {}
label2id = {}

for i, label in enumerate(model_data["labels"]):
    id2label[str(i)] = label
    label2id[label] = str(i)

# Create config.json file
config_json = {
    "labels": model_data["labels"],
    "id2label": id2label,
    "label2id": label2id,
    "image_size": v1_inference_data["model"]["image_size"],
    "num_channels": v1_inference_data["model"]["num_channels"]
}

# Serializing json
json_object = json.dumps(config_json, indent=4)

# Writing to sample.json
with open("config.json", "w") as stream:
    stream.write(json_object)
