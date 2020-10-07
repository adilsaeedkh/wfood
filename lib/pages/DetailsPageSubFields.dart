import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:wfoodalbayt/src/model/ModelSubFileds.dart';
import 'package:wfoodalbayt/static/APIConstants.dart';
import 'package:wfoodalbayt/ui_widgets/SizedText.dart';

class DetailsPageSubFields extends StatefulWidget {
  final int subfieldId;
  DetailsPageSubFields({this.subfieldId});
  @override
  _DetailsPageSubFieldsState createState() => _DetailsPageSubFieldsState();
}

class _DetailsPageSubFieldsState extends State<DetailsPageSubFields> {
  //Future Rating for catch all the rating apis to display
  bool loading = false;

  List<ModelSubFieldsElement> _modelSubFileds = <ModelSubFieldsElement>[];

  bool _loading = false;
  /*
   * Future for Agency api
   * receives data from the internet
   * with the Model Agency
   */
  Future<List<ModelSubFieldsElement>> getSubFileds() async {
    var res = await http.get(
        Uri.encodeFull(APIOP.SUB_FIELDS + '${widget.subfieldId}'),
        headers: {"Accept": "application/json"});

    if (res.statusCode == APIRCODE.SC_OK) {
      var data = json.decode(res.body);
      var rest = data['subfield'] as List;

      setState(() {
        _modelSubFileds = rest
            .map<ModelSubFieldsElement>(
                (rest) => ModelSubFieldsElement.fromJson(rest))
            .toList();
      });
      _loading = false;
    }
    return _modelSubFileds;
  }

  final Set<Marker> _markers = Set();
  final double _zoom = 10;
  CameraPosition _initialPosition = CameraPosition(target: LatLng(0, -0));
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> _goToMaps() async {
    double lat = double.parse("0");
    double long = double.parse("-0");
    GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(
      () {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: MarkerId("${_modelSubFileds[0].id}"),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
              title: '${_modelSubFileds[0].description}',
              snippet: '${_modelSubFileds[0].name}',
            ),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      },
    );
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  var rating = 1.2;

  List getServiceList(List str) {
    List<String> _listOfItems = [];
    for (var i = 0; i < str.length; i++) {
      _listOfItems.add(str[i]['service_type']);
    }
    return _listOfItems;
  }

  @override
  initState() {
    super.initState();
    this.getSubFileds();

    setState(
      () {
        _goToMaps();
        setState(
          () {
            loading = true;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: <Widget>[
                new SliverAppBar(
                  title: Text(
                    '${_modelSubFileds[0].name}',
                    style: new TextStyle(
                      fontSize: EventSizedConstants.TextappBarSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: ArabicFonts.El_Messiri,
                      package: 'google_fonts_arabic',
                      color: Colors.white,
                      shadows: <Shadow>[
                        new Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        new Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 8.0,
                          color: Color.fromARGB(125, 0, 0, 255),
                        ),
                      ],
                    ),
                  ),
                  centerTitle: true,
                  pinned: true,
                  floating: false,
                  expandedHeight: 256,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: 'assets/logo.png',
                          image: '${_modelSubFileds[0].profileImg}',
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: <Color>[
                                  Colors.black54,
                                  Color(0x00000000)
                                ],
                                stops: [
                                  0.0,
                                  2.0
                                ],
                                begin: FractionalOffset.bottomCenter,
                                end: FractionalOffset.topCenter,
                                tileMode: TileMode.mirror),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.7, 0.9],
                                colors: [
                                  Colors.white10,
                                  Colors.white12,
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            //color: Color.fromRGBO(255, 255, 255, 0.5),
                            child: SmoothStarRating(
                              rating: _modelSubFileds[0].rating,
                              size: 25,
                              color: Colors.yellow,
                              borderColor: Colors.grey,
                              starCount: 5,
                              onRatingChanged: (value) {
                                setState(
                                  () {
                                    rating = value;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      new Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          children: <Widget>[
                            new Expanded(
                              child: Text(
                                '${_modelSubFileds[0].name}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: ArabicFonts.El_Messiri,
                                  package: 'google_fonts_arabic',
                                ),
                              ),
                            ),
                            new FlatButton(
                              onPressed: null,
                              child: new Text(
                                "إضافة تقييم",
                                style: TextStyle(
                                    fontFamily: ArabicFonts.El_Messiri,
                                    package: 'google_fonts_arabic',
                                    color: Color(0xFFE91E63),
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //address
                      new Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'العنوان',
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontFamily: ArabicFonts.El_Messiri,
                                  package: 'google_fonts_arabic',
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      EventSizedConstants.TextTitleFontSized,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 12.0,
                            ),
                            Expanded(
                              child: Text(
                                '${_modelSubFileds[0].addressText}',
                                style: TextStyle(
                                  fontFamily: ArabicFonts.El_Messiri,
                                  fontSize: 10.0,
                                  package: 'google_fonts_arabic',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //descriptions
                      new Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "الوصف",
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontFamily: ArabicFonts.El_Messiri,
                                  package: 'google_fonts_arabic',
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      EventSizedConstants.TextTitleFontSized,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "${_modelSubFileds[0].description}",
                                style: TextStyle(
                                    fontFamily: ArabicFonts.El_Messiri,
                                    package: 'google_fonts_arabic',
                                    fontSize: 10.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'النوع والخدمات',
                                style: TextStyle(
                                  color: Colors.pinkAccent,
                                  fontFamily: ArabicFonts.El_Messiri,
                                  package: 'google_fonts_arabic',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //committee
                      new Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "${_modelSubFileds[0].field}",
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontFamily: ArabicFonts.El_Messiri,
                                  package: 'google_fonts_arabic',
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      EventSizedConstants.TextTitleFontSized,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Align(
                        alignment: Alignment.topCenter,
                        child: Wrap(
                          spacing: 3.0,
                          runSpacing: 5.0,
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          children: getServiceList(_modelSubFileds[0].service)
                              .map((serviceType) => MyButton(
                                    serviceType,
                                  ))
                              .toList(),
                        ),
                      ),
                      new SizedBox(
                        width: 5.0,
                      ),
                      //map
                      new Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'الموقع',
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontFamily: ArabicFonts.El_Messiri,
                                  package: 'google_fonts_arabic',
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      EventSizedConstants.TextTitleFontSized,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: new MaterialButton(
                onPressed: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => CentersDepartment(
//                      ),
//                    ),
//                  );
                },
                color: Colors.brown,
                splashColor: Colors.brown[200],
                textColor: Colors.white,
                elevation: 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "إحجز الان",
                    style: TextStyle(
                      fontFamily: ArabicFonts.El_Messiri,
                      package: 'google_fonts_arabic',
                      fontSize: EventSizedConstants.TextButtonFontSized,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 8.0,
                          color: Color.fromARGB(125, 0, 0, 255),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 2.0,
            ),
            Expanded(
              child: new MaterialButton(
                onPressed: _showModalSheet,
                color: Colors.brown,
                splashColor: Colors.brown[200],
                textColor: Colors.white,
                elevation: 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "التقيمات",
                    style: TextStyle(
                      fontFamily: ArabicFonts.El_Messiri,
                      package: 'google_fonts_arabic',
                      fontSize: EventSizedConstants.TextButtonFontSized,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 8.0,
                          color: Color.fromARGB(125, 0, 0, 255),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Show Modal Sheet that Display all the #Rating about specific Fields
  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "التقيمات",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: ArabicFonts.El_Messiri,
                    color: Colors.white,
                    package: 'google_fonts_arabic',
                    fontSize: EventSizedConstants.TextappBarSize,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 8.0,
                        color: Color.fromARGB(125, 0, 0, 255),
                      ),
                    ]),
              ),
            ),
            body: new Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 3.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SmoothStarRating(
                        rating: 4.4,
                        size: 30,
                        color: Colors.yellow,
                        borderColor: Colors.grey,
                        starCount: 5,
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'التقييم الكلي',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: loading
                          ? Center(child: CircularProgressIndicator())
                          : _buildRatingList()),
                ],
              ),
            ),
          );
        });
  }

  /*
   *  here I just make Widget name it _buildRatingList
   *  to to fetch all the ratting and loop inside it
   */
  Widget _buildRatingList() {
    Widget _ratingList;

    if (_modelSubFileds[0].review.length > 0) {
      _ratingList = new ListView.builder(
        padding: EdgeInsets.all(1.0),
        itemExtent: 80.0,
        shrinkWrap: true,
        itemCount: _modelSubFileds[0].review.length,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: new Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  height: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: <Widget>[
                        new Container(
                          height: 50.0,
                          width: 50.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.fill,
                              placeholder: 'assets/avatar_person.png',
                              image: '${_modelSubFileds[0].review[0]['image']}',
                            ),
                          ),
                        ),
                        new SizedBox(
                          width: 5.0,
                        ),
                        new Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(0.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          '${_modelSubFileds[0].review[0]['reviewer']}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: ArabicFonts.El_Messiri,
                                            package: 'google_fonts_arabic',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'عدد التقيمات',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.green,
                                          fontFamily: ArabicFonts.El_Messiri,
                                          package: 'google_fonts_arabic',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        '${_modelSubFileds[0].review[0]['star']}',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.red,
                                          fontFamily: ArabicFonts.El_Messiri,
                                          package: 'google_fonts_arabic',
                                        ),
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          '${_modelSubFileds[0].review[0]['review']}',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.pinkAccent,
                                            fontFamily: ArabicFonts.El_Messiri,
                                            package: 'google_fonts_arabic',
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${_modelSubFileds[0].review[0]['created_at'].toString().substring(0, 10)}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: ArabicFonts.El_Messiri,
                                      package: 'google_fonts_arabic',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      _ratingList = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(Icons.hourglass_empty),
            ),
            Text(
              'عفواً لا توجد تقيمات الان!',
              style: TextStyle(
                  fontFamily: ArabicFonts.El_Messiri,
                  package: 'google_fonts_arabic',
                  fontSize: 20.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
    return _ratingList;
  }
}

class MyButton extends StatelessWidget {
  final text;

  MyButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      child: OutlineButton(
        padding: EdgeInsets.all(0.0),
        borderSide: BorderSide(color: Colors.brown, style: BorderStyle.solid),
        disabledBorderColor: Colors.grey,
        highlightedBorderColor: Colors.brown,
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
              fontSize: 8.0,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
