import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:festivals_exam_4/logic/blocs/auth/auth_bloc.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_bloc.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_events.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_states.dart';
import 'package:festivals_exam_4/logic/blocs/theme/theme_bloc.dart';
import 'package:festivals_exam_4/logic/blocs/theme/theme_events.dart';
import 'package:festivals_exam_4/logic/blocs/theme/theme_state.dart';
import 'package:festivals_exam_4/services/festivals_http_services.dart';
import 'package:festivals_exam_4/ui/screens/festival_info_screen.dart';
import 'package:festivals_exam_4/ui/screens/notifications_screen.dart';
import 'package:festivals_exam_4/ui/widgets/weekly_festivals_card.dart';
import 'package:festivals_exam_4/utils/app_styles.dart';
import 'package:festivals_exam_4/utils/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

  final FestivalsHttpServices festivalsHttpServices = FestivalsHttpServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Bosh sahifa",
          style: AppTextStyles.headline24,
        ),
        actions: [
          IconButton(
              onPressed: () {
                festivalsHttpServices.addFestival(
                  "something",
                  [2024, 10, 16],
                  [20, 45],
                  'THis is description',
                  "https://ideafoster.com/wp-content/uploads/2023/03/hackaton-concepto-funciona-922.jpeg",
                  [24, 35],
                );
              },
              icon: Icon(Icons.add)),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_active,
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<FestivalsBloc, FestivalsState>(
              bloc: context.read<FestivalsBloc>()..add(GetFestivalWithinWeek()),
              builder: (ctx, state) {
                if (state is LoadingFestivalsState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ErrorProductsState) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                if (state is LoadedFestivalsState) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Aligns children to the start
                      children: [
                        Text(
                          "Barcha tadbirlar",
                          style: AppTextStyles.headline20,
                        ),
                        const SizedBox(
                            height:
                                20), // Adds space between the text and the carousel
                        Expanded(
                          child: CarouselSlider.builder(
                            itemCount: state.festivals.length,
                            itemBuilder: (context, index, realIndex) {
                              final festival = state.festivals[index];
                              return WeeklyFestivalsCard(festival: festival);
                            },
                            options: CarouselOptions(
                              height: 400,
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const Center(
                  child: Text("Tadbirlar mavjud emas"),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<FestivalsBloc, FestivalsState>(
              bloc: context.read<FestivalsBloc>()..add(GetFestivalsEvent()),
              builder: (ctx, state) {
                if (state is LoadingFestivalsState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ErrorProductsState) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                if (state is LoadedFestivalsState) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Barcha tadbirlar",
                          style: AppTextStyles.headline20,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.festivals.length,
                            itemBuilder: (ctx, index) {
                              final festival = state.festivals[index];
                              DateTime date = festival.time;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return FestivalInfoScreen(
                                        festival: festival,
                                      );
                                    },
                                  ));
                                },
                                child: Card(
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 150,
                                          height: 120,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Image.network(
                                            festival.imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                festival.name,
                                                maxLines: 2,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(date.formatDateWithWeekday())
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const Center(
                  child: Text("Mahsulotlar mavjud emas"),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(child: Icon(Icons.abc)),
            const ListTile(
              title: Text("user information"),
            ),
            ListTile(
              title: Text("Logout"),
              leading: IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                },
                icon: const Icon(Icons.logout),
              ),
            ),
            ListTile(
              title: Text("Dark MOde"),
              leading: IconButton(
                onPressed: () {
                  AdaptiveTheme.of(context).toggleThemeMode(useSystem: false);
                  // context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
                icon: const Icon(Icons.night_shelter),
              ),
            )
          ],
        ),
      ),
    );
  }
}



  ///barcha festivallar
      // body: BlocBuilder<FestivalsBloc, FestivalsState>(
      //   bloc: context.read<FestivalsBloc>()..add(GetFestivalsEvent()),
      //   builder: (ctx, state) {
      //     if (state is LoadingFestivalsState) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }

      //     if (state is ErrorProductsState) {
      //       return Center(
      //         child: Text(state.message),
      //       );
      //     }

      //     if (state is LoadedFestivalsState) {
      //       return Padding(
      //         padding: const EdgeInsets.all(20.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               "Barcha tadbirlar",
      //               style: AppTextStyles.headline20,
      //             ),
      //             Expanded(
      //               child: ListView.builder(
      //                 itemCount: state.festivals.length,
      //                 itemBuilder: (ctx, index) {
      //                   final festival = state.festivals[index];
      //                   DateTime date = festival.time;
      //                   return GestureDetector(
      //                     onTap: () {
      //                       Navigator.push(context, MaterialPageRoute(
      //                         builder: (context) {
      //                           return FestivalInfoScreen(
      //                             festival: festival,
      //                           );
      //                         },
      //                       ));
      //                     },
      //                     child: Card(
      //                       child: Container(
      //                         padding: const EdgeInsets.all(20),
      //                         child: Row(
      //                           children: [
      //                             Container(
      //                               width: 150,
      //                               height: 120,
      //                               clipBehavior: Clip.hardEdge,
      //                               decoration: BoxDecoration(
      //                                 borderRadius: BorderRadius.circular(20),
      //                               ),
      //                               child: Image.network(
      //                                 festival.imageUrl,
      //                                 fit: BoxFit.cover,
      //                               ),
      //                             ),
      //                             const SizedBox(
      //                               width: 30,
      //                             ),
      //                             Column(
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               children: [
      //                                 Text(festival.name),
      //                                 const SizedBox(
      //                                   height: 10,
      //                                 ),
      //                                 Text(date.formatDateWithWeekday())
      //                               ],
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                   );
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //       );
      //     }

      //     return const Center(
      //       child: Text("Mahsulotlar mavjud emas"),
      //     );
      //   },
      // ),