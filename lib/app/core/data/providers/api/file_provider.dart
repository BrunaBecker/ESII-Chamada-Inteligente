import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as hp;
import 'package:http_parser/http_parser.dart';
import '../../../adapters/http_adapter.dart';
import '../../../constants.dart';
import '../base_provider.dart';
import 'package:path_provider/path_provider.dart';

class FileProvider extends BaseProvider {
  final Http http;

  FileProvider({required this.http});

  Future<void> downloadFile(String filename, String fileType) async {
    if (!filename.contains(fileType)) filename = "$filename.$fileType";
    String? requestPath;
    String? deflt;

    if (fileType == 'png' || fileType == 'jpg') {
      requestPath = 'file/image';
      deflt = 'image';
    } else if (fileType == 'pdf') {
      requestPath = 'file/document';
      deflt = "file";
    }

    try {
      final response = await http.getBytes("/$requestPath/$filename");

      if (response.statusCode == 200) {
        // Get the filename from the Content-Disposition header
        String? contentDisposition = response.headers['content-disposition'].join();
        String filename = contentDisposition?.split('filename=')[1].replaceAll("\"", "") ?? "$deflt.$fileType";

        // Save the file locally
        await _saveFile(response.data, filename);
      } else {
        throw Exception('Failed to download file');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> uploadFile(String filename, String fileType) async {
    if (!filename.contains(fileType)) filename = "$filename.$fileType";
    String? requestPath;

    if (fileType == 'png' || fileType == 'jpg') {
      requestPath = 'file/image/';
    } else if (fileType == 'pdf') {
      requestPath = 'file/document/';
    }

    Directory directory = await getApplicationDocumentsDirectory();

    File file = File("${directory.path}/$filename");
    var uri = Uri.parse('$baseUrl/$requestPath');
    var request = hp.MultipartRequest('POST', uri)
      ..files.add(await hp.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType('application', 'octet-stream'),
      ));

    try {
      var response = await request.send();

      if (response.statusCode != 200) {
        throw Exception('File upload failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _saveFile(Uint8List data, String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    final file = File('${directory.path}/$filename');
    await file.writeAsBytes(data);
  }
}
