import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_management_setu/common/base_page.dart';
import 'package:task_management_setu/common/base_screen.dart';
import 'package:task_management_setu/model/local/local.dart';
import 'package:task_management_setu/res/res.dart';
import 'package:task_management_setu/ui/screen/to_do/add_to_do_screen/add_to_do_screen_bloc.dart';
import 'package:task_management_setu/ui/ui.dart';
import 'package:task_management_setu/util/util.dart';

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({super.key});

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> with BasePageState {
  late AddToDoScreenBloc _bloc;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _addFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _bloc = BlocProvider.of<AddToDoScreenBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AddToDoScreenBloc, AddToDoScreenState>(
      listener: (context, state) {
        if (state is ToDoAddedSuccessfully) {
          showToast(
              "${AppString.toDo} added successfully...!", ToastType.success);
          Navigator.pop(context, true);
          // Clear fields and show success message
          _titleController.clear();
          _descriptionController.clear();
          _dueDateController.clear();
        }
        if (state is ToDoAddedFailed) {
          showToast("${AppString.toDo} failed", ToastType.error);
          Navigator.pop(context, false);
          // Clear fields and show success message
          _titleController.clear();
          _descriptionController.clear();
          _dueDateController.clear();
        }
      },
      child: BaseScreen(
        title: "Add ${AppString.toDo}",
        isAppShadowEffect: false,
        isIcon: true,
        body: Form(
          key: _addFormKey,
          child: SizedBox(
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title Field
                vGap(),
                CustomTextField(
                  textFieldHeading: 'Title ',
                  controller: _titleController,
                  isHeading: true,
                  required: true,

                  txtHint: 'e.g xyz',
                  maxLength: 20,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                ),
                vGap(height: AppDimen.appSpace15),

                CustomTextField(
                  textFieldHeading: 'Description ',
                  controller: _descriptionController,
                  isHeading: true,

                  txtHint: 'e.g xyz',
                  maxLines: 3,
                ),
                vGap(height: AppDimen.appSpace15),

                // Due Date Field
                CustomTextField(
                  textFieldHeading: 'Due Date',
                  controller: _dueDateController,
                  txtHint:
                      "e.g. ${DateTimeHelper.formatAnyDateTimeRes(DateTime.now().toString(), "dd-MM-yyyy HH:mm")}",
                  required: true,
                  isHeading: true,
                  onTap: () {
                    debugPrint('date picker activated');
                    _pickDueDate(context);
                  },
                  suffixIcon: const Icon(Icons.calendar_month_rounded),
                  suffixIconAction: () {
                    debugPrint('date picker activated');
                    _pickDueDate(context);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Due date is required';
                    }

                    return null;
                  },
                ),
                const Spacer(),

                // Save Button
              ],
            ),
          ),
        ),
        bottomNav: SizedBox(
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(AppDimen.appSpace10),
            child: CustomElevatedButton(
              onPressed: _saveToDo,
              text: 'Save ${AppString.toDo}',
            ),
          ),
        ),
      ),
    );
  }

  // This function opens the date picker
  Future<void> _pickDueDate(BuildContext context) async {
    // Step 1: Pick the Date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Step 2: Pick the Time
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (pickedTime != null) {
        // Step 3: Combine Date and Time
        final DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Step 4: Format the combined DateTime
        String formattedDate =
            DateFormat('dd-MM-yyyy HH:mm').format(finalDateTime);

        // Step 5: Update the text field
        setState(() {
          _dueDateController.text = formattedDate;
        });
      }
    }
  }

  // This function adds a new to-do item
  Future<void> _saveToDo() async {
    String titleValue = _titleController.text;
    String descriptionValue = _descriptionController.text;
    String dueDateValue = _dueDateController.text;
    if (_addFormKey.currentState?.validate() ?? false) {
      final todo = ToDoModel(
        name: titleValue,
        description: descriptionValue,
        dueDate: dueDateValue,
      );

      _bloc.add(AddToDoDetail(todo));
    }
  }

  @override
  void dispose() {
    _bloc.close();
    _titleController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }
}
