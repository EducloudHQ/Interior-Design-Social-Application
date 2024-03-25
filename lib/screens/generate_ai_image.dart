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
        title: Text('Generate ai image'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(create:(context) => PostRepository.instance(),
      child:Consumer(
        builder:(_,PostRepository postRepo, child){
          return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child:Column(
                        children: [


                          Container(

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



                        ],
                      )







                  ),

                  postRepo.base64ImageString.isEmpty?Container(): Image.memory(base64Decode(postRepo.base64ImageString),width: size.width,fit: BoxFit.cover,),
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
