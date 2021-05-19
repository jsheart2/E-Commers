import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mystore/constants.dart';
import 'package:mystore/widgets/custom_btn.dart';
import 'package:mystore/widgets/custom_input.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // Membuat Pemberitahuan dialog kepada display
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
        return AlertDialog(
          title: Text("Error"),
         content: Container(
           child: Text(error),
         ),
          actions: [
            FlatButton(
             child: Text("Keluar Dialog"),
              onPressed: (){
               Navigator.pop(context);
              },
            )
          ],
        );
        }
        );
  }

  // Membuat akun baru
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
    } on FirebaseException catch(e){
      if(e.code == 'password'){
        return 'The password provided is to weak';
      }else if (e.code == 'email sudah ada') {
        print('Akun sudah ada karena email sama');
      }
      return e.message;
    }catch (e) {
      print(e.toString());
    }
  }

  void _submitForm() async{
    // loading
    setState(() {
      _registerFormLoading = true;
    });

    // menjalankan pembuatan akun
    String _createAccountfeedBack = await _createAccount();

    // pengecekan pada pembuatan akun baru.
    if(_createAccountfeedBack != null) {
      _alertDialogBuilder(_createAccountfeedBack);

      // form to regular [tidak loading]
      setState(() {
        _registerFormLoading = true;
      });
    }else {
      Navigator.pop(context);
    }
  }

  // Ketika dia sudah mengisikan email dan password akan memunculkan loading dari sini
  bool _registerFormLoading = false;

  // untuk mendaftarkan email dan password
  String _registerEmail = "";
  String _registerPassword = "";

  // Focus Node untuk input fields
  FocusNode _passwordFocusNode;

 @override
  void initState() {
   _passwordFocusNode = FocusNode();
   super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 24.0,
                ),
                child: Text(
                  "Pembuatan Akun Baru",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "Email",
                    onChanged: (value){
                      _registerEmail = value;
                    },
                    onSubmitted: (value){
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: "Password",
                    onChanged: (value){
                      _registerPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    onSubmitted: (value) {

                    },
                  ),
                  CustomBtn(
                    text: "Pembuatan Akun Baru",
                    onPressed: () {
                      _submitForm();
                    },
                    isLoading: _registerFormLoading,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: CustomBtn(
                  text: "Sudah Punya Akun ?? Login Disini !!",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  outlineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
