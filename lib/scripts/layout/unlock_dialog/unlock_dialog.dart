import 'package:flutter/material.dart';

class UnlockDialog extends StatefulWidget {
  const UnlockDialog({super.key, required this.unlockedAcquirables});

  final List<List<dynamic>> unlockedAcquirables;

  @override
  State<UnlockDialog> createState() => _UnlockDialogState();
}

class _UnlockDialogState extends State<UnlockDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxHeight: 400, minWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Unlocked Items 🎉",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: widget.unlockedAcquirables.isEmpty
                  ? const Center(child: Text("No items unlocked yet."))
                  : ListView.separated(
                      itemCount: widget.unlockedAcquirables.length,
                      separatorBuilder: (_, __) => const Divider(height: 16),
                      itemBuilder: (context, index) {
                        final item = widget.unlockedAcquirables[index];

                        // Example structure:
                        // item[0] = title (String)
                        // item[1] = subtitle (String)
                        // item[2] = icon (IconData)  <-- optional
                        // item[3] = trailing text (String) <-- optional

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (item.length > 2 && item[2] is IconData)
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(
                                  item[2],
                                  size: 28,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),

                            /// Title
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item[0]?.toString() ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (item.length > 1)
                                    Text(
                                      item[1]?.toString() ?? "",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            /// Optional trailing info
                            if (item.length > 3)
                              Text(
                                item[3]?.toString() ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
            ),

            const SizedBox(height: 16),

            /// Close button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Close"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
