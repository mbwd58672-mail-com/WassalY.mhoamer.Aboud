import 'package:flutter/material.dart';

void main() => runApp(const WassalyApp());

class WassalyApp extends StatelessWidget {
  const WassalyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'وصلني محمد عبود',
      locale: const Locale('ar'),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1C8F4B)),
        scaffoldBackgroundColor: const Color(0xFFF7F8F5),
        fontFamily: 'Arial',
      ),
      home: const CustomerHome(),
    );
  }
}

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  int selectedIndex = 0;

  static const categories = [
    ('مطاعم', Icons.restaurant_rounded, Color(0xFFFF7043)),
    ('سوبرماركت', Icons.local_grocery_store_rounded, Color(0xFF43A047)),
    ('مشاوير', Icons.delivery_dining_rounded, Color(0xFF42A5F5)),
  ];

  static const shops = [
    ('مطعم الذوق', 'وجبات عربية • توصيل سريع', '4.8', '25 د', 'food'),
    ('ماركت البيت', 'بقالة ومنتجات منزلية', '4.7', '20 د', 'market'),
    ('خدمة المشاوير', 'استلام وتسليم كل احتياجاتك', '4.9', '15 د', 'trip'),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('وصلني', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
              Text('محمد عبود', style: TextStyle(fontSize: 11, color: Color(0xFF777777))),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline_rounded)),
          ],
        ),
        body: _buildBody(),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (value) => setState(() => selectedIndex = value),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'طلباتي'),
            NavigationDestination(icon: Icon(Icons.favorite_outline), selectedIcon: Icon(Icons.favorite), label: 'المفضلة'),
            NavigationDestination(icon: Icon(Icons.menu_rounded), label: 'المزيد'),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (selectedIndex == 1) return _simplePage('طلباتي', Icons.receipt_long_rounded);
    if (selectedIndex == 2) return _simplePage('المفضلة', Icons.favorite_rounded);
    if (selectedIndex == 3) return _dashboardMenu();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFE8F5EC), borderRadius: BorderRadius.circular(18)),
          child: Row(children: [
            const Icon(Icons.location_on_rounded, color: Color(0xFF1C8F4B)),
            const SizedBox(width: 8),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('الموقع الحالي', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('اختر عنوان التوصيل', style: TextStyle(fontWeight: FontWeight.bold)),
            ])),
            TextButton(onPressed: () {}, child: const Text('تغيير')),
          ]),
        ),
        const SizedBox(height: 14),
        TextField(
          decoration: InputDecoration(
            hintText: 'ابحث عن مطعم أو سوبرماركت أو خدمة',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 18),
        const Text('ماذا تحتاج؟', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        Row(
          children: categories.map((item) => Expanded(child: _categoryCard(item.$1, item.$2, item.$3))).toList(),
        ),
        const SizedBox(height: 22),
        const Text('الأقرب إليك', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        ...shops.map((shop) => _shopCard(shop.$1, shop.$2, shop.$3, shop.$4, shop.$5)),
      ],
    );
  }

  Widget _categoryCard(String title, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 112,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(radius: 25, backgroundColor: color.withValues(alpha: .13), child: Icon(icon, color: color, size: 28)),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        ]),
      ),
    );
  }

  Widget _shopCard(String name, String subtitle, String rating, String time, String kind) {
    final icons = {'food': Icons.restaurant, 'market': Icons.local_grocery_store, 'trip': Icons.delivery_dining};
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(color: const Color(0xFFE8F5EC), borderRadius: BorderRadius.circular(14)),
          child: Icon(icons[kind], color: const Color(0xFF1C8F4B), size: 30),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(subtitle),
        trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.star_rounded, size: 16, color: Colors.amber), Text(rating)]),
          Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ]),
      ),
    );
  }

  Widget _simplePage(String title, IconData icon) {
    return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 72, color: const Color(0xFF1C8F4B)),
      const SizedBox(height: 14),
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      const Text('لا توجد عناصر حاليًا'),
    ]));
  }

  Widget _dashboardMenu() {
    const items = [
      ('لوحة الإدارة', Icons.dashboard_rounded),
      ('إدارة المتاجر', Icons.storefront_rounded),
      ('الطَيَّارون', Icons.motorcycle_rounded),
      ('الإعدادات', Icons.settings_rounded),
    ];
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('المزيد', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
      const SizedBox(height: 12),
      ...items.map((item) => Card(child: ListTile(leading: Icon(item.$2, color: const Color(0xFF1C8F4B)), title: Text(item.$1), trailing: const Icon(Icons.chevron_left)))),
    ]);
  }
}
