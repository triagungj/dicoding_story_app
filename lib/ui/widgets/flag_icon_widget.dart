import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/common.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/data/providers/localization_provider.dart';

class FlagIconWidget extends StatelessWidget {
  const FlagIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocal = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    ).locale;
    final currentFlag = Localization.getFlag(currentLocal.languageCode);

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        isDense: true,
        icon: Text(
          currentFlag,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        items: AppLocalizations.supportedLocales.map((Locale locale) {
          final flag = Localization.getFlag(locale.languageCode);
          return DropdownMenuItem(
            value: locale,
            child: Center(
              child: Text(
                flag,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            onTap: () {
              Provider.of<LocalizationProvider>(context, listen: false)
                  .setLocale(locale);
            },
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
