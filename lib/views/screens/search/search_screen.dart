import 'package:fingerspot_library_app/views/components/card_categories.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/search/components/card_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.h)
                ),
                prefixIcon: GestureDetector(
                  onTap: (){},
                  child: const Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 5.h,),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CardCategories(categoriesName: 'Terbanyak Dilihat', isSelected: false,),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .69,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CardSearch(),
                    const CardSearch(),
                    const CardSearch(),
                    const CardSearch(),
                    const CardSearch(),
                    SizedBox(height: 10.h,),
                    Text(
                      "Rekomendasi Informasi Untukmu".toUpperCase(),
                      style: TextStyle(
                        fontSize: p1,
                        fontWeight: heavy,
                        color: kPrimary,
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    const CardRekomendasi(),
                    const CardRekomendasi(),
                    const CardRekomendasi(),
                    const CardRekomendasi(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
