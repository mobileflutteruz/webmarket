import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:web_shop/presentation/home/web/whome/home_page_web.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 
 

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
        {}
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: GoogleFonts.manrope(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              const Gap(10),
              Text(
                'Please sign in to continue',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.left,
              ),
              const Gap(30),
              TextFielsWidget(
                controller: nameController,
                icon: Icon(Icons.person_2_outlined),
                label: "FULL NAME",
              ),
              const Gap(30),
              TextFielsWidget(
                  controller: emailController,
                  icon: Icon(Icons.email_outlined),
                  label: "EMAIL"),
              const Gap(30),
              TextFieldPassword(
                label: "Password ",
                controller: passwordController,
              ),
              const Gap(30),
              TextFieldPassword(
                label: "Confirm Password ",
                controller: confirmPasswordController,
              ),
              const Gap(30),
              SizedBox(
                height: 50,
                width: double.infinity, // Width to occupy full width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        )
                        .then((value) => {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HomeScreenWeb(),
                                ),
                              ),
                            });
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have a account?",
                style: GoogleFonts.manrope(
                  color: Colors.green,
                  // fontSize: 18.sp,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.manrope(
                      color: Colors.green,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldPassword extends StatelessWidget {
  final String label;
  TextEditingController controller;

  TextFieldPassword({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: label,
        labelStyle: GoogleFonts.manrope(fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixStyle: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TextFielsWidget extends StatelessWidget {
  final Icon icon;
  final String label;
  TextEditingController controller;

  TextFielsWidget({
    super.key,
    required this.controller,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon,
          labelText: label,
          labelStyle: GoogleFonts.manrope(fontSize: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
