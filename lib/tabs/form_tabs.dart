import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mystore/constants.dart';

class FormTabs extends StatefulWidget {

  @override
  _FormTabsState createState() => _FormTabsState();
}

class _FormTabsState extends State<FormTabs> {
  TextEditingController _nameController, _numberController, _alamatController, _tanggalController;

  DatabaseReference _ref;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _alamatController = TextEditingController();
    _tanggalController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('Data User');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(15),
          width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 24.0,
              ),
              child: Text(
                "Form Data User",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                prefixIcon: Icon(
                  Icons.account_circle,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Nomer Telpon',
                prefixIcon: Icon(
                  Icons.phone_iphone,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: _tanggalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Tanggal Lahir',
                prefixIcon: Icon(
                  Icons.date_range,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: _alamatController,
              decoration: InputDecoration(
                hintText: 'Alamat Lengkap',
                prefixIcon: Icon(
                  Icons.add_location,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 25,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(child: Text('Submit',style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,

              ),),
                onPressed: ()  {
                  saveContact();
                },

                color: Colors.white,
              ),
            )

          ],
        ),
      ),
      ),
    );
  }
  void saveContact(){

    String name = _nameController.text;
    String number = _numberController.text;
    String lahir = _tanggalController.text;
    String alamat = _alamatController.text;

    Map<String,String> datauser = {
      'name':name,
      'number': number,
      'lahir': lahir,
      'alamat': alamat,

    };

    _ref.push().set(datauser).then((value) {
        Navigator.pop(context);
    });


  }
}