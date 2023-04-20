import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/common/assets_path.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  final imageFile = ValueNotifier<XFile?>(null);
  final imagePath = ValueNotifier<String?>(null);

  void _showBottomsheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return imagePickBottomsheet();
      },
    );
  }

  Future<void> _onCameraView() async {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setImageFile(pickedFile);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> _onGalleryView() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setImageFile(pickedFile);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  void setImageFile(XFile? value) {
    imageFile.value = value;
    imagePath.value = value?.path;
  }

  Widget _showImage(String path) {
    return kIsWeb
        ? Image.network(
            path,
            fit: BoxFit.contain,
          )
        : Image.file(
            File(path),
            fit: BoxFit.contain,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Cerita'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        children: [
          Text(
            'Ceritakan pengalaman menarikmu saat belajar di Dicoding! 🤩',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Deskripsi'),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: 'Tulis ceritamu...',
              border: OutlineInputBorder(),
            ),
            minLines: 1,
            maxLines: 4,
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Tambah Gambar Cerita'),
              const SizedBox(height: 5),
              InkWell(
                onTap: _showBottomsheet,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).disabledColor,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ValueListenableBuilder<String?>(
                    valueListenable: imagePath,
                    builder: (context, value, widget) {
                      if (value != null) {
                        return _showImage(value);
                      }
                      return Image.asset(
                        AssetsPath.placeHodler,
                        height: 200,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Text('KIRIM'),
        ),
      ),
    );
  }

  Widget imagePickBottomsheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.photo),
          title: const Text('Gallery'),
          onTap: _onGalleryView,
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt_outlined),
          title: const Text('Camera'),
          onTap: _onCameraView,
        ),
      ],
    );
  }
}
