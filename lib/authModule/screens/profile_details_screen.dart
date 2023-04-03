import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mmt_courses/authModule/providers/users.dart';
import 'package:mmt_courses/authModule/widgets/custom_button.dart';
import 'package:mmt_courses/homeModule/screens/dashboard.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '/common_widgets/custom_background_container.dart';

class ProfileDetailsScreen extends StatefulWidget {
  static const routeName = "/profile-details";

  const ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  var _isInit = true;

  var _editedUser = User(
    name: "",
    imagePath: "",
    birthDate: DateTime.now(),
    gender: "",
    email: "",
    mobileNumber: "",
    wishlistCourseIds: [],
    enrolledCourseIds: [],
  );

  var _initValue = {
    "name": "",
    "imagePath": "",
    "birthDate": DateTime.now(),
    "gender": "",
    "email": "",
    "mobileNumber": "",
  };
  late String _newId;
  late String _newName;
  late String _newImagePath;
  late DateTime _newBirthDate;
  String _newGender = "male";
  late String _newEmail;
  late String _newMobileNumber;

  int _gender = 0;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemp = File(image.path);

    setState(() {
      _image = imageTemp;
    });
    if (ModalRoute.of(context)!.settings.arguments == null) {
      _newImagePath = _image!.path;
    } else {
      _newImagePath = _initValue['imagePath'] as String;
    }
  }

  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _initValue['birthDate'] as DateTime,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        _selectedDate = value;
      });
      _newBirthDate = _selectedDate!;
    });
  }

  String? _validateName(String value) {
    if (value.isEmpty) {
      return "Required";
    } else {
      _newName = value;
      return null;
    }
  }

  String? _validateEmail(String value) {
    final bool isValid = EmailValidator.validate(value);

    if (!isValid) {
      return "Enter correct email address";
    } else {
      _newEmail = value;
      return null;
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final userId = ModalRoute.of(context)!.settings.arguments;
      if (userId != null) {
        _editedUser = Provider.of<Users>(context, listen: false).fetchUser();
        _initValue = {
          "name": _editedUser.name!,
          "imagePath": _editedUser.imagePath!,
          "birthDate": _editedUser.birthDate!,
          "gender": _editedUser.gender!,
          "email": _editedUser.email!,
          "mobileNumber": _editedUser.mobileNumber!,
        };
        if (_editedUser.gender == "male") _gender = 0;
        if (_editedUser.gender == "female") _gender = 1;
        if (_editedUser.gender == "other") _gender = 2;
        _image = File(_editedUser.imagePath!);
        _newImagePath = _editedUser.imagePath!;
        _newBirthDate = _initValue['birthDate'] as DateTime;
        print(_initValue['birthDate']);
        _selectedDate = _initValue['birthDate'] as DateTime;
        setState(() {});
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _newMobileNumber = Provider.of<Users>(context).fetchUser().mobileNumber!;
    Future<void> saveForm() async {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      var isValid = _formKey.currentState!.validate();
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Select Date"),
          duration: Duration(milliseconds: 200),
        ));
      }
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Select Image"),
            duration: Duration(milliseconds: 200),
          ),
        );
      }

      if (!isValid || _selectedDate == null || _image == null) {
        return;
      }

      // final user = User(
      //   name: _newName,
      //   imagePath: _newImagePath,
      //   birthDate: _newBirthDate,
      //   gender: _newGender,
      //   email: _newEmail,
      //   mobileNumber: _newMobileNumber,
      // );

      if (ModalRoute.of(context)!.settings.arguments == null) {
        Map body = {
          "name": _newName,
          "imagePath": _newImagePath,
          "birthDate": _newBirthDate.toString(),
          "gender": _newGender,
          "mobileNumber": _newMobileNumber,
          "email": _newEmail,
        };
        bool isAccRegister =
            await Provider.of<Users>(context, listen: false).registerUser(body);

        if (isAccRegister) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            Dashboard.routeName,
            (route) => false,
          );
        }
      } else {
        Map body2 = {
          "_id": ModalRoute.of(context)!.settings.arguments as String,
          "name": _newName,
          "imagePath": _newImagePath,
          "birthDate": _newBirthDate.toString(),
          "gender": _newGender,
          "mobileNumber": _newMobileNumber,
          "email": _newEmail,
        };

        bool isUserUpdated =
            await Provider.of<Users>(context, listen: false).updateUser(body2);
        if (isUserUpdated) {
          print("user updated");
        } else {
          print("user not updated");
        }
      }
    }

    return Scaffold(
      body: CustomBackgroundContainer(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: getImage,
                        child: Stack(
                          children: [
                            _image != null
                                ? SizedBox(
                                    height: 88,
                                    width: 88,
                                    child: CircleAvatar(
                                        radius: 88,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(88),
                                            child: Image.file(_image!))),
                                  )
                                : SvgPicture.asset(
                                    "assets/images/profile_icon.svg"),
                            const Positioned(
                              right: 0,
                              bottom: 0,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor:
                                    Color.fromRGBO(49, 153, 216, 1),
                                child: Padding(
                                  padding: EdgeInsets.all(5.5),
                                  child: FittedBox(
                                    child: Icon(
                                      Icons.edit_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 33,
                      ),
                      TextFormField(
                        initialValue: _initValue['name'] as String,
                        validator: (value) => _validateName(value!),
                        decoration: const InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          contentPadding: EdgeInsets.only(left: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        initialValue: _initValue['email'] as String,
                        validator: (value) => _validateEmail(value!),
                        decoration: const InputDecoration(
                          hintText: "Email Address",
                          hintStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          contentPadding: EdgeInsets.only(left: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: _presentDatePicker,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Birth Date",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(67, 67, 67, .85),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _selectedDate == null
                                            ? "dd/mm/yyy"
                                            : DateFormat.yMMMd()
                                                .format(_selectedDate!),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromRGBO(67, 67, 67, .85),
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        "assets/images/calendar.svg",
                                        color: const Color.fromRGBO(
                                            67, 67, 67, .85),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Color.fromRGBO(67, 67, 67, .85),
                              thickness: .6,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: const Text("Gender")),
                          Row(
                            children: [
                              Radio(
                                  value: 0,
                                  groupValue: _gender,
                                  onChanged: (v) {
                                    setState(() {
                                      _gender = 0;
                                    });
                                    _newGender = "male";
                                  },
                                  activeColor: Theme.of(context).primaryColor),
                              const Text("Male"),
                              Radio(
                                  value: 1,
                                  groupValue: _gender,
                                  onChanged: (v) {
                                    setState(() {
                                      _gender = 1;
                                    });
                                    _newGender = "female";
                                  },
                                  activeColor: Theme.of(context).primaryColor),
                              const Text("Female"),
                              Radio(
                                  value: 2,
                                  groupValue: _gender,
                                  onChanged: (v) {
                                    setState(() {
                                      _gender = 2;
                                    });
                                    _newGender = "other";
                                  },
                                  activeColor: Theme.of(context).primaryColor),
                              const Text("Other"),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 29),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                width: 17.5,
                                height: 20,
                                child: FittedBox(
                                    child: SvgPicture.asset(
                                        "assets/images/back.svg")),
                              ),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            const Text(
                              "Profile Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 24),
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                            buttonText: "CONTINUE",
                            onTap: saveForm,
                            isEnable: true),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
