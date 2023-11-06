class ValidatorAdapter {
  String? validateNotNullInput(String? value) {
    if (value == null || value.isEmpty) {
      return "O campo é obrigatório";
    }

    return null;
  }

  String? validateRegistration(String? value) {
    if (value == null || value.isEmpty) {
      return "O campo matrícula/SIAPE é obrigatório";
    } else if (value.length != 9 && value.length != 7) {
      return "Número incorreto de dígitos para matrícula/SIAPE";
    }

    return null;
  }
}
