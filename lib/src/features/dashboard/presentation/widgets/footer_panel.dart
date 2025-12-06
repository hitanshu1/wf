import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/radius/radius.dart';
import '../../../../config/theme/space/edge.dart';
import '../../../../config/theme/space/gap.dart';
import '../../../../core/localization/bloc/locale_bloc.dart';
import '../../../../core/localization/bloc/locale_event.dart';
import '../../../../core/localization/bloc/locale_state.dart';
import '../../../../core/widgets/kuick_icon.dart';

class FooterPanel extends StatelessWidget {
  const FooterPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33,
      padding: edge.h8,
      decoration: BoxDecoration(color: AppColor.color4(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, state) {
              final currentCode = state.localeCode;
              return PopupMenuButton<String>(
                tooltip: 'Change language',
                shape: RoundedRectangleBorder(
                  borderRadius: radius.x8,
                ),
                color: AppColor.color1(context),
                elevation: 4,
                onSelected: (value) {
                  context.read<LocaleBloc>().add(ChangeLocale(value));
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'en', child: Text('🇬🇧  English')),
                  PopupMenuItem(value: 'es', child: Text('🇪🇸  Español')),
                ],
                child: Row(
                  children: [
                    KuickIcon(Icons.language, size: 18),
                    gap.w5,
                    Text(
                      currentCode.toUpperCase(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    KuickIcon(Icons.keyboard_arrow_up_rounded, size: 18)
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
