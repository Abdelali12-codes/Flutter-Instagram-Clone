import 'package:flutter/material.dart';

class ImageClass {
  final String url;
  final String name;
  final String username;

  ImageClass({this.url, this.name, this.username});
}

List<ImageClass> list = [
  ImageClass(
      url:
          "https://images.pexels.com/photos/333850/pexels-photo-333850.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      name: "fullStack",
      username: "abdelali.codes"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/837306/pexels-photo-837306.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
      name: "alaoui ismaili",
      username: "ismaili ismali"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/747964/pexels-photo-747964.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
      name: "bouham ismail",
      username: "ismail ismail"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/1793525/pexels-photo-1793525.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
      name: "goual slah",
      username: "salah salah"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/262391/pexels-photo-262391.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
      name: "fullStack",
      username: "abdelali.codes"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
      name: "fullStack",
      username: "abdelali.codes"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/927022/pexels-photo-927022.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      name: "fullStack",
      username: "abdelali.codes"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/1576937/pexels-photo-1576937.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      name: "fullStack",
      username: "abdelali.codes"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/801885/pexels-photo-801885.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      name: "fullStack",
      username: "abdelali.codes"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/842548/pexels-photo-842548.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      name: "fullStack",
      username: "abdelali.codes"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/1484771/pexels-photo-1484771.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      name: "ai_machine_learning",
      username: "deep_learning"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/1438081/pexels-photo-1438081.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      name: "ai_machine_learning",
      username: "deep_learning"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/937481/pexels-photo-937481.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      name: "ai_machine_learning",
      username: "deep_learning"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/433452/pexels-photo-433452.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
      name: "ai_machine_learning",
      username: "deep_learning"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/3951883/pexels-photo-3951883.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      name: "ai_machine_learning",
      username: "deep_learning"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/4127449/pexels-photo-4127449.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
      name: "ai_machine_learning",
      username: "deep_learning"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/4177484/pexels-photo-4177484.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      name: "ai_machine_learning",
      username: "deep_learning"),
  ImageClass(
      url:
          "https://images.pexels.com/photos/4173168/pexels-photo-4173168.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      name: "abdelhadi essabri",
      username: "essabri essaberi")
];

class Items {
  final String title;
  final Icon icon;

  Items({this.title, this.icon});
}

List<dynamic> searchItems = <dynamic>[
  Items(title: "IGTV "),
  Items(title: "Shop"),
  "Travel",
  "Travel",
  "Architecture",
  "Decor",
  "Art",
  "Food",
  "Style",
  "Tv & Movies",
  "DIY",
  "Music",
  "Sports",
  "Beauty"
];
