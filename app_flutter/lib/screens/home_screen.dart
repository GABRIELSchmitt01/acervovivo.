import 'package:flutter/material.dart';
import '../data/api_client.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.onOpenCatalog,required this.onOpenHistory,super.key});
  final VoidCallback onOpenCatalog,onOpenHistory;
  @override State<HomeScreen> createState()=>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  List<dynamic> _books=[];bool _loading=true;String? _error;
  @override void initState(){super.initState();_load();}
  Future<void> _load() async {setState(()=>_loading=true);try{_books=await ApiClient.instance.get('/books') as List;_error=null;}catch(e){_error=e.toString().replaceFirst('Exception: ','');}if(mounted)setState(()=>_loading=false);}
  @override Widget build(BuildContext context)=>RefreshIndicator(onRefresh:_load,child:ListView(padding:const EdgeInsets.fromLTRB(22,14,22,28),children:[
    Row(children:[Container(width:42,height:42,decoration:BoxDecoration(color:AppColors.forest,borderRadius:BorderRadius.circular(14)),child:const Icon(Icons.menu_book_rounded,color:Colors.white,size:24)),const SizedBox(width:10),const Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('AcervoVivo',style:TextStyle(color:AppColors.deep,fontSize:18,fontWeight:FontWeight.w800)),Text('SUA BIBLIOTECA CONECTADA',style:TextStyle(color:AppColors.secondaryText,fontSize:8,letterSpacing:.5,fontWeight:FontWeight.w600))])),IconButton(onPressed:_load,icon:const Icon(Icons.refresh))]),
    const SizedBox(height:28),const Text('BIBLIOTECA AO SEU ALCANCE',style:TextStyle(color:AppColors.forest,fontSize:10,fontWeight:FontWeight.w800,letterSpacing:.8)),const SizedBox(height:9),
    Text('Sua próxima leitura\ncomeça aqui.',style:Theme.of(context).textTheme.headlineMedium?.copyWith(color:AppColors.deep,fontWeight:FontWeight.w800,height:1.08)),const SizedBox(height:9),
    const Text('Encontre histórias, descubra autores e explore o acervo da sua biblioteca.',style:TextStyle(color:AppColors.secondaryText,fontSize:12,height:1.4)),
    const SizedBox(height:20),InkWell(onTap:widget.onOpenCatalog,borderRadius:BorderRadius.circular(15),child:Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:AppColors.card,borderRadius:BorderRadius.circular(15),border:Border.all(color:AppColors.border)),child:const Row(children:[Icon(Icons.search_rounded,color:AppColors.forest),SizedBox(width:10),Expanded(child:Text('Buscar no catálogo',style:TextStyle(color:AppColors.secondaryText))),Icon(Icons.arrow_forward_ios_rounded,size:15)]))),
    const SizedBox(height:22),Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:AppColors.mint,borderRadius:BorderRadius.circular(18)),child:Row(children:[const Icon(Icons.library_books_outlined,color:AppColors.forest,size:30),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Acervo disponível',style:TextStyle(color:AppColors.deep,fontWeight:FontWeight.w700)),const SizedBox(height:4),if(_loading)const Text('Carregando catálogo...',style:TextStyle(color:AppColors.secondaryText))else if(_error!=null)Text('Não foi possível carregar o catálogo.',style:TextStyle(color:AppColors.danger))else Text('${_books.length} título(s) cadastrado(s)',style:const TextStyle(color:AppColors.secondaryText))]))])),
    const SizedBox(height:24),Row(children:[Expanded(child:Text('Explore o catálogo',style:Theme.of(context).textTheme.titleMedium?.copyWith(color:AppColors.primaryText,fontWeight:FontWeight.w800))),TextButton(onPressed:widget.onOpenCatalog,child:const Text('Ver todos'))]),
    if(_loading)const Padding(padding:EdgeInsets.all(20),child:Center(child:CircularProgressIndicator()))else if(_error!=null)Text(_error!,style:const TextStyle(color:AppColors.danger))else if(_books.isEmpty)const Text('Ainda não há livros cadastrados.',style:TextStyle(color:AppColors.secondaryText))else ..._books.take(4).map((b)=>Card(child:ListTile(leading:const Icon(Icons.menu_book_outlined,color:AppColors.forest),title:Text(b['title']??''),subtitle:Text(b['author']??''),trailing:Text('${b['available_copies']} disp.',style:const TextStyle(fontSize:11,color:AppColors.secondaryText))))),
    const SizedBox(height:18),InkWell(onTap:widget.onOpenHistory,borderRadius:BorderRadius.circular(18),child:Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:AppColors.card,border:Border.all(color:AppColors.border),borderRadius:BorderRadius.circular(18)),child:const Row(children:[Icon(Icons.history_rounded,color:AppColors.forest),SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Seus empréstimos',style:TextStyle(fontWeight:FontWeight.w700)),SizedBox(height:3),Text('Acompanhe os livros com você.',style:TextStyle(color:AppColors.secondaryText,fontSize:10))])),Icon(Icons.chevron_right_rounded,color:AppColors.forest)]))),
  ]));
}
