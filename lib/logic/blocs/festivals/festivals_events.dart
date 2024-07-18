sealed class FestivalsEvents {}

final class AddFestivalEvent extends FestivalsEvents {
  final String title;
  AddFestivalEvent(this.title);
}

final class IncrementFestivalAttendantsEvent extends FestivalsEvents {
  final String id;
  final int attendants;
  final int orders;

  IncrementFestivalAttendantsEvent({
    required this.id,
    required this.attendants,
    required this.orders,
  });
}

final class DeleteFestivalEvent extends FestivalsEvents {
  final String id;

  DeleteFestivalEvent({required this.id});
}

final class GetFestivalWithinWeek extends FestivalsEvents {}

final class GetFestivalsEvent extends FestivalsEvents {}
