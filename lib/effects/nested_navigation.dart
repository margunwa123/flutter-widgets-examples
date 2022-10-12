import 'package:flutter/material.dart';

const routeHome = '/';
const routeSettings = '/settings';
const routePrefixDeviceSetup = '/setup/';
const routeDeviceSetupStart = '/setup/$routeDeviceSetupStartPage';
const routeDeviceSetupStartPage = 'find_devices';
const routeDeviceSetupSelectDevicePage = 'select_device';
const routeDeviceSetupConnectingPage = 'connecting';
const routeDeviceSetupFinishedPage = 'finished';

class NestedMaterialApp extends StatelessWidget {
  const NestedMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        late Widget page;
        if(settings.name == routeHome) {
          page = const Home();
        }
        else if(settings.name == routeSettings) {
          page = const Settings();
        }
        else if(settings.name!.startsWith(routePrefixDeviceSetup)) {
          final subString = settings.name!.substring(routePrefixDeviceSetup.length);

          page = SetupFlow(
            setupPageRoute: subString
          );
        }
        else {
          throw Exception("Unknown route: ${settings.name}");
        }

        return MaterialPageRoute<dynamic>(
          builder: (_) {
            return page;
          },
          settings: settings
        );
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(routeDeviceSetupStart);
          }, icon: Icon(Icons.play_arrow))
        ],
        title: const Text("Home")),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
    );
  }
}

class SetupFlow extends StatefulWidget {
  SetupFlow({
    super.key,
    required this.setupPageRoute
  });

  final String setupPageRoute;

  @override
  State<SetupFlow> createState() => _SetupFlowState();
}

class _SetupFlowState extends State<SetupFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  void _onDiscoveryComplete() {
    _navigatorKey.currentState!.pushNamed(routeDeviceSetupSelectDevicePage);
  }

  void _onDeviceSelected(String deviceId) {
    _navigatorKey.currentState!.pushNamed(routeDeviceSetupConnectingPage);
  }

  void _onConnectionEstablished() {
    _navigatorKey.currentState!.pushNamed(routeDeviceSetupFinishedPage);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _showAreYouSureDialog,
      child: Scaffold(
        appBar: _buildFlowAppbar(),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.setupPageRoute,
          onGenerateRoute: _onGenerateRoute,
        )
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
  late Widget page;
  switch (settings.name) {
    case routeDeviceSetupStartPage:
      page = WaitingPage(
        message: 'Searching for nearby bulb...',
        onWaitComplete: _onDiscoveryComplete,
      );
      break;
    case routeDeviceSetupSelectDevicePage:
      page = SelectDevicePage(
        onDeviceSelected: _onDeviceSelected,
      );
      break;
    case routeDeviceSetupConnectingPage:
      page = WaitingPage(
        message: 'Connecting...',
        onWaitComplete: _onConnectionEstablished,
      );
      break;
    case routeDeviceSetupFinishedPage:
      page = FinishedPage(
        onFinishPressed: () {
          Navigator.of(context).pop();
        },
      );
      break;
  }

  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
  }


  PreferredSizeWidget _buildFlowAppbar() {
    return AppBar(
      leading: IconButton(onPressed: _onExitPressed, icon: const Icon(Icons.chevron_left)),
      title: const Text('Bulb Setup')
    );
  }

  Future<void> _onExitPressed() async {
    final isSure = await _showAreYouSureDialog();

    if(isSure && mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<bool> _showAreYouSureDialog() async {
    return await showDialog<bool>(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Are you sure quitting the setup process?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            }, 
            style: TextButton.styleFrom(
              textStyle: const TextStyle(color: Colors.red)
          ), 
            child: const Text("No"),),

          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            }, 
            style: TextButton.styleFrom(
              textStyle: const TextStyle(color: Colors.green)
          ), 
            child: const Text("Yes"),)
        ],
      );
    }) ?? false;
  }
}


class SelectDevicePage extends StatelessWidget {
  const SelectDevicePage({
    super.key,
    required this.onDeviceSelected,
  });

  final void Function(String deviceId) onDeviceSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select a nearby device:',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      return const Color(0xFF222222);
                    }),
                  ),
                  onPressed: () {
                    onDeviceSelected('22n483nk5834');
                  },
                  child: const Text(
                    'Bulb 22n483nk5834',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaitingPage extends StatefulWidget {
  const WaitingPage({
    super.key,
    required this.message,
    required this.onWaitComplete,
  });

  final String message;
  final VoidCallback onWaitComplete;

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  void initState() {
    super.initState();
    _startWaiting();
  }

  Future<void> _startWaiting() async {
    await Future<dynamic>.delayed(const Duration(seconds: 3));

    if (mounted) {
      widget.onWaitComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 32),
              Text(widget.message),
            ],
          ),
        ),
      ),
    );
  }
}

class FinishedPage extends StatelessWidget {
  const FinishedPage({
    super.key,
    required this.onFinishPressed,
  });

  final VoidCallback onFinishPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF222222),
                ),
                child: const Center(
                  child: Icon(
                    Icons.lightbulb,
                    size: 175,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Bulb added!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) {
                    return const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12);
                  }),
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    return const Color(0xFF222222);
                  }),
                  shape: MaterialStateProperty.resolveWith((states) {
                    return const StadiumBorder();
                  }),
                ),
                onPressed: onFinishPressed,
                child: const Text(
                  'Finish',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF222222),
                ),
                child: Center(
                  child: Icon(
                    Icons.lightbulb,
                    size: 175,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Add your first bulb',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(routeDeviceSetupStart);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Welcome'),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, routeSettings);
          },
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(8, (index) {
            return Container(
              width: double.infinity,
              height: 54,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF222222),
              ),
            );
          }),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Settings'),
    );
  }
}