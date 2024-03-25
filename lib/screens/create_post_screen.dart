

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../repositories/post_respository.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({required this.email});
  final String email;
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  List<TextEditingController> controller = [];



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
    return ChangeNotifierProvider(create: (_)=>PostRepository.instance(),
      child: Consumer(builder: (_,PostRepository postRepo,child){
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Create a post'),
            centerTitle: true,
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

                            maxLines: null,
                            controller: postRepo.contentController,
                           // style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(

                              filled: false,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsetsDirectional.only(start: 10.0),



                              labelText: "What's on your mind today ?",

                              hintText: "What's on your mind today ?",
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


                      ],
                    )







                  ),



                  Container(
                    margin:const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: <Widget>[
                        postRepo.loading? Container(
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

/*
                                    taskRepo.createTask(widget.email).then((bool value){
                                     if(value){
                                       Navigator.of(context).pop();
                                     }else{
                                       taskRepo.showInSnackBar(context, 'An Error Occured While creating task');
                                     }
        }

                                      );
*/







                                  }

                                }, child: const Text('Create Post',style: TextStyle(fontWeight:FontWeight.bold, color: Colors.white),)),
                          ),
                        )

                      ],
                    ),
                  ),




                ],
              ),
            ),
          ),

        );
      },),);
  }
}