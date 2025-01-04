import 'package:declarative_navigation/model/quote.dart';
import 'package:declarative_navigation/screen/quote_detail_screen.dart';
import 'package:declarative_navigation/screen/quotes_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const QuotesApp());
}

class QuotesApp extends StatefulWidget {
  const QuotesApp({super.key});

  @override
  State<QuotesApp> createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  String? selectedQuote;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes App',
      home: Navigator(
        pages: [
          MaterialPage(
            child: QuotesListScreen(
              key: const ValueKey("QuotesListPage"),
              quotes: quotes,
              onTapped: (String quoteId) {
                setState(() {
                  selectedQuote = quoteId;
                });
              }
            ),
          ),
          if (selectedQuote != null)
            MaterialPage(
              key: ValueKey("QuoteDetailsPage-$selectedQuote"),
              child: QuoteDetailsScreen(
                quoteId: selectedQuote!
              )
            )
        ],
        onPopPage: (route, result) {
          final didPop = route.didPop(result);
          if (!didPop) {
            return false;
          }

          setState(() {
            selectedQuote = null;
          });

          return true;
        },
      ),
    );
  }
}