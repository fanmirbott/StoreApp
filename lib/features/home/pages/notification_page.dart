import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/data/repositories/notification_repository.dart';
import 'package:storeapp/features/home/managers/notification_bloc.dart';
import 'package:storeapp/features/home/managers/notification_state.dart';
import 'package:storeapp/data/models/notification_model.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      NotificationBloc(notifRepo: context.read()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(AppIcons.backArrow),
          ),
          centerTitle: true,
          title: const Text(
            'Notifications',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: SvgPicture.asset(AppIcons.bell)),
          ],
        ),
        body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());

              case Status.error:
                return Center(
                  child: Text(state.errorMessage ?? "Something went wrong"),
                );
              case Status.success:
                if (state.notifications.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.notifications_none,
                            size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          "You haven’t gotten any notifications yet!",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "We’ll alert you when something cool happens.",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
                final notifications = state.notifications.reversed.toList();
                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final NotificationModel notif = notifications[index];
                    final now = DateTime.now();
                    String header = "";
                    if (index == 0 ||
                        !isSameDay(notifications[index - 1].date, notif.date)) {
                      if (isSameDay(notif.date, now)) {
                        header = "Today";
                      } else if (isSameDay(
                          notif.date, now.subtract(const Duration(days: 1)))) {
                        header = "Yesterday";
                      } else {
                        header = DateFormat.yMMMMd().format(notif.date);
                      }
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (header.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              header,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ListTile(
                          leading: SvgPicture.network(
                            notif.icon,
                            width: 32,
                            height: 32,
                            placeholderBuilder: (context) =>
                            const CircularProgressIndicator(strokeWidth: 2),
                          ),
                          title: Text(notif.title),
                          subtitle: Text(notif.content),
                          trailing: Text(
                            DateFormat.Hm().format(notif.date),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),

                      ],
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }

  bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case "discount":
        return Icons.local_offer;
      case "wallet":
        return Icons.account_balance_wallet;
      case "service":
        return Icons.room_service;
      case "card":
        return Icons.credit_card;
      case "account":
        return Icons.person;
      default:
        return Icons.notifications;
    }
  }
}
