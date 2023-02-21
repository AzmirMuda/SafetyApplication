import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:homestay_raya1/config.dart';
import 'package:homestay_raya1/models/user.dart';
import 'package:homestay_raya1/views/loginscreen.dart';
import 'package:homestay_raya1/views/profilescreen.dart';
import 'package:homestay_raya1/views/registrationscreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateScreen extends StatefulWidget {
  final User user;
  const UpdateScreen({super.key, required this.user});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late double screenHeight, screenWidth, resWidth;
  File? _image;
  var pathAsset = "assets/images/profile.png";
  var val = 50;

  bool isDisable = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  Random random = Random();
  @override
  void initState() {
    super.initState();
    if (widget.user.id == "0") {
      isDisable = true;
    } else {
      isDisable = false;
    }

    _nameController.text = widget.user.name.toString();
    _emailController.text = widget.user.email.toString();
    _phoneController.text = widget.user.phone.toString();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar( title: const Text('Profile',style:TextStyle(fontStyle: FontStyle.normal,fontWeight :FontWeight.bold))),
          body: Column(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: screenHeight * 0.25,
                  child: Row(
                    children: [
                      /* Flexible(
                        flex: 4,
                        child: SizedBox(
                            height: screenHeight * 0.25,
                            child: GestureDetector(
                              onTap: isDisable ? null : _updateImageDialog,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: CachedNetworkImage(
                                  width: resWidth / 2,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "${Confiq.SERVER}/assets/profileimages/${widget.user.id}.png?v=$val",
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.image_not_supported,
                                    size: 128,
                                  ),
                                ),
                              ),
                            )),
                      ),
                      */
                      Flexible(
                          flex: 6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(widget.user.name.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 2, 0, 8),
                                child: Divider(
                                  color: Colors.blueGrey,
                                  height: 2,
                                  thickness: 2.0,
                                ),
                              ),

                              // columnWidths: const {
                              //   0: FractionColumnWidth(0.3),
                              //   1: FractionColumnWidth(0.7)
                              // },
                              // defaultVerticalAlignment:
                              //   TableCellVerticalAlignment.middle,

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Icon(Icons.email),
                                  Spacer(),
                                  Expanded(
                                    child: Text(
                                      widget.user.email.toString(),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Spacer(),
                                  Spacer(),
                                ],
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Icon(Icons.phone),
                                  Spacer(),
                                  Expanded(
                                    child: Text(
                                      widget.user.phone.toString(),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Spacer(),
                                  Spacer(),
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                )),
            Flexible(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth,
                        alignment: Alignment.center,
                        color: Theme.of(context).backgroundColor,
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                          child: Text("PROFILE SETTINGS",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      Expanded(
                          child: ListView(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              shrinkWrap: true,
                              children: [
                            MaterialButton(
                              onPressed: isDisable ? null : _updateNameDialog,
                              child: const Text("UPDATE NAME"),
                            ),
                            const Divider(
                              height: 2,
                            ),
                            MaterialButton(
                              onPressed: isDisable ? null : _updateEmailDialog,
                              child: const Text("UPDATE Email"),
                            ),
                            const Divider(
                              height: 2,
                            ),
                            MaterialButton(
                              onPressed: isDisable ? null : _updatePhoneDialog,
                              child: const Text("UPDATE PHONE"),
                            ),
                            const Divider(
                              height: 2,
                            ),
                            MaterialButton(
                              onPressed: isDisable ? null : _changePassDialog,
                              child: const Text("UPDATE PASSWORD"),
                            ),
                            const Divider(
                              height: 2,
                            ),
                            MaterialButton(
                              onPressed: _registerAccountDialog,
                              child: const Text("NEW REGISTRATION"),
                            ),
                            const Divider(
                              height: 2,
                            ),
                            MaterialButton(
                              onPressed: _loginDialog,
                              child: const Text("LOGIN"),
                            ),
                            const Divider(
                              height: 2,
                            ),
                            const Divider(
                              height: 2,
                            ),
                            MaterialButton(
                              onPressed: isDisable ? null : _logoutDialog,
                              child: const Text("LOGOUT"),
                            ),
                          ])),
                    ],
                  ),
                )),
          ]),
          drawer: ProfileScreen(
            user: widget.user,
          )),
    );
  }

  void buyCreditPage() {}

  void _registerAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "New Account Registration",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (content) =>  RegistrationScreen(user: widget.user,)));
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _loginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Login",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (content) =>   LoginPage(user: widget.user,)));
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _updateImageDialog() {
    if (widget.user.id == "0") {
      Fluttertoast.showToast(
          msg: "Please login/register",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Select from",
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                    onPressed: () => {
                          Navigator.of(context).pop(),
                          _galleryPicker(),
                        },
                    icon: const Icon(Icons.browse_gallery),
                    label: const Text("Gallery")),
                TextButton.icon(
                    onPressed: () =>
                        {Navigator.of(context).pop(), _cameraPicker()},
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera")),
              ],
            ));
      },
    );
  }

  _galleryPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  _cameraPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  void _updateProfileImage(image) {
    String base64Image = base64Encode(image!.readAsBytesSync());
    http.post(Uri.parse("${Config.SERVER}homeStayRaya/php/update_profile.php"), body: {
      "userid": widget.user.id,
      "image": base64Image,
    }).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        val = random.nextInt(1000);
        setState(() {});
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }

  void _updateNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Name?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                String newname = _nameController.text;
                _updateName(newname);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateName(String newname) {
    http.post(Uri.parse("${Config.SERVER}homeStayRaya/php/update_profile.php"), body: {
      "userid": widget.user.id,
      "newname": newname,
    }).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        setState(() {
          widget.user.name = newname;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }

  void _updateEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Email?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                String newemail = _emailController.text;
                _updateEmail(newemail);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateEmail(String newemail) {
    http.post(Uri.parse("${Config.SERVER}/php/update_profile.php"), body: {
      "userid": widget.user.id,
      "newemail": newemail,
    }).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        setState(() {
          widget.user.email = newemail;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }

  void _updatePhoneDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Phone?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _phoneController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new your phone';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                String newphone = _phoneController.text;
                _updatePhone(newphone);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updatePhone(String newphone) {
    http.post(Uri.parse("${Config.SERVER}homeStayRaya/php/update_profile.php"), body: {
      "userid": widget.user.id,
      "newphone": newphone,
    }).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        setState(() {
          widget.user.phone = newphone;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }

  void _changePassDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Password?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _oldpasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Old Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _newpasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                changePass();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateAddressDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Address?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                minLines: 6,
                maxLines: 6,
                controller: _addressController,
                decoration: InputDecoration(
                    labelText: 'Home Address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your home address';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _logoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Logout?",
            style: TextStyle(),
          ),
          content: const Text("Are your sure"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('email', '');
                await prefs.setString('pass', '');
                await prefs.setBool('remember', false);
                User user = User(
                  id: "0",
                  email: "unregistered@email.com",
                  name: "unregistered",
                  address: "na",
                  phone: "0123456789",
                  regdate: "0",
                );
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => ProfileScreen(user: user)));
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void changePass() {
    http.post(Uri.parse("${Config.SERVER}homeStayRaya/php/update_profile.php"), body: {
      "userid": widget.user.id,
      "oldpass": _oldpasswordController.text,
      "newpass": _newpasswordController.text,
    }).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        setState(() {});
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }
}