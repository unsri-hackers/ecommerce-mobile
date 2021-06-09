import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:deuvox/controller/bloc/uploadimage/upload_image_bloc.dart';
import 'package:deuvox/controller/bloc/uploaditem/upload_item_bloc.dart';
import 'package:deuvox/data/model/upload_image_model.dart';
import 'package:deuvox/data/model/upload_item_model.dart';
import 'package:deuvox/views/component/common_button.dart';
import 'package:deuvox/views/component/common_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);


  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UploadItemBloc uploadItemBloc = UploadItemBloc();
  UploadImageBloc uploadImageBloc = UploadImageBloc();
  UploadItemModel uploadItemModel = UploadItemModel();
  List<UploadImageModel> uploadImageModels = [];
  List<File> images = [];
  final index = ValueNotifier<int>(0);

  Widget displayImage(int index) {
    if (images.isEmpty) {
      return SizedBox.shrink();
    } else {
      return Image.file(images[index]);
    }
  }

  @override
  void initState() {
    uploadItemBloc = UploadItemBloc();
    uploadImageBloc = UploadImageBloc();
    super.initState();
  }

  @override
  void dispose() {
    uploadItemBloc.close();
    uploadImageBloc.close();
    super.dispose();
  }

  Future<void> showDialogUploadImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => BlocProvider<UploadImageBloc>(
            create: (context) => uploadImageBloc,
            child: BlocConsumer<UploadImageBloc, UploadImageState>(
              bloc: uploadImageBloc,
              listener: (context, state) {
                if(state is UploadImagePickerSelected) {
                  images.add(state.image);
                  UploadImageModel temp = UploadImageModel();
                  temp.image_name = state.image.path;
                  uploadImageModels.add(temp);
                }
                if(state is UploadImagePickerFailure) {
                  FlushbarHelper.createError(
                      message: "Terjadi kesalahan saat memilih image.")
                    ..show(context);
                }
                if(state is UploadImageExceedsSizeLimit) {
                  FlushbarHelper.createError(
                      message: "Gambar melebihi batas ukuran yang ditentukan.")
                    ..show(context);
                }
                if(state is UploadImageWrongResolution) {
                  FlushbarHelper.createError(
                      message: "Gambar memiliki resolusi yang tidak sesuai.")
                    ..show(context);
                }
              },
              builder: (context, state) {
                return SimpleDialog(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  children: [
                    CButtonFilled(
                      textLabel: "Browse Files",
                      onPressed: () {
                        uploadImageBloc.add(UploadImageBrowsingFiles());
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            if (index.value.toInt() != 0) index.value--;
                            },
                        ),
                        ValueListenableBuilder(
                          valueListenable: index,
                          builder: (context, index, widget) {
                            return Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1)
                                ),
                                child: displayImage(int.parse(index.toString())),
                              )
                            );
                          },
                        ),
                        IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              if (index.value.toInt() < images.length -1 ) index.value++;
                            }
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    CButtonFilled(
                      textLabel: "Upload",
                      onPressed: () {
                        uploadImageBloc.add(UploadImageStarted(uploadImageModels));
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<UploadItemBloc>(
              create: (context) => uploadItemBloc
          ),
          BlocProvider<UploadImageBloc>(
              create: (context) => uploadImageBloc
          )
        ],
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: BlocConsumer<UploadItemBloc, UploadItemState>(
              bloc: uploadItemBloc,
              listener: (context, state) {
                if (state is UploadItemFailure) {
                  FlushbarHelper.createError(
                      message: "Upload gagal, terjadi kesalahan dalam mengupload item")
                    ..show(context);
                }
                if (state is UploadItemSuccess) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  print(uploadItemModel.name);
                  print(uploadItemModel.price);
                  print(uploadItemModel.condition);
                  print(uploadItemModel.weight);
                  print(uploadItemModel.description);
                }
              },
              builder: (context, state) {
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                  children: [
                    Text(
                      "Upload Barang",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 30),
                    CTextFormFilled(
                      labelText: "Nama Barang*",
                      onSaved: (val) => uploadItemModel.name = val,
                      validator: (value) =>
                      value!.isEmpty ? "Data belum lengkap" : null,
                    ),
                    SizedBox(height: 20),
                    CTextFormFilled(
                      labelText: "Harga*",
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onSaved: (val) =>
                        {
                          if(val != null) uploadItemModel.price = double.parse(val)
                        },
                      validator: (value) =>
                      value!.isEmpty ? "Data belum lengkap" : null,
                    ),
                    SizedBox(height: 20),
                    Text("Detail Barang",style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    )),
                    SizedBox(height: 20),
                    CTextFormFilled(
                      labelText: "Kondisi Barang*",
                      hintText: "Baru",
                      onSaved: (val) => uploadItemModel.condition = val,
                      validator: (value) =>
                      value!.isEmpty ? "Data belum lengkap" : null,
                    ),
                    SizedBox(height: 20),
                    CTextFormFilled(
                      labelText: "Berat*",
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onSaved: (val) =>
                        {
                          if(val != null) uploadItemModel.weight = double.parse(val)
                        },
                      validator: (value) =>
                      value!.isEmpty ? "Data belum lengkap" : null,
                    ),

                    SizedBox(height: 20),
                    CTextFormFilled(
                      labelText: "Deskripsi Barang*",
                      maxLines: 4,
                      onSaved: (val) => uploadItemModel.description = val,
                      validator: (value) =>
                      value!.isEmpty ? "Data belum lengkap" : null,
                    ),
                    SizedBox(height: 20),
                    Text("Upload Photo*"),
                    SizedBox(height: 10),
                    BlocConsumer(
                        bloc: uploadImageBloc,
                        listener: (context, state) {
                          if (state is UploadImageSuccess) {
                            //get resdata from uploadimagesuccess
                            uploadImageBloc.add(UploadImagePreview("image_name"));
                            //uploadItemModel.filename = state.image
                          }
                        },
                        builder: (context, state) {
                          if (state is UploadImagePreviewSuccess) {
                            return Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1)
                                      ),
                                      child: //Image.file(state.image)
                                      SizedBox.shrink() //image file after api available later
                                  )
                                ]
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        }
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: CButtonFilled(
                                textLabel: "Upload",
                                onPressed: (){
                                  showDialogUploadImage(context);
                                }
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 300,
                          child: CButtonFilled(
                            textLabel: "Submit",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();

                                uploadItemBloc.add(UploadItemStarted(uploadItemModel));
                              }
                            }
                          )
                        ),
                      ]
                    )
                  ],
                );
              }
            )
          ),
        )
    );
  }
}
