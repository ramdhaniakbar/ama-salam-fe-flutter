import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mobile_app_flutter/constants/color_constants.dart';
import 'package:mobile_app_flutter/src/screens/user/cubit/user_flow/user_flow_bloc.dart';
import 'package:mobile_app_flutter/src/screens/user/cubit/user_flow/user_flow_event.dart';

class UserPageScreen extends StatefulWidget {
  const UserPageScreen({super.key});
  @override
  State<UserPageScreen> createState() => _UserPageScreenState();
}

class _UserPageScreenState extends State<UserPageScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<UserFlowBloc>().add(LoadUsersEvent(isInitialEvent: true)));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<UserFlowBloc>().add(LoadUsersEvent());
      }
    });
  }

  Future _refresh() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Users Page',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            LucideIcons.chevronLeft,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo_image.jpeg',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20,),
            Text(
              'Selamat Datang di Aplikasi Mobile Salam Enterprise',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
