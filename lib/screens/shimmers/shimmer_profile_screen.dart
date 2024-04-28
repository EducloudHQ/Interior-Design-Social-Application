import 'package:flutter/material.dart';

class ShimmerProfileScreen extends StatelessWidget {
  const ShimmerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.start,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
             ClipRRect(
                      borderRadius:
                      BorderRadius.circular(100),
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Colors.white,

                            ),
                      ),


              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width/4,
                        height: 20,
                        color: Colors.white,

                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: size.width/8,
                        height: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
             Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white),

                ),

            ],
          ),
          Container(
            padding:
            EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child:Row(
                    children: [
                     Container(
                       width: size.width/10,
                       height: 20,
                       color: Colors.white,

                      ),
                      Text(' '),
                      Container(
                        width: size.width/6,
                        height: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Container(
                  child:Row(
                    children: [
                      Container(
                        width: size.width/10,
                        height: 20,
                        color: Colors.white,

                      ),
                      Text(' '),
                      Container(
                        width: size.width/6,
                        height: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Container(
                  child:Row(
                    children: [
                      Container(
                        width: size.width/10,
                        height: 20,
                        color: Colors.white,

                      ),
                      Text(' '),
                      Container(
                        width: size.width/6,
                        height: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.start,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                 Container(
                   width: size.width/10,
                   height: 20,
                   color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                    width: size.width,
                    height: size.height/4,
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
