import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_chat_application/constant_widgets/constant_widgets.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) imagePickedFn;
  UserImagePicker(this.imagePickedFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  final picker = ImagePicker();

  Future getImage(ImageSource option) async {
    final pickedFile =
        await picker.getImage(source: option, imageQuality: 50, maxWidth: 150);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ConstantWidgets().snackBar(context, 'No Image Selected!');
      }
    });
    Navigator.pop(context);
    widget.imagePickedFn(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 40,
            backgroundImage: _image != null
                ? FileImage(_image)
                : const AssetImage('assets/images/profile.jpg')),
        FlatButton.icon(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                        title: const Text('Add Profile Photo'),
                        actions: [
                          FlatButton.icon(
                              icon: const Icon(Icons.camera_alt_rounded),
                              onPressed: () {
                                getImage(ImageSource.camera);
                              },
                              label: const Text('Take Photo')),
                          FlatButton.icon(
                              icon: const Icon(Icons.photo_album),
                              onPressed: () {
                                getImage(ImageSource.gallery);
                              },
                              label: const Text('Gallery'))
                        ],
                      ));
            },
            icon: const Icon(CupertinoIcons.photo),
            label: const Text('Add Profile Photo')),
      ],
    );
  }
}
