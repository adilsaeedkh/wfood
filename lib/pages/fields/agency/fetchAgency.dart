import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:wfoodalbayt/pages/DetailsPage.dart';
import 'package:wfoodalbayt/src/model/ModelAgency.dart';
import 'package:wfoodalbayt/static/APIConstants.dart';
import 'package:wfoodalbayt/ui_widgets/SizedText.dart';

class FetchAgency extends StatefulWidget {
  @override
  _FetchAgencyState createState() => _FetchAgencyState();
}

class _FetchAgencyState extends State<FetchAgency> {
  /*
   *  We have defined a list from model
   *  model that contains
   *  all the details
   */
  List<AgencyElement> _modelAgencys = <AgencyElement>[];
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
  Future<List<AgencyElement>> getAgency() async {
    var res = await http.get(Uri.encodeFull(APIOP.AGENCY),
        headers: {"Accept": "application/json"});
    if (res.statusCode == APIRCODE.SC_OK) {
      var data = json.decode(res.body);
      var rest = data['agency'] as List;
      setState(() {
        _modelAgencys = rest
            .map<AgencyElement>((rest) => AgencyElement.fromJson(rest))
            .toList();
      });
      _loading = false;
    }
    return _modelAgencys;
  }

  @override
  void initState() {
    super.initState();
    this.getAgency();
    setState(() {
      _loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'وكالات السفر والسياحة',
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            fontSize: EventSizedConstants.TextappBarSize,
            fontWeight: FontWeight.bold,
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _buildCenters(),
      ),
    );
  }

  Widget _buildCenters() {
    Widget _agency;
    if (_modelAgencys.length > 0) {
      _agency = ListView.builder(
        itemCount: _modelAgencys.length,
        itemBuilder: (BuildContext context, index) {
          final _agencyObj = _modelAgencys[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => DetailsPage(
                    id: _agencyObj.id,
                    fieldId: _agencyObj.fieldId,
                    field: _agencyObj.field,
                    cityId: _agencyObj.cityId,
                    cityName: _agencyObj.cityName,
                    name: _agencyObj.name,
                    description: _agencyObj.description,
                    addressText: _agencyObj.addressText,
                    latitude: _agencyObj.latitude,
                    longitude: _agencyObj.longitude,
                    service: _agencyObj.service,
                    review: _agencyObj.review,
                    rating: _agencyObj.rating,
                    profileImg: _agencyObj.profileImg,
                    isActive: _agencyObj.isActive,
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 0.0),
              height: 190.0,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    child: Stack(
                      children: <Widget>[
                        FadeInImage.assetNetwork(
                          placeholder: "assets/logo.png",
                          image: "${_agencyObj.profileImg}",
                          fit: BoxFit.cover,
                          width: 1000,
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black,
                                  Colors.black12,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          right: 10,
                          bottom: 10.0,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${_agencyObj.name.length > 30 ? _agencyObj.name.substring(0, 29) : _agencyObj.name}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1,
                                      fontFamily: ArabicFonts.El_Messiri,
                                      package: 'google_fonts_arabic',
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text(
                                  "${_agencyObj.field}",
                                  style: TextStyle(
                                    color: Color(0xFF0082B1),
                                    fontSize: 14,
                                    fontFamily: ArabicFonts.El_Messiri,
                                    package: 'google_fonts_arabic',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          left: 5.0,
                          top: 1.0,
                          child: SmoothStarRating(
                            rating: _agencyObj.rating,
                            size: 30,
                            color: Colors.yellow,
                            borderColor: Colors.black54,
                            starCount: 5,
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
      _agency = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(Icons.hourglass_empty),
            ),
            Text(
              "عفواً لا توجد وكالات حالياً",
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
    return _agency;
  }
}
