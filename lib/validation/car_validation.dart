import 'package:auto_service/blocs/cars/car_bloc.dart';

class CarValidator {
  String? message;
  CarState? state;
  String? clientMessage;

  CarValidator(message, state);

  CarValidator.isValidCarNumber({required String number}) {
    RegExp regex =
        RegExp(r'^[авекмнорстух]\d{3}(?<!000)[авекмнорстух]{2}\d{2,3}$');
    if (!regex.hasMatch(number)) {
      message = 'Неправильный формат номера';
    }
  }

  CarValidator.isValidVinNumber({required String number}) {
    RegExp regex = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');
    if (!regex.hasMatch(number)) {
      message = 'Неправильный формат VIN';
    }
  }

  CarValidator.validated(CarState state) {
    clientMessage = state.isClientNotEmpty ? null : 'Это обязательное поле';
  }

  CarValidator.isValidModel({required String model}) {
    if (model.isEmpty) {
      message = 'Это обязательное поле';
    }
  }

  CarValidator.isValidMileage({required String mileage}) {
    if (mileage.isEmpty) {
      message = 'Это обязательное поле';
    }
  }
}
