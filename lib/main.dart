// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String text1 = "";
String text2 = "";
String text3 = "";
String text4 = "";
String text5 = "";
String picUrl = "";

const Color buttoncoloryes = Color(0xff74A57F);
const Color color = Color(0xff344966);

int boxno = 0;
String mId = "";

String getId(String id) {
  return id;
}

int getBox(int box) {
  return box;
}

Future<void> twoBoxMeme(String abs, String a, String b) async {
  await dotenv.load(fileName: ".env");
  var headers = {'Cookie': 'claim_key=ZftcrPfMgVpuaxwfEzo_4v_l4yFIEiHm'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('https://api.imgflip.com/caption_image'));

  request.fields.addAll({
    'template_id': abs,
    'username': dotenv.env['USERNAME'].toString(),
    'password': dotenv.env['PASSWORD'].toString(),
    'font': 'impact',
    'max_font_size': '15',
    'text0': a,
    'text1': b,
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final respStr = await response.stream.bytesToString();
    var convertDataToJson = jsonDecode(respStr);
    picUrl = convertDataToJson['data']['url'] as String;
    print(picUrl);
  } else {
    print(response.reasonPhrase);
  }
}

Future<void> threeBoxMeme(String abs, String a, String b, String c) async {
  await dotenv.load(fileName: ".env");
  var headers = {'Cookie': 'claim_key=ZftcrPfMgVpuaxwfEzo_4v_l4yFIEiHm'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('https://api.imgflip.com/caption_image'));
  request.fields.addAll({
    'template_id': abs,
    'username': dotenv.env['USERNAME'].toString(),
    'password': dotenv.env['PASSWORD'].toString(),
    'font': 'impact',
    'max_font_size': '15',
    'boxes[0][text]': a,
    'boxes[1][text]': b,
    'boxes[2][text]': c
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final respStr = await response.stream.bytesToString();
    var convertDataToJson = jsonDecode(respStr);
    picUrl = convertDataToJson['data']['url'] as String;
    print(picUrl);
  } else {
    print(response.reasonPhrase);
  }
}

Future<void> fourBoxMeme(
    String abs, String a, String b, String c, String d) async {
  await dotenv.load(fileName: ".env");
  var headers = {'Cookie': 'claim_key=ZftcrPfMgVpuaxwfEzo_4v_l4yFIEiHm'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('https://api.imgflip.com/caption_image'));
  request.fields.addAll({
    'template_id': abs,
    'username': dotenv.env['USERNAME'].toString(),
    'password': dotenv.env['PASSWORD'].toString(),
    'font': 'impact',
    'max_font_size': '15',
    'boxes[0][text]': a,
    'boxes[1][text]': b,
    'boxes[2][text]': c,
    'boxes[3][text]': d
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final respStr = await response.stream.bytesToString();
    var convertDataToJson = jsonDecode(respStr);
    picUrl = convertDataToJson['data']['url'] as String;
    print(picUrl);
  } else {
    print(response.reasonPhrase);
  }
}

Future<void> fiveBoxMeme(
    String abs, String a, String b, String c, String d, String e) async {
  await dotenv.load(fileName: ".env");
  var headers = {'Cookie': 'claim_key=ZftcrPfMgVpuaxwfEzo_4v_l4yFIEiHm'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('https://api.imgflip.com/caption_image'));
  request.fields.addAll({
    'template_id': abs,
    'username': dotenv.env['USERNAME'].toString(),
    'password': dotenv.env['PASSWORD'].toString(),
    'font': 'impact',
    'max_font_size': '15',
    'boxes[0][text]': a,
    'boxes[1][text]': b,
    'boxes[2][text]': c,
    'boxes[3][text]': d,
    'boxes[4][text]': e
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final respStr = await response.stream.bytesToString();
    var convertDataToJson = jsonDecode(respStr);
    picUrl = convertDataToJson['data']['url'] as String;
    print(picUrl);
  } else {
    print(response.reasonPhrase);
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [];
  Future<String> getJsonData() async {
    String url = 'https://api.imgflip.com/get_memes';
    var response = await http.get(Uri.parse(url),
        headers: {'Cookie': 'claim_key=4Dn-nq8GOSfs_VZAKowrQt2AZsEWYkJS'});

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['data']['memes'];
    });
    print(data);
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    final alucard = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          SizedBox(height: 80.0),
          CircleAvatar(
              radius: 72.0,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/dep.png')),
        ]),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
        SizedBox(
          height: 40.0,
        ),
        Text(
          'Welcome to MemeGen',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28.0, color: Colors.white),
        ),
      ]),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Click to start making memes',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
    const Color color = Color(0xff344966);
    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: color,
      ),
      child: Column(
        children: <Widget>[
          alucard,
          welcome,
          lorem,
          SizedBox(height: 20.0),
          RaisedButton(
            child: new Text("Create"),
            textColor: Colors.white,
            color: buttoncoloryes,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemeList()),
              );
            },
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}

class MemeList extends StatefulWidget {
  const MemeList({Key? key}) : super(key: key);

  @override
  _MemeListState createState() => _MemeListState();
}

class _MemeListState extends State<MemeList> {
  List data = [];
  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    String url = 'https://api.imgflip.com/get_memes';
    var response = await http.get(Uri.parse(url),
        headers: {'Cookie': 'claim_key=4Dn-nq8GOSfs_VZAKowrQt2AZsEWYkJS'});

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['data']['memes'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    const Color color = Color(0xff344966);
    final body = Stack(children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          color: color,
        ),
      ),
      new ListView.builder(
          itemCount: data == [] ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return (new Container(
                child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new ListTile(
                          leading: Icon(Icons.link_outlined),
                          title: new Text(data[index]['name']),
                        ),
                        TextButton(
                          child: const Text('View Meme Template'),
                          onPressed: () {
                            if (data[index]['box_count'] == 2) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoubleText()),
                              );
                              mId = data[index]['id'];
                              picUrl = data[index]['url'];
                            } else if (data[index]['box_count'] == 3) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TripleText()),
                              );
                              mId = data[index]['id'];
                              picUrl = data[index]['url'];
                            } else if (data[index]['box_count'] == 4) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuadText()),
                              );
                              mId = data[index]['id'];
                              picUrl = data[index]['url'];
                            } else if (data[index]['box_count'] == 5) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PentText()),
                              );
                              mId = data[index]['id'];
                              picUrl = data[index]['url'];
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
          })
    ]);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Templates"),
      ),
      body: body,
    );
  }
}

class DoubleText extends StatefulWidget {
  const DoubleText({Key? key}) : super(key: key);

  @override
  _DoubleTextState createState() => _DoubleTextState();
}

class _DoubleTextState extends State<DoubleText> {
  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Your meme is available at:'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new InkWell(
                    child: new Text(
                      picUrl,
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () => launch(picUrl)),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(28.0),
          decoration: BoxDecoration(
            color: color,
          ),
          child: Column(children: <Widget>[
            SizedBox(
                child: Image.network(
              picUrl,
              height: 500.0,
              width: 500.0,
            )),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 500.0,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.add_link,
                    color: Colors.white,
                  ),
                ),
                onChanged: (text) {
                  text1 = text;
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 500.0,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.add_link,
                    color: Colors.white,
                  ),
                ),
                onChanged: (text) {
                  text2 = text;
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: new Text("Create"),
              textColor: Colors.white,
              color: buttoncoloryes,
              onPressed: () {
                twoBoxMeme(mId, text1, text2);
                _showcontent();
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class TripleText extends StatefulWidget {
  const TripleText({Key? key}) : super(key: key);

  @override
  _TripleTextState createState() => _TripleTextState();
}

class _TripleTextState extends State<TripleText> {
  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('You clicked on'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new InkWell(
                    child: new Text(
                      picUrl,
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () => launch(picUrl)),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final body = SingleChildScrollView(
        child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: color,
      ),
      child: Column(children: <Widget>[
        SizedBox(
            child: Image.network(
          picUrl,
          height: 500.0,
          width: 500.0,
        )),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 500.0,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.add_link,
                color: Colors.white,
              ),
            ),
            onChanged: (text) {
              text1 = text;
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 500.0,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.add_link,
                color: Colors.white,
              ),
            ),
            onChanged: (text) {
              text2 = text;
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 500.0,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.add_link,
                color: Colors.white,
              ),
            ),
            onChanged: (text) {
              text3 = text;
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        RaisedButton(
          child: new Text("Create"),
          textColor: Colors.white,
          color: buttoncoloryes,
          onPressed: () {
            threeBoxMeme(mId, text1, text2, text3);
            _showcontent();
          },
        ),
      ]),
    ));
    return Scaffold(body: body);
  }
}

class QuadText extends StatefulWidget {
  const QuadText({Key? key}) : super(key: key);

  @override
  _QuadTextState createState() => _QuadTextState();
}

class _QuadTextState extends State<QuadText> {
  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('You clicked on'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new InkWell(
                    child: new Text(
                      picUrl,
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () => launch(picUrl)),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color color = Color(0xff344966);

    final body = SingleChildScrollView(
        child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: color,
      ),
      child: Column(children: <Widget>[
        SizedBox(
            child: Image.network(
          picUrl,
          height: 500.0,
          width: 500.0,
        )),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 500.0,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.add_link,
                color: Colors.white,
              ),
            ),
            onChanged: (text) {
              text1 = text;
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 500.0,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.add_link,
                color: Colors.white,
              ),
            ),
            onChanged: (text) {
              text1 = text;
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 500.0,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.add_link,
                color: Colors.white,
              ),
            ),
            onChanged: (text) {
              text1 = text;
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 500.0,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.add_link,
                color: Colors.white,
              ),
            ),
            onChanged: (text) {
              text1 = text;
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        RaisedButton(
          child: new Text("Create"),
          textColor: Colors.white,
          color: buttoncoloryes,
          onPressed: () {
            fourBoxMeme(mId, text1, text2, text3, text4);
            _showcontent();
          },
        ),
      ]),
    ));
    return Scaffold(body: body);
  }
}

class PentText extends StatefulWidget {
  const PentText({Key? key}) : super(key: key);

  @override
  _PentTextState createState() => _PentTextState();
}

class _PentTextState extends State<PentText> {
  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('You clicked on'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new InkWell(
                    child: new Text(
                      picUrl,
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () => launch(picUrl)),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color color = Color(0xff344966);

    final body = SingleChildScrollView(
        child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: color,
      ),
      child: Column(children: <Widget>[
        SizedBox(
            child: Image.network(
          picUrl,
          height: 500.0,
          width: 500.0,
        )),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 500.0,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.add_link,
                color: Colors.white,
              ),
            ),
            onChanged: (text) {
              text1 = text;
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 500.0,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.add_link,
                color: Colors.white,
              ),
            ),
            onChanged: (text) {
              text2 = text;
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 500.0,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.add_link,
                color: Colors.white,
              ),
            ),
            onChanged: (text) {
              text3 = text;
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 500.0,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.add_link,
                color: Colors.white,
              ),
            ),
            onChanged: (text) {
              text4 = text;
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 500.0,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.add_link,
                color: Colors.white,
              ),
            ),
            onChanged: (text) {
              text5 = text;
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        RaisedButton(
          child: new Text("Create"),
          textColor: Colors.white,
          color: buttoncoloryes,
          onPressed: () {
            fiveBoxMeme(mId, text1, text2, text3, text4, text5);
            _showcontent();
          },
        ),
      ]),
    ));
    return Scaffold(body: body);
  }
}
