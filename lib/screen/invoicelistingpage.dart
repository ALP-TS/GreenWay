import 'package:flutter/material.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';

class Invoicelist extends StatelessWidget {
  const Invoicelist({super.key});

  String _date(dynamic raw) {
    final v = clean(raw);
    if (v.isEmpty) return '—';
    if (int.tryParse(v) != null) return timeconvert(v);
    return v;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar('Invoices'),
      body: AsyncView<List<Map<String, dynamic>>>(
        load: () => invoicelist(userId ?? ''),
        errorAsEmpty: true,
        emptyIcon: Icons.receipt_long_outlined,
        emptyTitle: 'No invoices yet',
        emptyMessage: 'Your fee invoices will appear here once generated.',
        builder: (context, invoicedata, reload) {
          return RefreshIndicator(
            onRefresh: reload,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(Brand.gutter),
              itemCount: invoicedata.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (BuildContext context, int index) {
                final inv = invoicedata[index];
                final paid = inv['status'] == 'paid';
                return AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const IconBadge(
                              icon: Icons.receipt_long_rounded, size: 44),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              clean(inv['fee_name'], 'Fee'),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(width: 8),
                          StatusChip(
                            label: paid ? 'Paid' : 'Pending',
                            color: paid ? Brand.accent : Brand.warning,
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        '₹${clean(inv['amount'], '0')}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _dateCol('From', _date(inv['from_date'])),
                          const SizedBox(width: 12),
                          _dateCol('To', _date(inv['to_date'])),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _dateCol(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 12, color: Brand.textMuted)),
          const SizedBox(height: 2),
          Text(value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
