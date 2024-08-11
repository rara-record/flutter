import 'package:flutter/material.dart';
import 'package:intro/models/hotel.dart';
import 'package:intro/repositories/hotel_repository.dart';

class HotelListPage extends StatefulWidget {
  const HotelListPage({super.key});

  @override
  State<HotelListPage> createState() => _HotelListPageState();
}

class _HotelListPageState extends State<HotelListPage> {
  List<Hotel> hotels = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchHotels();
  }

  Future<void> _fetchHotels() async {
    hotels = await fetchHotels();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hotels')),
      body: Center(
        child: loading ? const CircularProgressIndicator() : buildHotels(),
      ),
    );
  }

  // 호텔 리스트를 생성
  Widget buildHotels() {
    return Padding(
      padding: const EdgeInsets.all(20),
      // ListView.Builder 형태에서 구분선이 필요할 때 사용.
      child: ListView.separated(
        itemCount: hotels.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.grey,
            thickness: 2,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return;
        },
      ),
    );
  }
}
