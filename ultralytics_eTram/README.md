# YOLOv8: You Only Look Once (v8.1)

This is the modified yolov8 version for the CVPR 2024 paper [eTraM: Event-based Traffic Monitoring Dataset](https://arxiv.org/abs/2403.19976).

## Whats Different?

The ultralytics library was updated to consider only 2 channels from the image as the events and discard the 3rd channel. Similarly a zero last channel is added before visualization.

The updated configs and training script utilizing this library can be found in `./yolo_eTram/`.

## Installation
Pip install modified ultralytics in a Python>=3.8 environment with PyTorch>=1.8.

```Bash
pip install -e .
```


## Required Data
To evaluate or train YOLOv8 on eTram you will need to download the eTram dataset from [Link to Dataset](https://docs.google.com/forms/d/e/1FAIpQLSfH2LI5oqWWfose-pBC3dsbaAMvRQuv0BI93njV_5wQjYx83w/viewform).


<!-- ## Preprocessing  -->
<!-- ```html -->
<!-- Add stuff here -->
<!-- ``` -->

## Training
```bash
python main.py --data data.yaml --batch_size 128 --max_epoch 20 
```

## Code Acknowledgments
This project has used code from the following projects:
- [ultralytics](https://github.com/ultralytics/ultralytics) for the official YOLOv8 implementation in Pytorch
