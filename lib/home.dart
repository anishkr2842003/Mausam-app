import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //new
  TextEditingController searchController = TextEditingController();

  // Sample data for auto-complete suggestions
  List<String> suggestions = [
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Hyderabad',
    'Chennai',
    'Kolkata',
    'Ahmedabad',
    'Pune',
    'Surat',
    'Jaipur',
    'Lucknow',
    'Kanpur',
    'Nagpur',
    'Indore',
    'Thane',
    'Bhopal',
    'Visakhapatnam',
    'Pimpri-Chinchwad',
    'Patna',
    'Vadodara',
    'Ghaziabad',
    'Ludhiana',
    'Agra',
    'Nashik',
    'Ranchi',
    'Faridabad',
    'Meerut',
    'Rajkot',
    'Kalyan-Dombivli',
    'Vasai-Virar',
    'Varanasi',
    'Srinagar',
    'Aurangabad',
    'Dhanbad',
    'Amritsar',
    'Navi Mumbai',
    'Allahabad',
    'Howrah',
    'Gwalior',
    'Jabalpur',
    'Coimbatore',
    'Vijayawada',
    'Jodhpur',
    'Madurai',
    'Raipur',
    'Kota',
    'Chandigarh',
    'Guwahati',
    'Solapur',
    'Hubli-Dharwad',
    'Bareilly',
    'Moradabad',
    'Nainital',
    'Shimla',
    'Darjeeling',
    'Ooty',
    'Kodaikanal',
    'Manali',
    'Munnar',
    'Almora',
    'Mussoorie',
    'Mount Abu',
    'Rishikesh',
    'Coonoor',
    'Yercaud',
    'Lansdowne',
    'Pachmarhi',
    'Khajjiar',
    'Chamba',
    'Lavasa',
    'Auli',
    'Matheran',
    'Bhandardara',
    'Ranikhet',
    'Chail',
    'Kasauli',
    'Gulmarg',
    'Pahalgam',
    'Gangtok',
    'Kalimpong',
    'Kurseong',
    'Mirik',
    'Siliguri',
    'Naggar',
    'Palampur',
    'Solan',
    'Dharamshala',
    'Dalhousie',
    'Rohru',
    'Kufri',
    'Dhanaulti',
    'Gangotri',
    'Yamunotri',
    'Badrinath',
    'Kedarnath',
    'Ranikhet',
    'Chamba',
    'Almora',
    'Pithoragarh',
  ];

  //new

  // TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? info =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    // value get and assign
    String temp = ((info?['temp_value']).toString()).substring(0, 2);
    String icon = info?['icon_value'];
    String city = ((info?['city_value']).toString()).toUpperCase();
    String humidity = info?['humidity_value'];
    String air_speed = ((info?['air_speed']).toString()).substring(0, 4);
    String description = info?['description'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: GradientAppBar(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue.shade800, Colors.blue.shade300]))),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue.shade800, Colors.blue.shade300])),
          child: SafeArea(
              child: Container(
            child: Column(
              children: [
                //search bar
                // Auto-complete search bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle search button tap
                          if ((searchController.text).replaceAll(" ", "") ==
                              "") {
                            print('Blank');
                          } else {
                            Navigator.pushReplacementNamed(context, "loading",
                                arguments: {
                                  "searchText": searchController.text,
                                });
                          }
                        },
                        child: Container(
                          child: CircleAvatar(
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return suggestions
                                .where((suggestion) => suggestion
                                    .toLowerCase()
                                    .contains(
                                        textEditingValue.text.toLowerCase()))
                                .toList();
                          },
                          onSelected: (String selected) {
                            // Handle selection of auto-complete suggestion
                            searchController.text = selected;
                          },
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted) {
                            return TextField(
                              controller: textEditingController,
                              focusNode: focusNode,
                              onSubmitted: (value) {
                                onFieldSubmitted();
                                // Handle search on submit
                                if (value.replaceAll(" ", "") != "") {
                                  Navigator.pushReplacementNamed(
                                      context, "loading",
                                      arguments: {
                                        "searchText": value,
                                      });
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search any city",
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                //container one
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  // padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/city3.gif'),
                          fit: BoxFit.cover,
                          opacity: 1),
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                          'https://openweathermap.org/img/wn/$icon@2x.png'),
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Text(
                              '$description',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              '$city',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //container two
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  padding: EdgeInsets.only(top: 30, right: 30, left: 30),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/temp.jpg'),
                          fit: BoxFit.cover),
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        WeatherIcons.thermometer,
                        size: 45,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        padding: EdgeInsets.all(40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$temp',
                              style: TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              '°C',
                              style: TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //container three and four
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      //container three
                      child: Container(
                        height: 200,
                        margin: EdgeInsets.only(left: 30, right: 5),
                        padding: EdgeInsets.only(top: 10, left: 10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/wind3.gif'),
                              fit: BoxFit.cover,
                              alignment: Alignment.topLeft,
                            ),
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  WeatherIcons.cloudy_windy,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 120,
                            ),
                            Text(
                              '$air_speed' ' ' 'Km/hr',
                              style: TextStyle(
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0, // shadow blur
                                      color: Colors.cyanAccent, // shadow color
                                      offset: Offset(2.0,
                                          2.0), // how much shadow will be shown
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      //container four
                      child: Container(
                        height: 200,
                        margin: EdgeInsets.only(right: 30, left: 5),
                        padding: EdgeInsets.only(top: 10, left: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage('assets/images/hum2.gif'),
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  WeatherIcons.humidity,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 90,
                            ),
                            Text(
                              '$humidity' '%',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0, // shadow blur
                                      color: Colors.cyanAccent, // shadow color
                                      offset: Offset(2.0,
                                          2.0), // how much shadow will be shown
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //bottom text
                Container(
                  padding: EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Text('Made By Anish Kumar'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Data Provided By Openweathermap.org'),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
