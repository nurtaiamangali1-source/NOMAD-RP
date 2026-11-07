import 'package:flutter/material.dart';

void main() => runApp(const NomadLauncherApp());

const gold = Color(0xFFD8B46A);
const bg = Color(0xFF0A0D12);

class NomadLauncherApp extends StatelessWidget {
  const NomadLauncherApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'NOMAD RP',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(seedColor: gold, brightness: Brightness.dark),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: const Color(0xFF171C23),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white12)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white12)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: gold)),
        labelStyle: const TextStyle(color: Colors.white60),
      ),
    ),
    home: const LauncherHome(),
  );
}

class LauncherHome extends StatefulWidget {
  const LauncherHome({super.key});
  @override
  State<LauncherHome> createState() => _LauncherHomeState();
}

class _LauncherHomeState extends State<LauncherHome> {
  int page = 0;
  bool isRegister = false;
  String gender = 'male';
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    loginController.dispose(); passwordController.dispose();
    firstNameController.dispose(); lastNameController.dispose();
    super.dispose();
  }

  void toast(String message) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: const Color(0xFF252B34)));

  Widget field(String label, TextEditingController controller, {bool secret=false}) =>
    TextField(controller: controller, obscureText: secret,
      decoration: InputDecoration(labelText: label));

  Widget goldButton(String label, VoidCallback action) => SizedBox(
    height: 54, child: FilledButton(
      style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: bg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      onPressed: action,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.3)),
    ));

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(22),
      child: Column(children: [
        header(),
        const SizedBox(height: 22),
        Expanded(child: AnimatedSwitcher(duration: const Duration(milliseconds: 220),
          child: page == 0 ? homePage() : page == 1 ? authPage() : page == 2 ? characterPage() : serverPage())),
        const SizedBox(height: 10),
        const Text('NOMAD RP • 0.1.0 • ҚАЗАҚСТАН',
          style: TextStyle(fontSize: 9, color: Colors.white30, letterSpacing: 1.5)),
      ]),
    )),
  );

  Widget header() => Row(children: [
    Container(width: 44, height: 44, decoration: BoxDecoration(
      border: Border.all(color: gold, width: 1.5), borderRadius: BorderRadius.circular(12)),
      child: const Icon(Icons.landscape, color: gold)),
    const SizedBox(width: 12),
    const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('NOMAD', style: TextStyle(fontSize: 21, letterSpacing: 4, fontWeight: FontWeight.w900)),
      Text('ҚАЗАҚСТАН ROLEPLAY', style: TextStyle(fontSize: 9, letterSpacing: 2, color: Colors.white54)),
    ]),
    const Spacer(),
    IconButton(onPressed: () => toast('Баптаулар келесі кезеңде қосылады.'),
      icon: const Icon(Icons.settings_outlined, color: Colors.white70)),
  ]);

  Widget homePage() => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    Expanded(child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [Color(0xFF263541), Color(0xFF10151B), Color(0xFF090B0F)]),
        borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(Icons.landscape, size: 76, color: Color(0x33D8B46A)),
          const Text('СЕНІҢ ТАРИХЫҢ\\nОСЫ ЖЕРДЕН БАСТАЛАДЫ',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900, height: 1.16)),
          const SizedBox(height: 12),
          const Text('Заманауи Қазақстан. Жаңа өмір. Сенің таңдауың.',
            style: TextStyle(color: Colors.white60)),
          const SizedBox(height: 18),
          statusPill(),
        ],
      ),
    )),
    const SizedBox(height: 18),
    goldButton('ОЙЫНҒА КІРУ', () => setState(() => page = 1)),
    const SizedBox(height: 10),
    OutlinedButton(onPressed: () { isRegister = true; setState(() => page = 1); },
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
      child: const Text('ТІРКЕЛУ')),
  ]);

  Widget statusPill() => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.white12)),
    child: const Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.circle, color: Colors.orange, size: 8), SizedBox(width: 8),
      Text('СЕРВЕР ӘЗІРЛЕНУ ҮСТІНДЕ', style: TextStyle(fontSize: 10, letterSpacing: 1.1)),
    ]));

  Widget authPage() => ListView(children: [
    const SizedBox(height: 8),
    Text(isRegister ? 'АККАУНТ ТІРКЕУ' : 'АККАУНТҚА КІРУ',
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
    const SizedBox(height: 8),
    const Text('Логин мен құпиясөзді енгізіңіз.', style: TextStyle(color: Colors.white54)),
    const SizedBox(height: 22),
    field('Логин (ағылшын әріптері)', loginController),
    const SizedBox(height: 12),
    field('Құпиясөз', passwordController, secret: true),
    const SizedBox(height: 18),
    goldButton(isRegister ? 'ТІРКЕЛУ' : 'КІРУ', () {
      if (loginController.text.trim().length < 3 || passwordController.text.length < 8) {
        toast('Логин кемінде 3 таңба, құпиясөз кемінде 8 таңба болуы керек.');
        return;
      }
      toast('API серверіне қосылу келесі интеграция кезеңінде іске қосылады.');
      setState(() => page = 2);
    }),
    TextButton(onPressed: () => setState(() => isRegister = !isRegister),
      child: Text(isRegister ? 'Аккаунтыңыз бар ма? Кіру' : 'Аккаунтыңыз жоқ па? Тіркелу')),
    TextButton(onPressed: () => setState(() => page = 0), child: const Text('← Басты бетке қайту')),
  ]);

  Widget characterPage() => ListView(children: [
    const Text('КЕЙІПКЕР ЖАСАУ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
    const SizedBox(height: 8),
    const Text('Кейіпкеріңе қазақша аты-жөн бер.', style: TextStyle(color: Colors.white54)),
    const SizedBox(height: 22),
    field('Аты', firstNameController),
    const SizedBox(height: 12),
    field('Тегі', lastNameController),
    const SizedBox(height: 16),
    const Text('ЖЫНЫСЫ', style: TextStyle(color: gold, letterSpacing: 1.2)),
    const SizedBox(height: 8),
    SegmentedButton<String>(segments: const [
      ButtonSegment(value: 'male', label: Text('Ер адам'), icon: Icon(Icons.male)),
      ButtonSegment(value: 'female', label: Text('Әйел'), icon: Icon(Icons.female)),
    ], selected: {gender}, onSelectionChanged: (v) => setState(() => gender = v.first)),
    const SizedBox(height: 20),
    goldButton('КЕЙІПКЕРДІ ҚҰРУ', () {
      if (firstNameController.text.trim().isEmpty || lastNameController.text.trim().isEmpty) {
        toast('Аты мен тегін енгізіңіз.'); return;
      }
      toast('Кейіпкер API арқылы сақталуы керек. Қазір UI прототипі.');
      setState(() => page = 3);
    }),
    TextButton(onPressed: () => setState(() => page = 1), child: const Text('← Артқа')),
  ]);

  Widget serverPage() => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    const Text('СЕРВЕР ТАҢДАУ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: const Color(0xFF171C23), borderRadius: BorderRadius.circular(18),
        border: Border.all(color: gold.withValues(alpha: 0.5))),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('NOMAD RP | KAZAKHSTAN', style: TextStyle(fontWeight: FontWeight.w900, color: gold)),
        SizedBox(height: 8), Text('Күйі: Әзірленуде'),
        Text('Ойыншылар: 0 / 500', style: TextStyle(color: Colors.white54)),
        SizedBox(height: 10), Text('Ойын клиенті әлі қосылмаған.', style: TextStyle(color: Colors.orangeAccent)),
      ])),
    const Spacer(),
    goldButton('СЕРВЕРГЕ ҚОСЫЛУ', () => toast('Үйлесімді мобильді SA-MP клиенті интеграциялануы қажет.')),
    TextButton(onPressed: () => setState(() => page = 0), child: const Text('← Басты бет')),
  ]);
}
