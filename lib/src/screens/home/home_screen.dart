import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mobile_app_flutter/constants/color_constants.dart';
import 'package:mobile_app_flutter/src/screens/user/cubit/user_flow/user_flow_bloc.dart';
import 'package:mobile_app_flutter/src/screens/user/user_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});
  static const route = "/";
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        title: Text(
          'Home Page',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo_image.jpeg',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Selamat Datang di Aplikasi Mobile Salam Enterprise',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: ColorConstants.primaryColor),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<UserFlowBloc>(context),
                      child: UserPageScreen(),
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Go to Second Page",
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    LucideIcons.chevronRight,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
