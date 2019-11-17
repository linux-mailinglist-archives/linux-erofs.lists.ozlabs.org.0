Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B1323FF8B7
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Nov 2019 11:11:12 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47G7CK5fy7zDqcw
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Nov 2019 21:11:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::534;
 helo=mail-ed1-x534.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KeCO6Oqt"; 
 dkim-atps=neutral
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47G7CC5rGBzDqY6
 for <linux-erofs@lists.ozlabs.org>; Sun, 17 Nov 2019 21:11:02 +1100 (AEDT)
Received: by mail-ed1-x534.google.com with SMTP id a24so11114021edt.0
 for <linux-erofs@lists.ozlabs.org>; Sun, 17 Nov 2019 02:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=yaNFogrF+16XDw1ErHSzTBWC0QVu6RcU0Zkdw1QFmKQ=;
 b=KeCO6Oqtmg9QKXQe3aw3sRLYottLAl1m59oEWneetnYrMgR6/UFVmDg9ZxzlFeYwxc
 sqR8CxVycRP4pQGkCb68qdwUZgWPjaAOs0bbisUYAYpiB/NNu2RtJoj8N9OrNRzjcYOp
 S6Sfgoiz2bYQr8ZfdKc8IPRTENt6HUM5uvTGP21uL+UppXFa0ulv42VwiwzwItgCGj7U
 98GBznqUw54Lyj6aKHUASsNcDae4AVLVFKquWM9aQVR9P/TKXSuJacDppqAbZV2e9TzF
 ezq3CDBS2JHEJdi0Kaien5yaXZNAW8mdgnK58WivZJsnfG7zBZ0ebYAlzcUECY7/3q0J
 pClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=yaNFogrF+16XDw1ErHSzTBWC0QVu6RcU0Zkdw1QFmKQ=;
 b=ZXWoRcPuAJMkTy6iJwQ02WFTwgw+vailFC00ZPGeaiE0pm4DscGY4Q74O/tFmR1UQV
 TbwbkVbXEjTVY58JPHEyyJEz4XwKVAR5p05uqP/yvQnoylYiPit5xMbxlq6z1YFHyBzh
 oocwNkMogBMyCYd1uEgZXQRrO4U53YQa2snDBDHRwv8xl+6KNWrUiNhiT9B4Wrbvn1IY
 TaXIR5+uSFJyUwMcDVeCu0MSW7g1QfdFxythHH4WN0kNiibq50a9r+QS9qwAOIsyzr0W
 B98ivhc9k2TNqqFFWHEK+6COfgg3RldZIkGVO2OwwHqK7DhxW5kEUx+ZGqubcSe+f76t
 fpZg==
X-Gm-Message-State: APjAAAX6aRdIDhYVsHpug06Y1XCdxgJfljTfiOu6h1ZGv1VE4Z2L7zac
 kDI+YhOg/IlKRCB+qWpwIwskgZ/LYA46yAVRxcY=
X-Google-Smtp-Source: APXvYqyxfpVlaex/izvv8tO+qzj/zuA1ct/X0RhxheyUfHQLw7wnUhG6/DoD6sb0uHqApZYpbkXVcKhNMqMzqyYTlew=
X-Received: by 2002:a17:906:1d19:: with SMTP id
 n25mr16509676ejh.151.1573985454815; 
 Sun, 17 Nov 2019 02:10:54 -0800 (PST)
MIME-Version: 1.0
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Sun, 17 Nov 2019 15:40:43 +0530
Message-ID: <CAGu0czQOorHC=JxQVpWDB2KD0NOzh13OuHj3r_4_U5hCWkkNwQ@mail.gmail.com>
Subject: Support for uncompressed sparse files.
To: Gao Xiang <hsiangkao@aol.com>, Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000ea7ed20597880b7e"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000ea7ed20597880b7e
Content-Type: text/plain; charset="UTF-8"

Hello Gao,

I have started working on above functionality for erofs.
First thing we need to do is detect sparse files & determine location of
holes in it.

I was thinking of using lseek() with SEEK_HOLE & SEEK_DATA for detecting
holes.
Let me know what you think about the approach OR any other better approach
in your mind.

PS : support for SEEK_HOLE & SEEK_DATA came in 3.4 kernel.

--000000000000ea7ed20597880b7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Gao,</div><div><br></div><div>I have started wo=
rking on above functionality for erofs.</div><div>First thing we need to do=
 is detect sparse files &amp; determine location of holes in it.</div><div>=
<br></div><div>I was thinking of using lseek() with SEEK_HOLE &amp; SEEK_DA=
TA for detecting holes.</div><div>Let me know what you think about the appr=
oach OR any other better approach in your mind.<br></div><div><br></div><di=
v>PS : support for SEEK_HOLE &amp; SEEK_DATA came in 3.4 kernel. <br></div>=
<div> <br></div></div>

--000000000000ea7ed20597880b7e--
