import '../../data/repositories/create_virtual_zone_repository.dart';
import '../entities/virtual_zone_entity.dart';

class CreateVirtualZoneUsecase {
  final CreateVirtualZoneRepository _virtualZoneRepository;

  CreateVirtualZoneUsecase(this._virtualZoneRepository);

  Future<VirtualZoneEntity> call({
    required VirtualZoneEntity virtualZone,
  }) async {
    return await _virtualZoneRepository(
      virtualZone: virtualZone,
    );
  }
}
