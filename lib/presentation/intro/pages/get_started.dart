import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/presentation/choose_mode/pages/choose_mode.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.introBG), fit: BoxFit.fill)),
        ),
        Container(
          color: Colors.black.withOpacity(0.15),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(AppVectors.logo),
              ),
              const Spacer(),
              const Text(
                'Enjoy Listening to Musing',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 21,
              ),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer sit amet tempor neque. Suspendisse tempor neque non rhoncus porttitor. Vivamus at sapien et ante sodales pretium in ut leo.',
                style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              BasicAppButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ChooseModePage();
                    }));
                  },
                  title: 'Get Started'),
            ],
          ),
        ),
      ],
    ));
  }
}
