// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

class Iframe extends StatefulWidget {
  Iframe({
    Key? key,
    // this.allow,
    // this.allowFullscreen,
    // this.allowPaymentRequest,
    // this.csp,
    required this.height,
    // this.name,
    // this.referrerPolicy,
    required this.src,
    // this.srcdoc,
    required this.width,
    this.decoration,
  })  : iframe = IFrameElement(),
        super(key: key);

  final IFrameElement iframe;
  // final String? allow;
  // final bool? allowFullscreen;
  // final bool? allowPaymentRequest;
  // final String? csp;
  final String? height;
  // final String? name;
  // final String? referrerPolicy;
  final String? src;
  // final String? srcdoc;
  final String? width;
  final Decoration? decoration;

  DomTokenList? get sandbox => iframe.sandbox;

  @override
  State createState() => _IframeState();
}

class _IframeState extends State<Iframe> {
  //
  @override
  void initState() {
    super.initState();
    // widget.iframe.allow = widget.allow;
    // widget.iframe.allowFullscreen = widget.allowFullscreen;
    // widget.iframe.allowPaymentRequest = widget.allowPaymentRequest;
    // widget.iframe.csp = widget.csp;
    widget.iframe.height = widget.height;
    // widget.iframe.name = widget.name;
    // widget.iframe.referrerPolicy = widget.referrerPolicy;
    //ignore: unsafe_html
    widget.iframe.src = widget.src;
    // //ignore: unsafe_html
    // widget.iframe.srcdoc = widget.srcdoc;
    widget.iframe.width = widget.width;
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory('hello-world-html', (int viewId) => widget.iframe);
    // // ignore: undefined_prefixed_name
    // ui.platformViewRegistry.registerViewFactory(
    //     'hello-world-html',
    //     (int viewId) => IFrameElement()
    //       ..src = widget.src
    //       ..width = '640'
    //       ..height = '360'
    //       ..style.border = 'none');
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: widget.iframe.style.border != 'none'
            ? null
            : widget.decoration ??
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        width: double.tryParse(widget.iframe.width!) ?? 900,
        height: double.tryParse(widget.iframe.height!) ?? 1000,
        child: const HtmlElementView(viewType: 'hello-world-html'),
      );
}
