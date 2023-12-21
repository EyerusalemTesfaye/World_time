import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(location: 'London', flag: 'uk.png', url: 'Europe/London'),
    WorldTime(location: 'Berlin', flag: 'berlin.png', url: 'Europe/Berlin'),
    WorldTime(location: 'Cairo', flag: 'cairo.png', url: 'Africa/Cairo'),
    WorldTime(location: 'Nairobi', flag: 'nairobi.jpg', url: 'Africa/Nairobi'),
    WorldTime(location: 'Chicago', flag: 'chicago.png', url: 'America/Chicago'),
    WorldTime(location: 'New York', flag: 'new.png', url: 'America/New_York'),
    WorldTime(location: 'Seoul', flag: 'seoul.png', url: 'Asia/Seoul'),
    WorldTime(location: 'Jakarta', flag: 'jakarta.png', url: 'Asia/Jakarta'),
  ];
  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Choose Location',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/${locations[index].flag}')),
              ),
            ),
          );
        },
        itemCount: locations.length,
      ),
    );
  }
}
