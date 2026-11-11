import 'package:flutter/material.dart';
import '../services/app_storage.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback onLogout;
  final ValueChanged<bool> onThemeChanged;

  const SettingsPage({
    super.key,
    required this.onLogout,
    required this.onThemeChanged,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppStorage _appStorage = AppStorage();
  bool _isLoading = true;
  bool _darkMode = false;
  bool _confirmDelete = true;

  @override
  void initState(){
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await _appStorage.loadSettings();
    setState(() {
      _darkMode = settings.darkMode;
      _confirmDelete = settings.confirmDelete;
      _isLoading = false;
    });
  }

  Future<void> _toggleDarkMode(bool value) async {
    setState(() {
      _darkMode = value;
    });

    await _appStorage.saveDarkMode(value);
    widget.onThemeChanged(value);
  }  

  Future<void> _toggleConfirmDelete(bool value) async{
    setState(() {
      _confirmDelete = value;
    });

    await _appStorage.saveConfirmDelete(value);
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Deseja sair da conta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
               child: const Text('Cancelar'),
           ),
           FilledButton(
            onPressed: () => Navigator.pop(context, true),
             child: const Text('Sair'),

             )
          ],
        );
      }
    );

    if (shouldLogout == true){
      await _appStorage.setLoggedIn(false);

      if (!mounted){
        return;
      }

      Navigator.pop(context);

      widget.onLogout();
    }
  }
}
