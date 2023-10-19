def auto_fabrica(car):
    def produce_auto(color):
        auto = f"{car} - {color}"

        return auto

    return produce_auto


def auto_decorator_fabric(car_model):
    def car_decorator(func):
        def car_color_wrapper(*args, **kwargs):
            color = func(*args, **kwargs)
            produced_car = f"{car_model} - {color}"

            return produced_car
        return car_color_wrapper

    return car_decorator


@auto_decorator_fabric("hyundai")
def car(color):
    return color


@auto_decorator_fabric("BMW")
def car_with_tires(color, radius):
    return f"{color} - R{radius}"


if __name__ == "__main__":
    hyundai_fabric = auto_fabrica("hyundai")
    yellow_hyundai = hyundai_fabric("yellow")

    print(car("yellow"))