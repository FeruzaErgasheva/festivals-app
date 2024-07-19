import 'package:carousel_slider/carousel_slider.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_bloc.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_events.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_states.dart';
import 'package:festivals_exam_4/services/festivals/festivals_http_services.dart';
import 'package:festivals_exam_4/ui/screens/add_festival.dart';
import 'package:festivals_exam_4/ui/screens/notifications_screen.dart';
import 'package:festivals_exam_4/ui/widgets/all_festivals_card.dart';
import 'package:festivals_exam_4/ui/widgets/my_drawer.dart';
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications_active,
                size: 24,
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EventAddPage();
                      },
                    ),
                  );
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<FestivalsBloc, FestivalsState>(
                bloc: context.read<FestivalsBloc>()
                  ..add(GetFestivalWithinWeek()),
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
                            "Keyingi 7 kun ichidagi tadbirlar",
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
                                DateTime date = festival.addedDate.toDateTime();
                                return AllFestivalsCard(festival: festival);
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
        drawer: MyDrawer());
  }
}
