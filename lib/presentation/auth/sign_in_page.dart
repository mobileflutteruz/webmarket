import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:web_shop/presentation/home/web/whome/home_page_web.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailAddressController = TextEditingController();
    TextEditingController _passwordAddressController = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
        
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
                'Login',
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
              TextField(
                controller: _emailAddressController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const Gap(20),
              TextFormField(
                controller: _passwordAddressController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot?',
                        style: GoogleFonts.manrope(
                          color: Colors.green,
                        ),
                      )),
                  suffixStyle: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailAddressController.text,
                        password: _passwordAddressController.text).then((value) => {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreenWeb(),),),
                        });
                  },
                  child: Text(
                    'Sign In',
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
