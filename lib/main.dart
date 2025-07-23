import 'package:ecommerce_app/Data/Bloc/Categories/Categories_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Category_products/category_products_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Product/product_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/User/user_bloc.dart';
import 'package:ecommerce_app/Data/Helper/api_helper.dart';
import 'package:ecommerce_app/Data/Repository/categories_repo.dart';
import 'package:ecommerce_app/Data/Repository/products_repository.dart';
import 'package:ecommerce_app/Data/Repository/user_repository.dart';
import 'package:ecommerce_app/Utilities/Data/app_routes.dart';
import 'package:ecommerce_app/Utilities/Theme/theme_helper.dart';
import 'package:ecommerce_app/Utilities/Theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>
            CategoryProductBloc(
              repo: CategoriesRepo(apiHelper: ApiHelper(),),),),
        BlocProvider(create: (context) =>
            CategoriesBloc(repo: CategoriesRepo(apiHelper: ApiHelper(),),),),
        BlocProvider(
          create: (context) =>
              ProductBloc(repo: ProductRepo(apiHelper: ApiHelper())),
        ),
        BlocProvider(
          create: (context) =>
              UserBloc(repo: UserRepository(apiHelper: ApiHelper())),
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ThemeProvider();
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          themeMode: value.getTheme(),
          theme: ThemeHelper().lightTheme(),
          darkTheme: ThemeHelper().darkTheme(),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splashScreen,
          routes: AppRoutes().routes,
        );
      },
    );
  }
}
