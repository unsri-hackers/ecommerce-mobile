import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:deuvox/app/config/themes.dart';
import 'package:deuvox/controller/bloc/uploadimage/upload_image_bloc.dart';
import 'package:deuvox/controller/bloc/uploaditem/upload_item_bloc.dart';
import 'package:deuvox/data/model/upload_image_model.dart';
import 'package:deuvox/data/model/upload_item_model.dart';
import 'package:deuvox/generated/lang_utils.dart';
import 'package:deuvox/views/component/common_button.dart';
import 'package:deuvox/views/component/common_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

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
  //List<String> variant = [];
  String _categoryValue = LocaleKeys.category_food.tr();
  String _conditionValue = LocaleKeys.condition_new.tr();
  final index = ValueNotifier<int>(0);

  Widget displayImage(int index) {
    if (images.isEmpty) {
      return SizedBox.shrink();
    } else {
      return Image.file(images[index]);
    }
  }

  /*
  void variantDelete(int index) {
    variant.removeAt(index);
  }
   */

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
          appBar: AppBar(
            title: Text(
              LocaleKeys.add_product.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            bottomOpacity: 0.0,
          ),
          body: Form(
              key: _formKey,
              child: BlocConsumer<UploadItemBloc, UploadItemState>(
                  bloc: uploadItemBloc,
                  listener: (context, state) {
                    if (state is UploadItemFailure) {
                      FlushbarHelper.createError(
                          message: LocaleKeys.failed_to_upload_item.tr())
                        ..show(context);
                    }
                    if (state is UploadItemSuccess) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    }
                  },
                  builder: (context, state) {
                    return ListView(
                      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                      children: [
                        SizedBox(height: 10),
                        CGhostInputField(
                          labelText: LocaleKeys.product_name.tr(),
                          onSaved: (val) => uploadItemModel.name = val,
                          validator: (value) =>
                          value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_name.tr()]) : null,
                        ),
                        SizedBox(height: 20),
                        CGhostInputField(
                          labelText: LocaleKeys.product_price.tr(),
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          onSaved: (val) =>
                          {
                            if(val != null) uploadItemModel.price = int.parse(val)
                          },
                          validator: (value) =>
                          value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_price.tr()]) : null,
                        ),
                        SizedBox(height: 24),
                        Text(LocaleKeys.item_details.tr(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 24),
                        Container(
                          margin: EdgeInsets.only(left: 2),
                          child: Text(
                            LocaleKeys.product_category.tr(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                            isDense: true,
                          ),
                          value: _categoryValue,
                          items: [
                            DropdownMenuItem(
                              child: Text(LocaleKeys.category_food.tr()),
                              value: LocaleKeys.category_food.tr(),
                            ),
                            DropdownMenuItem(
                              child: Text(LocaleKeys.category_clothes.tr()),
                              value: LocaleKeys.category_clothes.tr(),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _categoryValue = value!;
                            });
                          },
                          onSaved: (val) => uploadItemModel.category = val,
                          validator: (value) =>
                          value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_category.tr()]) : null,
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.only(left: 2),
                          child: Text(
                            LocaleKeys.product_variant.tr(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        /*
                        Container(
                          height: 60,
                          width: 30,
                          child: GridView.builder(
                            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: variant.length + 1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if(index == variant.length) {
                                return GestureDetector(
                                  onTap: () => showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => Container(
                                      margin: EdgeInsets.only(left: 14, top: 10, right: 24),
                                      padding: MediaQuery.of(context).viewInsets,
                                      height: MediaQuery.of(context).viewInsets.bottom + 70,
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: 2),
                                                child: Text(
                                                  LocaleKeys.product_variant.tr(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              TextFormField(
                                                autofocus: true,
                                                decoration:
                                                InputDecoration(
                                                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                                                  border: UnderlineInputBorder(),
                                                  isDense: true,
                                                ),
                                                textInputAction: TextInputAction.done,
                                                onFieldSubmitted: (value) {
                                                  setState(() {
                                                    variant.add(value);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              margin: EdgeInsets.only(right: 8),
                                              width: 15,
                                              height: 15,
                                              decoration: BoxDecoration(color: Colors.transparent,),
                                              child: GestureDetector(
                                                onTap: () => Navigator.pop(context),
                                                child: Icon(
                                                  Icons.close,
                                                  color: ThemeColors.black100,
                                                  size: 20,
                                                ),
                                              )
                                            ),
                                          )
                                        ]
                                      ),
                                    )
                                  ),
                                  child: Container(
                                      padding: EdgeInsets.only(top: 7),
                                      color: ThemeColors.white100,
                                      width: 80,
                                      child: Text(
                                        " +" + LocaleKeys.product_variant.tr(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                  ),
                                );
                              }
                              return Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    color: ThemeColors.white100,
                                    width: 60,
                                    height: 30,
                                    child: Text(
                                      variant[index],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: ThemeColors.red80,
                                        shape: BoxShape.circle,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            variantDelete(index);
                                          });
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: ThemeColors.white100,
                                          size: 8,
                                        ),
                                      )
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                         */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 2),
                                    child: Text(
                                      LocaleKeys.product_condition.tr(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  DropdownButtonFormField<String>(
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700
                                    ),
                                    decoration:
                                    InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                                      isDense: true,
                                    ),
                                    value: _conditionValue,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text(LocaleKeys.condition_new.tr()),
                                        value: LocaleKeys.condition_new.tr(),
                                      ),
                                      DropdownMenuItem(
                                        child: Text(LocaleKeys.condition_second.tr()),
                                        value: LocaleKeys.condition_second.tr(),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _conditionValue = value!;
                                      });
                                    },
                                    onSaved: (val) => uploadItemModel.condition = val,
                                    validator: (value) =>
                                    value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_condition.tr()]) : null,
                                  ),
                                ],
                              )
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              child: CGhostInputField(
                                labelText: LocaleKeys.product_weight.tr(),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                onSaved: (val) =>
                                {
                                  if(val != null) uploadItemModel.weight = double.parse(val)
                                },
                                validator: (value) =>
                                value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_weight.tr()]) : null,
                              ),
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              child: CGhostInputField(
                                labelText: LocaleKeys.product_stock.tr(),
                                keyboardType: TextInputType.number,
                                onSaved: (val) =>
                                {
                                  if(val != null) uploadItemModel.stock = int.parse(val)
                                },
                                validator: (value) =>
                                value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_stock.tr()]) : null,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        CGhostInputField(
                          labelText: LocaleKeys.product_description.tr(),
                          maxLines: 4,
                          onSaved: (val) => uploadItemModel.description = val,
                          validator: (value) =>
                          value!.isEmpty ? LocaleKeys.is_required.tr(args: [LocaleKeys.product_description.tr()]) : null,
                        ),
                        SizedBox(height: 20),
                        Text(LocaleKeys.upload_image.tr()),
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
                              return Container(
                                height: 90,
                                width: 90,
                                child: GridView.builder(
                                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 3,
                                  ),
                                  itemCount: images.length + 1,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    if(index == images.length) {
                                      return Row(
                                        children: [
                                          Container(
                                              height: 80,
                                              width: 80,
                                              child: CButtonFilled(
                                                  primaryColor: ThemeColors.white100,
                                                  textLabel: "Upload",
                                                  onPressed: (){
                                                    showDialogUploadImage(context);
                                                  }
                                              )
                                          ),
                                        ],
                                      );
                                    }
                                    return Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider("https://cf.shopee.co.id/file/fd71b0fc1e91217d07fc0cb30ec7c87f")
                                        )
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  child: CButtonFilled(
                                    primaryColor: ThemeColors.white100,
                                    textLabel: "Upload",
                                    onPressed: (){
                                      showDialogUploadImage(context);
                                    }
                                  )
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.limit_image_size.tr(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: ThemeColors.red80,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      LocaleKeys.limit_image_pixel.tr(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: ThemeColors.red80,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          }
                        ),
                        SizedBox(height: 20),

                        Container(
                          height: 40,
                          width: double.infinity,
                          child: Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CButtonFilled(
                                    rounded: true,
                                    textLabel: LocaleKeys.save.tr(),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState?.save();

                                        uploadItemBloc.add(UploadItemStarted(uploadItemModel));
                                      }
                                    }
                                ),
                              )
                            ],
                          )
                        ),
                      ]
                    );
                  }
              )
          ),
        )
    );
  }
}