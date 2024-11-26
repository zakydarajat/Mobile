import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  // Observables
  var profileImage = Rx<File?>(null);
  var name = ''.obs;
  var gender = ''.obs;
  var birthDate = ''.obs;
  var phone = ''.obs;
  var email = ''.obs;

  final _picker = ImagePicker();

  // Function to pick an image
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  // Function to save profile data
  void saveProfile(String newName, String newGender, String newBirthDate,
      String newPhone, String newEmail) {
    name.value = newName;
    gender.value = newGender;
    birthDate.value = newBirthDate;
    phone.value = newPhone;
    email.value = newEmail;

    // Add logic to save the data to database or API if necessary
    Get.snackbar('Success', 'Profile saved successfully!',
        snackPosition: SnackPosition.BOTTOM);
  }
}
