import 'package:flutter/material.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:pay_tracker/types/insights_screen/spending_analytics/places_spent.dart';
import 'package:provider/provider.dart';

class PlacesSpentGraph extends StatelessWidget {
  const PlacesSpentGraph({super.key});

  @override
  Widget build(BuildContext context) {
    MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context);
    PlacesSpent placesSpent = messageStoreModel
        .getPlacesSpent(messageStoreModel.selectedMonthAndYear);

    return Container();
  }
}
