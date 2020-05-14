import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AddRolePage extends StatefulWidget {
  @override
  _AddRolePageState createState() => _AddRolePageState();
}
class _AddRolePageState extends State<AddRolePage> {
  TextEditingController text_box=new TextEditingController();
  String msg='';
  String _mySelectionType;
  String _mySelectionlocation;
  final String url = "http://10.0.2.2:8000/dashboard/myfolder/get.php";
  final String url1 = "http://10.0.2.2:8000/dashboard/myfolder/get_loc.php";
  List data1 = List(); //edited line
  List data2 = List(); //edited line

  Future<List> _add_role() async {
    var texts  = text_box.text;
    var type_ = _mySelectionType;
    var loc = _mySelectionlocation;
//    print(texts);
//    print(loc);
//    print(type_);
    var url = 'http://10.0.2.2:8000/dashboard/myfolder/insert.php';
    Response response = await http.post(url, body: {
      "user": type_,
      "pass": loc,
      "role": texts,
    });
    var datauser = response.body;
//    print(datauser);
//    print("result");
//    print(response.body);
    if(datauser == "successfully") {
//      print('successful');
      String msg = "successful" ;
      var line_msg = msg;
      var alertDialog = AlertDialog(
        title: Text("Request Status"),
        content: Text("$line_msg"),
      );
      // ignore: missing_return
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertDialog;
          });
    } else {
//      print('Request failed ');
      String msg;
      msg = "Operation Failed";
      var line_msg = msg;
      var alertDialog = AlertDialog(
        title: Text("Request Status"),
        content: Text("$line_msg"),
      );
      // ignore: missing_return
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertDialog;
          });
    }
  }

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      data1 = resBody;
    });
//    print(resBody);
    return "Sucess";
  }
  Future<String> getSWData1() async {
    var res = await http
        .get(Uri.encodeFull(url1), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      data2 = resBody;
    });
//    print(resBody);
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
    this.getSWData1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Demo"),),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("images/back.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                  height: 60.0),
                Text("Service Type: ",style: TextStyle(fontSize: 18.0),),
              SizedBox(
                  height: 10.0),
                DropdownButton(
                  hint: Text('Please Choose a Service Type'),
                  items: data1.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item['service_type']),
                      value: item['service_type'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _mySelectionType = newVal;
                    });
                  },
                  value: _mySelectionType,
                ),
              SizedBox(
                  height: 20.0),

              Text("Service Location: ",style: TextStyle(fontSize: 18.0),),
              SizedBox(
                  height: 10.0),
              DropdownButton(
                      hint: Text('Please choose a Service Location'),
                      items: data2.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['location']),
                          value: item['location'].toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _mySelectionlocation = newVal;
                        });
                      },
                      value: _mySelectionlocation,
                    ),
              SizedBox(
                  height: 20.0),
              Text("Text Box: ",style: TextStyle(fontSize: 18.0),),
              SizedBox(
                  height: 10.0),
              new TextFormField(
                controller: text_box,
                decoration: new InputDecoration(
                  labelText: "Enter Text",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if(val.length==0) {
                    return "cannot be empty";
                  }else{
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                  height: 40.0),
              ButtonTheme(
                minWidth: 200.0,
                height: 35.0,
                child: RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  child: Text('Submit', style: TextStyle(fontSize: 20),),
                  onPressed: () {
                    _add_role();
//                  Navigator.pop(context);
                  },
                ),
              ),
              Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),),
              SizedBox(
                  height: 5.0),
              ButtonTheme(
                minWidth: 200.0,
                height: 35.0,
                child: RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  child: Text('Back', style: TextStyle(fontSize: 20),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
//
//
//import 'package:flutter/material.dart';
//import 'dart:async';
//import 'dart:convert' as convert;
//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:http/http.dart';
//import 'package:email_validator/email_validator.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//
//
//class ProductInwardPage extends StatefulWidget {
//  @override
//  _ProductInwardPageState createState() => _ProductInwardPageState();
//}
//class _ProductInwardPageState extends State<ProductInwardPage> {
//
//
//
//  String _username,_email,_password= "";
//  final _formKey = GlobalKey<FormState>();
//
//  FocusNode _usernameFocusNode = FocusNode();
//  FocusNode _emailFocusNode = FocusNode();
//  FocusNode _passwordFocusNode = FocusNode();
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text("Input Validation"),),
//      body: HomePageBody(),
//    );
//  }
//
//  Widget HomePageBody() {
//
//    return Container(
//      padding: EdgeInsets.all(16),
//      child: Form(
//        key: _formKey,
//        child: SingleChildScrollView(
//          child: Column(
//            children: <Widget>[
//              NameInput(),
//              SizedBox(height: 16,),
//              EmailInput(),
//              SizedBox(height: 16,),
//              PasswordInput(),
//              SizedBox(height: 16,),
//              SubmitButton()
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget NameInput() {
//    return TextFormField(
//      focusNode: _usernameFocusNode,
//      autofocus: true,
//      textCapitalization: TextCapitalization.words,
//      keyboardType: TextInputType.text ,
//      decoration: InputDecoration(
//        labelText: "Username",
//        hintText: "e.g Morgan",
//        border: new OutlineInputBorder(
//          borderRadius: new BorderRadius.circular(25.0),
//          borderSide: new BorderSide(
//          ),
//        ),
//      ),
//      textInputAction: TextInputAction.next,
//      validator: (name){
//        Pattern pattern =
//            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
//        RegExp regex = new RegExp(pattern);
//        if (!regex.hasMatch(name))
//          return 'Invalid username';
//        else
//          return null;
//
//      },
//      onSaved: (name)=> _username = name,
//      onFieldSubmitted: (_){
//        fieldFocusChange(context, _usernameFocusNode, _emailFocusNode);
//      },
//    );
//  }
//
//
//
//  Widget EmailInput() {
//    return TextFormField(
//      focusNode: _emailFocusNode,
//      keyboardType: TextInputType.emailAddress ,
//      decoration: InputDecoration(
//        labelText: "Email",
//        hintText: "e.g abc@gmail.com",
//        border: new OutlineInputBorder(
//          borderRadius: new BorderRadius.circular(25.0),
//          borderSide: new BorderSide(
//          ),
//        ),
//      ),
//      textInputAction: TextInputAction.next,
//      validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
//      onSaved: (email)=> _email = email,
//      onFieldSubmitted: (_){
//        fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
//      },
//    );
//  }
//
//  Widget PasswordInput() {
//    return TextFormField(
//      focusNode: _passwordFocusNode,
//      keyboardType: TextInputType.text ,
//      obscureText: true,
//      decoration: InputDecoration(
//        labelText: "Password",
//        suffixIcon: Icon(Icons.lock),
//        border: new OutlineInputBorder(
//          borderRadius: new BorderRadius.circular(25.0),
//          borderSide: new BorderSide(
//          ),
//        ),
//      ),
//      textInputAction: TextInputAction.done,
//
//      validator: (password){
//        Pattern pattern =
//            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
//        RegExp regex = new RegExp(pattern);
//        if (!regex.hasMatch(password))
//          return 'Invalid password';
//        else
//          return null;
//      },
//      onSaved: (password)=> _password = password,
//    );
//  }
//
//
//
//  RaisedButton SubmitButton(){
//    return  RaisedButton(
//      color:Theme.of(context).primaryColor,
//      onPressed: (){
//        if(_formKey.currentState.validate()){
//          _formKey.currentState.save();
//          toastMessage("Username: $_username\nEmail: $_email\nPassword: $_password");
//        }
//      },
//      child: Text("Submit",style: TextStyle(color: Colors.white),),
//    );
//  }
//}
//
//void toastMessage(String message){
//  Fluttertoast.showToast(
//      msg: message,
//      toastLength: Toast.LENGTH_SHORT,
//      gravity: ToastGravity.TOP,
//      timeInSecForIosWeb: 1,
//      fontSize: 16.0
//  );
//}
//
//void fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
//  currentFocus.unfocus();
//  FocusScope.of(context).requestFocus(nextFocus);
//}