import 'package:fingerspot_library_app/views/components/expandable_text.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/home/components/icon_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardProfile extends StatelessWidget {
  const CardProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
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
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama User",
                      style: TextStyle(
                          color: kPrimary,
                          fontSize: p1,
                          fontWeight: heavy
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Diperbaruhi pada 18 Mei 2024, 08:19",
                      style: TextStyle(
                          color: kGrey,
                          fontSize: p2,
                          fontWeight: regular
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
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
                fontSize: p1,
                fontWeight: heavy
            ),
          ),
          SizedBox(height: 10.h,),
          ExpandableText(
            maxLines: 2,
            text: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Error totam maiores magni omnis reprehenderit enim, facilis, voluptas suscipit voluptatibus, officiis fugit quia debitis dolorum ratione ex! Neque praesentium modi ipsum error minus a, nesciunt eius molestias doloribus consectetur. Architecto eaque suscipit quidem cumque tempore debitis necessitatibus voluptatibus facilis temporibus voluptatum enim recusandae veritatis accusamus dolores qui, sint at est, ipsa dolorum reiciendis? Eaque voluptatem quas eveniet culpa sed necessitatibus, incidunt natus omnis quo atque libero animi voluptates amet commodi! Cumque consequuntur modi veritatis voluptatum? Exercitationem id alias ullam, doloremque asperiores voluptates quia aspernatur explicabo numquam, unde odio eos consequatur aliquam.",
            style: TextStyle(
                fontSize: p2,
                fontWeight: regular
            ),
          ),
          SizedBox(height: 10.h,),
          const Row(
            children: [
              IconHome(icon: Icons.thumb_up_alt_outlined, label: "15,8k"),
              IconHome(icon: Icons.comment_bank_outlined, label: "10,8k"),
              IconHome(icon: Icons.remove_red_eye_outlined, label: "15,8k"),
            ],
          ),
          const Divider(
            color: kGrey,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
