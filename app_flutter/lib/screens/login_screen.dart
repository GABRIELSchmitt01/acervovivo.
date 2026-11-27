import 'package:flutter/material.dart';
import '../data/api_client.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.onLoggedIn, super.key});
  final VoidCallback onLoggedIn;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false, _showPassword = false;
  String? _error;
  @override
  void dispose() { _email.dispose(); _password.dispose(); super.dispose(); }
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });
    try { await ApiClient.instance.login(_email.text, _password.text); if (mounted) widget.onLoggedIn(); }
    catch (e) { if (mounted) setState(() => _error = e.toString().replaceFirst('Exception: ','')); }
    finally { if (mounted) setState(() => _loading = false); }
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.canvas,
    body: SafeArea(child: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 420), child: Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(height:68,alignment:Alignment.center,decoration:BoxDecoration(color:AppColors.forest,borderRadius:BorderRadius.circular(22)),child:const Icon(Icons.menu_book_rounded,color:Colors.white,size:36)),
          const SizedBox(height:22),
          Text('AcervoVivo',textAlign:TextAlign.center,style:Theme.of(context).textTheme.headlineMedium?.copyWith(color:AppColors.deep,fontWeight:FontWeight.w800)),
          const SizedBox(height:6),
          const Text('Entre para acessar sua biblioteca',textAlign:TextAlign.center,style:TextStyle(color:AppColors.secondaryText)),
          const SizedBox(height:30),
          TextFormField(controller:_email,keyboardType:TextInputType.emailAddress,autofillHints:const [AutofillHints.email],decoration:const InputDecoration(labelText:'E-mail',prefixIcon:Icon(Icons.email_outlined)),validator:(v)=>v==null||!v.contains('@')?'Informe um e-mail válido.':null),
          const SizedBox(height:14),
          TextFormField(controller:_password,obscureText:!_showPassword,autofillHints:const [AutofillHints.password],decoration:InputDecoration(labelText:'Senha',prefixIcon:const Icon(Icons.lock_outline),suffixIcon:IconButton(onPressed:()=>setState(()=>_showPassword=!_showPassword),icon:Icon(_showPassword?Icons.visibility_off:Icons.visibility))),validator:(v)=>v==null||v.isEmpty?'Informe sua senha.':null,onFieldSubmitted:(_)=>_submit()),
          if(_error!=null)...[const SizedBox(height:12),Text(_error!,style:const TextStyle(color:Colors.red),textAlign:TextAlign.center)],
          const SizedBox(height:22),
          FilledButton(onPressed:_loading?null:_submit,style:FilledButton.styleFrom(backgroundColor:AppColors.forest,padding:const EdgeInsets.symmetric(vertical:16)),child:_loading?const SizedBox(width:20,height:20,child:CircularProgressIndicator(strokeWidth:2,color:Colors.white)):const Text('Entrar')),
          const SizedBox(height:14),
          const Text('O cadastro é fornecido pela biblioteca. Se ainda não possui acesso, procure o bibliotecário.',textAlign:TextAlign.center,style:TextStyle(color:AppColors.secondaryText,fontSize:12,height:1.5)),
        ]),
      )),
    ))),
  );
}