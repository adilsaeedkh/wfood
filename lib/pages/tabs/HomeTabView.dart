import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:wfoodalbayt/pages/DetailsPage.dart';
import 'package:wfoodalbayt/pages/fields/agency/AgencyCard.dart';
import 'package:wfoodalbayt/pages/fields/agency/fetchAgency.dart';
import 'package:wfoodalbayt/pages/fields/apartment/ApartmentRentalCard.dart';
import 'package:wfoodalbayt/pages/fields/apartment/fetchApartment.dart';
import 'package:wfoodalbayt/pages/fields/car/CarRentalCard.dart';
import 'package:wfoodalbayt/pages/fields/car/fetchCar.dart';
import 'package:wfoodalbayt/pages/fields/hotel/HotelCard.dart';
import 'package:wfoodalbayt/pages/fields/hotel/fetchHotel.dart';
import 'package:wfoodalbayt/pages/fields/trip/TripsCard.dart';
import 'package:wfoodalbayt/pages/fields/trip/fetchTrip.dart';
import 'package:wfoodalbayt/pages/widgets/Category.dart';
import 'package:wfoodalbayt/src/model/ModelAdds.dart';
import 'package:wfoodalbayt/src/model/ModelAgency.dart';
import 'package:wfoodalbayt/src/model/ModelApartmnetRental.dart';
import 'package:wfoodalbayt/src/model/ModelHotels.dart';
import 'package:wfoodalbayt/src/model/ModelRentalCar.dart';
import 'package:wfoodalbayt/src/model/ModelTrips.dar.dart';
import 'package:wfoodalbayt/static/APIConstants.dart';

class HomeTabView extends StatefulWidget {
  final Widget child;
  HomeTabView({Key key, this.child}) : super(key: key);
  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  /*
   *  We have defined a list from model
   *  model that contains
   *  all the details
   */
  List<AgencyElement> _modelAgencys = <AgencyElement>[];
  List<HotelElement> _modelHotels = <HotelElement>[];
  List<RentalCarElement> _modelRentalCar = <RentalCarElement>[];
  List<RentalApartmentElement> _modelRentalApartment =
      <RentalApartmentElement>[];
  List<TripElement> _modelTrip = <TripElement>[];
  List<AdsElement> _modelAds = <AdsElement>[];
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

  /*
   * Future for Hotel api
   * receives data from the internet
   * with the Model Hotel
   */
  Future<List<HotelElement>> getHotel() async {
    var res = await http.get(Uri.encodeFull(APIOP.HOTEL),
        headers: {"Accept": "application/json"});
    if (res.statusCode == APIRCODE.SC_OK) {
      var data = json.decode(res.body);
      var rest = data['hotel'] as List;
      setState(() {
        _modelHotels = rest
            .map<HotelElement>((rest) => HotelElement.fromJson(rest))
            .toList();
      });
      _loading = false;
    }
    return _modelHotels;
  }

  /*
   * Future for RentalCar api
   * receives data from the internet
   * with the Model RentalCar
   */
  Future<List<RentalCarElement>> getRentalCar() async {
    var res = await http.get(Uri.encodeFull(APIOP.CAR_RENTAL),
        headers: {"Accept": "application/json"});
    if (res.statusCode == APIRCODE.SC_OK) {
      var data = json.decode(res.body);
      var rest = data['car'] as List;

      setState(() {
        _modelRentalCar = rest
            .map<RentalCarElement>((rest) => RentalCarElement.fromJson(rest))
            .toList();
      });
      _loading = false;
    }
    return _modelRentalCar;
  }

  /*
   * Future for Rental Apartment api
   * receives data from the internet
   * with the Model Rental Apartment
   */
  Future<List<RentalApartmentElement>> getRentalApartment() async {
    var res = await http.get(Uri.encodeFull(APIOP.APARTMENT),
        headers: {"Accept": "application/json"});
    if (res.statusCode == APIRCODE.SC_OK) {
      var data = json.decode(res.body);
      var rest = data['apartment'] as List;
      setState(() {
        _modelRentalApartment = rest
            .map<RentalApartmentElement>(
                (rest) => RentalApartmentElement.fromJson(rest))
            .toList();
      });
      _loading = false;
    }
    return _modelRentalApartment;
  }

  /*
   * Future for Rental Apartment api
   * receives data from the internet
   * with the Model Rental Apartment
   */
  Future<List<TripElement>> getTrip() async {
    var res = await http.get(Uri.encodeFull(APIOP.TRIP),
        headers: {"Accept": "application/json"});
    if (res.statusCode == APIRCODE.SC_OK) {
      var data = json.decode(res.body);
      var rest = data['trip'] as List;
      setState(() {
        _modelTrip = rest
            .map<TripElement>((rest) => TripElement.fromJson(rest))
            .toList();
      });
      _loading = false;
    }
    return _modelTrip;
  }

  /*
   * Future for Rental Apartment api
   * receives data from the internet
   * with the Model Rental Apartment
   */
  Future<List<AdsElement>> getAds() async {
    var res = await http.get(Uri.encodeFull(APIOP.ADS),
        headers: {"Accept": "application/json"});
    if (res.statusCode == APIRCODE.SC_OK) {
      var data = json.decode(res.body);
      var rest = data['ads'] as List;
      setState(() {
        _modelAds =
            rest.map<AdsElement>((rest) => AdsElement.fromJson(rest)).toList();
      });
      _loading = false;
    }
    return _modelAds;
  }

  @override
  void initState() {
    super.initState();
    this.getAgency();
    this.getHotel();
    this.getRentalCar();
    this.getRentalApartment();
    this.getTrip();
    this.getAds();
    setState(() {
      _loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        /*
         * This the slider container
         * to fetch all the ads for the agency
         * or hotel or apartment or rental car
         * or for the services
         */
        Container(
          height: 200.0,
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _buildSlider(),
        ),

        /*
         * here we just show all
         * the category for the services
         */
        Container(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => FetchAgency(),
                    ),
                  );
                },
                child: Category(
                  backgroundColor: Color.fromRGBO(11, 200, 0, 0.15),
                  image: 'assets/grocery/vegetables.png',
                  title: "وكالات",
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => FetchHotel(),
                    ),
                  );
                },
                child: Category(
                  backgroundColor: Color.fromRGBO(200, 0, 11, 0.15),
                  title: "فنادق",
                  image: "assets/grocery/fruit.png",
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => FetchCar(),
                    ),
                  );
                },
                child: Category(
                  image: "assets/grocery/mortar.png",
                  backgroundColor: Color.fromRGBO(20, 20, 15, 0.15),
                  title: "سيارات",
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => FetchTrip(),
                    ),
                  );
                },
                child: Category(
                  backgroundColor: Color.fromRGBO(11, 200, 0, 0.15),
                  image: 'assets/grocery/safari.png',
                  title: "سفاري",
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => FetchApartment(),
                    ),
                  );
                },
                child: Category(
                  backgroundColor: Color.fromRGBO(200, 0, 11, 0.15),
                  title: "شقق",
                  image: "assets/grocery/home.png",
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        //Agency card
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                color: Colors.brown,
                child: Text(
                  "الوكالات",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: ArabicFonts.El_Messiri,
                    package: 'google_fonts_arabic',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => FetchAgency(),
                      ),
                    );
                  },
                  child: Text(
                    "عرض الكل",
                    style: TextStyle(
                      color: Colors.brown,
                      fontFamily: ArabicFonts.El_Messiri,
                      package: 'google_fonts_arabic',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 200.0,
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _agencyCard(),
        ),
        SizedBox(
          height: 10.0,
        ),
        //Hotel card
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                color: Colors.brown,
                child: Text(
                  "الفنادق",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: ArabicFonts.El_Messiri,
                    package: 'google_fonts_arabic',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => FetchHotel(),
                      ),
                    );
                  },
                  child: Text(
                    "عرض الكل",
                    style: TextStyle(
                      color: Colors.brown,
                      fontFamily: ArabicFonts.El_Messiri,
                      package: 'google_fonts_arabic',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 200.0,
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _hotelCard(),
        ),
        SizedBox(
          height: 10.0,
        ),
        //Rental Car card
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                color: Colors.brown,
                child: Text(
                  "تأجير السيارات",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: ArabicFonts.El_Messiri,
                    package: 'google_fonts_arabic',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => FetchCar(),
                      ),
                    );
                  },
                  child: Text(
                    "عرض الكل",
                    style: TextStyle(
                      color: Colors.brown,
                      fontFamily: ArabicFonts.El_Messiri,
                      package: 'google_fonts_arabic',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 200.0,
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _RentalCarCard(),
        ),
        SizedBox(
          height: 10.0,
        ),
        //Renter apartment  card
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                color: Colors.brown,
                child: Text(
                  "تأجير الشقق",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: ArabicFonts.El_Messiri,
                    package: 'google_fonts_arabic',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => FetchApartment(),
                      ),
                    );
                  },
                  child: Text(
                    "عرض الكل",
                    style: TextStyle(
                      color: Colors.brown,
                      fontFamily: ArabicFonts.El_Messiri,
                      package: 'google_fonts_arabic',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 200.0,
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _RentalApartmentCard(),
        ),
        SizedBox(
          height: 10.0,
        ),
        //Trips card
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                color: Colors.brown,
                child: Text(
                  "السفر والسياحة",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: ArabicFonts.El_Messiri,
                    package: 'google_fonts_arabic',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => FetchTrip(),
                      ),
                    );
                  },
                  child: Text(
                    "عرض الكل",
                    style: TextStyle(
                      color: Colors.brown,
                      fontFamily: ArabicFonts.El_Messiri,
                      package: 'google_fonts_arabic',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 200.0,
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _TripCard(),
        ),
      ],
    );
  }

  /*
   * We have created a Widget _agencyCard()
   * that passes data to an AgencyCard
   * Class to be passed to the user screen
   */
  Widget _agencyCard() {
    Widget _agency;
    if (_modelAgencys.length > 0) {
      _agency = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _modelAgencys.length,
        itemBuilder: (BuildContext context, index) {
          final _agencyObj = _modelAgencys[index];

          return GestureDetector(
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
            child: AgencyCard(
              "${_agencyObj.profileImg}",
              "${_agencyObj.name}",
              "${_agencyObj.field}",
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

  /*
   * We have created a Widget _hotelCard()
   * that passes data to an HotelCard
   * Class to be passed to the user screen
   */
  Widget _hotelCard() {
    Widget _agency;
    if (_modelHotels.length > 0) {
      _agency = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _modelHotels.length,
        itemBuilder: (BuildContext context, index) {
          final _agencyObj = _modelHotels[index];
          return GestureDetector(
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
            child: HotelCard(
              "${_agencyObj.profileImg}",
              "${_agencyObj.name}",
              "${_agencyObj.field}",
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
              "عفواً لا توجد فنادقً",
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

  /*
   * We have created a Widget _RentalCarCard()
   * that passes data to an RentalCarCard
   * Class to be passed to the user screen
   */
  Widget _RentalCarCard() {
    Widget _agency;
    if (_modelRentalCar.length > 0) {
      _agency = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _modelRentalCar.length,
        itemBuilder: (BuildContext context, index) {
          final _agencyObj = _modelRentalCar[index];
          return GestureDetector(
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
            child: CarRentalCard(
              "${_agencyObj.profileImg}",
              "${_agencyObj.name}",
              "${_agencyObj.field}",
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
              "عفواً لا توجد تأجير سيارات",
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

  /*
   * We have created a Widget _RentalApartmentCard()
   * that to pass the image to the
   * user screen to display it on the screen
   */
  Widget _RentalApartmentCard() {
    Widget _agency;
    if (_modelRentalApartment.length > 0) {
      _agency = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _modelRentalApartment.length,
        itemBuilder: (BuildContext context, index) {
          final _agencyObj = _modelRentalApartment[index];
          return GestureDetector(
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
            child: ApartmentRentalCard(
              "${_agencyObj.profileImg}",
              "${_agencyObj.name}",
              "${_agencyObj.field}",
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
              "عفواً لا توجد تأجير سيارات",
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

  /*
   * We have created a Widget _TripCard()
   * that to pass the image to the
   * user screen to display it on the screen
   */
  Widget _TripCard() {
    Widget _agency;
    if (_modelTrip.length > 0) {
      _agency = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _modelTrip.length,
        itemBuilder: (BuildContext context, index) {
          final _agencyObj = _modelTrip[index];
          return GestureDetector(
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
            child: TripsCard(
              "${_agencyObj.profileImg}",
              "${_agencyObj.name}",
              "${_agencyObj.field}",
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
              "عفواً لا توجد لا توجد وكالات سفر وسياحة",
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

  /*
   * We have created a Widget _buildSlider()
   * that to pass the image to the
   * user screen to display it on the screen
   */

  Widget _buildSlider() {
    Widget _ads;
    if (_modelAds.length > 0) {
      _ads = Container(
        padding: EdgeInsets.only(bottom: 0.0),
        height: 200.0,
        child: Container(
          child: Swiper(
            autoplay: true,
            pagination: new SwiperPagination(),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              final _adsObj = _modelAds[index];
              return Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: new FadeInImage.assetNetwork(
                      placeholder: "assets/logo.png",
                      image: _adsObj.image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.height,
                      height: 250.0,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black12,
                            Colors.black45,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 60.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${_adsObj.title.length > 100 ? _adsObj.title.substring(0, 99) : _adsObj.title}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: ArabicFonts.El_Messiri,
                                package: 'google_fonts_arabic',
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    } else {
      _ads = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(Icons.hourglass_empty),
            ),
            Text(
              "عفواً لا يوجد إعلانات الأن",
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
    return _ads;
  }
}
