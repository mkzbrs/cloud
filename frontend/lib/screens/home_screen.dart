import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/file_item.dart';
import '../widgets/responsive_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<FileItem> mockFiles = [
    FileItem(name: 'Financial_Report_2026.pdf', size: '2.4 MB', date: 'Today', type: ItemType.document),
    FileItem(name: 'Family_Vacation_Video.mp4', size: '1.2 GB', date: 'Yesterday', type: ItemType.video),
    FileItem(name: 'IMG_9921_RAW.dng', size: '45.1 MB', date: '10 May', type: ItemType.image),
    FileItem(name: 'Project_Architecture.zip', size: '150 MB', date: '08 May', type: ItemType.other),
  ];

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Tambah Fail Baru'),
        message: const Text('Pilih jenis fail untuk muat naik ke server.'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(onPressed: () => Navigator.pop(context), child: const Text('Muat Naik Gambar')),
          CupertinoActionSheetAction(onPressed: () => Navigator.pop(context), child: const Text('Muat Naik Dokumen')),
          CupertinoActionSheetAction(onPressed: () => Navigator.pop(context), child: const Text('Cipta Folder Baru')),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = CupertinoColors.systemGroupedBackground.resolveFrom(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Stack(
      children: [
        IndexedStack(
          index: _selectedIndex,
          children: [
            _buildMainContent(context),
            _buildPlaceholder('Semua Fail'),
            _buildSettingsScreen(context),
          ],
        ),
        Positioned(
          bottom: 30,
          left: 50,
          right: 50,
          child: _buildGlassmorphismMenu(context),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 260,
          decoration: BoxDecoration(
            border: Border(right: BorderSide(color: CupertinoColors.systemGrey4.resolveFrom(context), width: 0.5)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Icon(CupertinoIcons.cloud_fill, size: 50, color: CupertinoColors.activeBlue),
              const SizedBox(height: 10),
              const Text('Cloud', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              _buildSidebarItem(0, CupertinoIcons.home, 'Home'),
              _buildSidebarItem(1, CupertinoIcons.folder, 'All Files'),
              _buildSidebarItem(2, CupertinoIcons.settings, 'Settings'),
            ],
          ),
        ),
        Expanded(
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              _buildMainContent(context),
              _buildPlaceholder('Semua Fail'),
              _buildSettingsScreen(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSidebarItem(int index, IconData icon, String title) {
    final isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? CupertinoColors.activeBlue.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? CupertinoColors.activeBlue : CupertinoColors.systemGrey, size: 22),
            const SizedBox(width: 12),
            Text(title, style: TextStyle(
              fontSize: 15,
              color: isActive ? CupertinoColors.activeBlue : CupertinoColors.label,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassmorphismMenu(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 70,
          color: CupertinoColors.systemBackground.resolveFrom(context).withValues(alpha: 0.7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomNavItem(0, CupertinoIcons.home),
              _buildBottomNavItem(1, CupertinoIcons.folder),
              _buildBottomNavItem(2, CupertinoIcons.settings),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(int index, IconData icon) {
    final isActive = _selectedIndex == index;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => setState(() => _selectedIndex = index),
      child: Icon(icon, size: 26, color: isActive ? CupertinoColors.activeBlue : CupertinoColors.systemGrey),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CupertinoSliverNavigationBar(
          largeTitle: Text('Cloud'),
          border: null,
          backgroundColor: Colors.transparent,
          transitionBetweenRoutes: false,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const CupertinoSearchTextField(placeholder: 'Cari fail...'),
                const SizedBox(height: 24),
                // Storage Widget Asal
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBackground.resolveFrom(context),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Home Server', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Icon(CupertinoIcons.desktopcomputer, color: CupertinoColors.activeBlue),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: const LinearProgressIndicator(
                          value: 0.3,
                          minHeight: 8,
                          backgroundColor: CupertinoColors.systemGrey5,
                          valueColor: AlwaysStoppedAnimation<Color>(CupertinoColors.activeBlue),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('1.2 TB / 4 TB Digunakan', style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton(CupertinoIcons.cloud_upload_fill, 'Upload', context, () => _showActionSheet(context)),
                    _buildActionButton(CupertinoIcons.folder_badge_plus, 'Folder', context, () => _showActionSheet(context)),
                    _buildActionButton(CupertinoIcons.doc_text_viewfinder, 'Scan', context, () {}),
                  ],
                ),
                const SizedBox(height: 32),
                const Text('Recent Files', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: CupertinoListSection.insetGrouped(
            backgroundColor: Colors.transparent,
            children: mockFiles.map((file) => CupertinoListTile(
              leading: _buildFileIcon(file.type),
              title: Text(file.name, style: const TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('${file.date} • ${file.size}'),
              trailing: const Icon(CupertinoIcons.ellipsis, color: CupertinoColors.systemGrey),
            )).toList(),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }

  Widget _buildSettingsScreen(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CupertinoSliverNavigationBar(
          largeTitle: Text('Settings'),
          transitionBetweenRoutes: false,
        ),
        SliverToBoxAdapter(
          child: CupertinoListSection.insetGrouped(
            children: [
              const CupertinoListTile(
                leading: Icon(CupertinoIcons.person_solid, color: CupertinoColors.activeBlue),
                title: Text('Admin MK'),
                additionalInfo: Text('drive.mkzbrs.com'),
              ),
              const CupertinoListTile(
                leading: Icon(CupertinoIcons.cloud, color: CupertinoColors.activeGreen),
                title: Text('Server Status'),
                additionalInfo: Text('Online'),
              ),
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.escape, color: CupertinoColors.destructiveRed),
                title: const Text('Log Out', style: TextStyle(color: CupertinoColors.destructiveRed)),
                onTap: () => Navigator.pushReplacementNamed(context, '/'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(String title) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(largeTitle: Text(title), transitionBetweenRoutes: false),
        const SliverFillRemaining(child: Center(child: Icon(CupertinoIcons.folder_open, size: 100, color: CupertinoColors.systemGrey4))),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, BuildContext context, VoidCallback onTap) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Column(
        children: [
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground.resolveFrom(context),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Icon(icon, color: CupertinoColors.activeBlue, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: CupertinoColors.label)),
        ],
      ),
    );
  }

  Widget _buildFileIcon(ItemType type) {
    IconData icon; Color color;
    switch (type) {
      case ItemType.folder: icon = CupertinoIcons.folder_fill; color = CupertinoColors.activeBlue; break;
      case ItemType.document: icon = CupertinoIcons.doc_fill; color = CupertinoColors.systemRed; break;
      case ItemType.image: icon = CupertinoIcons.photo_fill; color = CupertinoColors.activeGreen; break;
      case ItemType.video: icon = CupertinoIcons.play_rectangle_fill; color = CupertinoColors.systemPurple; break;
      default: icon = CupertinoIcons.doc; color = CupertinoColors.systemGrey;
    }
    return Icon(icon, color: color, size: 28);
  }
}