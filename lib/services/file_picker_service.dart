import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'error_code_handle_service.dart';

class FilePickService {
  static Future<File?> getSingleFile({List<String>? allowedExtensions}) async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        final String? filePath = result.files.single.path;
        if (filePath != null) {
          final File file = File(filePath);
          return file;
        }
      }

      // User canceled the picker
      throw FileSelectionError("No File Selected");
    } catch (e) {
      ApiErrorHandleService.handleStatusCodeError({
        "code": 404,
        "message": "File Selection Error",
      });
      throw FileSelectionError("Something went wrong");
    }
  }

  Future<List<File?>> getMultipleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      return files;
    } else {
      // User canceled the picker
      ApiErrorHandleService.handleStatusCodeError({
        "code": 404,
        "message": "No File Selected",
      });
      throw {
        "message": "Something went to Wrong",
      };
    }
  }
}

class FileSelectionError implements Exception {
  final String message;

  FileSelectionError(this.message);
}
