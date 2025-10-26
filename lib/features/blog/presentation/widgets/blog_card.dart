import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogCard extends StatelessWidget {
  final BlogEntity blog;
  final Color color;

  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: blog.topics.map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Chip(
                        label: Text(e),
                      ),
                    ),
                  ).toList(),
                ),
              ),
              Text(blog.title,style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ))
            ],

          ),
          const Text('1 min'),

        ],
      ),
    );
  }
}
