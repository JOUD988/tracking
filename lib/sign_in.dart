import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tracking/driver_map.dart';
import 'package:tracking/parent_map.dart';


class SignIn extends StatelessWidget {

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: myController,
            ),
            TextButton(onPressed: (){
              if(myController.text == "1") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ParentMap()),
                );

                //Get.to(ParentMap());
                }
                if(myController.text == "2") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  DriverMap("user1")),
                  );
                  //Get.to(DriverMap("user1"));
                }
              }, child: Text("OK"))
          ],
        ),

    );
  }
}
