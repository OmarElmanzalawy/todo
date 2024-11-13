import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerProvider = StateNotifierProvider<ImagePickerProvider, File?>((ref)=> ImagePickerProvider());

class ImagePickerProvider extends StateNotifier<File?> {
  ImagePickerProvider() : super(null);

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // Update the state with the picked image
      state = File(pickedImage.path);
    }
  }
}