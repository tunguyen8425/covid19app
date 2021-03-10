import 'package:flutter/material.dart';
import 'package:healthpro/src/config/route.dart';
import 'package:healthpro/src/pages/app2/covid_detail.dart';
import 'package:healthpro/src/pages/app2/direct_detail.dart';
import 'package:healthpro/src/pages/app2/hospital_detail.dart';
import 'package:healthpro/src/pages/app1/form_detail.dart';
import 'package:healthpro/src/pages/app1/login_page.dart';
import 'package:healthpro/src/pages/app1/register_page.dart';
import 'package:healthpro/src/wigets/custom_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/pages/app1/home_page.dart';
import 'src/themes/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Pro ',
      theme:  AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false ,
      routes: Routes.getRoute(),
      // ignore: missing_return
      onGenerateRoute: (RouteSettings settings ){
              final List<String> pathElements = settings.name.split('/');
                if(pathElements[1].contains('hospital_detail')){
                  return CustomRoute<bool>(builder:(BuildContext context)=> HospitalDetailPage());
                }else if(pathElements[1].contains('form_detail')){
                  return CustomRoute<bool>(builder:(BuildContext context)=> FormDetailPage());
                }else if(pathElements[1].contains('covid_detail')){
                  return CustomRoute<bool>(builder:(BuildContext context)=> CovidDetailPage());
                }else if(pathElements[1].contains('direct_detail')){
                  return CustomRoute<bool>(builder:(BuildContext context)=> DirectDetailPage());
                }else if(pathElements[1].contains('login')){
                  return CustomRoute<bool>(builder:(BuildContext context)=> LoginPage());
                }else if(pathElements[1].contains('register')){
                  return CustomRoute<bool>(builder:(BuildContext context)=> RegisterPage());
                }
               
          },
    );
  }
}