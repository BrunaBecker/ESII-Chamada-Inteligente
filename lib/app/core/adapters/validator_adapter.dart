class ValidatorAdapter {
  String? validateRegistration(String? value) {
    if (value == null || value.isEmpty) {
      return "O campo matrícula/SIAPE é obrigatório";
    } else if (value.length != 9) {
      return "O campo matrícula/SIAPE deve conter 9 dígitos";
    }

    return null;
  }
}
