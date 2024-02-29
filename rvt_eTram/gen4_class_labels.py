import os
import numpy as np
import glob

"""
eTraP annotations
{
    "0": "pedestrian",
    "1": "car",
    "2": "bicycle",
    "3": "bus",
    "4": "motorbike",
    "5": "truck",
    "6": "tram",
    "7": "wheelchair"
}
​
1 Megapixel annotations
    pedestrian, two wheeler, car, truck, bus, traffic sign, traffic light
"""
CONVERT_LABELS_TO_1MP_ORDER = {
    0: 0,
    1: 2,
    2: 1,
    3: 4,
    4: 1,
    5: 3,
    6: 5,
    7: 6
} 

def mapping_labels(npy_file):
    original_npy = np.load(npy_file)
    converted_npy = np.copy(original_npy)

    # print(converted_npy[0:10])
    save_path = '/home/arpit/caram_air_ws/datasets/etrap_gen4/gen4_train_labels/' + npy_file.split('/')[-1]
    
    new_labels = [CONVERT_LABELS_TO_1MP_ORDER[x] for x in original_npy['class_id']]
    converted_npy['class_id'] = new_labels
    print(np.bincount(original_npy['class_id']))
    print(np.bincount(converted_npy['class_id']))
    
    print(converted_npy[0:10])
    print('NEW')
    np.save(save_path, converted_npy)
    
if __name__ == "__main__":
    annotations_folder = "/home/arpit/caram_air_ws/datasets/etrap_gen4/train_labels"
    npy_files = glob.glob(os.path.join(annotations_folder, '*.npy'))

    # npy_files = ['/media/exx/data/aayush/RED/pretrained/eval/recording_2023-08-24_16-03-57_bbox.npy']
    for file in npy_files:   
        mapping_labels(file)