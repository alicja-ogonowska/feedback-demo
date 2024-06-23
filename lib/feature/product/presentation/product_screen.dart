import 'package:feedback_demo/di/service_locator.dart';
import 'package:feedback_demo/feature/ab_testing/presentation/ab_test_cubit.dart';
import 'package:feedback_demo/feature/analytics/analytics_service.dart';
import 'package:feedback_demo/feature/product/data/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiredash/wiredash.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          style: TextStyle(color: theme.colorScheme.onPrimary),
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product.image,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    product.image,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    product.category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: SizedBox(
          width: double.infinity,
          child:
              BlocBuilder<ABTestCubit, ABTestState>(builder: (context, state) {
            return ElevatedButton(
              onPressed: () {
                const snackBar = SnackBar(
                  content: Text('Item purchased!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                getIt
                    .get<AnalyticsService>()
                    .logPurchase(amount: product.price, currency: 'USD');
                // _showPromoterSurvey(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: state.config.addToCartAccentColorValue
                    ? Colors.orange
                    : primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void _showPromoterSurvey(BuildContext context) {
    Wiredash.of(context).showPromoterSurvey(
      force: true,
      options: const PsOptions(
        // minimum time between two surveys
        frequency: Duration(days: 90),
        // delay before the first survey is available
        initialDelay: Duration(days: 7),
        // minimum number of app starts before the survey will be shown
        minimumAppStarts: 3,
      ),
    );
  }
}
