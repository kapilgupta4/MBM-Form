import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MBM University Jodhpur',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(title: 'Send Data To MBMU Jodhpur'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey        = GlobalKey<FormState>();

  /// Controllers
  TextEditingController nameController    = TextEditingController();
  TextEditingController emailController     = TextEditingController();
  TextEditingController mobnoController     = TextEditingController();
  TextEditingController branchController     = TextEditingController();
  TextEditingController rollnoController     = TextEditingController();
  TextEditingController batchController     = TextEditingController();
  TextEditingController sectionController     = TextEditingController();


  void _submitForm() async{
    if(_formKey.currentState!.validate()){
      
      const String scriptURL  = 'https://script.google.com/macros/s/AKfycbz3iPcJz6zk9WSSWKwTq7i-h1tUO3og5qYJ4z0bzsoR7_rIyFXOTU6xZHHZ7du8fnqO/exec';

      String tempName     = nameController.text;
      String tempEMail      = emailController.text;
      String tempMobileNo     = mobnoController.text;
      String tempBranch     = branchController.text;
      String tempRollNo     = rollnoController.text;
      String tempBatch     = batchController.text;
      String tempSection     = sectionController.text;

      String queryString  = "?name=$tempName&email=$tempEMail&mobno=$tempMobileNo&branch=$tempBranch&rollno=$tempRollNo&batch=$tempBatch&section=$tempSection";

      var finalURI   = Uri.parse(scriptURL + queryString);
      var response    = await http.get(finalURI);
      //print(finalURI);
      
      if (response.statusCode == 200) {
        var bodyR = convert.jsonDecode(response.body);
        print(bodyR);
      }

    }
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  validator: (value){
                    if(value ==""){
                      return "Enter a valid value for Name";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                  ),
                  controller: nameController,
                ),
                TextFormField(
                  validator: (value){
                    if(value == ""){
                      return "Enter a valid E-Mail Address";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'E-Mail',
                  ),
                  controller: emailController,
                ),
                TextFormField(
                  validator: (value){
                    if(value == ""){
                      return "Enter a valid Contact No.";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Mobile No.',
                  ),
                  controller: mobnoController,
                ),
                TextFormField(
                  validator: (value){
                    if(value == ""){
                      return "Enter a valid Branch";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Branch',
                  ),
                  controller: branchController,
                ),
                TextFormField(
                  validator: (value){
                    if(value == ""){
                      return "Enter a valid Roll No.";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Roll No.',
                  ),
                  controller: rollnoController,
                ),
                TextFormField(
                  validator: (value){
                    if(value == ""){
                      return "Enter a valid Batch";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Batch',
                  ),
                  controller: batchController,
                ),
                TextFormField(
                  validator: (value){
                    if(value == ""){
                      return "Enter a valid Year";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Year',
                  ),
                  controller: sectionController,
                ),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: (){ 
                  _submitForm();
                },
                  child: Text('Save Details'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}