import 'package:flutter/material.dart';
import 'package:flutter_dashboard/Responsive.dart';
import 'package:flutter_dashboard/model/health_model.dart';
import 'package:flutter_dashboard/widgets/custom_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_database/firebase_database.dart';

class ActivityDetailsCard extends StatefulWidget {
  @override
  _ActivityDetailsCardState createState() => _ActivityDetailsCardState();
}

class _ActivityDetailsCardState extends State<ActivityDetailsCard> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _database.child('sensordata').onValue, // Adjust with your actual data path
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.hasData && !snapshot.hasError && snapshot.data!.snapshot.value != null) {
          Map values = snapshot.data!.snapshot.value as Map;
          List<HealthModel> healthDetails = values.entries.map((e) => HealthModel.fromMap("./assets/svg/${e.key}.svg",e.key, e.value)).toList();
          return GridView.builder(
            itemCount: healthDetails.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
                crossAxisSpacing: !Responsive.isMobile(context) ? 15 : 12,
                mainAxisSpacing: 12.0),
            itemBuilder: (context, i) {
              return CustomCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(healthDetails[i].icon),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 4),
                      child: Text(
                        healthDetails[i].value,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      healthDetails[i].title,
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
  });
  }
}
