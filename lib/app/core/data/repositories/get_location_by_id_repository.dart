import '../../domain/entities/location_entity.dart';
import '../providers/api/location_provider.dart';

class GetLocationByIdRepository {
  GetLocationByIdRepository({
    required LocationProvider locationProvider,
  }) : _locationProvider = locationProvider;

  final LocationProvider _locationProvider;

  Future<LocationEntity> call(int id) async {
    return await _locationProvider.fetchById(id);
  }
}
