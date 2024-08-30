import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

Widget renderHtml(String htmlContent) {
  return Html(
    data: htmlContent,
    // Optional: Custom styling for HTML elements
    style: {
      "p": Style(
        fontSize: const FontSize(16.0),
        color: Colors.black87,
      ),
      "a": Style(
        textDecoration: TextDecoration.none,
        color: Colors.blue,
      ),
      // Add more styling as needed
    },
    // Optional: Handle custom tags or unsupported tags
    customRender: {
      "custom_tag": (RenderContext context, Widget child) {
        return Container(
          color: Colors.grey[300],
          child: child,
        );
      },
    },
    // Optional: Handle onTap actions for links
    onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, element) {
      if (url != null) {
        // Handle the URL, e.g., open it in a webview or browser
      }
    },
  );
}