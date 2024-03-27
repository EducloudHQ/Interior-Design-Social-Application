

import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import '../repositories/post_respository.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: const Color(0xFFFF5ACD))
                            ),
                            margin: const EdgeInsets.only(top: 20),
                            child: TextFormField(

                              controller: postRepo.promptController,
                              onChanged: (String value){
                                if(value.isEmpty){
                                  postRepo.isGenerateBtnVissible = false;
                                }else{
                                  postRepo.isGenerateBtnVissible = true;
                                }


                              },


                              maxLines:2,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "write a prompt",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  )),



                            ),

                          ),

                        postRepo.base64ImageStrings.isEmpty?

                            Container():


                            
                            Container(
                              height: 300,
                              padding: EdgeInsets.only(top: 20),
                              child: GridView.builder(

                                itemCount:postRepo.base64ImageStrings.length ,

                                  gridDelegate:  SliverQuiltedGridDelegate(
                                crossAxisCount: 2,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                                repeatPattern: QuiltedGridRepeatPattern.inverted,
                                pattern: [

                                  QuiltedGridTile(1, 2),
                                  QuiltedGridTile(1, 1),



                                ],
                              ), itemBuilder: (BuildContext context, int index) {

                                return Image.memory(base64Decode(postRepo.base64ImageStrings[index],),


                                  fit: BoxFit.cover,);

                              },
                            ),),




                       postRepo.isGenerateBtnVissible ?
                       postRepo.isLoadingGeneratedImage ? Container(
                         padding: const EdgeInsets.only(top: 30.0),

                         child: const CircularProgressIndicator(),
                       ) :

                       InkWell(
                          onTap: (){



              postRepo.generateImage(postRepo.promptController.text).then((List<String> base64ImageString) {


                postRepo.base64ImageStrings = base64ImageString;
              });
                          },
                          child: Container(
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
                          ),
                        ) : SizedBox()


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
                                        child: Icon(Icons.cancel,color:Colors.white)),
                                    Text("clear",style: TextStyle(fontSize: 15,color:Colors.white),),
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


                                child: const CircularProgressIndicator(),
                              ) :
                              InkWell(
                                onTap: (){
                                  final FormState form = formKey.currentState!;
                                  if (!form.validate()) {

                                  } else {
                                    form.save();
                                    String userId = const Uuid().v4();
                                    postRepo.createPost(userId);



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


                                    child: const Text("Create Post",style: TextStyle(fontSize: 15),)),
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