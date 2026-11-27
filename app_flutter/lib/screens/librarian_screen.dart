import 'package:flutter/material.dart';
import '../data/api_client.dart';
import '../theme/app_theme.dart';

class LibrarianScreen extends StatefulWidget {
  const LibrarianScreen({super.key});
  @override
  State<LibrarianScreen> createState() => _LibrarianScreenState();
}
class _LibrarianScreenState extends State<LibrarianScreen> {
  List<dynamic> _books=[], _readers=[], _loans=[];
  bool _loading=true; String? _error; int _tab=0;
  @override
  void initState(){super.initState();_load();}
  Future<void> _load() async {
    setState(()=>_loading=true);
    try {
      final a=await ApiClient.instance.get('/books') as List;
      final u=await ApiClient.instance.get('/users') as List;
      final l=await ApiClient.instance.get('/loans',query:{'open_only':'true'}) as List;
      _books=a; _readers=u.where((x)=>x['role']=='reader').toList(); _loans=l; _error=null;
    } catch(e){_error=e.toString().replaceFirst('Exception: ','');}
    if(mounted)setState(()=>_loading=false);
  }
  void _msg(String s)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(s.replaceFirst('Exception: ',''))));
  String? _clean(String s)=>s.trim().isEmpty?null:s.trim();
  Future<void> _bookForm([Map<String,dynamic>? b]) async {
    final title=TextEditingController(text:b?['title']?.toString()??'');
    final author=TextEditingController(text:b?['author']?.toString()??'');
    final isbn=TextEditingController(text:b?['isbn']?.toString()??'');
    final cat=TextEditingController(text:b?['category']?.toString()??'');
    final year=TextEditingController(text:b?['publication_year']?.toString()??'');
    final qty=TextEditingController(text:b?['total_copies']?.toString()??'1');
    final publisher=TextEditingController(text:b?['publisher']?.toString()??'');
    final desc=TextEditingController(text:b?['description']?.toString()??'');
    final key=GlobalKey<FormState>();
    final data=await showDialog<Map<String,dynamic>>(context:context,builder:(c)=>AlertDialog(title:Text(b==null?'Cadastrar livro':'Editar livro'),content:SizedBox(width:430,child:SingleChildScrollView(child:Form(key:key,child:Column(mainAxisSize:MainAxisSize.min,children:[
      _field(title,'Título',required:true),_field(author,'Autor',required:true),_field(isbn,'ISBN'),_field(cat,'Categoria/gênero'),_field(year,'Ano',numeric:true),_field(qty,'Quantidade de exemplares',numeric:true,required:true),_field(publisher,'Editora'),_field(desc,'Descrição',lines:3)
    ])))),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancelar')),FilledButton(onPressed:()=>key.currentState!.validate()?Navigator.pop(c,{'title':title.text.trim(),'author':author.text.trim(),'isbn':_clean(isbn.text),'category':_clean(cat.text),'publication_year':year.text.trim().isEmpty?null:int.tryParse(year.text),'total_copies':int.tryParse(qty.text)??1,'publisher':_clean(publisher.text),'description':_clean(desc.text)}):null,child:const Text('Salvar'))]));
    if(data!=null){try{if(b==null)await ApiClient.instance.post('/books',body:data);else await ApiClient.instance.put('/books/${b['id']}',body:data);await _load();}catch(e){_msg(e.toString());}}
    for(final c in [title,author,isbn,cat,year,qty,publisher,desc]){c.dispose();}
  }
  Widget _field(TextEditingController c,String label,{bool required=false,bool numeric=false,int lines=1})=>Padding(padding:const EdgeInsets.only(bottom:9),child:TextFormField(controller:c,maxLines:lines,keyboardType:numeric?TextInputType.number:null,decoration:InputDecoration(labelText:label),validator:(v){if(required&&(v==null||v.trim().isEmpty))return 'Campo obrigatório.';if(numeric&&v!=null&&v.trim().isNotEmpty&&int.tryParse(v)==null)return 'Informe um número válido.';return null;}));
  Future<void> _readerForm() async {
    final name=TextEditingController(),email=TextEditingController(),pass=TextEditingController(),code=TextEditingController(),phone=TextEditingController();final key=GlobalKey<FormState>();
    final data=await showDialog<Map<String,dynamic>>(context:context,builder:(c)=>AlertDialog(title:const Text('Cadastrar leitor'),content:SizedBox(width:420,child:SingleChildScrollView(child:Form(key:key,child:Column(mainAxisSize:MainAxisSize.min,children:[_field(name,'Nome completo',required:true),_field(email,'E-mail',required:true),_field(pass,'Senha inicial (mínimo 10 caracteres)',required:true),_field(code,'Matrícula/código'),_field(phone,'Telefone')])))),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancelar')),FilledButton(onPressed:()=>key.currentState!.validate()&&pass.text.length>=10?Navigator.pop(c,{'name':name.text.trim(),'email':email.text.trim(),'password':pass.text,'registration_code':_clean(code.text),'phone':_clean(phone.text),'role':'reader'}):null,child:const Text('Cadastrar'))]));
    if(data!=null){try{await ApiClient.instance.post('/users',body:data);await _load();}catch(e){_msg(e.toString());}}
    for(final c in [name,email,pass,code,phone]){c.dispose();}
  }
  Future<void> _loanForm() async {
    if(_books.isEmpty||_readers.isEmpty){_msg('Cadastre livros e leitores antes de registrar empréstimos.');return;}
    int? bid=int.tryParse(_books.first['id'].toString()),uid=int.tryParse(_readers.first['id'].toString());
    final due=TextEditingController(text:DateTime.now().add(const Duration(days:14)).toIso8601String().substring(0,10));final key=GlobalKey<FormState>();
    final data=await showDialog<Map<String,dynamic>>(context:context,builder:(c)=>AlertDialog(title:const Text('Registrar empréstimo'),content:Form(key:key,child:Column(mainAxisSize:MainAxisSize.min,children:[
      DropdownButtonFormField<int>(value:bid,decoration:const InputDecoration(labelText:'Livro'),items:_books.map<DropdownMenuItem<int>>((x)=>DropdownMenuItem(value:int.parse(x['id'].toString()),child:SizedBox(width:220,child:Text(x['title'],overflow:TextOverflow.ellipsis)))).toList(),onChanged:(v)=>bid=v),
      DropdownButtonFormField<int>(value:uid,decoration:const InputDecoration(labelText:'Leitor'),items:_readers.map<DropdownMenuItem<int>>((x)=>DropdownMenuItem(value:int.parse(x['id'].toString()),child:SizedBox(width:220,child:Text(x['name'],overflow:TextOverflow.ellipsis)))).toList(),onChanged:(v)=>uid=v),
      TextFormField(controller:due,decoration:const InputDecoration(labelText:'Devolução prevista (AAAA-MM-DD)'),validator:(v)=>DateTime.tryParse(v??'')==null?'Informe uma data válida.':null)
    ])),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancelar')),FilledButton(onPressed:()=>key.currentState!.validate()?Navigator.pop(c,{'book_id':bid,'user_id':uid,'due_date':due.text}):null,child:const Text('Registrar'))]));
    if(data!=null){try{await ApiClient.instance.post('/loans',body:data);await _load();}catch(e){_msg(e.toString());}}due.dispose();
  }
  Future<void> _return(Map<String,dynamic> l) async {try{await ApiClient.instance.post('/loans/${l['id']}/return');await _load();}catch(e){_msg(e.toString());}}
  @override
  Widget build(BuildContext context)=>RefreshIndicator(onRefresh:_load,child:ListView(padding:const EdgeInsets.all(20),children:[
    Row(children:[Expanded(child:Text('Painel do bibliotecário',style:Theme.of(context).textTheme.headlineSmall?.copyWith(color:AppColors.deep,fontWeight:FontWeight.w800))),IconButton(onPressed:_load,icon:const Icon(Icons.refresh))]),
    const SizedBox(height:5),const Text('Gerencie o acervo, leitores e empréstimos.',style:TextStyle(color:AppColors.secondaryText)),
    const SizedBox(height:14),Wrap(spacing:8,runSpacing:8,children:[_stat('Acervo',_books.length,Icons.menu_book),_stat('Leitores',_readers.length,Icons.people),_stat('Em aberto',_loans.length,Icons.assignment)]),
    const SizedBox(height:16),SegmentedButton<int>(segments:const [ButtonSegment(value:0,label:Text('Livros')),ButtonSegment(value:1,label:Text('Leitores')),ButtonSegment(value:2,label:Text('Empréstimos'))],selected:{_tab},onSelectionChanged:(s)=>setState(()=>_tab=s.first)),
    const SizedBox(height:12),Align(alignment:Alignment.centerRight,child:FilledButton.icon(onPressed:_loading?null:(_tab==0?_bookForm:_tab==1?_readerForm:_loanForm),icon:const Icon(Icons.add),label:Text(_tab==0?'Novo livro':_tab==1?'Novo leitor':'Novo empréstimo'))),
    if(_loading)const Padding(padding:EdgeInsets.all(28),child:Center(child:CircularProgressIndicator()))else if(_error!=null)Padding(padding:const EdgeInsets.all(12),child:Text(_error!,style:const TextStyle(color:Colors.red)))else if(_tab==0)..._books.map((b)=>Card(child:ListTile(title:Text(b['title']),subtitle:Text('${b['author']} • ${b['available_copies']} disponível(is) de ${b['total_copies']}'),trailing:PopupMenuButton<String>(onSelected:(v)async{if(v=='edit')await _bookForm(Map<String,dynamic>.from(b));if(v=='delete'){try{await ApiClient.instance.delete('/books/${b['id']}');await _load();}catch(e){_msg(e.toString());}}},itemBuilder:(_)=>const [PopupMenuItem(value:'edit',child:Text('Editar')),PopupMenuItem(value:'delete',child:Text('Excluir'))]))))else if(_tab==1)..._readers.map((u)=>Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.person)),title:Text(u['name']),subtitle:Text('${u['email']} • ${u['registration_code']??'Sem matrícula'}'))))else if(_tab==2)..._loans.map((l)=>Card(child:ListTile(title:Text(l['book_title']),subtitle:Text('${l['user_name']} • devolver até ${l['due_date']}'),trailing:TextButton(onPressed:()=>_return(Map<String,dynamic>.from(l)),child:const Text('Devolver'))))),
  ]));
  Widget _stat(String t,int n,IconData i)=>Container(padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:AppColors.card,borderRadius:BorderRadius.circular(13),border:Border.all(color:AppColors.border)),child:Row(mainAxisSize:MainAxisSize.min,children:[Icon(i,color:AppColors.forest),const SizedBox(width:7),Text('$t: $n',style:const TextStyle(fontWeight:FontWeight.w700))]));
}
