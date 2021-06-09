import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ImageData {
  var linkData;

  //API Call
  Future _callHttp() async {
    var url =
        Uri.parse('https://5d55541936ad770014ccdf2d.mockapi.io/api/v1/paths');
    Response response = await get(Uri.parse(url.toString()));
    String data;
    if (response.statusCode == 200) {
      data = response.body;
      return jsonDecode(data);
    } else {
      return response.statusCode;
    }
  }

  Future<void> getLinkData() async {
    linkData = await _callHttp();
  }

  //Create Image List View
  PageView createImagePageView(List<String> imagePathList) {

    List<Image> listOfImages = [];
    for (int i = 0; i < imagePathList.length; i++) {
      listOfImages.add(Image.network(
        imagePathList[i],
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
              "images/defaultImage.jpg");
        },
      ));
    }

    return PageView(controller: new PageController(initialPage: 1,keepPage: true), scrollDirection: Axis.horizontal, children: listOfImages);
  }

  //Create Title List View
  PageView createTitlePageView(List<String> titlePathList) {
    List<Text> listOfTitle = [];
    for (int i = 0; i < titlePathList.length; i++) {
      String tempTitle = titlePathList[i];
      listOfTitle.add(Text("$tempTitle --> ",
          textAlign: TextAlign.center, style: TextStyle(fontSize: 20)));
    }

    return PageView(controller: new PageController(initialPage: 1,keepPage: true), scrollDirection: Axis.horizontal, children: listOfTitle);
  }

  //Building Nested ListView
  Widget buildViewForImagesTitles(String title, int numberOfPaths,
      PageView imagePageView, PageView titlePageView)
  {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 3,
                child: Container(
                    child: ListTile(
                  title: Text("$title"),
                  subtitle: Text("$numberOfPaths SubPaths"),
                ))),
            Expanded(
                child: Container(
                    child: TextButton(
                        onPressed: () {},
                        child: Text('Open Path'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white))))),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  double pageNo = double.parse(imagePageView.controller.page.toString()).roundToDouble();
                  titlePageView.controller.animateToPage(pageNo.toInt(),duration: Duration(seconds: 2),curve: Curves.ease);
                },
                child: Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    width: double.infinity,
                    height: 200,
                    child: PageView.builder(
                         itemBuilder: (context, index) {
                          return Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: imagePageView);
                        })
                )),
            GestureDetector(
                onTap: () {
                  double pageNo = double.parse(titlePageView.controller.page.toString()).roundToDouble();
                  imagePageView.controller.animateToPage(pageNo.toInt(),duration: Duration(seconds: 2),curve: Curves.ease);
                },
                child: Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    width: double.infinity,
                    height: 40,
                    child: PageView.builder(
                        itemBuilder: (context, index) {
                      return Container(
                          height: 200,
                          width: 50,
                          child: titlePageView);
                    }))),
          ],
        )
      ],
    );
  }

  //Building Master List View
  List<Widget> buildingMasterPageView(ImageData imageData) {
    List<dynamic> dataList = [];
    List<String> imageList = [];
    List<String> titleList = [];
    List<Widget> masterViewList = [];
    dataList.addAll(imageData.linkData);

    for (int k = 0; k < dataList.length; k++) {
      if (dataList[k]["sub_paths"] != null) {
        for (int i = 0; i < dataList[k]["sub_paths"].length; i++) {
          imageList.add(dataList[k]["sub_paths"][i]["image"]);
        }

        //create Image ListView
        PageView imagePageView = createImagePageView(imageList);

        for (int i = 0; i < dataList[k]["sub_paths"].length; i++) {
          titleList.add(dataList[k]["sub_paths"][i]["title"]);
        }

        //create Title ListView
        PageView titlePageView = createTitlePageView(titleList);

        masterViewList.add(imageData.buildViewForImagesTitles(
          dataList[k]["title"],
          dataList[k]["sub_paths"].length,
          imagePageView,
          titlePageView,
        ));

        imageList.clear();
        titleList.clear();
      }
    }
    return masterViewList;
  }
}
