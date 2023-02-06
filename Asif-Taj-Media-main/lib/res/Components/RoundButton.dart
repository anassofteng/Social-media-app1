import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  final Color color, textColor;
  final bool loading;
  const RoundButton({
    super.key,
    required this.title,
    required this.onpress,
    this.textColor = AppColors.whiteColor,
    this.color = AppColors.primaryColor,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onpress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.PrimaryButtonColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
            child: loading
                ? CircularProgressIndicator(
                    color: textColor,
                  )
                : Center(
                    child: Text(title,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 16, color: textColor)),
                  )),
      ),
    );
  }
}
