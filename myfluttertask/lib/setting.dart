import 'package:flutter/material.dart';
import 'package:myfluttertask/Profile_page.dart' as profile;
// import 'package:myfluttertask/account_page.dart' as account ;

void main() {
  runApp(const SettingsApp());
}

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Settings Demo',
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool isLockInBackgroundEnabled = true;
  bool isUseFingerprintEnabled = true;
  String selectedLanguage = 'Arabic';

  List<String> availableLanguages = ['Arabic', 'English', 'French', 'Spanish'];

  // ------------------------- TEXTS FOR ALL LANGUAGES -------------------------
  Map<String, Map<String, String>> texts = {
    "Arabic": {
      "settings": "الإعدادات",
      "common": "عام",
      "language": "اللغة",
      "environment": "البيئة",
      "production": "إنتاج",
      "security": "الأمان",
      "lockApp": "قفل التطبيق في الخلفية",
      "fingerprint": "استخدام البصمة",
      "misc": "متنوع",
      "terms": "شروط الخدمة",
      "licenses": "رخصة المصدر المفتوح",
      "selectLanguage": "اختيار اللغة"
    },
    "English": {
      "settings": "Settings",
      "common": "Common",
      "language": "Language",
      "environment": "Environment",
      "production": "Production",
      "security": "Security",
      "lockApp": "Lock app in background",
      "fingerprint": "Use fingerprint",
      "misc": "Misc",
      "terms": "Terms of Service",
      "licenses": "Open source licenses",
      "selectLanguage": "Select Language"
    },
    "French": {
      "settings": "Paramètres",
      "common": "Commun",
      "language": "Langue",
      "environment": "Environnement",
      "production": "Production",
      "security": "Sécurité",
      "lockApp": "Verrouiller l'application",
      "fingerprint": "Utiliser l'empreinte",
      "misc": "Divers",
      "terms": "Conditions d'utilisation",
      "licenses": "Licences open source",
      "selectLanguage": "Choisir la langue"
    },
    "Spanish": {
      "settings": "Ajustes",
      "common": "Común",
      "language": "Idioma",
      "environment": "Entorno",
      "production": "Producción",
      "security": "Seguridad",
      "lockApp": "Bloquear app",
      "fingerprint": "Usar huella",
      "misc": "Misceláneo",
      "terms": "Términos de servicio",
      "licenses": "Licencias de código abierto",
      "selectLanguage": "Seleccionar idioma"
    },
  };

  @override
  void initState() {
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 63, 173, 228),
                Color.fromARGB(255, 23, 176, 176),
                Color(0xFF008080),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              texts[selectedLanguage]!["settings"]!,
              style: const TextStyle(color: Colors.white),
            ),
            // ---------------- BACK BUTTON MODIFIED HERE ----------------
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const profile.AccountPage(
                email: '',
                 address: ''
                 , gender: ''
                 , name: '',
                  phone: '',
                )));
              },
            ),
          ),
        ),
      ),

      // --------------------- BODY ------------------------
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildSectionHeader(texts[selectedLanguage]!["common"]!),

          // Language
          _buildLanguageTile(),

          // Environment
          _buildListTile(
            icon: Icons.cloud_queue,
            title: texts[selectedLanguage]!["environment"]!,
            subtitle: texts[selectedLanguage]!["production"]!,
          ),

          // Security
          _buildSectionHeader(texts[selectedLanguage]!["security"]!),

          _buildSwitchListTile(
            icon: Icons.lock_outline,
            title: texts[selectedLanguage]!["lockApp"]!,
            value: isLockInBackgroundEnabled,
            onChanged: (value) {
              setState(() {
                isLockInBackgroundEnabled = value;
              });
            },
          ),

          _buildSwitchListTile(
            icon: Icons.fingerprint,
            title: texts[selectedLanguage]!["fingerprint"]!,
            value: isUseFingerprintEnabled,
            onChanged: (value) {
              setState(() {
                isUseFingerprintEnabled = value;
              });
            },
          ),

          // Misc
          _buildSectionHeader(texts[selectedLanguage]!["misc"]!),

          _buildListTile(
            icon: Icons.description_outlined,
            title: texts[selectedLanguage]!["terms"]!,
          ),

          _buildListTile(
            icon: Icons.code_outlined,
            title: texts[selectedLanguage]!["licenses"]!,
          ),
        ],
      ),
    );
  }

  // SECTION HEADER
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.teal,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  // REGULAR TILE
  Widget _buildListTile({required IconData icon, required String title, String? subtitle}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  // SWITCH TILE
  Widget _buildSwitchListTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(title),
      value: value,
      onChanged: onChanged,
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
    );
  }

  // LANGUAGE TILE
  Widget _buildLanguageTile() {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(texts[selectedLanguage]!["language"]!),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            selectedLanguage,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
      onTap: () => _showLanguageDialog(),
    );
  }

  // LANGUAGE DIALOG
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(texts[selectedLanguage]!["selectLanguage"]!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
          ),
        );
      },
    );
  }
}