import '../../../adapters/http_adapter.dart';
import '../base_provider.dart';

class PersonProvider extends BaseProvider {
  Http http;

  PersonProvider({required this.http});

  //todo concrete/{id} mapping return a Object -> ProfessorDto or StudentDto
  //todo {id} mapping return PersonDto
}
