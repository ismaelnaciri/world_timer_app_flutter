import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments from the route
    data = data.isNotEmpty ? data : (ModalRoute.of(context)?.settings.arguments as Map?)!;

    // Display an error message if the data is null or not in the expected format
    if (data == null || data.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text("Error: Data is null or not in the expected format"),
        ),
      );
    }

    print("data : $data");

    String bgImage = data["isDaytime"] ? 'day.png' : 'night.png';
    Color? bgColor = data["isDaytime"] ? Colors.blue[300] : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/$bgImage"), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        "time": result["time"],
                        "location": result["location"],
                        "flag": result["flag"],
                        "isDaytime": result["isDaytime"]
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    "edit location",
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(data?["location"] ?? "Location not available",
                        style: TextStyle(
                            fontSize: 28.0,
                            letterSpacing: 2.0,
                            color: Colors.white)),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  data?["time"] ?? "Time not available",
                  style: TextStyle(
                      fontSize: 63.0,
                      color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
