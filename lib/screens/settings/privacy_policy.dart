import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          const Text(
            'Privacy and policy for Muzeeq',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 2,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          headerText('PRIVACY'),
          const Text(
              '''   For a better experience, while using my Service, I may require you to provide with certain personally identifiable information, including but not limited to IP Address. The information that I request is and will be retained by us and used as described in this privacy policy.  \n 
    This page is used to inform website visitors and app users regarding my policies with the collection, use, and disclosure of Personal and non-personal Information if they have decided to use my Service. \n 
    If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service provided by Music Player. We will not use or share your information with anyone except as described in this Privacy Policy. '''),
          headerText('INFORMATION COLLECTED AND USED'),
          const Text(
              '''   Muhammad Faheem built the Music Player app as a free app. This SERVICE is provided by Muhammad Faheem at no cost and is intended for use as is. \n 
    The app uses third party services that may collect information that can be used to identify you.  \n 
   Link to privacy policy of third party service providers used by the app : \n   1.Google Playstore '''),
          headerText('LOG DATA'),
          const Text('''
    I also inform you that whenever you use our Service, incase of an error in the app we collect data and information on your phone called as Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics. '''),
          headerText('COOKIES'),
          const Text(
              '''    Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory. \n
     This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services such as advertisements. You have the option to either accept or refuse the use of these cookies.   '''),
          headerText('SECURITY'),
          const Text(
              '''    I value your trust in providing us your valuable information, thus we are striving to use commercially acceptable means of protecting it. The information collected from the user is stored and shared only with the user’s consent. The data can be retrieved if the user specifically asks for it. The data will stop being collected if the user withdraws his consent. Any previously collected data will also be deleted if the user specifically asks for it. In the unlikely event that a data breach occurs, the user will be notified and necessary measures will be taken to protect the user’s data.    '''),
          headerText("CHILDREN'S PRIVACY"),
          const Text(
              '''    These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to take the necessary actions.
    '''),
          headerText("CONTACT US"),
          const Text(
              '''    If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact me at faheem3713@gmail.com.

    '''),
        ],
      )),
    );
  }
}

Text headerText(String text) {
  return Text(text,
      style: const TextStyle(
        height: 2.5,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ));
}
