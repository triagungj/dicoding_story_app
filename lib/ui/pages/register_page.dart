import 'package:flutter/material.dart';
import 'package:story_app/common/common.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.registrationAccount,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.fillRegistrationDesc,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 18),
          TextFormField(
            decoration: InputDecoration(
              label: Text(AppLocalizations.of(context)!.name),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: const OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 18),
          TextFormField(
            decoration: InputDecoration(
              label: Text(AppLocalizations.of(context)!.email),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 18),
          TextFormField(
            decoration: InputDecoration(
              label: Text(
                AppLocalizations.of(context)!.password,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: const OutlineInputBorder(),
            ),
            obscureText: true,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 18),
          TextFormField(
            decoration: InputDecoration(
              label: Text(
                AppLocalizations.of(context)!.confirmPassword,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: const OutlineInputBorder(),
            ),
            obscureText: true,
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            AppLocalizations.of(context)!.register,
          ),
        ),
      ),
    );
  }
}
