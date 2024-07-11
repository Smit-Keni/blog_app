import 'dart:ui';

import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class authButton extends StatelessWidget {
final String msg;
final VoidCallback onPressed;
  const authButton(
      {super.key,required this.msg, required this.onPressed}
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppPallete.gradient1,
          AppPallete.gradient2
        ],
        begin: Alignment.topLeft,
          end: Alignment.bottomRight
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(onPressed: onPressed ,


          style: ElevatedButton.styleFrom(
            fixedSize: const Size(395,55),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        child:Text(msg, style:const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600
        ),)),
    );
  }
}
