import 'package:blogapp/core/common/Cubits/app_user_cubit.dart';
import 'package:blogapp/core/consts/constants.dart';
import 'package:blogapp/core/theme/themes.dart';
import 'package:blogapp/features/auth/data/data%20sources/auth_remote_data_source.dart';
import 'package:blogapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repository.dart';
import 'package:blogapp/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/auth/presentation/pages/login_page.dart';
import 'package:blogapp/features/auth/presentation/pages/signup_page.dart';
import 'package:blogapp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blogapp/features/blog/presentation/pages/blog_page.dart';
import 'package:blogapp/firebase_options.dart';
import 'package:blogapp/init_dependencies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final supabase = await Supabase.initialize(
  //     url: appConstants.supabaseUrl,
  //     anonKey: appConstants.anonKey);

  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<BlogBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // initialRoute:
      //   FirebaseAuth.instance.currentUser == null? LoginPage():,
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.themeDark,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if(isLoggedIn){
            return const BlogPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}



