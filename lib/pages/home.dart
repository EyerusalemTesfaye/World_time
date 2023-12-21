import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    // data = arguments as Map;
    // print(data);
    String bgImage = 'day.jpg';
    Color? bgcolor;
    if (arguments is Map<dynamic, dynamic>) {
      data = data.isNotEmpty ? data : arguments;
      print(data);
      bgImage = data['isDaytime'] ? 'day.jpg' : 'night.jpg';
      bgcolor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];
      // Use data Map as needed here
    } else {}
    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: <Widget>[
              ElevatedButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    if (result != null) {
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'flag': result['flag'],
                          'isDaytime': result['isDaytime']
                        };
                      });
                    }
                  },
                  icon: Icon(
                    Icons.edit_location,
                  ),
                  label: Text(
                    'Edit Locattion',
                  )),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                data['time'],
                style: TextStyle(fontSize: 66.0, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
