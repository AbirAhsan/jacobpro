import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'error_code_handle_service.dart';

class FilePickService {
  Future<File?> getSingleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);

      return file;
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
