import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode
          ? const Color.fromARGB(255, 168, 172, 125)
          : Colors.grey[300],
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgimage.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 100)),
            const Text('data'),
            Expanded(
              child: Center(
                child: Container(
                  width: 280,
                  height: 480,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: darkMode
                            ? const Color.fromARGB(52, 0, 0, 0)
                            : const Color.fromARGB(146, 254, 250, 224),
                        offset: const Offset(8, 8),
                        blurRadius: 20,
                      ),
                      BoxShadow(
                        color: darkMode
                            ? const Color.fromARGB(172, 238, 241, 213)
                            : const Color.fromARGB(100, 0, 0, 0),
                        offset: const Offset(-8, -8),
                        blurRadius: 20,
                      ),
                    ],
                    color: darkMode
                        ? const Color.fromARGB(255, 168, 172, 125)
                        : const Color.fromARGB(255, 254, 250, 224),
                  ),
                  child: Icon(
                    Icons.android,
                    size: 80,
                    color: darkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
