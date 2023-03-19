

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../repositories/task_respository.dart';

class CreateTaskScreen extends StatefulWidget {
  CreateTaskScreen({required this.email});
  final String email;
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  List<TextEditingController> controller = [];
  Widget _listView(TaskRepository taskRepository) {
    return  ListView.builder(
          shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),

        itemCount: taskRepository.fields.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5),
            child: taskRepository.fields[index],
          );
        },
      );

  }

  Widget _addTile(TaskRepository taskRepository) {
    return ListTile(
      title: Text('add Tasks'),
     leading: Icon(Icons.add),
      onTap: () {
        final controller = TextEditingController();
        final field = TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: "name${taskRepository.controllers.length + 1}",
          ),
        );

          taskRepository.controller = controller;
         // taskRepository.controllers.add(controller);
          taskRepository.field = field;

      },
    );
  }


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(create: (_)=>TaskRepository.instance(),
      child: Consumer(builder: (_,TaskRepository taskRepo,child){
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: const Color(0xFF264653),

          appBar: AppBar(
            title: const Text('Create a task'),
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.secondary,

          ),
          body:

          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
              child: Column(
                children: [

                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child:Column(
                      children: [
                        Container(

                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(

                            controller: taskRepo.taskTitleController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(

                              filled: true,

                              border: OutlineInputBorder(

                                borderSide: BorderSide(color: (Colors.grey[700])!, width: 2),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(

                                borderSide: BorderSide(color: (Colors.grey[700])!, width: 2),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: (Colors.grey[700])!, width: 2),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              labelText: 'title',

                              labelStyle: TextStyle(color: Colors.white),
                              hintText: "title",
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'title';
                              }
                              return null;
                            },
                          ),

                        ),
                        Container(

                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(

                            controller: taskRepo.taskDescriptionController,
                            maxLines: 6,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(

                              filled: true,

                              border: OutlineInputBorder(

                                borderSide: BorderSide(color: (Colors.grey[700])!, width: 2),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(

                                borderSide: BorderSide(color: (Colors.grey[700])!, width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: (Colors.grey[700])!, width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              labelText: 'Description',

                              labelStyle: TextStyle(color: Colors.white),
                              hintText: "Description",
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Description';
                              }
                              return null;
                            },
                          ),

                        ),

                      ],
                    )







                  ),

                  _listView(taskRepo),

                  Container(
                    margin:const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: <Widget>[
                        taskRepo.loading? Container(
                          padding: const EdgeInsets.only(top: 30.0),

                          child: const CircularProgressIndicator(),
                        ) :
                        Container(
                          padding: const EdgeInsets.only(top: 50),
                          child: SizedBox(
                            width: size.width/1.1,
                            height:50,

                            child: ElevatedButton(

                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))

                                ),
                                onPressed: (){


                                  final FormState form = formKey.currentState!;
                                  if (!form.validate()) {

                                  } else {
                                    form.save();


                                    taskRepo.createTask(widget.email).then((bool value){
                                     if(value){
                                       Navigator.of(context).pop();
                                     }else{
                                       taskRepo.showInSnackBar(context, 'An Error Occured While creating task');
                                     }
        }

                                      );








                                  }

                                }, child: const Text('Create Task',style: TextStyle(fontWeight:FontWeight.bold, color: Colors.white),)),
                          ),
                        )

                      ],
                    ),
                  ),


                  _addTile(taskRepo),

                ],
              ),
            ),
          ),

        );
      },),);
  }
}