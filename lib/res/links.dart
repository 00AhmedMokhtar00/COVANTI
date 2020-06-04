
import 'package:url_launcher/url_launcher.dart';

class Links{

  static const String CORONA_TEST = "https://covapp.charite.de/questionnaire";
  static const String CORONA_CASES = "https://corona.lmao.ninja/v2/countries/";


  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}