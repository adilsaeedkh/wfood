import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Stadiums extends StatefulWidget {
  @override
  _StadiumsState createState() => _StadiumsState();
}

class _StadiumsState extends State<Stadiums> {
  final globalKey = new GlobalKey<ScaffoldState>();

  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;
  final List serviceList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "سيارات",
        style: TextStyle(
          fontFamily: ArabicFonts.El_Messiri,
          package: 'google_fonts_arabic',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Column(
        children: <Widget>[
          Expanded(
            child: _buildmodelStadiumsList(),
          )
        ],
      ),
    );
  }

  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(
      color: Colors.black,
      fontFamily: ArabicFonts.El_Messiri,
      package: 'google_fonts_arabic',
      fontSize: 16.0,
    );
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: active,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
              color: Colors.red,
              elevation: 5.0,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "10+",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: ArabicFonts.El_Messiri,
                    package: 'google_fonts_arabic',
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildmodelStadiumsList() {
    Widget _carsList;
    if (serviceList.length > 0) {
      _carsList = ListView.builder(
        shrinkWrap: true,
        itemCount: serviceList.length,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              print('thisis taped to book page');
            },
            child: Card(
              elevation: 2,
              color: Colors.white.withOpacity(0.5),
              child: _buildFeaturedItem(
//                image: ,
//                name: ,
//                ratings: ,
//                stadiumsPrice:,
//                stadiumsArea: ,
                  ),
            ),
          );
        },
      );
    } else {
      _carsList = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(Icons.hourglass_empty),
            ),
            Text(
              "عفواً لا توجد سيارات للإجار الان",
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
    return _carsList;
  }

  Container _buildFeaturedItem(
      {String image,
      String name,
      String ratings,
      String stadiumsPrice,
      String stadiumsArea}) {
    return Container(
      height: MediaQuery.of(context).size.width * 2 / 4,
      width: double.infinity,
      child: Material(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/header.jpg',
                image: image,
                width: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height / 2,
              ),
            ),
            Positioned(
              bottom: 1.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                color: Colors.black.withOpacity(0.7),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        /// staduim name goes here
                        Container(
                          margin: EdgeInsets.only(right: 8.0, bottom: 5.0),
                          child: Text(
                            name,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8.0, bottom: 5.0),
                          child: Text(
                            stadiumsPrice == ""
                                ? "\$" + "\~50"
                                : "\$" + stadiumsPrice,
                            style: TextStyle(
                              color: Colors.green,
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.border_all,
                                size: 25,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                stadiumsArea,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                ),
                              ),
                            ],
                          ),
                        ),
                        ///////////// rating goes here 5 from left and also from bottom
                        Container(
                          margin: EdgeInsets.only(left: 5.0, bottom: 15.0),
                          child: SmoothStarRating(
                            rating: 3.5,
                            size: 15,
                            color: Colors.yellow,
                            borderColor: Colors.grey,
                            starCount: 5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }
}
