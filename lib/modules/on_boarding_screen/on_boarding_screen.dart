import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messanger/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/component/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';
import '../login_screen/login_screen.dart';

class onBoarding_screen extends StatefulWidget {
  @override
  State<onBoarding_screen> createState() => _onBoarding_screenState();
}

class _onBoarding_screenState extends State<onBoarding_screen> {
  @override
  void initState() {
    super.initState();
  }
  var pageController=PageController();
  bool islast=false;
  void submit()
  {
    cachehelper.savedata(key: 'boarding', value: true).then((value) {
      if(value)
        navandreplace(context, Chat_login_screen());
    });

  }
  @override

  Widget build(BuildContext context) {
    List<onboardingmodel>boarding=[
      onboardingmodel(image: 'assets/images/onboarding1.jpg', title: 'Communication Today', text:'Chat With Your Firends '),
      onboardingmodel(image: 'assets/images/onboarding2.jpg', title: 'Communication Today', text: 'Contact Me Everyday '),
      onboardingmodel(image: 'assets/images/onboarding3.jpg', title: 'Communication Today', text: 'Call Me Easier Now'),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed:
                  (){
                  submit();
                },
              child: Text(
                'skip',
                style:Theme.of(context).textTheme.subtitle1,
              ),
          ),
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Expanded(
          child: PageView.builder(
            physics: BouncingScrollPhysics(),
            controller: pageController,
              itemBuilder:(context,index)=> buildboardingitem(boarding[index]),
              itemCount: boarding.length,
            onPageChanged: (index)
            {
              if(index==boarding.length-1)
                {
                  setState((){
                    islast=true;
                  });
                }else
                  setState((){
                    islast=false;
                  });
            },
          ),
        ),
            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotHeight:10 ,
                    dotWidth: 10,
                    dotColor:Colors.grey ,
                    activeDotColor: defaultcolor,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if (islast)
                    {
                      submit();
                    }else
                    {
                      pageController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(IconBroken.Arrow___Right),
                ),
              ],
            ),
    ],
        ),
      ),
    );
  }

  Widget buildboardingitem(onboardingmodel model)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          ' ${model.title}',

          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          '${model.text}',

          style: TextStyle(
              fontStyle:FontStyle.italic,
              fontSize: 20,
              color: Colors.black
          ),
        ),
      ],
    );
  }
}
class onboardingmodel
{
 final String image;
 final String title;
 final String text;
  onboardingmodel({required this.image,required this.title,required this.text});
}