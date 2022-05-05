// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:memegen/collection.dart';
import 'package:memegen/signin.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'authentication_service.dart';
import 'firebase_options.dart';


String picUrl = "";
final emailController = TextEditingController();
final pwdController = TextEditingController();

const Color buttoncoloryes = Color(0xff74A57F);
const Color color = Color(0xff344966);


String mId = "";

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'Memegen',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return HomeScreen();
    }
    return SignInPage();
  }
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
          Container(
            alignment: Alignment.topRight,
            child: RaisedButton(
              child: new Text("Sign Out"),
              textColor: Colors.white,
              color: buttoncoloryes,
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
            ),
          ),
          alucard,
          welcome,
          lorem,
          SizedBox(height: 20.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
              RaisedButton(
                child: new Text("View my collection"),
                textColor: Colors.white,
                color: buttoncoloryes,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CollectionPage()),
                  );
                },
              ),
            ],
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

List<Widget> textFieldList = [];

class _MemeListState extends State<MemeList> {
  List data = [];

  void _addTextFieldWidget(int i) {
    textFieldList.add(textField(i));
  }

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
                            int x = data[index]['box_count'];
                            for (int i = 0; i < x; i++) {
                              _addTextFieldWidget(i);
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoubleText(
                                        boxCount: data[index]['box_count'],
                                      )),
                            );
                            mId = data[index]['id'];
                            picUrl = data[index]['url'];
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

List<String> textStorage = ["", "", "", "", ""];

Widget textField(int i) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 500,
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
          textStorage[i] = text;
        },
      ),
    ),
  );
}

class DoubleText extends StatefulWidget {
  final int boxCount;
  const DoubleText({Key? key, required this.boxCount}) : super(key: key);

  @override
  _DoubleTextState createState() => _DoubleTextState();
}

class _DoubleTextState extends State<DoubleText> {
  final TextEditingController nameController = TextEditingController();
  void _showFirstDialog() {
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
            new FlatButton(
              child: new Text('Add to collection'),
              onPressed: () {
                Navigator.of(context).pop();
                _showSecondDialog();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSecondDialog() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Your meme is available at:'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Meme name",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new InkWell(
                      child: new Text(
                        picUrl,
                        style: TextStyle(color: Colors.blue),
                        textAlign: TextAlign.right,
                      ),
                      onTap: () => launch(picUrl)),
                ),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Add'),
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                final docRef = await FirebaseFirestore.instance
                    .collection('users')
                    .where('email', isEqualTo: user?.email)
                    .get();

                List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
                    docRef.docs;
                var value =
                    data[0]; // there should be only 1 document with that email
                Map<String, dynamic> originalUrl = value['urls'];
                originalUrl[nameController.text] = picUrl;

                FirebaseFirestore.instance
                    .collection('users')
                    .doc(value['docID'])
                    .update({
                  'docID': value['docID'],
                  'email': user!.email,
                  'urls': originalUrl
                });
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('Cancel'),
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
    return new Scaffold(
      body: new Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          color: color,
        ),
        child: new Column(children: <Widget>[
          new Container(
              child: Image.network(
            picUrl,
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.3,
          )),
          new Expanded(
            child: new SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: 500,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.boxCount,
                  itemBuilder: (context, index) {
                    return textFieldList[index];
                  }),
            ),
          ),
          RaisedButton(
            child: new Text("Create"),
            textColor: Colors.white,
            color: buttoncoloryes,
            onPressed: () {
              
              
              if(widget.boxCount==2){
                  twoBoxMeme(mId, textStorage[0], textStorage[1]);
              }
              else if(widget.boxCount == 3){
                threeBoxMeme(mId, textStorage[0],  textStorage[1], textStorage[2]);
              }
              else if(widget.boxCount == 4){
                fourBoxMeme(mId, textStorage[0],  textStorage[1], textStorage[2], textStorage[3]);
              }
              else if(widget.boxCount == 5){
                fiveBoxMeme(mId, textStorage[0],  textStorage[1], textStorage[2], textStorage[3], textStorage[4]);
              }
            
              _showFirstDialog();
            },
          ),
        ]),
      ),
    );
  }
}

