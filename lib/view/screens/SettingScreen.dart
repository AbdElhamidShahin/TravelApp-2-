import 'package:Tourism_app/model/cubit/bloc.dart';
import 'package:Tourism_app/model/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TravelCubit(),
      child: BlocConsumer<TravelCubit, TravelState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = TravelCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Center(
                  child: Text(
                "Settinges",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
              )),
              actions: [],
            ),
            body: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                _buildSettingsOption(
                  context,
                  icon: Icons.person_outline,
                  title: 'Account',
                  onPressed: () {
                    _launchUrl(
                        "https://www.freeprivacypolicy.com/live/931d000c-ebf9-46ec-a72d-a619560a7173");
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Divider(),
                ),
                _buildSettingsOption(
                  context,
                  icon: Icons.notifications_none,
                  title: ' Notifications',
                  onPressed: () {
                    _launchUrl(
                        "https://play.google.com/store/apps/details?id=com.lilithgame.roc.gp&pcampaignid=merch_published_cluster_promotion_battlestar_browse_all_games");
                  },
                ),
                IconButton(
                  onPressed: () {
                    TravelCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(Icons.dark_mode_outlined),
                ),

                Divider(),
                Padding(
                  padding: EdgeInsets.only(right: 0, left: 0),
                  child: ListTile(
                    leading: IconButton(
                      onPressed: () {
                        cubit.changeAppMode();
                      },
                      icon: Icon(
                        Icons.dark_mode_outlined,
                        size: 32,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    title: Text(
                      "Dark Mode",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 22),
                    onTap: () {},
                  ),
                ),
                Divider(),
                _buildSettingsOption(
                  context,
                  icon: Icons.remove_red_eye_outlined,
                  title: 'Appearance',
                  onPressed: () {},
                ),
                Divider(),
                _buildSettingsOption(
                  context,
                  icon: Icons.lock_open_rounded,
                  title: 'Privacy',
                  onPressed: () {
                    _showWarningDialog(context);
                  },
                ),
                Divider(),
                _buildSettingsOption(
                  context,
                  icon: Icons.warning_amber,
                  title: 'warning',
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => FAQPage()),
                    // );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingsOption(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        leading: Icon(icon, size: 32),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 22),
        onTap: onPressed,
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    if (!await launchUrl(Uri.parse(urlString))) {
      throw Exception("Could not launch $urlString");
    }
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تحذير',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          content: const Text(
            'هذه رسالة تحذير.',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('موافق'),
            ),
          ],
        );
      },
    );
  }
}
