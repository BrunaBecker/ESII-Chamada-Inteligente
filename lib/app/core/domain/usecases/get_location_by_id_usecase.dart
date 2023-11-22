import '../../data/repositories/get_location_by_id_repository.dart';
import '../entities/location_entity.dart';

class GetLocationByIdUsecase {
  final GetLocationByIdRepository _getLocationByIdRepository;

  GetLocationByIdUsecase(this._getLocationByIdRepository);

  Future<LocationEntity> call({required int id}) async {
    return await _getLocationByIdRepository(id);
  }
}
