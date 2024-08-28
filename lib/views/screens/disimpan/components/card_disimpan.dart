import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardDisimpan extends StatelessWidget {
  const CardDisimpan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  height: 28.h,
                  width: 28.w,
                  fit: BoxFit.contain,
                  "assets/images/profile.png",
                ),
              ),
              SizedBox(width: 10.h,),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama User",
                      style: TextStyle(
                          fontSize: p2,
                          fontWeight: heavy
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Dibuat 3 Hari yang lalu',
                      style: TextStyle(
                          fontSize: p2,
                          fontWeight: regular
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.chat, size: p2, color: kPrimary,),
                    SizedBox(width: 5.w,),
                    Text(
                      "Topik Umum",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: kPrimary,
                          fontSize: p3,
                          fontWeight: heavy
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: Icon(
                  Icons.more_vert,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h,),
          Text(
            "Lorem ipsum dolor sit amet consectetur.",
            style: TextStyle(
                fontSize: p2,
                fontWeight: heavy
            ),
          ),
          SizedBox(height: 10.h,),
          const Divider(
            color: kGrey,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
