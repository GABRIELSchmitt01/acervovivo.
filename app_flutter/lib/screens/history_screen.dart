import 'package:flutter/material.dart';
import '../data/api_client.dart';
import '../theme/app_theme.dart';

class HistoryScreen extends StatefulWidget { const HistoryScreen({super.key}); @override State<HistoryScreen> createState()=>_HistoryScreenState(); }
class _HistoryScreenState extends State<HistoryScreen>{
  List<dynamic> _loans=[];bool _loading=true;String? _error;
  @override void initState(){super.initState();_load();}
  Future<void> _load() async {setState(()=>_loading=true);try{_loans=await ApiClient.instance.get('/loans') as List;_error=null;}catch(e){_error=e.toString().replaceFirst('Exception: ','');}if(mounted)setState(()=>_loading=false);}
  @override Widget build(BuildContext context)=>RefreshIndicator(onRefresh:_load,child:ListView(padding:const EdgeInsets.fromLTRB(22,22,22,28),children:[
    Row(children:[Expanded(child:Text('Meu histórico',style:Theme.of(context).textTheme.headlineSmall?.copyWith(color:AppColors.deep,fontWeight:FontWeight.w800))),IconButton(onPressed:_load,icon:const Icon(Icons.refresh))]),
    const SizedBox(height:5),const Text('Acompanhe seus empréstimos e devoluções.',style:TextStyle(color:AppColors.secondaryText,fontSize:11)),const SizedBox(height:22),
    if(_loading)const Padding(padding:EdgeInsets.all(30),child:Center(child:CircularProgressIndicator()))
    else if(_error!=null)Column(children:[Text(_error!,textAlign:TextAlign.center),const SizedBox(height:12),FilledButton(onPressed:_load,child:const Text('Tentar novamente'))])
    else if(_loans.isEmpty)Container(padding:const EdgeInsets.all(24),decoration:BoxDecoration(color:AppColors.card,borderRadius:BorderRadius.circular(18),border:Border.all(color:AppColors.border)),child:const Column(children:[Icon(Icons.history_rounded,size:46,color:AppColors.forest),SizedBox(height:14),Text('Ainda não há empréstimos registrados',textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.w700)),SizedBox(height:7),Text('Quando a biblioteca registrar um empréstimo para sua conta, ele aparecerá aqui.',textAlign:TextAlign.center,style:TextStyle(color:AppColors.secondaryText,fontSize:11,height:1.4))]))
    else ..._loans.map((l){final returned=l['returned_at']!=null;final overdue=!returned&&DateTime.tryParse(l['due_date']??'')?.isBefore(DateTime.now())==true;return Card(child:ListTile(leading:CircleAvatar(backgroundColor:AppColors.mint,child:Icon(returned?Icons.check:overdue?Icons.warning_amber_rounded:Icons.menu_book,color:overdue?AppColors.danger:AppColors.forest)),title:Text(l['book_title']??'Livro'),subtitle:Text('Retirada: ${l['loan_date']}\nPrevista: ${l['due_date']}${returned?' • Devolvido: ${l['returned_at']}':''}'),isThreeLine:true,trailing:Text(returned?'Devolvido':overdue?'Atrasado':'Em aberto',style:TextStyle(fontSize:10,fontWeight:FontWeight.w700,color:returned?AppColors.forest:overdue?AppColors.danger:AppColors.secondaryText))));}),
  ]));
}
