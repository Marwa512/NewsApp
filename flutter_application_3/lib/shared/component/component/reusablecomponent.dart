// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/module/webView/webView.dart';

Widget buildArticleItem(article, context) {
  return InkWell(
    onTap: () {
      navigateTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage("${article['urlToImage']}"),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Expanded(
                    child: Text(
                      "${article['title']} ",
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${article['publishedAt']}",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget seperatedItem() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 20,
    ),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  );
}

Widget articleBuilder(
  List list, {
  isSearch = false,
}) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return buildArticleItem(list[index], context);
      },
      separatorBuilder: (context, index) {
        return seperatedItem();
      },
      itemCount: list.length,
    ),
    fallback: (context) => isSearch
        ? Container()
        : Center(
            child: CircularProgressIndicator(),
          ),
  );
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
