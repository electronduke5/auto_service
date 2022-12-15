import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/services/api_service.dart';
import 'package:auto_service/services/const_api_route.dart';

class CarService extends ApiService<CarDto> {
  @override
  String apiRoute = ApiConstUrl.carsUrl;

  Future<List<CarDto>> getCars({String? function, String? query}) {
    return getEntities(
        entityProducer: (json) => CarDto.fromJsonCar(json),
        function: function,
        query: query);
  }

  Future<CarDto> addAutopart({
    required CarDto car,
  }) =>
      getEntity(
        entityProducer: (Map<String, dynamic> json) => CarDto.fromJsonCar(json),
        dataJson: car.toJson(),
      );

  Future<CarDto> editCar({required CarDto car}) {
    Map<String, dynamic> carJson = car.toJson();
    carJson.addAll({'_method': 'PUT'});

    return getEntity(
        id: car.id,
        entityProducer: (Map<String, dynamic> json) => CarDto.fromJson(json),
        dataJson: carJson);
  }

  Future deleteCar({required int id}) => deleteEntity(id: id);
}
