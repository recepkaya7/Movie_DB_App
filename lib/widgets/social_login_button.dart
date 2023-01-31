import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton(
      {Key? key,
      required this.butonText,
      required this.butonColor,
      required this.textColor,
      required this.butonIcon,
      required this.onPressed})
      : super(key: key);

  final String butonText;
  final Color butonColor;
  final Color textColor;
  final Widget butonIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
            icon: butonIcon,
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(butonColor),
            ),
            onPressed: onPressed,
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: 150,
                    child: Text(
                      butonText,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
