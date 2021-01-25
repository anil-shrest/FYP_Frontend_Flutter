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
      "Food delivery or pickup from local restaurants, Explore restaurants that deliver near you.");
  sliderModel.setTitle("Experienced Doctors");
  sliderModel.setImageAssetPath("assets/doctor.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc(
      "Discover Restaurants offering the best fast food food near you on Foodwa");
  sliderModel.setTitle("Book Appointment");
  sliderModel.setImageAssetPath("assets/booking.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc(
      "Our veggie plan is filled with delicious seasonal vegetables, whole grains,  vegetarian proteins");
  sliderModel.setTitle("Locations");
  sliderModel.setImageAssetPath("assets/maps.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
