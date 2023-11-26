import '../../data/repositories/create_location_repository.dart';
import '../entities/location_entity.dart';

class CreateLocationUsecase {
  final CreateLocationRepository _locationRepository;

  CreateLocationUsecase(this._locationRepository);

  Future<LocationEntity> call({
    required LocationEntity location,
  }) async {
    return await _locationRepository(
      location: location,
    );
  }
}
