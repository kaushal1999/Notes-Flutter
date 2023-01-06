import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/widgets/rounded_button.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String dateTime = DateTime.now().toLocal().toString();
  String selectColor = "0XFFe63946";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Color(0XFFAD6C98),
        title: Text('Add your Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 25.0,
                  left: 10,
                ),
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          // color: Theme.of(context).accentColor,
                          ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          // color: Theme.of(context).primaryColor,
                          ),
                    ),
                    hintText: 'title',
                  ),
                  // style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                  right: 25.0,
                  left: 10,
                ),
                child: TextFormField(
                  maxLines: 9,
                  expands: false,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          // color: Theme.of(context).accentColor,
                          ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          // color: Theme.of(context).primaryColor,
                          ),
                    ),
                    hintText: 'description',
                  ),
                  // style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                  right: 25.0,
                  left: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          selectColor = "0XFFe63946";
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0XFFe63946),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          selectColor = "0XFFfb8500";
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0XFFfb8500),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          selectColor = "0XFFa8dadc";
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0XFFa8dadc),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          selectColor = "0XFF457b9d";
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0XFF457b9d),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          selectColor = "0XFF1d3557";
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0XFF1d3557),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          selectColor = "0XFFbc6c25";
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0XFFbc6c25),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: 50,
                child: Divider(
                  thickness: 5,
                  color: Color(
                    int.parse(selectColor),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(
                  right: 25.0,
                  left: 10,
                ),
                child: RoundedButtonWidget(
                  buttonText: 'Add Note',
                  width: MediaQuery.of(context).size.width * 0.90,
                  onpressed: () async {
                    await supabase.from('notes').insert([
                      {
                        'email': supabase.auth.currentUser?.email,
                        'title': titleController.text,
                        'content': _descriptionController.text,
                        'date_time': dateTime,
                        'color': selectColor,
                        // 'year': year,
                        // 'month': month,
                        // 'date': date,
                        // 'hr': hr,
                        // 'mins': mins,
                      }
                    ]);

                    _descriptionController.text = "";
                    titleController.text = "";
                    context.showSnackBar(message: "Successfully inserted!");
                    // Navigator.pushNamedAndRemoveUntil(
                    // context, '/home', (route) => false);
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
