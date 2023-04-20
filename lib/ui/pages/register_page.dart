import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Akun'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 12),
          Text(
            'Isi data yang diperlukan dibawah ini untuk mendaftarkan akun!',
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 18),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Nama'),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 18),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Email'),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 18),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Password'),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 18),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Konfirmasi Password'),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(),
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
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Text('DAFTAR'),
        ),
      ),
    );
  }
}
