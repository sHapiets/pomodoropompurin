import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/version_control/client_version_manager.dart';
import 'package:pomodoropompurin/scripts/core/version_control/notes_from_version.dart';
import 'package:pomodoropompurin/scripts/foundation/client_version.dart';

class VersionNotesDialog extends StatefulWidget {
  const VersionNotesDialog({super.key});

  @override
  State<VersionNotesDialog> createState() => _VersionNotesDialogState();
}

class _VersionNotesDialogState extends State<VersionNotesDialog> {
  final clientVersionManager = ClientVersionManager.singleton;
  late ClientVersion selectedVersion;
  final NotesFromVersion notes = NotesFromVersion();

  @override
  void initState() {
    super.initState();

    // Default to most recent version (highest recencyTag)
    selectedVersion = ClientVersion.values.reduce(
      (a, b) => a.recencyTag > b.recencyTag ? a : b,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: DefaultTextStyle(
        style: const TextStyle(fontFamily: "Fredoka"),
        child: SizedBox(
          width: 300,
          height: 420,
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Row(
                  children: [
                    _buildVersionTabs(),
                    const SizedBox(width: 5),
                    Expanded(child: _buildContent()),
                  ],
                ),
              ),
              SizedBox(height: 3),
              _softContent(
                child: Text(
                  "v. ${clientVersionManager.clientVersion.versionNumber}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: const BoxDecoration(
        color: Color.fromARGB(0, 46, 46, 46),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(4), // matches Dialog rounding nicely
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "version notes",
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontWeight: FontWeight.w500,
              fontSize: 30,
              color: Colors.white,
              shadows: [Shadow(color: Colors.black38, offset: Offset(3, 3))],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.white,
              shadows: [Shadow(color: Colors.black38, offset: Offset(3, 3))],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionTabs() {
    final versions = ClientVersion.values.toList()
      ..sort((a, b) => b.recencyTag.compareTo(a.recencyTag));

    return Container(
      width: 50,
      color: const Color.fromARGB(255, 46, 46, 46),
      child: ListView.builder(
        itemCount: versions.length,
        itemBuilder: (context, index) {
          final version = versions[index];
          final isSelected = version == selectedVersion;

          return InkWell(
            onTap: () {
              setState(() => selectedVersion = version);
            },
            child: FittedBox(
              fit: BoxFit.contain,
              child: Container(
                margin: EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  version.versionNumber,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    final foreword = notes.foreword[selectedVersion];
    final patchMap = NotesFromVersion.patches[selectedVersion] ?? {};
    final changeMap = notes.changes[selectedVersion] ?? {};
    final additionMap = notes.additions[selectedVersion] ?? {};

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(232, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Version ${selectedVersion.versionNumber}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "ID: ${selectedVersion.name}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),

              if (foreword != null) ...[
                const Divider(),
                _sectionTitle("RELEASE MEMO", Icons.message_rounded),
                const SizedBox(height: 12),
                Text(
                  foreword,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                ),
                Text(
                  "\n-sHap",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                ),
              ],

              if (patchMap.isNotEmpty) ...[
                const Divider(),
                _sectionTitle("PATCHES", Icons.construction_rounded),
                ...patchMap.entries.map((entry) {
                  final header = entry.key;
                  final bullets = entry.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          header,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        _bulletList(bullets),
                      ],
                    ),
                  );
                }),
              ],

              if (additionMap.isNotEmpty) ...[
                const Divider(),
                _sectionTitle("ADDITIONS", Icons.new_releases_outlined),
                ...additionMap.entries.map((entry) {
                  final header = entry.key;
                  final bullets = entry.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          header,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        _bulletList(bullets),
                      ],
                    ),
                  );
                }),
              ],

              if (changeMap.isNotEmpty) ...[
                const Divider(),
                _sectionTitle("CHANGES", Icons.change_circle_outlined),
                ...changeMap.entries.map((entry) {
                  final header = entry.key;
                  final bullets = entry.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          header,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        _bulletList(bullets),
                      ],
                    ),
                  );
                }),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, IconData titleIcon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 12),
      child: Row(
        children: [
          Icon(titleIcon),
          SizedBox(width: 5),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _bulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .where((e) => e.trim().isNotEmpty)
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• "),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _softContent({required Widget child, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: child,
    );
  }
}
