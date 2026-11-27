import 'package:flutter/material.dart';
import '../data/api_client.dart';
import '../models/book.dart';
import '../theme/app_theme.dart';
import '../widgets/book_details_sheet.dart';
import '../widgets/book_list_tile.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});
  @override
  State<CatalogScreen> createState()=>_CatalogScreenState();
}
class _CatalogScreenState extends State<CatalogScreen>{
  final _search=TextEditingController();
  List<Book> _books=[];
  bool _loading=true; String? _error; String _category='Todos';
  List<String> get _categories { final cats=_books.map((b)=>b.category).where((x)=>x.isNotEmpty).toSet().toList()..sort(); return ['Todos',...cats]; }
  List<Book> get _filtered{
    final q=_search.text.trim().toLowerCase();
    return _books.where((b)=>(q.isEmpty||b.title.toLowerCase().contains(q)||b.author.toLowerCase().contains(q))&&(_category=='Todos'||b.category==_category)).toList();
  }
  @override void initState(){super.initState();_load();}
  Future<void> _load() async {
    setState(()=>_loading=true);
    try{
      final rows=await ApiClient.instance.get('/books') as List;
      _books=rows.map((x){final m=Map<String,dynamic>.from(x);return Book(id:m['id'].toString(),title:m['title']??'',author:m['author']??'',category:m['category']??'Sem categoria',description:m['description']??'Descrição não informada.',totalCopies:(m['total_copies'] as num?)?.toInt()??0,availableCopies:(m['available_copies'] as num?)?.toInt()??0);}).toList();
      if(!_categories.contains(_category))_category='Todos';
      _error=null;
    }catch(e){_error=e.toString().replaceFirst('Exception: ','');}
    if(mounted)setState(()=>_loading=false);
  }
  @override void dispose(){_search.dispose();super.dispose();}
  @override Widget build(BuildContext context){
    final books=_filtered;
    return RefreshIndicator(onRefresh:_load,child:ListView(padding:const EdgeInsets.fromLTRB(22,22,22,28),children:[
      Row(children:[Expanded(child:Text('Catálogo de livros',style:Theme.of(context).textTheme.headlineSmall?.copyWith(color:AppColors.deep,fontWeight:FontWeight.w800))),IconButton(onPressed:_load,icon:const Icon(Icons.refresh))]),
      const SizedBox(height:5),const Text('Pesquise obras cadastradas na biblioteca.',style:TextStyle(color:AppColors.secondaryText,fontSize:11)),
      const SizedBox(height:20),TextField(controller:_search,onChanged:(_)=>setState((){}),decoration:const InputDecoration(hintText:'Buscar por título ou autor...',prefixIcon:Icon(Icons.search_rounded))),
      const SizedBox(height:13),SizedBox(height:36,child:ListView.separated(scrollDirection:Axis.horizontal,itemCount:_categories.length,separatorBuilder:(_,__)=>const SizedBox(width:7),itemBuilder:(c,i){final cat=_categories[i];final selected=cat==_category;return ChoiceChip(label:Text(cat),selected:selected,onSelected:(_)=>setState(()=>_category=cat),showCheckmark:false,selectedColor:AppColors.forest,backgroundColor:AppColors.card,side:BorderSide(color:selected?AppColors.forest:AppColors.border),labelStyle:TextStyle(color:selected?Colors.white:AppColors.secondaryText,fontSize:11));})),
      const SizedBox(height:20),
      if(_loading)const Padding(padding:EdgeInsets.all(32),child:Center(child:CircularProgressIndicator()))
      else if(_error!=null)Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:AppColors.card,borderRadius:BorderRadius.circular(16),border:Border.all(color:AppColors.border)),child:Column(children:[const Icon(Icons.cloud_off_outlined,size:36,color:AppColors.danger),const SizedBox(height:10),Text(_error!,textAlign:TextAlign.center),const SizedBox(height:12),FilledButton(onPressed:_load,child:const Text('Tentar novamente'))]))
      else ...[
        Text('${books.length} livro(s) encontrado(s)',style:const TextStyle(color:AppColors.secondaryText,fontSize:10,fontWeight:FontWeight.w700)),
        const SizedBox(height:10),
        if(books.isEmpty)Container(padding:const EdgeInsets.all(24),decoration:BoxDecoration(color:AppColors.card,borderRadius:BorderRadius.circular(16),border:Border.all(color:AppColors.border)),child:const Column(children:[Icon(Icons.menu_book_outlined,size:34,color:AppColors.secondaryText),SizedBox(height:10),Text('Nenhum livro encontrado.'),SizedBox(height:4),Text('O catálogo será atualizado quando a biblioteca cadastrar obras.',textAlign:TextAlign.center,style:TextStyle(color:AppColors.secondaryText,fontSize:10))]))
        else ...books.map((b)=>Padding(padding:const EdgeInsets.only(bottom:9),child:BookListTile(book:b,onTap:()=>showBookDetails(context,b)))),
      ],
    ]));
  }
}
