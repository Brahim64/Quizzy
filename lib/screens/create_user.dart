import 'package:flutter/material.dart';
import 'package:quizzy/core/supabase_client.dart';
import 'package:quizzy/screens/create_room.dart';
import 'package:quizzy/services/user_local_storage.dart';
import 'package:quizzy/utils/generation.dart';
import 'package:quizzy/widgets/app_background.dart';
import 'package:quizzy/widgets/player_profile.dart';
import 'package:quizzy/services/user_service.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final supabase = SupabaseService.client;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  /*final List<String> userpics=[
    "assets/images/userpic1.png",
    "assets/images/userpic2.png",
    "assets/images/userpic3.jpg",
    "assets/images/userpic4.jpg",
  ];*/
  final Map<int,String> userpics={
    0:"assets/images/userpic1.png",
    1:"assets/images/userpic2.png",
    5:"assets/images/userpic6.png",
    6:"assets/images/userpic7.png",
    7:"assets/images/userpic8.png",
    8:"assets/images/userpic9.png",
  };

  int currentpic=0;

  void nextPic(){
    setState(() {
      currentpic=(currentpic+1)% userpics.length;
    });
  }
  void previousPic(){
    setState(() {
      currentpic=(currentpic-1+userpics.length)% userpics.length;
    });
  }
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousPic,
                  icon: const Icon(Icons.arrow_circle_left,color: Colors.white,size: 40,),
                ),
                SizedBox(width: 10,),
                Image.asset(
                  userpics[currentpic]!,
                  width: 100,
                  height: 100,
                ),
                SizedBox(width: 10,),
                IconButton(
                  onPressed: nextPic,
                  icon: const Icon(Icons.arrow_circle_right,color: Colors.white,size: 40,),
                ),
              ],
            ),

            const SizedBox(height: 80),

            Center(
              child: SizedBox(
                width: 300,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        style: TextStyle(color: Colors.white,),
                        
                        cursorOpacityAnimates: true,
                        cursorColor: Colors.yellow,
                        decoration: const InputDecoration(
                          hintText: "Enter your name",
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          filled: true,
                          fillColor: Colors.grey,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () async{
                          int roomId=generateFourDigitNumber();
                          if (_formKey.currentState?.validate() ?? false) {
                            print(nameController.text);
                            print(roomId);
                            print(currentpic);

                          }

                          final player=await createPlayer({
                            'name':nameController.text,
                            'avatar_id':currentpic,
                            'status':true,
                            'room_id':roomId
                          });
                          UserLocalStorage.saveUser(player);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateRoom()),
                          );
                        },
                        child: const Text("Continue"),
                      ),
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
