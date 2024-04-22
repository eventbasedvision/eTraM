from ultralytics import YOLO
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-m", "--model", default="./yolov8l.yaml")
    parser.add_argument("-d", "--data", default="data.yaml")
    parser.add_argument("--max_epoch", default=20, type=int)
    parser.add_argument("--batch_size", default=16, type=int)
    parser.add_argument("--test", action='store_true')
    args = parser.parse_args()
    model = YOLO(args.model)

    if args.test:
        model.val(data=args.data, split="test")
    else:
        model.train(data=args.data, epochs=args.max_epoch, batch=args.batch_size)
        model.val(data=args.data, split="test")