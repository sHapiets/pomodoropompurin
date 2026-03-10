import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/authentication/account_manager.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final accountManager = AccountManager.singleton;

  bool loading = false;
  String? error;

  Future<void> login(BuildContext context) async {
    setState(() {
      loading = true;
      error = null;
    });

    final user = await accountManager.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() {
      loading = false;
    });

    if (user == null) {
      setState(() {
        error = "Login failed";
      });
    } else {
      accountManager.loggedIn.value = true;
    }
  }

  Future<void> register() async {
    setState(() {
      loading = true;
      error = null;
    });

    final user = await accountManager.register(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() {
      loading = false;
    });

    if (user == null) {
      setState(() {
        error = "Registration failed";
      });
    } else {
      if (mounted) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),

            const SizedBox(height: 16),

            if (loading)
              const CircularProgressIndicator()
            else
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        login(context);
                      },
                      child: const Text("Login"),
                    ),
                  ),

                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: register,
                      child: const Text("Register"),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
