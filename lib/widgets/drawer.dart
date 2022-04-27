import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:note_it/provider/authProvider.dart';
import 'package:note_it/screens/profileScreen.dart';
import 'package:note_it/screens/signInScreen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(25)
      ),
      child: Drawer(
        width: MediaQuery.of(context).size.width-150,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                child: Consumer(
                  builder:(context, ref, child) {
                    final authWatch = ref.watch(authProvider);
                    return authWatch.when(data: (data){
                      if (data == null){
                        return  TextButton(
                          onPressed: () {
                            Get.to(()=> SignUp());
                          },
                          child: Text(
                            'Sign up to my Notes',
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                          ),
                        );
                      }else{
                        return TextButton(
                          onPressed: () {
                            Get.to(()=> SignUp());
                          },
                          child: Text(
                            'Hello username',
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                          ),
                        );
                      }
                    }, error: (err, stack) => Text('$err'), loading: ()=> CircularProgressIndicator());


                  }
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.sticky_note_2_outlined),
                title: Text('All notes'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.star),
                title: Text('Favorite notes'),
              ),
              ListTile(
                onTap: () {},
                title: Text('Archived notes'),
                leading: Icon(Icons.archive_outlined),
              ),
              ListTile(
                onTap: () {},
                title: Text('Premium'),
                  leading: Icon(Icons.workspace_premium)

              ),
              ListTile(
                onTap: () {},
                title: Text('Night Mode'),
                  leading: Icon(Icons.shield_moon_rounded)

              ),
              ListTile(
                onTap: () {},
                title: Text('About'),
                  leading: Icon(Icons.report)

              ),
            ],
          ),
        ),
      ),
    );
  }
}
