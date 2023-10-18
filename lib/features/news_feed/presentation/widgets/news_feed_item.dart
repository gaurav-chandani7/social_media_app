import 'dart:math';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/news_feed/domain/entities/entities.dart';
import 'package:social_media_app/utils/helper/relative_time.dart';

class NewsFeedItemWidget extends StatefulWidget {
  const NewsFeedItemWidget({super.key, required this.newsFeedItemEntity});
  final NewsFeedItemEntity newsFeedItemEntity;

  @override
  State<NewsFeedItemWidget> createState() => _NewsFeedItemWidgetState();
}

class _NewsFeedItemWidgetState extends State<NewsFeedItemWidget> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> pageValueNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    final newsFeedItem = widget.newsFeedItemEntity;
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        color: Colors.black,
                        shape: BoxShape.circle),
                    child: ClipOval(
                      child: Image.network(
                        newsFeedItem.authorDetails.displayPicture ??
                            defaultDisplayPicture,
                        width: min(constraints.maxWidth * 0.1, 50),
                        height: min(constraints.maxWidth * 0.1, 50),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${widget.newsFeedItemEntity.authorDetails.firstName} ${widget.newsFeedItemEntity.authorDetails.lastName}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: newsFeedItem.urls.length,
                    onPageChanged: (val) => pageValueNotifier.value = val,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.black,
                        width: constraints.maxWidth,
                        child: Image.network(
                          newsFeedItem.urls[index],
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                  ValueListenableBuilder<int>(
                      valueListenable: pageValueNotifier,
                      builder: (context, pageValue, child) {
                        return Visibility(
                          visible: pageValue != newsFeedItem.urls.length - 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () => pageValueNotifier.value ==
                                      newsFeedItem.urls.length
                                  ? null
                                  : _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.decelerate),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade300,
                                  foregroundColor: Colors.black45,
                                  visualDensity: VisualDensity.compact,
                                  shape: const CircleBorder()),
                              child: const Icon(
                                Icons.chevron_right,
                                size: 20,
                              ),
                            ),
                          ),
                        );
                      }),
                  ValueListenableBuilder<int>(
                      valueListenable: pageValueNotifier,
                      builder: (context, pageValue, child) {
                        return Visibility(
                          visible: pageValue != 0,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton(
                                onPressed: () => pageValue == 0
                                    ? null
                                    : _pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.decelerate),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade300,
                                    foregroundColor: Colors.black45,
                                    visualDensity: VisualDensity.compact,
                                    shape: const CircleBorder()),
                                child: const Icon(Icons.chevron_left)),
                          ),
                        );
                      })
                ],
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.newsFeedItemEntity.postTitle,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  widget.newsFeedItemEntity.postDescription != null
                      ? Text(
                          widget.newsFeedItemEntity.postDescription!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    getRelativeTime(widget.newsFeedItemEntity.createdAt ?? ""),
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
