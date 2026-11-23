import 'package:flutter/material.dart';
import 'package:greenway/dashboard/widget/bottomnavigationbar.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool tapped = false;
  bool _obscure = true;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Brand.background,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            _buildHeader(context),
            Transform.translate(
              offset: const Offset(0, -36),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Brand.gutter),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: _buildForm(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, top + 32, 24, 64),
      decoration: const BoxDecoration(
        gradient: Brand.gradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Image.asset(logo, height: 84, width: 84),
          ),
          const SizedBox(height: 16),
          Text(
            Instittename,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Sign in to continue learning',
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: Brand.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Welcome back',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w700, color: Brand.text),
          ),
          const SizedBox(height: 4),
          const Text(
            'Enter your username and password',
            style: TextStyle(fontSize: 14, color: Brand.textMuted),
          ),
          const SizedBox(height: 24),
          _label('Username'),
          TextField(
            controller: usernameController,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Your username',
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
          ),
          const SizedBox(height: 16),
          _label('Password'),
          TextField(
            controller: passwordController,
            obscureText: _obscure,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _onLogin(),
            decoration: InputDecoration(
              hintText: 'Your password',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                icon: Icon(_obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
          ),
          const SizedBox(height: 28),
          ElevatedButton(
            onPressed: tapped ? null : _onLogin,
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: Brand.accent.withValues(alpha: 0.7),
            ),
            child: tapped
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.5, color: Colors.white),
                  )
                : const Text('Login'),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Brand.text),
        ),
      );

  void _stopLoading() {
    if (mounted) setState(() => tapped = false);
  }

  Future<void> _saveAndEnter({bool withDevice = false}) async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(KEYLOGIN, true);
    rememberUser = true; // keep in-memory login state in sync
    sharedPref.setString(id, studentId!);
    sharedPref.setString(usrid, userId!);
    if (withDevice) sharedPref.setString(Dceid, newdeviceid!);
    if (!mounted) return;
    // Dashboard becomes the root, so Back doesn't return to Explore/Login.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const navigationbar()),
      (route) => false,
    );
  }

  Future<void> _onLogin() async {
    if (tapped) return;
    FocusScope.of(context).unfocus();
    if (usernameController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      showMessage(context, 'Please enter your username and password');
      return;
    }
    setState(() => tapped = true);

    try {
      final result = await login(
          usernameController.text.toString(), passwordController.text.toString());

      if (result?.status != "success") {
        _stopLoading();
        if (mounted) showMessage(context, 'Invalid credentials');
        return;
      }

      password_status = result?.status;
      loginmessage = result?.message;
      studentId = result?.data?.studentId;
      userId = result?.data?.userId;
      classId = result?.data?.classId;
      stuname = result?.data?.name;
      phone = result?.data?.phone;
      expireDate = result?.data?.expireDate;
      seenVideo = result?.data?.seenVideo;
      ip = result?.data?.ip;
      deviceId = result?.data?.deviceId;
      status = result?.data?.status;
      utype = result?.data?.utype;

      securemode = await getsecuremod();
      final feeStatus = await fee_status(userId!);
      newdeviceid = await getDeviceId();
      feestatus = feeStatus?.data?.status;

      if (securemode == 'privent_m_l' || securemode == 'a_2d_s_n') {
        if (newdeviceid == null || newdeviceid!.isEmpty) {
          _stopLoading();
          if (mounted) {
            showMessage(context,
                'Could not read this device\'s ID. Please restart the app and try again.');
          }
          return;
        }
        if (deviceId == '' || deviceId == null) {
          String? update = await deviceidupdate(userId!, newdeviceid);
          _stopLoading();
          if (!mounted) return;
          if (update == 'something worng for insertion') {
            showMessage(context,
                'This device is already logged in with another account. Your device ID is $newdeviceid');
          } else if (update == "Data insert Successfully") {
            await _saveAndEnter(withDevice: true);
          } else {
            debugPrint('store_device_id unexpected reply: $update');
            showMessage(context,
                'Server error (${update ?? 'no response'}). Please try again later.');
          }
        } else if (deviceId == newdeviceid) {
          await _saveAndEnter(withDevice: true);
        } else {
          _stopLoading();
          if (mounted) {
            showMessage(context, 'Please login with your previous device');
          }
        }
      } else {
        await _saveAndEnter();
      }
    } catch (e) {
      debugPrint('Login failed: $e');
      _stopLoading();
      if (mounted) {
        showMessage(context,
            'Unable to login right now. Please check your connection and try again.');
      }
    }
  }
}

void showMessage(BuildContext context, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: const Icon(Icons.info_outline_rounded,
            color: Brand.warning, size: 36),
        title: const Text('Notice'),
        content: Text(msg, textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
