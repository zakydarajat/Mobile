import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/src/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: controller.pickImage,
                child: Obx(() {
                  return CircleAvatar(
                    radius: 60,
                    backgroundImage: controller.profileImage.value != null
                        ? FileImage(controller.profileImage.value!)
                        : const AssetImage('assets/images/profile_pic.png')
                            as ImageProvider,
                    child: controller.profileImage.value == null
                        ? const Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                  );
                }),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                "Name",
                controller.name.value,
                (value) => controller.name.value = value,
              ),
              _buildGenderDropdown(controller),
              _buildBirthDateField(controller, context),
              _buildTextField(
                "Phone",
                controller.phone.value,
                (value) => controller.phone.value = value,
              ),
              _buildTextField(
                "Email",
                controller.email.value,
                (value) => controller.email.value = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.saveProfile(
                    controller.name.value,
                    controller.gender.value,
                    controller.birthDate.value,
                    controller.phone.value,
                    controller.email.value,
                  );
                },
                child: const Text("Save Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk gender
  Widget _buildGenderDropdown(ProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Obx(() {
        return DropdownButtonFormField<String>(
          value: controller.gender.value.isEmpty ? null : controller.gender.value,
          decoration: const InputDecoration(
            labelText: "Gender",
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: "Laki-laki", child: Text("Laki-laki")),
            DropdownMenuItem(value: "Perempuan", child: Text("Perempuan")),
          ],
          onChanged: (value) {
            if (value != null) {
              controller.gender.value = value;
            }
          },
        );
      }),
    );
  }

  // Widget untuk memilih tanggal lahir
  Widget _buildBirthDateField(ProfileController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Obx(() {
        return TextFormField(
          readOnly: true,
          controller: TextEditingController(text: controller.birthDate.value),
          decoration: const InputDecoration(
            labelText: "Birth Date",
            border: OutlineInputBorder(),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              controller.birthDate.value = pickedDate.toLocal().toString().split(' ')[0];
            }
          },
        );
      }),
    );
  }

  // Widget untuk text field
  Widget _buildTextField(
      String label, String initialValue, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
        controller: TextEditingController(text: initialValue),
      ),
    );
  }
}
