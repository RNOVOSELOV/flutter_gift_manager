import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class GiftPageArgs extends Equatable {

  final String giftName;

  const GiftPageArgs({required this.giftName});

  @override
  List<Object?> get props => [giftName];

}

class GiftPage extends StatelessWidget {
  const GiftPage({Key? key, required this.args,}) : super(key: key);

  final GiftPageArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(args.giftName, style: const TextStyle(fontSize: 20),),),
    );
  }
}
