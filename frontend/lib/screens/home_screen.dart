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
  final List<FileItem> mockFiles = [
    FileItem(name: 'Financial_Report_2026.pdf', size: '2.4 MB', date: 'Today', type: ItemType.document),
    FileItem(name: 'Family_Vacation_Video.mp4', size: '1.2 GB', date: 'Yesterday', type: ItemType.video),
    FileItem(name: 'IMG_9921_RAW.dng', size: '45.1 MB', date: '10 May', type: ItemType.image),
    FileItem(name: 'Project_Architecture.zip', size: '150 MB', date: '08 May', type: ItemType.other),
  ];

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

  // ==========================================
  // LAYOUT 1: MOBILE (Menu Kat Bawah)
  // ==========================================
  Widget _buildMobileLayout(BuildContext context) {
    return Stack(
      children: [
        _buildMainContent(context),
        Positioned(
          bottom: 30,
          left: 50,
          right: 50,
          child: _buildGlassmorphismMenu(context, isMobile: true),
        ),
      ],
    );
  }

  // ==========================================
  // LAYOUT 2: DESKTOP / WEB (Sidebar Kat Kiri)
  // ==========================================
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 250,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: CupertinoColors.systemGrey4.resolveFrom(context),
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Icon(CupertinoIcons.cloud_fill, size: 60, color: CupertinoColors.activeBlue),
              const SizedBox(height: 10),
              const Text('MK-Cloud', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              _buildSidebarItem(CupertinoIcons.home, 'Home', isActive: true),
              _buildSidebarItem(CupertinoIcons.folder, 'All Files'),
              _buildSidebarItem(CupertinoIcons.settings, 'Settings'),
            ],
          ),
        ),
        Expanded(
          child: _buildMainContent(context),
        ),
      ],
    );
  }

  // ==========================================
  // KOMPONEN-KOMPONEN UI (Dikitar Semula)
  // ==========================================
  
  // Sidebar Item
  Widget _buildSidebarItem(IconData icon, String title, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? CupertinoColors.activeBlue.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? CupertinoColors.activeBlue : CupertinoColors.systemGrey, size: 24),
            const SizedBox(width: 15),
            Text(title, style: TextStyle(
              fontSize: 16, 
              color: isActive ? CupertinoColors.activeBlue : CupertinoColors.label,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            )),
          ],
        ),
      ),
    );
  }

  // Menu Glassmorphism (Khas untuk Mobile)
  Widget _buildGlassmorphismMenu(BuildContext context, {required bool isMobile}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 70,
          color: CupertinoColors.systemBackground.resolveFrom(context).withValues(alpha: 0.75),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(CupertinoIcons.home, size: 28, color: CupertinoColors.activeBlue),
              Icon(CupertinoIcons.folder, size: 28, color: CupertinoColors.systemGrey),
              Icon(CupertinoIcons.settings, size: 28, color: CupertinoColors.systemGrey),
            ],
          ),
        ),
      ),
    );
  }

  // Senarai Fail & Header Utama (Diguna oleh Mobile & Desktop)
  Widget _buildMainContent(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CupertinoSliverNavigationBar(
          largeTitle: Text('Cloud'),
          border: null,
          backgroundColor: Colors.transparent,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const CupertinoSearchTextField(placeholder: 'Cari fail di server...'),
                const SizedBox(height: 24),
                // Storage Widget
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBackground.resolveFrom(context),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
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
                    _buildActionButton(CupertinoIcons.cloud_upload_fill, 'Upload', context),
                    _buildActionButton(CupertinoIcons.folder_badge_plus, 'Folder', context),
                    _buildActionButton(CupertinoIcons.doc_text_viewfinder, 'Scan', context),
                  ],
                ),
                const SizedBox(height: 32),
                const Text('Recent Files', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: CupertinoListSection.insetGrouped(
            backgroundColor: Colors.transparent,
            children: mockFiles.map((file) {
              return CupertinoListTile(
                leading: _buildFileIcon(file.type),
                leadingSize: 40,
                title: Text(file.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('${file.date} • ${file.size}'),
                trailing: const Icon(CupertinoIcons.ellipsis, color: CupertinoColors.systemGrey),
                onTap: () {},
              );
            }).toList(),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8, offset: const Offset(0, 2)),
            ],
          ),
          child: Icon(icon, color: CupertinoColors.activeBlue, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildFileIcon(ItemType type) {
    IconData iconData;
    Color iconColor;
    switch (type) {
      case ItemType.folder: iconData = CupertinoIcons.folder_fill; iconColor = CupertinoColors.activeBlue; break;
      case ItemType.document: iconData = CupertinoIcons.doc_fill; iconColor = CupertinoColors.destructiveRed; break;
      case ItemType.image: iconData = CupertinoIcons.photo_fill; iconColor = CupertinoColors.activeGreen; break;
      case ItemType.video: iconData = CupertinoIcons.play_rectangle_fill; iconColor = CupertinoColors.systemPurple; break;
      default: iconData = CupertinoIcons.doc; iconColor = CupertinoColors.systemGrey;
    }
    return Icon(iconData, color: iconColor, size: 35);
  }
}