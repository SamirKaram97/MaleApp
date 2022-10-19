
//onboarding
class SlideObject {
  String title;
  String subtitle;
  String image;

  SlideObject(
      {required this.title, required this.subtitle, required this.image});
}
class SliderViewObject
{
   SlideObject slideObject;
   int currentPage;
   int numOfSlide;

  SliderViewObject({required this.slideObject, required this.currentPage, required this.numOfSlide});

}
