
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
}