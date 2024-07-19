import 'package:festivals_exam_4/logic/blocs/personal_festivals/person_festivals_events.dart';
import 'package:festivals_exam_4/logic/blocs/personal_festivals/personal_festivals_bloc.dart';
import 'package:festivals_exam_4/logic/blocs/personal_festivals/personal_festivals_states.dart';
import 'package:festivals_exam_4/ui/widgets/all_festivals_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalFestivals extends StatefulWidget {
  const PersonalFestivals({super.key});

  @override
  State<PersonalFestivals> createState() => _PersonalFestivalsState();
}

class _PersonalFestivalsState extends State<PersonalFestivals> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalFestivalsBloc, PersonalFestivalsStates>(
      // bloc: context.read<FestivalsBloc>()..add(GetPersonalFestivals()),
      bloc: context.read<PersonalFestivalsBloc>()
        ..add(GetPersonalFestivalsEvent()),
      builder: (context, state) {
        if (state is LoadingPersonalFestivalsState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ErrorPersonalFestivalState) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is LoadedPersonalFestivalsState) {
          return state.festivals.length != 0
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.festivals.length,
                          itemBuilder: (context, index) {
                            final festival = state.festivals[index];
                            return AllFestivalsCard(festival: festival);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Text("Eventlar mavjud emas"),
                );
        }

        return Container(); // Return an empty container if none of the states match
      },
    );
  }
}
