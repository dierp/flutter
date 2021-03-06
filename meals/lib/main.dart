import 'package:flutter/material.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';

import './utils/app_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Recipes',
        theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.amber,
            fontFamily: 'Raleway',
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                  ),
                )),
        routes: {
          AppRoutes.HOME: (ctx) => CategoriesScreen(),
          AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsScreen(),
          AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreen(),
        });
  }
}
