import '../../domain/entities/location_entity.dart';
import '../providers/api/location_provider.dart';

class CreateLocationRepository {
  CreateLocationRepository({
    required locationProvider,
  }) : _locationProvider = locationProvider;

  final LocationProvider _locationProvider;

  Future<LocationEntity> call({
    required LocationEntity location,
  }) async {
    return await _locationProvider.create(location);
  }
}
