import 'package:flutter/material.dart';
import 'data/api_client.dart';
import 'screens/catalog_screen.dart';
import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/librarian_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AcervoVivoApp());
}
class AcervoVivoApp extends StatelessWidget {
  const AcervoVivoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title:'AcervoVivo',debugShowCheckedModeBanner:false,theme:AppTheme.light,home:const SessionGate());
}
class SessionGate extends StatefulWidget {
  const SessionGate({super.key});
  @override
  State<SessionGate> createState()=>_SessionGateState();
}
class _SessionGateState extends State<SessionGate> {
  bool _ready=false;
  @override
  void initState(){super.initState();_restore();}
  Future<void> _restore() async {await ApiClient.instance.restoreSession();if(mounted)setState(()=>_ready=true);}
  void _changed()=>setState((){});
  @override
  Widget build(BuildContext context){
    if(!_ready)return const Scaffold(body:Center(child:CircularProgressIndicator()));
    if(!ApiClient.instance.isLoggedIn)return LoginScreen(onLoggedIn:_changed);
    return AppShell(key:ValueKey(ApiClient.instance.user?['id']),onLogout:()async{await ApiClient.instance.clearSession();_changed();});
  }
}
class AppShell extends StatefulWidget {
  const AppShell({required this.onLogout,super.key});
  final Future<void> Function() onLogout;
  @override
  State<AppShell> createState()=>_AppShellState();
}
class _AppShellState extends State<AppShell>{
  int _selected=0;
  void _open(int i)=>setState(()=>_selected=i);
  @override
  Widget build(BuildContext context){
    final librarian=ApiClient.instance.isLibrarian;
    final pages=<Widget>[
      HomeScreen(onOpenCatalog:()=>_open(1),onOpenHistory:()=>_open(2)),
      const CatalogScreen(),const HistoryScreen(),ProfileScreen(onLogout:widget.onLogout),
      if(librarian)const LibrarianScreen(),
    ];
    final destinations=<NavigationDestination>[
      const NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home_rounded),label:'Início'),
      const NavigationDestination(icon:Icon(Icons.menu_book_outlined),selectedIcon:Icon(Icons.menu_book_rounded),label:'Catálogo'),
      const NavigationDestination(icon:Icon(Icons.history_rounded),label:'Histórico'),
      const NavigationDestination(icon:Icon(Icons.person_outline_rounded),selectedIcon:Icon(Icons.person_rounded),label:'Perfil'),
      if(librarian)const NavigationDestination(icon:Icon(Icons.admin_panel_settings_outlined),selectedIcon:Icon(Icons.admin_panel_settings),label:'Biblioteca'),
    ];
    if(_selected>=pages.length)_selected=0;
    return Scaffold(body:SafeArea(child:IndexedStack(index:_selected,children:pages)),bottomNavigationBar:NavigationBar(selectedIndex:_selected,onDestinationSelected:_open,destinations:destinations));
  }
}
