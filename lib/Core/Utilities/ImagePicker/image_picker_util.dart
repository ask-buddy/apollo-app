import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  static final shared = ImagePickerUtil();

  final _picker = ImagePicker();

  Future<XFile?> getImageFromGallery() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<XFile?> getImageFromCamera() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }
}
