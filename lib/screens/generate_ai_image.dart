import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:social_media/repositories/post_respository.dart';
import 'package:provider/provider.dart';
class GenerateAiImageScreen extends StatefulWidget {
  const GenerateAiImageScreen({super.key});

  @override
  State<GenerateAiImageScreen> createState() => _GenerateAiImageScreenState();
}

class _GenerateAiImageScreenState extends State<GenerateAiImageScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate ai image'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(create:(context) => PostRepository.instance(),
      child:Consumer(
        builder:(_,PostRepository postRepo, child){
          return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child:Row(
                        children: [


                          Flexible(
                            flex:1,
                            child: Container(

                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: const Color(0xFFFF5ACD))
                              ),
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(

                                controller: postRepo.promptController,


                                maxLines: 6,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "write your prompt",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    )),



                              ),

                            ),
                          ),

                          postRepo.base64ImageString.isEmpty?Flexible(
                              flex:2,
                              child: Container()):
                          Container(
                            margin: EdgeInsets.only(top: 20,left: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                                child:

                                  Image.memory(base64Decode(postRepo.base64ImageString),


                                    width: size.width/2,fit: BoxFit.cover,),
                                ),
                          ),


                        ],
                      )







                  ),

                 Container(
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

                            postRepo.generateImage(postRepo.promptController.text).then((String base64ImageString) {
                              postRepo.base64ImageString = base64ImageString;
                            });

                            }},
                          child: Container(
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
                        )





                      ],
                    ),
                  ),
                ],),
              )

          );
      },
      ))
    );
  }
}
