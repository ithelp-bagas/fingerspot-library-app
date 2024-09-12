import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

class MentionText extends StatefulWidget {
  const MentionText({super.key, required this.htmlContent, required this.style, required this.maxLines});
  final String htmlContent;
  final TextStyle style;
  final int maxLines;

  @override
  State<MentionText> createState() => _MentionTextState();
}

class _MentionTextState extends State<MentionText> {
  bool _isExpanded = false;
  final PostController postController = Get.put(PostController());

  String renderHtmlToString(String htmlContent) {
    String processedContent = htmlContent
        .replaceAll('<br />', '\n')
        .replaceAll('</p>', '\n')
        .replaceAll('<p>', '');
    dom.Document document = html_parser.parse(processedContent);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final plainText = renderHtmlToString(widget.htmlContent);

    // Regular expression to match mentions like @username
    final mentionRegex = RegExp(r'(@\w+)');

    // Create a list of TextSpan for RichText
    final textSpans = <TextSpan>[];
    int lastMatchEnd = 0;

    mentionRegex.allMatches(plainText).forEach((match) {
      if (match.start > lastMatchEnd) {
        textSpans.add(TextSpan(
          text: plainText.substring(lastMatchEnd, match.start),
          style: widget.style,
        ));
      }
      textSpans.add(TextSpan(
        text: match.group(0),
        style: widget.style.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () async{
            String username = match.group(0)!.replaceFirst('@', '');
            int? id = await postController.searchIdByUsername(username);
            Get.toNamed(Routes.PROFILE_VISIT, arguments: {'profileId': id});
          }
      ));
      lastMatchEnd = match.end;
    });

    if (lastMatchEnd < plainText.length) {
      textSpans.add(TextSpan(
        text: plainText.substring(lastMatchEnd),
        style: widget.style,
      ));
    }

    final textWidget = RichText(
      text: TextSpan(
        children: textSpans,
        style: widget.style.copyWith(
          color: widget.style.color ?? Colors.black, // Ensure color is applied
        ),
      ),
      maxLines: _isExpanded ? null : widget.maxLines,
      overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(
            children: textSpans,
            style: widget.style,
          ),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflowing = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWidget,
            if (isOverflowing)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? "Tampilkan lebih sedikit" : "Tampilkan lebih banyak",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: widget.style.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
