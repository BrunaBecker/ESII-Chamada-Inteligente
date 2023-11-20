class FileMacFiEntity {
  FileMacFiEntity({
    this.id,
    required this.linkFile,
    required this.nameFile,
    required this.typeFile,
    required this.sizeFile,
    required this.dateFile,
  });

  int? id;
  String linkFile;
  String nameFile;
  String typeFile;
  int sizeFile;
  DateTime dateFile;
}
