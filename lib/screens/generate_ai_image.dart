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


                            maxLines: null,
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
                Container(
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


                            child: const Text("Generate Image",style: TextStyle(fontSize: 15),)),
                      )





                    ],
                  ),
                ),
              ],)

          );
      },
      ))
    );
  }
}
