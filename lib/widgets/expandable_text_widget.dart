import 'package:flutter/material.dart';
import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text; //come form any class and initialized here
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true; // intially for lon text we use this
  double textHeight = Dimensions.screenHeight / 5.6;
  @override
// =firstHalf=i love flutter laravel and golang 30 ,secondHalf=20   total 50 length
  void initState() {
    super.initState();

    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(
        0,
        textHeight.toInt(),
      );
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              size: Dimensions.font16,
              color: Colors.black45,
              height: 1.8,
              text: firstHalf,
            )
          : Column(
              children: [
                SmallText(
                  size: Dimensions.font16,
                  height: 1.8,
                  color: Colors.black45,
                  text: hiddenText
                      ? (firstHalf + "...")
                      : (firstHalf + secondHalf),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: "Show More",
                        color: Colors.lightBlueAccent,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                            
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
