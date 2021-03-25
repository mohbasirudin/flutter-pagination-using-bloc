import 'package:pagination/model/model_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventData {}

abstract class DataState {}

class DataUninitialized extends DataState {}

class DataLoaded extends DataState {
  List<ModelData> data;
  bool hasMax;

  DataLoaded({this.data, this.hasMax});

  DataLoaded copyWith({List<ModelData> data, bool hasMax}) =>
      DataLoaded(data: data ?? this.data, hasMax: hasMax ?? this.hasMax);
}

class BlocData extends Bloc<EventData, DataState> {
  BlocData() : super(DataUninitialized());

  @override
  Stream<DataState> mapEventToState(EventData event) async* {
    List<ModelData> _data;
    if (state is DataUninitialized) {
      _data = await ModelData.getData(start: 0, limit: 10);
      yield DataLoaded(data: _data, hasMax: false);
    } else {
      DataLoaded _dataLoaded = state as DataLoaded;
      _data =
          await ModelData.getData(start: _dataLoaded.data.length, limit: 10);
      yield (_data.isEmpty)
          ? _dataLoaded.copyWith(hasMax: true)
          : _dataLoaded.copyWith(data: _dataLoaded.data + _data, hasMax: false);
    }
  }
}
