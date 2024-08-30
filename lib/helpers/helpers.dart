import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;
import 'package:intl/intl.dart';

class Helper{

  String renderHtmlToString(String htmlContent) {
    // Parse the HTML string
    String processedContent = htmlContent
        .replaceAll('<br />', '\n')
        .replaceAll('</p>', '\n')
        .replaceAll('<p>', '');
    dom.Document document = html_parser.parse(processedContent);

    // Convert the document to plain text
    String plainText = document.body?.text ?? '';

    return plainText;
  }

  String dayDiff(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateTime now = DateTime.now();

    // Calculate the difference in days
    Duration difference = now.difference(dateTime);
    int days = difference.inDays;

    // Format the string based on the difference
    if (days < 1) {
      return 'Today'; // Or 'Less than a day ago' if preferred
    } else if (days == 1) {
      return 'Yesterday';
    } else {
      return '$days days ago';
    }
  }

  String formatedDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat("dd MMMM yyyy", "id_ID").format(dateTime);

    return formattedDate;
  }

  String formatedDateWtime(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat("dd MMMM yyyy, HH:mm", "id_ID").format(dateTime);

    return formattedDate;
  }
}