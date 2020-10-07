import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:wfoodalbayt/src/model/ModelOffers.dart';
import 'package:wfoodalbayt/static/APIConstants.dart';

import '../DetailsPageSubFields.dart';

class OfferlistTabView extends StatefulWidget {
  @override
  _OfferlistTabViewState createState() => _OfferlistTabViewState();
}

class _OfferlistTabViewState extends State<OfferlistTabView> {
  /*
   *  We have defined a list from model
   *  model that contains
   *  all the details
   */
  List<OffersElement> _modelOfferss = <OffersElement>[];
  /*
   * We have created a Future
   * that receives data from the
   * Internet and passes it to
   * the model for processing
   */
  bool _loading = false;
  /*
   * Future for Agency api
   * receives data from the internet
   * with the Model Agency
   */
  Future<List<OffersElement>> getOfferss() async {
    var res = await http.get(Uri.encodeFull(APIOP.OFFERS),
        headers: {"Accept": "application/json"});
    if (res.statusCode == APIRCODE.SC_OK) {
      var data = json.decode(res.body);
      var rest = data['offers'] as List;

      setState(() {
        _modelOfferss = rest
            .map<OffersElement>((rest) => OffersElement.fromJson(rest))
            .toList();
      });

      _loading = false;
    }
    return _modelOfferss;
  }

  @override
  void initState() {
    super.initState();
    this.getOfferss();
    setState(() {
      _loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildOffersList(),
    );
  }

  Widget _buildOffersList() {
    Widget _offers;
    if (_modelOfferss.length > 0) {
      _offers = ListView.builder(
        padding: EdgeInsets.all(6),
        itemCount: _modelOfferss.length,
        itemBuilder: (BuildContext context, int index) {
          var _offersObj = _modelOfferss[index];

          return GestureDetector(
            onTap: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (BuildContext context) => DetailsPageSubFields(
//                    subfieldId: _offersObj.subfieldId,
//                  ),
//                ),
//              );
            },
            child: Card(
              elevation: 0.0,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 125,
                    width: 120,
                    padding: EdgeInsets.only(
                        left: 0, top: 10, bottom: 70, right: 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(_offersObj.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: _offersObj.discount == null
                        ? Container()
                        : Container(
                            color: Colors.deepOrange,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "التخفيض",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: ArabicFonts.El_Messiri,
                                    package: 'google_fonts_arabic',
                                  ),
                                ),
                                Text(
                                  "${_offersObj.discount}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: ArabicFonts.El_Messiri,
                                    package: 'google_fonts_arabic',
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _offersObj.title.substring(0, 20),
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                          ),
                        ),
                        Text(
                          "catagory",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                          ),
                        ),
                        Text(
                          "place",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "ratings",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: ArabicFonts.El_Messiri,
                                package: 'google_fonts_arabic',
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "التقييم",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: ArabicFonts.El_Messiri,
                                package: 'google_fonts_arabic',
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      _offers = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(Icons.hourglass_empty),
            ),
            Text(
              "عفواً لا يوجد عروض حتى الأن",
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
    return _offers;
  }
}
