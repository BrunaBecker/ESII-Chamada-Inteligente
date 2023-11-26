import '../../domain/entities/virtual_zone_entity.dart';
import '../providers/api/virtual_zone_provider.dart';

class CreateVirtualZoneRepository {
  CreateVirtualZoneRepository({
    required virtualZoneProvider,
  }) : _virtualZoneProvider = virtualZoneProvider;

  final VirtualZoneProvider _virtualZoneProvider;

  Future<VirtualZoneEntity> call({
    required VirtualZoneEntity virtualZone,
  }) async {
    return await _virtualZoneProvider.create(virtualZone);
  }
}
