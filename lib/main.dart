import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widegts/toprated.dart';
import 'package:movie_app/widegts/trending.dart';
import 'package:movie_app/widegts/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main()=>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.teal),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  final String apikey = '2b9e8e7b7598e2b96ce2564b99dc1613';
  final readaccesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYjllOGU3Yjc1OThlMmI5NmNlMjU2NGI5OWRjMTYxMyIsInN1YiI6IjY0MGVkMTNlYTZjMTA0MDA5YWZlMGUyMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9vxzT8CFDfKWPHc2pl_nT2V3gfZkdG2SSjjHGxGprYg';


  void initState(){
    loadmovies();
    super.initState();
  }

  loadmovies()async{
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readaccesstoken),
    logConfig: ConfigLogger(
      showLogs: true,
      showErrorLogs: true
    ));
    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
    print(trendingmovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,
        title: modified_text(text: 'Movie App', color: Colors.white,size: 20,),),
      body: ListView(
        children: [
          TV(tv: tv,),
          TopRated(toprated: topratedmovies),
          TrendingMovies(
            trending: trendingmovies,
          ),
          // TopRatedMovies(
          //   toprated: topratedmovies,
          // ),
        ],
      ),
    );
  }
}

