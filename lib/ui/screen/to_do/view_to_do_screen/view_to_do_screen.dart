import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_management_setu/common/common.dart';
import 'package:task_management_setu/model/local/local.dart';
import 'package:task_management_setu/model/local/to_do_model.dart';
import 'package:task_management_setu/res/res.dart';
import 'package:task_management_setu/ui/screen/to_do/view_to_do_screen/view_to_do_screen_bloc.dart';
import 'package:task_management_setu/ui/widget/widget.dart';
import 'package:task_management_setu/util/util.dart';

class ViewToDoDetailArgs {
  final bool isEdit;
  final int id;

  ViewToDoDetailArgs({
    required this.isEdit,
    required this.id,
  });
}

class ViewToDoDetail extends StatefulWidget {
  final ViewToDoDetailArgs args;

  const ViewToDoDetail({
    super.key,
    required this.args,
  });

  @override
  State<ViewToDoDetail> createState() => _ViewToDoDetailState();
}

class _ViewToDoDetailState extends State<ViewToDoDetail> with BasePageState {
  String _title = "";
  bool isEdit = false;
  late ViewToDoScreenBloc _bloc;
  late ToDoModel _dataModel = ToDoModel();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _viewOrUpdateFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    isEdit = widget.args.isEdit;
    _bloc = BlocProvider.of<ViewToDoScreenBloc>(context);
    fetchToDoDetailByID();
    changeTitle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<ViewToDoScreenBloc, ViewToDoScreenState>(
      listener: (context, state) {
        if (state is ReceivedViewToDoDetail) {
          setState(() {
            _dataModel = state.toDoModel;
            populateControllers();
          });
        }
        if (state is SubmittedViewToDoSuccessful) {
          showToast(
              "${AppString.toDo} updated successfully...!", state.msgType);
          Navigator.pop(context, true);
          // Clear fields and show success message
          _titleController.clear();
          _descriptionController.clear();
          _dueDateController.clear();
        }

        if (state is SubmissionViewToDoFailed) {
          showToast("${AppString.toDo} update failed", state.msgType);
          Navigator.pop(context, false);
          // Clear fields and show success message
          _titleController.clear();
          _descriptionController.clear();
          _dueDateController.clear();
        }
      },
      child: BaseScreen(
        title: "$_title ${AppString.toDo}",
        isAppShadowEffect: false,
        isIcon: true,
        body: Form(
          key: _viewOrUpdateFormKey,
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
                  isReadOnly: !isEdit,

                  txtHint: 'e.g xyz',
                  maxLength: 20,
                  onChanged: (newValue) {
                    _dataModel.name = newValue;
                  },
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
                  isReadOnly: !isEdit,

                  txtHint: 'e.g xyz',
                  maxLines: 3,
                  onChanged: (newValue) {
                    _dataModel.description = newValue;
                  },
                ),
                vGap(height: AppDimen.appSpace15),

                // Due Date Field
                CustomTextField(
                  textFieldHeading: 'Due Date',
                  controller: _dueDateController,
                  required: true,
                  isHeading: true,
                  isReadOnly: !isEdit,


                  onTap: isEdit
                      ? () {
                          debugPrint('date picker activated');
                          _pickDueDate(context);
                        }
                      : null,
                  // Only allow tap when in edit mode
                  suffixIcon: const Icon(Icons.calendar_month_rounded),
                  suffixIconAction: () {
                    if (isEdit) {
                      debugPrint('date picker activated');
                      _pickDueDate(context);
                    }
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
        bottomNav: Visibility(
          visible: isEdit,
          child: SizedBox(
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.all(AppDimen.appSpace10),
              child: CustomElevatedButton(
                onPressed: _updateToDo,
                text: 'Update ${AppString.toDo}',
              ),
            ),
          ),
        ),
      ),
    );
  }

  void fetchToDoDetailByID() {
    _bloc.add(
      FetchToDoDetail(widget.args.id),
    );
  }

  void populateControllers() {
    _titleController.text = _dataModel.name ?? '';
    _descriptionController.text = _dataModel.description ?? '';

    _dueDateController.text = _dataModel.dueDate != null
        ? DateTimeHelper.formatAnyDateTime(
            _dataModel.dueDate.toString(), "dd-MM-yyyy HH:mm")
        : DateTimeHelper.formatAnyDateTime('0001-01-01', "dd-MM-yyyy HH:mm");
  }

  String changeTitle() {
    setState(() {
      _title = isEdit ? "Edit" : "View";
    });
    return _title;
  }

  // This function opens the date picker
  Future<void> _pickDueDate(BuildContext context) async {
    // Try to parse the date from the controller's text.
    DateTime initialDate = DateTime.now();
    if (_dueDateController.text.isNotEmpty) {
      try {
        initialDate =
            DateFormat('dd-MM-yyyy HH:mm').parse(_dueDateController.text);
      } catch (e) {
        // If parsing fails, fall back to current date.
        initialDate = DateTime.now();
      }
    }

    // Open the DatePicker dialog
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate, // Set the initial date here
      firstDate: DateTime.now(), // Set the first selectable date
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Step 2: Pick the Time
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(initialDate), // Use the same initial date
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

        // Step 5: Update the text field and model
        setState(() {
          _dueDateController.text = formattedDate;
          _dataModel.dueDate = formattedDate;
        });
      }
    }
  }

  // This function adds a new to-do item
  Future<void> _updateToDo() async {
    String titleValue = _titleController.text;
    String descriptionValue = _descriptionController.text;
    String dueDateValue = _dueDateController.text;
    if (_viewOrUpdateFormKey.currentState?.validate() ?? false) {
      final todo = ToDoModel(
        name: titleValue,
        description: descriptionValue,
        dueDate: dueDateValue,
        id: widget.args.id,
      );

      _bloc.add(UpdateToDoDetail(todo));
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
