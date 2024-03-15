import 'package:beat_wave/bloc/all_song/all_song_bloc.dart';
import 'package:beat_wave/bloc/all_song/all_song_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beat_wave/permission/premission.dart';
import 'package:beat_wave/view/home_screens.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool per = true;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    permission();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    controller!.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/splashscreen.png",
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                    child: per == true
                        ? SpinKitThreeBounce(
                            controller: controller!,
                            size: 18,
                            color: Colors.white,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/folder-security-svgrepo-com.svg",
                                // ignore: deprecated_member_use
                                color: Colors.white,
                                height: 55,
                                width: 55,
                              ),
                              const SizedBox(
                                height: 22,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 67),
                                child: Text(
                                  "Access is not granted",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'ROBR',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 55),
                                child: Text(
                                  "To display and play your music, Beat Wave needs access to the storage space to get the music information",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'ROBR',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(136, 40),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          side: const BorderSide(
                                              color: Colors.white, width: 1.5),
                                          backgroundColor: Colors.transparent),
                                      onPressed: () async {
                                        await openAppSettings();
                                      },
                                      child: const Text(
                                        "Open settings",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'ROBR',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(136, 40),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          side: const BorderSide(
                                              color: Colors.white, width: 1.5),
                                          backgroundColor: Colors.white),
                                      onPressed: () async {
                                        permission();
                                      },
                                      child: const Text(
                                        "log in",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'ROBR',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          )),
              ),
              const Text(
                "Developed by Mohammad Mahdi",
                style: TextStyle(
                  color: Color.fromARGB(174, 244, 244, 244),
                  fontSize: 13,
                  fontFamily: 'ROBR',
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          )),
    );
  }

  void permission() {
    Future.delayed(const Duration(seconds: 2), () async {
      await AppPremission.storage().then((value) {
        if (value) {
          navigate();
        } else {
          per = value;
          setState(() {});
        }
      });
    });
  }

  void navigate() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => BlocProvider(
              create: (context) {
                var allSongBloc = AllSongBloc();
                allSongBloc.add(GetAllSong());
                return allSongBloc;
              },
              child: const HomeScreen(),
            )));
  }
}
