import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/common/assets_path.dart';
import 'package:story_app/common/common.dart';
import 'package:story_app/data/cubit/story/add_story_cubit.dart';
import 'package:story_app/data/models/add_story_body.dart';
import 'package:story_app/ui/widgets/custom_snack_bar.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({
    required this.addStoryCubit,
    required this.onAddStorySuccess,
    super.key,
  });

  final AddStoryCubit addStoryCubit;
  final void Function() onAddStorySuccess;

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  final descriptionTextController = TextEditingController();
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

  Future<void> onUploadStory() async {
    if (imagePath.value == null || imageFile.value == null) {
      return showSnackBar(
        context,
        CustomSnackBar(
          context: context,
          content: Text(
            AppLocalizations.of(context)!.emptyFormMessage,
          ),
        ),
      );
    }

    final imageBytes = await imageFile.value?.readAsBytes();
    await widget.addStoryCubit.addStory(
      AddStoryBody(
        descriptionTextController.text,
        imageBytes!,
        imageFile.value!.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddStoryCubit, AddStoryState>(
      listener: (context, state) {
        if (state is AddStoryFailure) {
          showSnackBar(
            context,
            CustomSnackBar(context: context, content: Text(state.message)),
          );
        }
        if (state is AddStorySuccess) {
          showSnackBar(
            context,
            CustomSnackBar(context: context, content: Text(state.message)),
          );
          widget.onAddStorySuccess();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.addStory),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            children: [
              Text(
                '${AppLocalizations.of(context)!.shareYourStoryDesc} 🤩',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              addStoryForm(context, state),
            ],
          ),
        );
      },
    );
  }

  Column addStoryForm(BuildContext context, AddStoryState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppLocalizations.of(context)!.addStoryPicture),
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
        const SizedBox(height: 20),
        TextFormField(
          controller: descriptionTextController,
          decoration: InputDecoration(
            label: Text(AppLocalizations.of(context)!.description),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: '${AppLocalizations.of(context)!.writeYourStory}...',
            border: const OutlineInputBorder(),
          ),
          minLines: 4,
          maxLines: 8,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: state is AddStoryLoading ? null : onUploadStory,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: state is AddStoryLoading
                ? CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.send.toUpperCase(),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.send),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget imagePickBottomsheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.photo),
          title: Text(AppLocalizations.of(context)!.gallery),
          onTap: _onGalleryView,
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt_outlined),
          title: Text(AppLocalizations.of(context)!.camera),
          onTap: _onCameraView,
        ),
      ],
    );
  }
}
