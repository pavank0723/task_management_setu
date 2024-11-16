import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_management_setu/common/base_page.dart';
import 'package:task_management_setu/common/base_screen.dart';
import 'package:task_management_setu/model/local/local.dart';
import 'package:task_management_setu/network/local/local.dart';
import 'package:task_management_setu/network/local/theme_service.dart';
import 'package:task_management_setu/res/app_color.dart';
import 'package:task_management_setu/res/app_dimes.dart';
import 'package:task_management_setu/res/app_image.dart';
import 'package:task_management_setu/res/app_string.dart';
import 'package:task_management_setu/route/route.dart';
import 'package:task_management_setu/ui/screen/to_do/to_do_list/to_do_list_bloc.dart';
import 'package:task_management_setu/ui/ui.dart';
import 'package:task_management_setu/util/date_time_helper.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> with BasePageState {
  late ToDoListBloc _bloc;
  final TextEditingController _searchController = TextEditingController();
  List<ToDoModel> allToDo = [];

  @override
  void initState() {
    _bloc = BlocProvider.of<ToDoListBloc>(context);
    fetchToDo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<ToDoListBloc, ToDoListState>(
      listener: (context, state) {
        if (state is LoadedToDo) {
          setState(() {
            allToDo = state.toDos;
          });
        }
        if (state is UpdateStatusToDoSuccessfully) {
          fetchToDo();
        }
        if (state is UpdateToDoFailed) {
          fetchToDo();
        }
        if (state is DeletedToDoSuccessfully) {
          fetchToDo();
        }
        if (state is DeletedToDoFailed) {
          fetchToDo();
        }
      },
      child: Consumer<ThemeService>(
          builder: (context, ThemeService notifier, child) {
        return BaseScreen(
          title: "${AppString.toDo} List",
          isAppShadowEffect: false,
          isFloatingBtn: true,
          isFloatingBtnWithLabel: true,
          floatingIcon: AppImage.icAdd,
          isAction: true,
          isCustomAction: true,
          isCustomSvgIcon: true,
          appBarCustomIcon: '',
          customAction: Transform.scale(
            scaleX: 0.6,
            scaleY: 0.6,
            child: Switch(
              value: notifier.isDark,
              // This will determine if it's dark or light theme
              onChanged: (value) {
                notifier
                    .changeTheme(); // Change the theme when switch is toggled
              },
            ),
          ),
          navigateTo: AppRoute.addToDoScreen,
          navigationCallback: (v) {
            fetchToDo();
          },
          body: PopScope(
            canPop: false,
            onPopInvoked: (v) {
              if (v) {
                return;
              }
              onWillPop();
            },
            child: SizedBox(
              height: size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: allToDo.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (query) {
                          _bloc.add(SearchToDo(query));
                        },
                        decoration: const InputDecoration(
                            hintText: 'Search by name',
                            prefixIcon: Icon(Icons.search),
                            fillColor: AppColor.greyLightest),
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<ToDoListBloc, ToDoListState>(
                      builder: (context, state) {
                        if (state is LoadingToDo) {
                          return buildListShimmer(
                            const ViewToDoListItem(
                              isLoading: true,
                            ),
                          );
                        }
                        if (state is NoToDoAvailable) {
                          return Center(
                            child: Text(
                                "No ${AppString.toDo.toLowerCase()}s are listed"),
                          );
                        }
                        if (state is NoSearchToDoAvailable) {
                          return Center(
                            child: Text(
                                "No ${AppString.toDo.toLowerCase()} available in the list"),
                          );
                        }
                        if (state is LoadedToDo) {
                          final toDoWidgets =
                              DateTimeHelper.buildDatedSections<ToDoModel>(
                            allToDo,
                            (toDo) => toDo.addedOn!,
                            (toDo) => _buildToDoWidget(
                              toDo,
                            ),
                          );

                          // Add bottom padding to the last item
                          return ListView(
                            shrinkWrap: true,
                            controller: ScrollController(),
                            children: [
                              ...toDoWidgets,
                              const SizedBox(height: AppDimen.appSpace50 * 5),
                              // Adjust the height for desired padding
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      buildWhen: (prev, state) {
                        return state is LoadedToDo ||
                            state is LoadingToDo ||
                            state is NoToDoAvailable ||
                            state is NoSearchToDoAvailable;
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildToDoWidget(ToDoModel task) {
    return ViewToDoListItem(
      title: task.name ?? 'NA',
      description: task.description ?? 'NA',
      creationDate: task.addedOn!,
      deadline: task.dueDate!,
      isCompleted: task.isCompleted ?? false,
      onTap: () => navigateTo(
        AppRoute.viewOrUpdateToDoScreen,
        args: ViewToDoDetailArgs(
          isEdit: false,
          id: task.id!,
        ),
      ).then((value) => fetchToDo()),
      onToggleComplete: (value) {
        _bloc.add(
          UpdateToDo(task.id!, value),
        );
      },
      onDelete: () {
        _bloc.add(
          DeleteToDo(
            task.id!,
          ),
        );
      },
      onEdit: () => navigateTo(
        AppRoute.viewOrUpdateToDoScreen,
        args: ViewToDoDetailArgs(
          isEdit: true,
          id: task.id!,
        ),
      ).then((value) => fetchToDo()),
    );
  }

  void fetchToDo() {
    _bloc.add(LoadToDos());
  }
}
