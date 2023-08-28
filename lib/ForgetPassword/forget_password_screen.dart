import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Services/global_variables.dart';

class ForgetPassword extends StatefulWidget {


  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with TickerProviderStateMixin  {

  late Animation<double> _animation;
  late AnimationController _animationController;

  final TextEditingController _forgetPassTextController = TextEditingController(text: '');

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear)
      ..addListener(() {
        setState(() {

        });
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed)
        {
          _animationController.reset();
          _animationController.forward();
        }
      });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: forgetUrlImage,
            placeholder: (context, url) => Image.asset(
              'assets/images/wallpaper.jpg',
              fit: BoxFit.fill,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 55.0,
                    fontFamily: 'Signatra',
                  ),
                ),
                const SizedBox(height: 10.0,),
                const Text(
                  'Email Address',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 20.0,),
                TextField(
                  controller: _forgetPassTextController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white54,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
