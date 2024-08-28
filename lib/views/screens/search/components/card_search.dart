import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/search/components/icon_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardSearch extends StatelessWidget {
  const CardSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '01',
            style: TextStyle(
                color: kThird,
                fontSize: h2,
                fontWeight: heavy
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Container(
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
                      flex: 6,
                      child: Text(
                        "Nama User",
                        style: TextStyle(
                            fontSize: p2,
                            fontWeight: regular
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
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
                Row(
                  children: [
                    const IconSearch(icon: Icons.remove_red_eye_outlined, label: "15,8k Dilihat"),
                    const IconSearch(icon: Icons.comment_bank_outlined, label: "10,8k Komentar"),
                    Icon(
                      Icons.circle,
                      size: 4.sp,
                      color: kGrey,
                    ),
                    SizedBox(width: 10.h),
                    Text(
                      'Dibuat 3 Hari yang lalu',
                      style: TextStyle(
                          fontSize: p3
                      ),
                    )
                  ],
                ),
                const Divider(
                  color: kGrey,
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardRekomendasi extends StatelessWidget {
  const CardRekomendasi({super.key});

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
                flex: 6,
                child: Text(
                  "Nama User",
                  style: TextStyle(
                      fontSize: p2,
                      fontWeight: regular
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
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
          Row(
            children: [
              const IconSearch(icon: Icons.remove_red_eye_outlined, label: "15,8k Dilihat"),
              const IconSearch(icon: Icons.comment_bank_outlined, label: "10,8k Komentar"),
              Icon(
                Icons.circle,
                size: 4.sp,
                color: kGrey,
              ),
              SizedBox(width: 10.h),
              Text(
                'Dibuat 3 Hari yang lalu',
                style: TextStyle(
                    fontSize: p3
                ),
              )
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

