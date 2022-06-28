import 'package:aruna_test/bloc/home/home_bloc.dart';
import 'package:aruna_test/bloc/home/home_event.dart';
import 'package:aruna_test/bloc/home/home_state.dart';
import 'package:aruna_test/model/content_responses.dart';
import 'package:aruna_test/presentation/home/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeBloc _homeBloc;

  final globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  List<ContentResponses> _contents = [];
  bool _isSearching = false;
  List _searchResult = [];

  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    fetchAllContents();
    super.initState();
  }

  fetchAllContents() => _homeBloc.add(FetchContents());

  _HomeViewState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(24, 10, 24, 24),
        child: BlocConsumer<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return CircularProgressIndicator();
            } else if (state is HomeLoaded) {
              return showResults(state.listOfContents);
            } else if (state is HomeError) {
              return Center(
                child: Text(state.message),
              );
            }

            return Container();
          },
          listener: (context, state) {
            if (state is HomeLoaded) {
              setState(() {
                _contents = state.listOfContents;
              });
            }
          },
        ),
      ),
    );
  }

  Widget showResults(List<ContentResponses> contentResponses) {
    return _isSearching &&
            (_searchResult.length != 0 || _controller.text.isNotEmpty)
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: _searchResult.length,
            itemBuilder: (BuildContext context, int index) {
              String listData = _searchResult[index];
              return ListTile(
                title: Text(listData.toString()),
              );
            },
          )
        : ListView.builder(
            itemCount: contentResponses.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetail(
                          content: contentResponses[i],
                        ),
                      ),
                    );
                  },
                  child: Text(
                    contentResponses[i].title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget _getAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: TextField(
        controller: _controller,
        style: TextStyle(
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black87,
          ),
          hintText: "Search...",
          hintStyle: TextStyle(
            color: Colors.black54,
          ),
        ),
        onChanged: _handleSearchFunction,
      ),
    );
  }

  void _searchStarted() {
    setState(() {
      _isSearching = true;
    });
  }

  void _searchStopped() {
    setState(() {
      _isSearching = false;
      _controller.clear();
    });
  }

  void _handleSearchFunction(String query) {
    _searchStarted();
    _searchResult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _contents.length; i++) {
        String data = _contents[i].title;
        if (data.toLowerCase().contains(query.toLowerCase())) {
          _searchResult.add(data);
          print(_searchResult);
        }
      }
    }

    if (_controller.text.isEmpty) {
      _searchStopped();
    }
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }
}
