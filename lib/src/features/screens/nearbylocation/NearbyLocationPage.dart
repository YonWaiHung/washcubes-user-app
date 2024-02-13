import 'package:device_run_test/src/constants/colors.dart';
import 'package:device_run_test/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../home/home_screen.dart';
import 'NearbyLocationListPage.dart';
// import 'package:location/location.dart';

class NearbyLocationPage extends StatefulWidget {
  const NearbyLocationPage({Key? key}) : super(key: key);

  @override
  _NearbyLocationPageState createState() => _NearbyLocationPageState();
}

class _NearbyLocationPageState extends State<NearbyLocationPage> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(3.0649349689483643, 101.6168441772461);
  bool _infoWindowOpen = false;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: const MarkerId('marker_1'),
        position: const LatLng(3.1309800148010254, 101.62559509277344),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(
          title: 'Tropicana City Office Tower',
        ),
      ),
      Marker(
        markerId: const MarkerId('marker_2'),
        position: const LatLng(3.0649349689483643, 101.6168441772461),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(
          title: 'Taylor’s University',
        ),
      ),
      Marker(
        markerId: const MarkerId('marker_3'),
        position: const LatLng(3.0635976791381836, 101.6085433959961),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(
          title: 'Sunway Geo Residences',
        ),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nearby Locations',
          style: CTextTheme.blackTextTheme.displaySmall,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _infoWindowOpen = !_infoWindowOpen;
                });
                _showAlertDialog(context);
              },
              backgroundColor: AppColors.cBlueColor3,
              mini: true,
              child: const Icon(
                Icons.map,
                color: AppColors.cWhiteColor,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 13.0,
            ),
            markers: _createMarkers(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cBlueColor3,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const NearbyLocationListPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'List',
                        style: TextStyle(
                          color: AppColors.cWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select an action',
            style: CTextTheme.blackTextTheme.headlineMedium,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    // TODO: Implement action for "Open in Maps" here.
                  },
                  child: Text(
                    'Open in Maps',
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {
                    // TODO: Implement action for "Open in Waze" here.
                  },
                  child: Text(
                    'Open in Waze',
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                style: CTextTheme.blackTextTheme.headlineMedium,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the AlertDialog.
              },
            ),
          ],
        );
      },
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: NearbyLocationPage(),
//   ));
// }