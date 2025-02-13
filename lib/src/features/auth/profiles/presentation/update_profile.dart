import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:livine/src/features/auth/profiles/presentation/profile.dart';
import 'package:livine/src/common_widgets/auth/auth_widget.dart';
import 'package:livine/src/translations/locale_keys.g.dart';

import '../../application/auth_service.dart';
import '../../../get_recipes/application/vegan_service.dart';
import '../../../../shared/styles/lib_color_schemes.g.dart';
import '../data/get_user_data.dart';

class UpdateProfile extends ConsumerStatefulWidget {
  const UpdateProfile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends ConsumerState<UpdateProfile> {
  Client client = http.Client();
  final username = TextEditingController();
  final email = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isVeg = ref.watch(isVeganProvider);

    final data = ref.watch(userDataProvider).value;

    username.text = data?.username ?? "";
    email.text = data?.email ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.update.tr(),
            style: TextStyle(
              fontFamily: context.locale.languageCode == "en"
                  ? 'Kine'
                  : GoogleFonts.notoKufiArabic().fontFamily,
            )),
        centerTitle: true,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? darkColorScheme.background
            : lightColorScheme.secondaryContainer,
      ),
      body: Column(children: [
        UserInfo(
          name: "",
          image: 'assets/images/profile/default.png',
        ),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                authFormField(
                    context: context,
                    controller: username,
                    text: LocaleKeys.username.tr(),
                    setState: setState,
                    validator: (u) {
                      if (u!.isEmpty) {
                        return "Please enter your username";
                      } else if (u.length >= 20) {
                        return "Username shouldn't be more than 20 characters";
                      }
                      return null;
                    },
                    obscureText: false),
                SizedBox(
                  height: 30,
                ),
                authFormField(
                    context: context,
                    controller: email,
                    text: context.locale.languageCode == "en"
                        ? "Email"
                        : "البريد الإلكتروني",
                    setState: setState,
                    validator: (e) {
                      if (e!.isEmpty) {
                        return context.locale.languageCode == "en"
                            ? "Please enter your email"
                            : "من فضلك ادخل البريد الاكتروني";
                      }

                      return null;
                    },
                    obscureText: false),
              ],
            ),
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn3',
        onPressed: () {
          ref
              .read(authHelperProvider)
              .updateUser(
                  context, username.text, email.text, data?.patient ?? 5, isVeg)
              .then((value) => context.pop());
        },
        child: const Icon(Iconsax.arrow_up),
      ),
    );
  }
}
