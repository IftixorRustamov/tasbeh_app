import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tasbeh/config/theme/colors.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: const SizedBox.shrink(),
      dropdownColor: Theme.of(context).brightness == Brightness.dark
          ? MyColors.grey
          : MyColors.white,
      icon: Icon(
        Icons.language,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      borderRadius: BorderRadius.circular(10),
      onChanged: (String? newLanguage) {
        if (newLanguage != null) {
          context.setLocale(Locale(newLanguage));
        }
      },
      items: const [
        DropdownMenuItem(
          value: 'en',
          child: Text('English'),
        ),
        DropdownMenuItem(
          value: 'ru',
          child: Text('Russian'),
        ),
        DropdownMenuItem(
          value: 'uz',
          child: Text('Uzbek'),
        ),
      ],
    );
  }
}
