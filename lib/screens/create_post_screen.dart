

import 'package:flutter/cupertino.dart';
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
                                return "What's on your mind today ?";
                              }
                              return null;
                            },
                          ),

                        ),

                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Container(
                                width:50,
                                height: 50,


                                decoration: const BoxDecoration(
                                    shape:BoxShape.circle,
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment(0.8, 1),
                                        colors: [
                                          Color(0xFFFBDA61),
                                          Color(0xFFFF5ACD),

                                        ]

                                    )
                                ),
                                child: Image.asset('assets/bedrock.png',width: 50, height: 50,),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: const Text('Click to generate ai image',style: TextStyle(fontSize: 17),),
                              )
                            ],
                          ),
                        )


                      ],
                    )







                  ),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: InkWell(
                          onTap: (){
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


                            }},
                          child:  Container(

                                padding: const EdgeInsets.symmetric(vertical: 20),
                                margin: const EdgeInsets.only(right: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF30343F),
                                  borderRadius: BorderRadius.circular(50)
                                ),


                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                       padding: EdgeInsets.only(right: 5),
                                        child: Icon(Icons.cancel)),
                                    Text("clear",style: TextStyle(fontSize: 15),),
                                  ],
                                )),

                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          margin:const EdgeInsets.only(bottom: 20,top: 20),
                          child: Column(
                            children: <Widget>[
                              postRepo.loading? Container(
                                padding: const EdgeInsets.only(top: 30.0),

                                child: const CircularProgressIndicator(),
                              ) :
                              InkWell(
                                onTap: (){
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


                                  }},
                                child: Container(
                                    width: size.width/1.2,
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    alignment: Alignment.center,
                                    decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment(0.8, 1),
                                            colors: [
                                              Color(0xFFFBDA61),
                                              Color(0xFFFF5ACD),

                                            ]

                                        )
                                    ),


                                    child: Text("Create Post",style: TextStyle(fontSize: 15),)),
                              )





                            ],
                          ),
                        ),
                      ),
                    ],
                  )




                ],
              ),
            ),
          ),

        );
      },),);
  }
}