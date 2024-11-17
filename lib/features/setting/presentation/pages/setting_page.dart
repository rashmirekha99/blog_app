import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/utils/show_snack_bar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/setting/presentation/widgets/setting_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constant.navBarSettingText),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.messsage);
          } else if (state is AuthLogOutSucess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/sign_in', (Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return Column(
            spacing: 20,
            children: [
              SettingCardItem(
                icon: Icons.color_lens,
                name: 'Theme',
                onPress: () {},
              ),
              SettingCardItem(
                icon: Icons.logout_outlined,
                name: Constant.logOutButtonName,
                onPress: () {
                  context.read<AuthBloc>().add(AuthLogOutUser());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
