import 'package:flutter/material.dart';
import '../data/api_client.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.onLogout,super.key});
  final Future<void> Function() onLogout;
  @override
  Widget build(BuildContext context){
    final user=ApiClient.instance.user??{};
    final librarian=user['role']=='librarian';
    return ListView(padding:const EdgeInsets.fromLTRB(22,22,22,28),children:[
      Text('Meu perfil',style:Theme.of(context).textTheme.headlineSmall?.copyWith(color:AppColors.deep,fontWeight:FontWeight.w800)),
      const SizedBox(height:5),const Text('Seus dados de acesso ao AcervoVivo.',style:TextStyle(color:AppColors.secondaryText,fontSize:11)),
      const SizedBox(height:24),
      Container(padding:const EdgeInsets.all(24),decoration:BoxDecoration(color:AppColors.card,borderRadius:BorderRadius.circular(18),border:Border.all(color:AppColors.border)),child:Column(children:[
        CircleAvatar(radius:34,backgroundColor:AppColors.mint,child:Icon(librarian?Icons.admin_panel_settings:Icons.person_outline_rounded,color:AppColors.forest,size:36)),
        const SizedBox(height:14),Text(user['name']?.toString()??'Usuário',textAlign:TextAlign.center,style:const TextStyle(fontWeight:FontWeight.w800,color:AppColors.primaryText,fontSize:18)),
        const SizedBox(height:6),Text(user['email']?.toString()??'',textAlign:TextAlign.center,style:const TextStyle(color:AppColors.secondaryText)),
        const SizedBox(height:12),Chip(label:Text(librarian?'Bibliotecário':'Leitor'),backgroundColor:AppColors.mint),
        if(user['registration_code']!=null)Text('Matrícula: ${user['registration_code']}',style:const TextStyle(color:AppColors.secondaryText)),
      ])),
      const SizedBox(height:20),
      OutlinedButton.icon(onPressed:()=>showDialog<void>(context:context,builder:(c)=>AlertDialog(title:const Text('Sair da conta?'),content:const Text('Você precisará entrar novamente para acessar o AcervoVivo.'),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancelar')),FilledButton(onPressed:(){Navigator.pop(c);onLogout();},child:const Text('Sair'))])),icon:const Icon(Icons.logout),label:const Text('Sair da conta')),
    ]);
  }
}
