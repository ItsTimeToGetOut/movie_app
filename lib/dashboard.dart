import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'backend.dart';

class Dashboard extends StatefulWidget {
  Dashboard({this.a});
  final a;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ImagePicker _picker = ImagePicker();

  var name;
  var director;
  var image;
  XFile imagex;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var yo = widget.a;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Stack(
                    clipBehavior: Clip.antiAlias,
                    children: [
                      SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration:
                                      new InputDecoration(hintText: "Name"),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    } else
                                      name = value;
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration:
                                      new InputDecoration(hintText: "Director"),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    } else
                                      director = value;
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextButton(
                                  child: Text('Pick an Image'),
                                  onPressed: () async {
                                    imagex = await _picker.pickImage(
                                        source: ImageSource.gallery);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  child: Text("Submit"),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Processing Data, please wait')),
                                      );
                                      var heh;
                                      if (imagex != null) {
                                        var loc = await uploadImage(imagex);
                                        print(loc);
                                        addMovie(name, director, loc);
                                        heh = await query();
                                      } else {
                                        addMovie(name, director, null);
                                        heh = await query();
                                      }

                                      setState(() {
                                        yo = heh;
                                      });

                                      print(yo);
                                      image = null;
                                      name = null;
                                      director = null;
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Dashboard(
                                                    a: yo,
                                                  )));
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Container(
          child: ListView.builder(
              itemCount: yo == null ? 0 : yo.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.redAccent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          yo[index]['num'] != null
                              ? Image.network(
                                  yo[index]['num'],
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return CircularProgressIndicator();
                                  },
                                )
                              : Image.asset(
                                  'assets/splash_movie.png',
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${yo[index]['name']}",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${yo[index]['director']}",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    await deleteMovie(yo[index]['id']);
                                    var heh = await query();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Dashboard(
                                                  a: heh,
                                                )));
                                  },
                                  child: Text('Delete')),
                              TextButton(
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Stack(
                                              clipBehavior: Clip.antiAlias,
                                              children: [
                                                SingleChildScrollView(
                                                  child: Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: TextFormField(
                                                            decoration:
                                                                new InputDecoration(
                                                                    hintText:
                                                                        "Name"),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Please enter some text';
                                                              } else
                                                                name = value;
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: TextFormField(
                                                            decoration:
                                                                new InputDecoration(
                                                                    hintText:
                                                                        "Director"),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Please enter some text';
                                                              } else
                                                                director =
                                                                    value;
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: TextButton(
                                                            child: Text(
                                                                'Pick an Image'),
                                                            onPressed:
                                                                () async {
                                                              imagex = await _picker
                                                                  .pickImage(
                                                                      source: ImageSource
                                                                          .gallery);
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextButton(
                                                            child:
                                                                Text("Submit"),
                                                            onPressed:
                                                                () async {
                                                              if (_formKey
                                                                  .currentState
                                                                  .validate()) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Processing Data, please wait')),
                                                                );
                                                                var heh;
                                                                if (imagex !=
                                                                    null) {
                                                                  var loc =
                                                                      await uploadImage(
                                                                          imagex);
                                                                  print(loc);
                                                                  deleteMovie(yo[
                                                                          index]
                                                                      ['id']);
                                                                  addMovie(
                                                                      name,
                                                                      director,
                                                                      loc);
                                                                  heh =
                                                                      await query();
                                                                } else {
                                                                  deleteMovie(yo[
                                                                          index]
                                                                      ['id']);
                                                                  addMovie(
                                                                      name,
                                                                      director,
                                                                      null);
                                                                  heh =
                                                                      await query();
                                                                }

                                                                setState(() {
                                                                  yo = heh;
                                                                });

                                                                print(yo);
                                                                image = null;
                                                                name = null;
                                                                director = null;
                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => Dashboard(
                                                                              a: yo,
                                                                            )));
                                                              }
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Text('Update')),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
