import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:storeapp/core/client.dart';
import 'package:storeapp/features/home/managers/product_detail_bloc.dart';
import 'package:storeapp/features/home/managers/product_detail_state.dart';

import '../../../core/utils/icons.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailBloc(detailRepository: context.read())..add(get),
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset(AppIcons.backArrow),
            ),
            centerTitle: true,
            title: const Text(
              'Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: SvgPicture.asset(AppIcons.bell)),
            ],
          ),
          body: Column(
            children: [
              Image.network(
                'https://s9.stc.all.kpcdn.net/sports/wp-content/uploads/2022/03/mycollages-28.jpg',
              ),
              ...List.generate(state.productDetails.length, (index){
                return Text(state.productDetails.first.title);
              })
            ],
          ),
        ),
      ),
    );
  }
}
