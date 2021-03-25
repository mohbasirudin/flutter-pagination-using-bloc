import 'package:pagination/bloc/bloc_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageMain extends StatefulWidget {
  @override
  _PageMainState createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  ScrollController _scrollController = ScrollController();
  BlocData _blocData;

  _onScroll() {
    double _max = _scrollController.position.maxScrollExtent;
    double _cur = _scrollController.position.pixels;

    if (_cur == _max) _blocData.add(EventData());
  }

  @override
  Widget build(BuildContext context) {
    _blocData = BlocProvider.of<BlocData>(context);
    _scrollController.addListener(() => _onScroll());
    return Scaffold(
      body: Container(
        child: BlocBuilder<BlocData, DataState>(
          builder: (context, state) {
            if (state is DataUninitialized) {
              return Center(
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              DataLoaded _dataLoaded = state as DataLoaded;
              return Container(
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: _scrollController,
                  itemCount: (_dataLoaded.hasMax)
                      ? _dataLoaded.data.length
                      : _dataLoaded.data.length + 1,
                  itemBuilder: (context, index) =>
                      (index < _dataLoaded.data.length)
                          ? Container(
                              margin: EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    child: Text(
                                      '${_dataLoaded.data[index].id}.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _dataLoaded.data[index].body,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(vertical: 12),
                              child: Center(
                                child: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
