import 'package:flutter/material.dart';
import 'ImageData.dart';

class HomeScreen extends StatefulWidget {
  final username;

  HomeScreen({this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ImageData imageData = new ImageData();
  PageView imageListView = new PageView();

//Show LoggedInUser Details
  void _showAlert(BuildContext context) {
    String username = widget.username;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(child: Text("Alert")),
              content: Text(
                "Logged In As :   $username",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            ));
  }

  void initializeApp() async {
    await imageData.getLinkData();
    _showAlert(context);
  }

  @override
  void initState() {
    initializeApp();
    super.initState();
  }

  Future _checkLinkData() async {
    await imageData.getLinkData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dog\'s Path', style: TextStyle(fontSize: 20)),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _checkLinkData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SafeArea(
                    child: ListView(
                  children: imageData.buildingMasterPageView(imageData),
                ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
