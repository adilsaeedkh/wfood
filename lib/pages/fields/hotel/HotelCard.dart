import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

/*
 * her we put a class HotelCard which
 * show you the cards for the product
 * on click on it tack you to another page details
 */
class HotelCard extends StatelessWidget {
  final String imagePath, AgencyName, AgencyField;
  HotelCard(this.imagePath, this.AgencyName, this.AgencyField);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Stack(
          children: <Widget>[
            Container(
              width: 160,
              height: 210,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/logo.png",
                image: imagePath,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              width: 160,
              height: 40,
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
              bottom: 10.0,
              width: 145,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AgencyName.length > 30
                            ? AgencyName.substring(0, 29)
                            : AgencyName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                        ),
                      ),
                    ],
                  ),
//                  Container(
//                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                    decoration: BoxDecoration(
//                        color: Colors.white,
//                        shape: BoxShape.rectangle,
//                        borderRadius: BorderRadius.all(Radius.circular(10))),
//                    child: Text(
//                      "${AgencyField}",
//                      style: TextStyle(
//                        color: Colors.black,
//                        fontSize: 14,
//                        fontFamily: ArabicFonts.El_Messiri,
//                        package: 'google_fonts_arabic',
//                      ),
//                    ),
//                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
