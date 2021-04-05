import 'package:flutter/material.dart';

class SliderModel {
  String imagePath;
  String title;
  String desc;

  SliderModel({this.imagePath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imagePath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imagePath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc(
      "We have recruited the best dentist in the town, who have very high reputation and experience.");
  sliderModel.setTitle("Experienced Doctors");
  sliderModel.setImageAssetPath("assets/doctors.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc(
      "Feature to book appointment online via this application, choose the docotor you want and a prefereable time period.");
  sliderModel.setTitle("Book Appointment");
  sliderModel.setImageAssetPath("assets/booking.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc(
      "You can easily view our various branch location and visit the nearest branc for your treatment");
  sliderModel.setTitle("Locations");
  sliderModel.setImageAssetPath("assets/maps.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
