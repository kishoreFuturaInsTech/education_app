import 'dart:typed_data';

import 'package:api_practice/HttpService.dart';
import 'package:api_practice/Quantative.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HttpService api = HttpService();

  String? instituteName;
  String? universityName;
  String? courseName;
  String? courseDiscipline;
  String? certificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Form()),
          ).then((value) => {
          setState(() {

          })
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        title: Text(
          "Demo of Get Data",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.amberAccent,
          ),
        ),
      ),
      drawer: Drawer(),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                api.getAllQuants();
                return Card(
                  color: Colors.grey[850],

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(100.0,0,0,0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Text(
                                " ${snapshot.data[index].id}",
                                style: TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                              Text(
                                " ${snapshot.data[index].instituteName}",
                                style: TextStyle(color: Colors.amber),
                              ),
                              Text(
                                " ${snapshot.data[index].universityName}",
                                style: TextStyle(color: Colors.amber),
                              ),
                              Text(
                                " ${snapshot.data[index].courseName}",
                                style: TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                            ]
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                String uri = 'data:image/gif;base64,${snapshot.data[index].file}';
                                Uint8List _bytes;
                                _bytes = base64.decode(uri.split(',').last);
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Image'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children:  <Widget>[
                                            GestureDetector(
                                              onTap: () {

                                              },
                                              child: Container(
                                                height: 300,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.purple),
                                                  borderRadius: BorderRadius.circular(25.0),
                                                ), //             <--- BoxDecoration here
                                                child: Container(
                                                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  width: 500.0,
                                                  height: 800.0,
                                                  child: Image.memory(_bytes),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Back'),
                                          onPressed: () {
                                            // Fluttertoast.showToast(
                                            //     msg: "You have deleted the record successfully",
                                            //     toastLength: Toast.LENGTH_SHORT,
                                            //     gravity: ToastGravity.CENTER,
                                            //     timeInSecForIosWeb: 1,
                                            //     backgroundColor: Colors.red,
                                            //     textColor: Colors.white,
                                            //     fontSize: 16.0
                                            // );
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.view_agenda_outlined,color: Colors.redAccent,)),
                          IconButton(
                              onPressed: () {
                                api.deleteQuants(snapshot.data[index].id);
                                setState(() {
                                  api.getAllQuants();
                                });
                              },
                              icon: const Icon(Icons.delete,color: Colors.redAccent,)),
                          IconButton(
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Education Edit'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            TextFormField(
                                              initialValue:'${snapshot.data[index].instituteName}',

                                              onChanged: (e){
                                                setState(() {
                                                  instituteName=e;
                                                });
                                              },
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "Institute Name"
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              initialValue:'${snapshot.data[index].universityName}',

                                              onChanged: (e){
                                                setState(() {
                                                  universityName=e;
                                                });
                                              },
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "University Name"
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              initialValue:'${snapshot.data[index].courseName}',

                                              onChanged: (e){
                                                setState(() {
                                                  courseName=e;
                                                });
                                              },
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "Course Name"
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              initialValue:'${snapshot.data[index].courseDiscipline}',

                                              onChanged: (e){
                                                setState(() {
                                                  courseDiscipline=e;
                                                });
                                              },
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "Course Discipline"
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              initialValue:'${snapshot.data[index].certificationId}',

                                              onChanged: (e){
                                                setState(() {
                                                  certificationId=e;
                                                });
                                              },
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "Certification Id"
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),


                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Back'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Save'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            api.updateEducation(snapshot.data[index].id, Quantative(
                                              instituteName: instituteName,
                                              universityName: universityName,
                                              courseName: courseName,
                                              courseDiscipline: courseDiscipline,
                                              certificationId: certificationId,
                                            ));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                setState(() {
                                  api.getAllQuants();
                                });
                              },
                              icon: const Icon(Icons.edit,color: Colors.blueAccent,))
                        ],
                      ),

                    ],
                  )
                );
              },
              itemCount: snapshot.data.length,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        future: api.getAllQuants(),
      ),
    );
  }
}

class Form extends StatefulWidget {
  const Form({Key? key}) : super(key: key);

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  HttpService api = HttpService();
  TextEditingController instituteName = TextEditingController();
  TextEditingController universityName = TextEditingController();
  TextEditingController courseName = TextEditingController();
  TextEditingController courseDiscipline = TextEditingController();
  TextEditingController certificationId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
          centerTitle: true,
          title: Text(
        "Education Add",
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2.0),
      )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: TextField(
                controller: instituteName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Institute Name',
                  hintText: 'Enter Institute Name',
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Card(
              child: TextField(
                controller: universityName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'University Name',
                  hintText: 'Enter University Name',
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Card(
              child: TextField(
                controller: courseName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Course Name',
                  hintText: 'Enter Course Name',
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Card(
              child: TextField(
                controller: courseDiscipline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Course Discipline',
                  hintText: 'Enter Course Discipline',
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Card(
              child: TextField(
                controller: certificationId,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Certification Id',
                  hintText: 'Enter Certification Id',
                ),
              ),
            ),
            RaisedButton(onPressed: (){
              Navigator.pop(context);
              api.createQuants(Quantative(
                instituteName: instituteName.text,
                universityName: universityName.text,
                courseName: courseName.text,
                courseDiscipline: courseDiscipline.text,
                certificationId: certificationId.text

              ));
              setState(() {
                api.getAllQuants();
              });

            },
            child: Text("Submit"),)
          ],
        ),
      ),
    );
  }
}
