import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';


import '../../models/Post.dart';

import 'package:timeago/timeago.dart' as timeago;


class ShimmerPostItem extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
Size size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.all(10),
        child:  Column(
          children: [

          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [

        Container(

        decoration: BoxDecoration(

        border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(100)
      ),
      child: ClipOval(
          child: ClipRRect(
            borderRadius:
            BorderRadius.circular(
                30),
            child:  Container(
              color: Colors.white,
              width: 40.0,
              height: 40.0,),
          )),
    ),
                Container(

                  margin: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Container(
                        width: size.width/3,
                        height: 15.0,
                        color: Colors.white,
                      ),

                    ],
                  ),
                ),


              ],
            ),
              Container(
              width: size.width/10,
              height: 12.0,
              color: Colors.white,
            ),
          ],
        ),

            Container(
                margin: EdgeInsets.only(top: 10),
                width: size.width,

                height: size.height/3.5,

                child: Row(
                  children: [
                    Flexible(
                      flex:1,
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:  Container(
                              width: size.width/2,
                              height: size.height/3.5,
                              color: Colors.white,
                            ),



                        ),
                      ),
                    ),
                    Flexible(
                      flex:1,
                      child: Container(
                        width: size.width/2,
                        height: size.height/3.5,


                        child: Column(
                          children: [
                           Container(
                             margin: EdgeInsets.only(bottom: 5),
                             child: ClipRRect(

                                    borderRadius: BorderRadius.circular(10),
                                  child: Container(

                                    color: Colors.white,

                                    width: size.width/2,

                                    height: size.height/7,

                                  )


                                ),
                           ),

                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(

                                  width: size.width/2,
                                  height: size.height/7.3,
                                  color: Colors.white,
                                )


                              ),

                          ],
                        ),
                      ),
                    )
                  ],
                )),

          Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: size.width/6,
                      height: 12.0,
                      color: Colors.white,
                    ),
                    Container(
                      width: size.width,
                      height: 25.0,
                      color: Colors.white,
                    )








                  ],
                ),
          ),






          ],
        ),

      );


  }
}