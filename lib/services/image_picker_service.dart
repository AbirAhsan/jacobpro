import 'package:image_picker/image_picker.dart';
import 'error_code_handle_service.dart';

class ImagePickService {
  final ImagePicker _picker = ImagePicker();

  Future<String?> getSingleImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 20,
    );

    if (image != null) {
      return image.path;
      //<=========================== Most people just handle here. So it never returns anything upon cancel (iOS)
    } else {
      // throw Exception("No Image Selected");
      //<============================= User canceled the picker. You need do something here, or just add return
      ApiErrorHandleService.handleStatusCodeError({
        "code": 404,
        "message": "No Image Selected",
      });
      throw {
        "message": "Something went to Wrong",
      };
    }
  }

  Future<List<XFile>?> getMultipleImage() async {
    try {
      List<XFile> pickedfiles = await _picker.pickMultiImage(imageQuality: 20);
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles.isNotEmpty) {
        return pickedfiles;
      } else {
        ApiErrorHandleService.handleStatusCodeError({
          "code": 404,
          "message": "No Image Selected",
        });
      }
    } catch (e) {
      ApiErrorHandleService.handleStatusCodeError({
        "code": 404,
        "message": "error while picking file.",
      });
    }
    return null;
  }
}
