import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mobile_app_flutter/constants/color_constants.dart';
import 'package:mobile_app_flutter/src/screens/user/cubit/user_flow/user_flow_bloc.dart';
import 'package:mobile_app_flutter/src/screens/user/cubit/user_flow/user_flow_event.dart';
import 'package:mobile_app_flutter/src/screens/user/cubit/user_flow/user_flow_state.dart';

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
    Future.microtask(() =>
        context.read<UserFlowBloc>().add(LoadUsersEvent(isInitialEvent: true)));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
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
      body: Stack(
        children: [
          BlocBuilder<UserFlowBloc, UserFlowState>(
            builder: (context, state) {
              if (state is UsersLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UsersSuccessState) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: state.data.length + (state.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.data.length) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final user = state.data[index];
                    return ListTile(
                      title: Text(user['name']),
                      subtitle: Text(user['email']),
                      leading: CircleAvatar(
                        backgroundImage: user['photo'] != null
                            ? NetworkImage(user['photo'])
                            : const AssetImage('assets/default_image.png')
                                as ImageProvider,
                      ),
                    );
                  },
                );
              } else if (state is UsersErrorState) {
                return Center(
                    child: Text("Error: ${state.failure.errorMessage}"));
              }
              return Container();
            },
          ),

          // Button Positioned at the Bottom
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                context
                    .read<UserFlowBloc>()
                    .add(LoadUsersEvent(isInitialEvent: true));
              },
              child: const Text(
                "Reload Users",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
