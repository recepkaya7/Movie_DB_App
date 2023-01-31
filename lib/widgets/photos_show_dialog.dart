import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

InkWell photosShowDialog(
    BuildContext context, dynamic oankiTv, int index) {
  return InkWell(
    onTap: () {
      int increament = index;
      var imagepadding = 30;
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => StatefulBuilder(
          builder: (context, setState) => AspectRatio(
            aspectRatio: MediaQuery.of(context).size.width + 16 / 9,
            child: Center(
              child: Align(
                alignment: Alignment.center,
                child: AlertDialog(
                  actions: [
                    Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  //hoverColor: Colors.green[200],
                                  focusColor: Colors.green[300],
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () {
                                    if (increament <= 0) {
                                      increament = oankiTv.images!.length - 1;
                                    } else {
                                      increament -= 1;
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.blueGrey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: SizedBox(
                                width: MediaQuery.of(context).size.width - 100,
                              )),
                              Expanded(
                                child: InkWell(
                                  //hoverColor: Colors.green[200],
                                  focusColor: Colors.green[300],
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () {
                                    if (increament >=
                                        oankiTv.images!.length - 1) {
                                      increament = 0;
                                    } else {
                                      increament += 1;
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.blueGrey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                  insetPadding: EdgeInsets.only(
                      left: imagepadding.toDouble(),
                      right: imagepadding.toDouble(),
                      top: imagepadding.toDouble(),
                      bottom: 0),
                  contentPadding: EdgeInsets.only(
                      left: imagepadding.toDouble(),
                      right: imagepadding.toDouble(),
                      top: imagepadding.toDouble(),
                      bottom: 0),
                  backgroundColor: Colors.transparent,
                  content: imageMethod(oankiTv.images![increament].toString()),
                ),
              ),
            ),
          ),
        ),
      );
    },
    child: CircleAvatar(
      radius: MediaQuery.of(context).size.width / 10,
      backgroundImage: NetworkImage(
        oankiTv.images![index].toString(),
      ),
    ),
  );
}

CachedNetworkImage imageMethod(String imageUrl) {
  return CachedNetworkImage(
    fit: BoxFit.fill,
    imageUrl: imageUrl,
    placeholder: (context, url) => const CircularProgressIndicator(),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
