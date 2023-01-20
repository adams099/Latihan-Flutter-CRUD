import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:network_http_app/themes.dart';

class NetworkHttp extends StatefulWidget {
  const NetworkHttp({super.key});

  @override
  State<NetworkHttp> createState() => _NetworkHttpState();
}

late String itemGender = "";

class _NetworkHttpState extends State<NetworkHttp> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final add1 = TextEditingController();
    final add2 = TextEditingController();
    final add3 = TextEditingController();

    return Scaffold(
      backgroundColor: green2Color,
      appBar: AppBar(
        backgroundColor: green1Color,
        elevation: 0,
        title: const Center(child: Text("Flutter CRUD")),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        scrollable: true,
                        content: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controller: add1,
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      icon: Icon(Icons.person_add),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please input your Name';
                                      }
                                      if (value.length < 2) {
                                        return "Your name too short";
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: add2,
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      icon: Icon(Icons.email),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please input your Email';
                                      }
                                      if (!EmailValidator.validate(value)) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 5),
                                  DropdownSearch<String>(
                                    popupProps: const PopupProps.menu(
                                      fit: FlexFit.loose,
                                      showSelectedItems: true,
                                    ),
                                    items: ["Pria", "Wanita"],
                                    onChanged: ((value) {
                                      itemGender = value!.toUpperCase();
                                    }),
                                    dropdownDecoratorProps:
                                        const DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                      icon: Icon(Icons.male),
                                      labelText: "Gender",
                                    )),
                                    selectedItem: add3.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please input Your Gender';
                                      }
                                    },
                                  )
                                ],
                              ),
                            )),
                        actions: [
                          ElevatedButton(
                            child: Text("Tambah"),
                            // style: ButtonStyle(
                            //     backgroundColor:
                            //         MaterialStateProperty.all(Colors.purple)),
                            onPressed: (() {
                              if (_formKey.currentState!.validate()) {
                                postData({
                                  "nama": add1.text.toUpperCase(),
                                  "email": add2.text,
                                  "gender": itemGender,
                                  "password": ""
                                });
                                add1.clear();
                                add2.clear();
                                add3.clear();
                                Navigator.of(context).pop();
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text("Data ditambahkan"),
                                    content: const Text("Silahkan kembali"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, "ok"),
                                        child: const Text("ok"),
                                      ),
                                    ],
                                  ),
                                );
                                // });
                              }
                            }),
                          )
                        ]);
                  });
            },
            icon: const Icon(
              Icons.person_add,
            ),
          ),
        ],
      ),
      body: Container(child: UsingTheData()),
    );
  }
}

// class PrintResponseBody extends StatelessWidget {
//   const PrintResponseBody({super.key});
//   Future<http.Response> getData() async {
//     final response =
//         await http.get(Uri.parse("http://$localAddress/api/user/getAll"));
//     return response;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<http.Response>(
//       future: getData(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text(snapshot.data!.body);
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }
//         return Center(child: const CircularProgressIndicator());
//         ;
//       },
//     );
//   }
// }

String localAddress = "192.168.137.1:8082";

class UsingTheData extends StatefulWidget {
  UsingTheData({super.key});

  @override
  State<UsingTheData> createState() => _UsingTheDataState();
}

class _UsingTheDataState extends State<UsingTheData> {
  Future<http.Response> getData() async {
    final response =
        await http.get(Uri.parse("http://$localAddress/api/user/getAll"));
    setState(() {
      response;
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final add1 = TextEditingController();
    final add2 = TextEditingController();
    final add3 = TextEditingController();

    return FutureBuilder(
        future: getData().then((value) => value.body),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> json = jsonDecode(snapshot.data!);
            return ListView.builder(
              itemCount: json.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            json[index]["gender"].toUpperCase() == "WANITA"
                                ? Colors.pink[300]
                                : Colors.blue[300],
                        child: Text(
                          "${json[index]["nama"][0].toUpperCase()}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        "${json[index]["nama"]}",
                        style: font1,
                      ),
                      subtitle: Text("${json[index]["email"]}"),
                      onTap: () {
                        print("nama : ${json[index]["nama"]}");
                        print("Email : ${json[index]["email"]}");
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              add1.text = json[index]["nama"];
                              add2.text = json[index]["email"];
                              add3.text = json[index]["gender"];
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        scrollable: true,
                                        content: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextFormField(
                                                    controller: add1,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: 'Name',
                                                      icon: Icon(
                                                          Icons.person_add),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please input your Name';
                                                      }
                                                      if (value.length < 2) {
                                                        return "Your name too short";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    controller: add2,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: 'Email',
                                                      icon: Icon(Icons.email),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please input your Email';
                                                      }
                                                      if (!EmailValidator
                                                          .validate(value)) {
                                                        return 'Please enter a valid email';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(height: 5),
                                                  DropdownSearch<String>(
                                                    popupProps:
                                                        const PopupProps.menu(
                                                      fit: FlexFit.loose,
                                                      showSelectedItems: true,
                                                    ),
                                                    items: ["Pria", "Wanita"],
                                                    onChanged: ((value) {
                                                      itemGender =
                                                          value!.toUpperCase();
                                                    }),
                                                    dropdownDecoratorProps:
                                                        const DropDownDecoratorProps(
                                                            dropdownSearchDecoration:
                                                                InputDecoration(
                                                      icon: Icon(Icons.male),
                                                      labelText: "Gender",
                                                    )),
                                                    selectedItem: add3.text,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please input your Email';
                                                      }
                                                    },
                                                  )
                                                ],
                                              ),
                                            )),
                                        actions: [
                                          ElevatedButton(
                                            child: Text("Update"),
                                            // style: ButtonStyle(
                                            //     backgroundColor:
                                            //         MaterialStateProperty.all(Colors.purple)),
                                            onPressed: (() {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                updateData(json[index]["id"], {
                                                  "nama": add1.text,
                                                  "email": add2.text,
                                                  "gender": itemGender,
                                                  "password": ""
                                                });
                                                add1.clear();
                                                add2.clear();
                                                add3.clear();
                                                Navigator.of(context).pop();
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        "Data Berhasil diupdate"),
                                                    content: const Text(
                                                        "Silahkan kembali"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, "ok"),
                                                        child: const Text("ok"),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                // });
                                              }
                                            }),
                                          )
                                        ]);
                                  });
                            },
                            icon: const Icon(
                              Icons.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Menghapus data"),
                                  content: const Text(
                                      "Anda yakin ingin menghapus data ini!"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, "cancel");
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: (() {
                                        setState(() {
                                          deleteData(json[index]["id"]);
                                          Navigator.pop(context, "ok");
                                        });
                                      }),
                                      child: const Text("ok"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                            ),
                          ),
                        ],
                      )),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

// Future<http.Response> getData() async {
//   final response =
//       await http.get(Uri.parse("http://192.168.96.129:8082/api/user/getAll"));
//   // await http.get(Uri.parse("https://reqres.in/api/users?per_page=15"));
//   // await Future.delayed(const Duration(seconds: 2));
//   return response;
// }

Future<http.Response> postData(Map<String, dynamic> data) async {
  final response =
      await http.post(Uri.parse("http://$localAddress/api/user/insert"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
  print(response.statusCode);
  print(response.body);
  return response;
}

Future<http.Response> updateData(int id, Map<String, dynamic> data) async {
  final response =
      await http.put(Uri.parse("http://$localAddress/api/user/update/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
  print(response.statusCode);
  print(response.body);
  return response;
}

Future<http.Response> deleteData(id) async {
  final response = await http.delete(
    Uri.parse("http://$localAddress/api/user/delete/$id"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(id);
  print(response.statusCode);
  print(response.body);
  return response;
}
