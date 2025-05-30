import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:job_pool/data/storage/db/db.dart';
import 'package:provider/provider.dart';

@RoutePage(name: 'HomeTab')
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return Center(child: Text('Interviews'));
  }
}
