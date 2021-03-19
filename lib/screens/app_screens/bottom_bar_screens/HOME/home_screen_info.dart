import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:DentalHome/components/colors.dart';

class HomeScreenInfo extends StatefulWidget {
  @override
  _HomeScreenInfoState createState() => _HomeScreenInfoState();
}

class _HomeScreenInfoState extends State<HomeScreenInfo> {
  int _currentIndex = 0;

  List<Widget> cardList = [
    Container(
      margin: EdgeInsets.all(5.0),
      // padding: EdgeInsets.symmetric(horizontal: 15.0),
      // height: 250.0,
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: buttonColor,
        image: DecorationImage(
            image: NetworkImage(
                'https://www.cochrane.org/sites/default/files/public/styles/social_media/public/uploads/news/young-confident-asian-male-dentist-medical-treatment-to-a-female-patient-at-the-clinic.-dental-clinic-concept-911844046_1257x838_3.jpeg?itok=YzWpwBw8'),
            fit: BoxFit.cover),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '''Get help from the
best doctors''',
                  style: TextStyle(
                      color: Colors.grey[800], fontSize: 16.0, letterSpacing: 0.4),
                ),
              ),
              SizedBox(height: 10.0),
              IconButton(
                icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          // Image.network(
          //   // 'https://png2.cleanpng.com/sh/04cd4bad7ccdc9ce7b74acd1437707f4/L0KzQYm3UcI1N5D4iZH0aYP2gLBuTgBpgaRue9tqbj34frrtjCJuNaRoiudrcz36eLr7hb1kd5J5Rd9uZHnmebBsTfZwepZuf9C2ZHBmhLF5Tf1ifJZ3gdN1LUXkRonqWPI0O2Q3StQBLkm2RYGBV8A1OWY2Tqo6NkW5Q4O3WcUveJ9s/kisspng-physician-uniform-scrubs-white-coat-medicine-foreign-doctor-material-5a68c8b33322b6.9350870415168165632095.png',
          //   'https://www.cochrane.org/sites/default/files/public/styles/social_media/public/uploads/news/young-confident-asian-male-dentist-medical-treatment-to-a-female-patient-at-the-clinic.-dental-clinic-concept-911844046_1257x838_3.jpeg?itok=YzWpwBw8',
          //   fit: BoxFit.contain,
          // ),
        ],
      ),
    ),
    Container(
      margin: EdgeInsets.all(5.0),
      // padding: EdgeInsets.symmetric(horizontal: 15.0),
      // height: 250.0,
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://i.pinimg.com/originals/59/c7/26/59c726cf25dda6d0ebcbe6b174a83115.png'),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(15.0),
        color: buttonColor,
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '''New advanced
equipments''',
                  style: TextStyle(
                      color: Colors.grey[800], fontSize: 16.0, letterSpacing: 0.4),
                ),
              ),
              SizedBox(height: 10.0),
              IconButton(
                icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          // Image.network(
          //   // 'https://png2.cleanpng.com/sh/b3f33c0ee866a33ddfa79cbda04959bc/L0KzQYm3VsMxN5pmjZH0aYP2gLBuTfRmdqVuiAZ7eT3vcbP2kr11cJZ3eeJELXbkhcXslfltNZVqhuZqbD3meLLwkr02amQ9SqNqM0C8RrO8U741P2Q6TKQEOUG4Q4G7UMUzQGQ1S6oBLoDxd1==/kisspng-dentistry-labor-therapy-fauteuil-dental-chair-5b3821a3096b53.4735429915304052830386.png',
          //   // 'https://image.made-in-china.com/2f0j00tpwRdLBIEokj/New-Designed-Dentist-Equipment-Dental-Unit-Taiwan.jpg',
          //   fit: BoxFit.contain,
          //   width: 150.0,
          // ),
        ],
      ),
    ),
    Container(
      margin: EdgeInsets.all(5.0),
      // padding: EdgeInsets.symmetric(horizontal: 15.0),
      // height: 250.0,
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://wordtemplatesbundle.com/wp-content/uploads/2017/08/Discount-voucher-2-REV.jpg'),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(15.0),
        color: buttonColor,
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//               Text(
//                 '''Offers on
// special ocassions''',
//                 style: TextStyle(
//                     color: Colors.white, fontSize: 18.0, letterSpacing: 0.3),
//               ),
              SizedBox(height: 10.0),
              IconButton(
                icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(width: 10.0),
          // Image.network(
          //   // 'https://png2.cleanpng.com/sh/1efa88c231e37d8c56b080b75dc0f5a2/L0KzQYi4UsA0N2pnTJGAYUK3coW9hvRjOJMASZC6MUG6QoO4WME2OWM4TaYEMke7SYi5TwBvbz==/5a24b46fdb0b91.1117221815123549278972.png',
          //   'https://image.freepik.com/free-vector/discount-sale-time-vector-clipart-illustration_138676-382.jpg',
          //   fit: BoxFit.contain,
          //   width: 100.0,
          // ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // children: [
      // child: doctorSlide(context),
      // child: cardList[1],
      // placeSlide(context),
      // offerSlide(context),
      // ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: 170.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              // onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
            items: cardList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return i;
                  // return Container(
                  //     width: MediaQuery.of(context).size.width,
                  //     margin: EdgeInsets.symmetric(horizontal: 5.0),
                  //     decoration: BoxDecoration(color: Colors.amber),
                  //     child: Text(
                  //       'text $i',
                  //       style: TextStyle(fontSize: 16.0),
                  //     ));
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget doctorSlide(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: buttonColor,
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''Get help from the best
doctors''',
                  style: TextStyle(
                      color: Colors.white, fontSize: 18.0, letterSpacing: 0.3),
                ),
                SizedBox(height: 10.0),
                IconButton(
                  icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
            Image.network(
              'https://png2.cleanpng.com/sh/04cd4bad7ccdc9ce7b74acd1437707f4/L0KzQYm3UcI1N5D4iZH0aYP2gLBuTgBpgaRue9tqbj34frrtjCJuNaRoiudrcz36eLr7hb1kd5J5Rd9uZHnmebBsTfZwepZuf9C2ZHBmhLF5Tf1ifJZ3gdN1LUXkRonqWPI0O2Q3StQBLkm2RYGBV8A1OWY2Tqo6NkW5Q4O3WcUveJ9s/kisspng-physician-uniform-scrubs-white-coat-medicine-foreign-doctor-material-5a68c8b33322b6.9350870415168165632095.png',
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  Padding placeSlide(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: buttonColor,
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''New advanced
equipments''',
                  style: TextStyle(
                      color: Colors.white, fontSize: 18.0, letterSpacing: 0.3),
                ),
                SizedBox(height: 10.0),
                IconButton(
                  icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
            Image.network(
              'https://png2.cleanpng.com/sh/b3f33c0ee866a33ddfa79cbda04959bc/L0KzQYm3VsMxN5pmjZH0aYP2gLBuTfRmdqVuiAZ7eT3vcbP2kr11cJZ3eeJELXbkhcXslfltNZVqhuZqbD3meLLwkr02amQ9SqNqM0C8RrO8U741P2Q6TKQEOUG4Q4G7UMUzQGQ1S6oBLoDxd1==/kisspng-dentistry-labor-therapy-fauteuil-dental-chair-5b3821a3096b53.4735429915304052830386.png',
              fit: BoxFit.contain,
              width: 240.0,
            ),
          ],
        ),
      ),
    );
  }

  Padding offerSlide(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: buttonColor,
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''Offers on
special ocassions''',
                  style: TextStyle(
                      color: Colors.white, fontSize: 18.0, letterSpacing: 0.3),
                ),
                SizedBox(height: 10.0),
                IconButton(
                  icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(width: 10.0),
            Image.network(
              'https://png2.cleanpng.com/sh/1efa88c231e37d8c56b080b75dc0f5a2/L0KzQYi4UsA0N2pnTJGAYUK3coW9hvRjOJMASZC6MUG6QoO4WME2OWM4TaYEMke7SYi5TwBvbz==/5a24b46fdb0b91.1117221815123549278972.png',
              fit: BoxFit.contain,
              width: 180.0,
            ),
          ],
        ),
      ),
    );
  }
}
