library image_picker_extended;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerExtends {
  /// Choose image
  /// If permission deny it will return [null]
  static Future<File> chooseCamera(BuildContext context) async {
    File file;

    try {
      file = await ImagePicker.pickImage(source: ImageSource.camera);
    } catch (e) {
      _showAlertPermissionDeny(context);
    }
    return file;
  }

  /// Choose image
  /// If permission deny it will return [null]
  static Future<File> chooseGallery(BuildContext context) async {
    File file;

    try {
      file = await ImagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      _showAlertPermissionDeny(context);
    }

    return file;
  }

  /// Choose image
  /// If permission deny it will return [null]
  static Future<File> chooseCameraVideo(BuildContext context) async {
    File file;

    try {
      file = await ImagePicker.pickVideo(source: ImageSource.camera);
    } catch (e) {
      _showAlertPermissionDeny(context);
    }

    return file;
  }

  /// Choose image
  /// If permission deny it will return [null]
  static Future<File> chooseGalleryVideo(BuildContext context) async {
    File file;

    try {
      file = await ImagePicker.pickVideo(source: ImageSource.gallery);
    } catch (e) {
      _showAlertPermissionDeny(context);
    }

    return file;
  }

  static void _showAlertPermissionDeny(BuildContext context) {
    if (Platform.isAndroid) {
      _showAlertAndroid(context);
    } else if (Platform.isIOS) {
      _showAlertIos(context);
    }
  }

  static void _showAlertAndroid(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Permission"),
        content: Text("Please turn on permission in the settings"),
        actions: <Widget>[
          FlatButton(
            child: Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  static void _showAlertIos(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Permission"),
        content: const Text("Please turn on permission in the settings"),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  static void chooseImage(BuildContext context,
      {@required Function(File file) selectedImage,
      Color iconColor = Colors.black45}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white38, borderRadius: BorderRadius.circular(50)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 5,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        iconSize: 64,
                        icon: Icon(
                          Icons.camera_alt,
                          color: iconColor,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          final file = await chooseCamera(context);
                          selectedImage(file);
                        },
                      ),
                    ),
                    Container(
                      child: Text(
                        'Camera',
                        style: TextStyle(color: iconColor),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        iconSize: 64,
                        icon: Icon(
                          Icons.photo,
                          color: iconColor,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          final file = await chooseGallery(context);
                          selectedImage(file);
                        },
                      ),
                    ),
                    Container(
                      child: Text(
                        'Gallery',
                        style: TextStyle(color: iconColor),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Command
// flutter pub publish --dry-run
// flutter pub publish
