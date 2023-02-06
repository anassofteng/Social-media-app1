import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/ViewModel/Services/Sessionmanager.dart';
import 'package:tech_media/res/Components/Input_text_field.dart';
import 'package:tech_media/res/color.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/utils/routes/Utils.dart';

class ProfileController with ChangeNotifier {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('user');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future pickgalleryImage(BuildContext context) async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (PickedFile != null) {
      _image = XFile(PickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (PickedFile != null) {
      _image = XFile(PickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  void pickeImage(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickCameraImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.camera,
                    color: AppColors.primaryIconColor,
                  ),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickgalleryImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.photo_album,
                    color: AppColors.primaryIconColor,
                  ),
                  title: Text('Photo Library'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageref = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage' + SessionController().userId.toString());
    firebase_storage.UploadTask UploadTask =
        storageref.putFile(File(image!.path).absolute);
    await Future.value(UploadTask);
    final newUrl = await storageref.getDownloadURL();

    ref
        .child(SessionController().userId.toString())
        .update({'profile': newUrl.toString()}).then((value) {
      Utils.toastMessage('profile updated');
      setLoading(false);
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }

  Future<void> showUserNameDialogAlert(
      BuildContext context, String name) async {
    nameController.text = name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update username'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                      obscureText: false,
                      hint: 'Enter name',
                      keyBoardType: TextInputType.text,
                      onValidator: (value) {},
                      onFiledSubmittedValue: (value) {},
                      focusnode: nameFocusNode,
                      myController: nameController)
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.alertColor),
                  )),
              TextButton(
                  onPressed: () {
                    ref.child(SessionController().userId.toString()).update({
                      'username': nameController.text.toString()
                    }).then((value) {
                      nameController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ok',
                    style: Theme.of(context).textTheme.subtitle2!,
                  )),
            ],
          );
        });
  }

  Future<void> showPhoneDialogAlert(
      BuildContext context, String phonenumber) async {
    phoneController.text = phonenumber;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update phone number'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                      obscureText: false,
                      hint: 'Enter phone',
                      keyBoardType: TextInputType.phone,
                      onValidator: (value) {},
                      onFiledSubmittedValue: (value) {},
                      focusnode: phoneFocusNode,
                      myController: phoneController)
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.alertColor),
                  )),
              TextButton(
                  onPressed: () {
                    ref.child(SessionController().userId.toString()).update({
                      'phone': phoneController.text.toString()
                    }).then((value) {
                      phoneController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ok',
                    style: Theme.of(context).textTheme.subtitle2!,
                  )),
            ],
          );
        });
  }
}
