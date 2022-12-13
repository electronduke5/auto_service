
import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/services/api_service.dart';

class CarService extends ApiService<CarDto>{
  Future<List<CarDto>> getCars ({String? function, String? query}){
    return getEntities(
        apiRoute: 'http://127.0.0.1:8000/api/cars',
        entityProducer: (json) => CarDto.fromJsonCar(json),
      function: function,query: query
    );
  }

  Future<CarDto> addAutopart({
    required CarDto car,
  }) =>
      getEntity(
        apiRoute: 'http://127.0.0.1:8000/api/cars',
        entityProducer: (Map<String, dynamic> json) =>
            CarDto.fromJsonCar(json),
        dataJson: car.toJson(),
      );

  Future<CarDto> editCar({required CarDto car}) {
    Map<String, dynamic> carJson = car.toJson();
    carJson.addAll({'_method': 'PUT'});

    return getEntity(
        apiRoute: 'http://127.0.0.1:8000/api/cars/${car.id}',
        entityProducer: (Map<String, dynamic> json) =>
            CarDto.fromJson(json),
        dataJson: carJson);
  }

  Future deleteCar({required int id}) => deleteEntity(apiRoute: 'http://127.0.0.1:8000/api/cars/$id');
}