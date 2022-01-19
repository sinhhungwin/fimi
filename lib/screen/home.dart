import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fimi/service/state_manager.dart';
import 'package:fimi/utils/settings.dart';
import 'package:share_plus/share_plus.dart';

class Home extends StatelessWidget {
  final f = new DateFormat('EEEE dd,MMM', "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          final responseAsyncValue = watch.watch(airData);

          return responseAsyncValue.map(
            loading: (_) => Center(child: CircularProgressIndicator()),
            error: (_) => Text(
              _.error.toString(),
              style: TextStyle(color: Colors.red),
            ),
            data: (_) => Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: setGradient(_.data.value.data.current.weather.ic),
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height / 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // City name
                        Text(
                          _.data.value.data.city,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          f.format(_.data.value.data.current.weather.ts),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            setImage(_.data.value.data.current.weather.ic),
                            scale: 1.5,
                          ),
                        ),
                        Text(
                          '${_.data.value.data.current.weather.tp}\u2103',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          setWeather(_.data.value.data.current.weather.ic),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  DraggableScrollableSheet(
                    initialChildSize: 0.25,
                    minChildSize: 0.12,
                    expand: true,
                    builder: (BuildContext c, s) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          controller: s,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 8,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: setColor(
                                    _.data.value.data.current.pollution.mainus),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: setColorDark(_.data.value.data
                                            .current.pollution.mainus),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      width: 80.0,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Index AQI',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            '${_.data.value.data.current.pollution.aqius}',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Air Quality Description
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Air Quality'),
                                        Text(
                                          setAqi(_.data.value.data.current
                                              .pollution.aqius),
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      width: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            ListTile(
                                title: Text('Humidity'),
                                trailing: Text(
                                    '${_.data.value.data.current.weather.hu}%')),
                            ListTile(
                                title: Text('Wind'),
                                trailing: Text(
                                    '${_.data.value.data.current.weather.ws} m/s')),
                            ListTile(
                                title: Text('Pressure'),
                                trailing: Text(
                                    '${_.data.value.data.current.weather.pr} mb')),
                            ElevatedButton.icon(
                              onPressed: () async {
                                await Share.share(
                                  'Air quality is ' + setAqi(_
                                      .data.value.data.current.pollution.aqius),
                                  subject: 'AQI',
                                );
                              },
                              icon: Icon(Icons.share),
                              label: Text('Share'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
