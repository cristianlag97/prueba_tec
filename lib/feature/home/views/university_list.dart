import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tyba/feature/home/bloc/list_university_bloc.dart';
import 'package:flutter_tyba/feature/home/widgets/widgets.dart';

class UniversityList extends StatefulWidget {
  const UniversityList({Key? key}) : super(key: key);

  @override
  State<UniversityList> createState() => _UniversityListState();
}

class _UniversityListState extends State<UniversityList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListUniversityBloc, ListUniversityState>(
      builder: (context, state) {
        print(state.status);
        switch (state.status) {
          case UniversityStatus.failure:
            return const Center(child: Text('Carga faliida'));
          case UniversityStatus.success:
            if(state.universities.isEmpty){
              return const Center(child: Text('no existen universidades en la lista'));
            }
            return ListView.builder(
              itemBuilder: (_, int index) {
                return index >= state.universities.length
                ? const BottomLoader()
                : ListUniversityItem(university: state.universities[index], index: index);
              }
            );
          case UniversityStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ListUniversityBloc>().add(UniversityFetch());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
