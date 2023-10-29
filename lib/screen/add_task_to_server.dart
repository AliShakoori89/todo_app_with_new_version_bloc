import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_new_version_bloc/bloc/task_from_net_bloc/bloc.dart';
import 'package:todo_app_with_new_version_bloc/model/task_model.dart';
import 'package:todo_app_with_new_version_bloc/screen/from_net/all_task_from_net_page.dart';
import 'package:todo_app_with_new_version_bloc/utils/dimensions.dart';
import '../bloc/task_from_net_bloc/event.dart';
import '../custom_icon/my_flutter_app_icons.dart';

class AddTaskFromNetPage extends StatefulWidget {
  const AddTaskFromNetPage({Key? key}) : super(key: key);

  @override
  State<AddTaskFromNetPage> createState() => _AddTaskFromNetPageState();
}

class _AddTaskFromNetPageState extends State<AddTaskFromNetPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            right: Dimensions.paddingWith_10,
            left: Dimensions.paddingWith_10,
            top: Dimensions.paddingHeight_20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      icon: Icon(MyFlutterApp.arrow_left_circle,
                      size: Dimensions.iconSmallSize,)),
                  Text("Add Task",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Dimensions.fontLargeSize
                  ),)
                ],
              ),
              SizedBox(height: Dimensions.paddingHeight_20,),
              ListTile(
                title: Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.paddingHeight_10),
                  child: Row(
                    children: [
                      Text("Title ",
                        style: TextStyle(
                          fontSize:Dimensions.fontVerySmallSize,
                          fontWeight: FontWeight.w500
                        ),),
                      Text("(Required)",
                      style: TextStyle(
                        fontSize: Dimensions.fontVVerySmallSize
                      ),)
                    ],
                  ),
                ),
                subtitle: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(Dimensions.middleRadius))),
                      hintText: 'type your title',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(215, 215, 215, 1)
                        ),
                      errorStyle: TextStyle(
                        fontSize: Dimensions.fontVVerySmallSize,
                          fontWeight: FontWeight.w500),
                      filled: true,
                      ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '\u26A0 required';
                      }
                      return null;
                    },
                    ),
                ),
              ),
              SizedBox(height: Dimensions.paddingHeight_20,),
              ListTile(
                title: Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.paddingHeight_10),
                  child: Text("Description ",
                    style: TextStyle(
                        fontSize:Dimensions.fontVerySmallSize,
                        fontWeight: FontWeight.w500
                    ),),
                ),
                subtitle: SizedBox(
                  height: Dimensions.descriptionBoxSize,
                  child: TextFormField(
                    controller: descriptionController,
                      maxLines: 8,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.middleRadius))),
                          hintText: 'type your title',
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(215, 215, 215, 1)
                          )
                      )
                  ),
                ),
              ),
              SizedBox(height: Dimensions.paddingHeight_20,),
              Container(
                margin: EdgeInsets.only(
                    right: Dimensions.paddingWith_15,
                    left: Dimensions.paddingWith_15,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  style:  ElevatedButton.styleFrom(
                    elevation: 1, backgroundColor: Colors.white),
                  child: Text("Submit",
                  style: TextStyle(fontWeight: FontWeight.w700,
                  fontSize: Dimensions.fontSmallSize,
                  color: const Color.fromRGBO(22, 190, 105, 1))),
                  onPressed: (){
                    TaskModel taskModel = TaskModel();
                    if(_formKey.currentState!.validate()){
                    final createTask =
                    BlocProvider.of<TaskFromNetBloc>(context);
                    taskModel.title = titleController.text;
                    taskModel.description = descriptionController.text;
                    taskModel.done = false;
                    createTask.add(AddNewTaskEvent(
                      taskModel: taskModel

                    ));
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AllTaskFromNetPage()));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
