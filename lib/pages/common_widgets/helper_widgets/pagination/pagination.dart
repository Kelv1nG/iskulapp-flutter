import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/helper_widgets/pagination/pagination_controller.dart';
import 'package:school_erp/pages/common_widgets/helper_widgets/pagination/pagination_list.dart';

class Pagination<T> extends StatefulWidget {
  final List<T> listOfData;
  final Widget Function(BuildContext, T) itemBuilder;
  final int itemsPerPage;
  final bool isLoading;

  const Pagination({
    super.key,
    required this.listOfData,
    required this.itemBuilder,
    required this.itemsPerPage,
    required this.isLoading,
  });

  @override
  createState() => _PaginationState<T>();
}

class _PaginationState<T> extends State<Pagination<T>> {
  int currentPage = 1;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    int totalPages = (widget.listOfData.length / widget.itemsPerPage).ceil();

    return Expanded(
      child: Column(
        children: [
          PaginationList(
              listOfData: widget.listOfData,
              itemBuilder: widget.itemBuilder,
              itemsPerPage: widget.itemsPerPage,
              isLoading: widget.isLoading,
              currentIndex: currentIndex),
          PaginationController(
            currentPage: currentPage,
            currentIndex: currentIndex,
            totalPages: totalPages,
            itemsPerPage: widget.itemsPerPage,
            prevPageFn: () {
              setState(() {
                currentPage -= 1;
                currentIndex -= widget.itemsPerPage;
              });
            },
            nextPageFn: () {
              setState(() {
                currentPage += 1;
                currentIndex += widget.itemsPerPage;
              });
            },
          ),
        ],
      ),
    );
  }
}
