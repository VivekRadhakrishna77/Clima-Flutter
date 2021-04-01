//import 'dart:html';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:clima/services/address_search.dart';
import 'package:clima/services/place_service.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

String apiKey = 'API';

class _CityScreenState extends State<CityScreen> {
  String cityName;
  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';
  _getLatLng(Prediction prediction) async {
    GoogleMapsPlaces _places =
        new GoogleMapsPlaces(apiKey: apiKey); //Same API_KEY as above
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(prediction.placeId);
    double latitude = detail.result.geometry.location.lat;
    double longitude = detail.result.geometry.location.lng;
    String address = prediction.description;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.place,
                size: 250,
                color: Colors.lightBlue,
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: TextField(
                    controller: _controller,
                    readOnly: true,
                    onChanged: (value) {
                      cityName = value;
                    },
                    onTap: () async {
                      // generate a new token here
                      final sessionToken = Uuid().v4();
                      final Suggestion result = await showSearch(
                        context: context,
                        delegate: AddressSearch(sessionToken),
                      );
                      // This will change the text displayed in the TextField
                      if (result != null) {
                        final placeDetails =
                            await PlaceApiProvider(sessionToken)
                                .getPlaceDetailFromId(result.placeId);
                        setState(() {
                          _controller.text = result.description;
                          _streetNumber = placeDetails.streetNumber;
                          _street = placeDetails.street;
                          _city = placeDetails.city;
                          _zipCode = placeDetails.zipCode;
                        });
                      }
                      /*Prediction prediction = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: apiKey,
                          mode: Mode.overlay, // Mode.overlay

                          language: "en",
                          components: [Component(Component.country, "UK")]);*/
                    },
                    enableInteractiveSelection: true,
                    enableSuggestions: true,
                    decoration: inputDecoration,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Center(
                  child: Text(
                    'Get Weather',
                    style: kButtonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
