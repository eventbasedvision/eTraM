from ultralytics import YOLO

if __name__ == "__main__":
    model = YOLO("./yolov8l.yaml")
    model.train(data="day2night_data.yaml", epochs=10, batch=128)
    # model("daytime.mp4", save=True, conf=0.25)
    # model("nighttime.mp4", save=True, conf=0.25)
