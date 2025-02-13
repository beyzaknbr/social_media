import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/resources/auth_methods.dart';
import 'package:social_media/screens/auth/sign_up_screen.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  void loginUser() async {
    if (_emailController.text.isNotEmpty && _emailController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      bool response = await AuthMethods()
          .loginUser(_emailController.text, _passwordController.text);
      if (mounted) {
        //loginUser gibi async işlemler asenkron olarak çalıştığı için, işlemin bitişinde widget'ın artık aktif olmama ihtimali vardır. Eğer widget kaldırıldıysa (örneğin, kullanıcı bu ekranı kapattıysa), context kullanımı hata verebilir. mounted ile bu durumdan kaçınılır.

        if (response) {
          Utils().showSnackBar("Giriş Yaptınız", context, waveColor);
          //burada ana sayfaya dönecek
        }
      }
      setState(() {
        isLoading = false;
      });
    } else {
      Utils().showSnackBar(
        "Lütfen gerekli alanları doldurunuz,boş alanlar var!",
        context,
        waveColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ekran boyutlarını alıyoruz
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // Klavye açıldığında ekranın yeniden boyutlanmasını engelle
      body: SafeArea(
        child: Column(
          children: [
            // Üst SVG dalgası
            SvgPicture.asset(
              "assets/images/wavegreen.svg",
              height: height * 0.17, // Üst SVG için daha az yer ayırıyoruz
              width: width,
              fit: BoxFit.cover,
            ),
            // Ortadaki içerikler
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/star_logo.png",
                    width: 120,
                    height: 120,
                  ),
                  Text(
                    "Our Social Media",
                    style: TextStyle(fontFamily: "Header"),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: textFieldColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:  TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Kullanıcı Adı",
                        prefixIcon: Icon(Icons.account_box_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: textFieldColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:  TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Şifre",
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Şifremi Unuttum",
                        style: TextStyle(
                          fontFamily: "TextType",
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: waveColor,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      loginUser();
                    },
                    child: !isLoading? Text(
                      "Giriş Yap",
                      style: TextStyle(
                        fontFamily: "TextType",
                      ),
                    ):Center(child: CircularProgressIndicator(),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: textFieldColor,
                      foregroundColor: textColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Divider(
                          indent: 50,
                          thickness: 1,
                        ),
                      ),
                      const Text(
                        " Hesabınız yok mu?",
                        style: styleText,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: const Text("kayıt olun"),
                        style: TextButton.styleFrom(
                          foregroundColor: waveColor,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          endIndent: 50,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Alt SVG dalgası
            Opacity(
              opacity: 0.2,
              child: SvgPicture.asset(
                "assets/images/wave_green_down.svg",
                height: height * 0.18,
                // Alt SVG'nin ekranın alt kısmında görünmesini sağladık
                width: width,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
