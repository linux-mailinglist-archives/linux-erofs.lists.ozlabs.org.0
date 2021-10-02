Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C55441FE80
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Oct 2021 00:39:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HMMND5hlsz2yNK
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Oct 2021 09:39:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qtLTmGGn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::730;
 helo=mail-qk1-x730.google.com; envelope-from=fedora.dm0@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=qtLTmGGn; dkim-atps=neutral
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HMMN83ywYz2yHj
 for <linux-erofs@lists.ozlabs.org>; Sun,  3 Oct 2021 09:39:03 +1100 (AEDT)
Received: by mail-qk1-x730.google.com with SMTP id m7so12775391qke.8
 for <linux-erofs@lists.ozlabs.org>; Sat, 02 Oct 2021 15:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=W/aSRieWDLsSJdnzH8A8K1Xh+uxwmG6ud9nYrUVC73g=;
 b=qtLTmGGnec/HN48lzIo0bs4+CylOyXNH9J4nAG8P9vxJZ5ozTHx+BOtEvNpsiA6AJ2
 7mG25quHaAKdmSaRZdbDU1+O0qCxLOuNQA7PDXESFt+5OvnZRk/QEXjr4aKJf7PV741Q
 wgmg2YVAMUFS4amw1MqSpnJZpHGMINS42uEqCyyl4whiCefHbe28VegaOW06jD5YCuKR
 78lYOb2/2lHjXNiL06LORCONca3mtDlKdeC0s2eWIICi51ZmlMwMvIHdbPMbRIVnLc2S
 wveRHPS4QDzAL6EYLdfbmvBireizY3PxHyIctCIV13JPntPkN5/f3v802qirv/eVaDja
 QM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=W/aSRieWDLsSJdnzH8A8K1Xh+uxwmG6ud9nYrUVC73g=;
 b=isLBcaH/CZie1vpiibxpv2Hn/DXtthsUZGHZyvQo2a4vb05O1OI/Xd0ysk9M5N2cR9
 RT/JC7VfLJubzxMrCWX0juJNkqxR5gU+L0xcAiWZwXNLNm56V/q/0MbLONho7x9FoPaI
 Qkbg9gvZr7wv8McsBa1q+W9X8QHxEi+58uJEt7Ku5Xkv/8ICBWaMxedBPqITcBhIf246
 QP6tfzyEjAw05O+/MI7TkaXnpDexrxhsvvIvRVB0yYddFYzUe5uPRMqJSpogYwoJ5dy0
 4gs5t9JdwLsY/CkJ/Q06SLmoYG6QvJKOZmclSjagoKESNcicoNkhRTwWpp6e6CJuGX+3
 /IFA==
X-Gm-Message-State: AOAM5320qZDDRECI5rnQo9+EUKQm1NsK3e34uVIbOYjJHXeGOog6nADV
 tXrCjnGpY/4GttrmiyrdyJk=
X-Google-Smtp-Source: ABdhPJxA8xHm+SRTyx969M2ydweCqwsy2UshZP9EsWiQqnGYTLQkTCDeAkpTm8JqdesiIl/BXylUyw==
X-Received: by 2002:a37:9401:: with SMTP id w1mr4121778qkd.166.1633214338831; 
 Sat, 02 Oct 2021 15:38:58 -0700 (PDT)
Received: from callisto (c-73-175-137-55.hsd1.pa.comcast.net. [73.175.137.55])
 by smtp.gmail.com with ESMTPSA id
 u12sm6618978qtw.73.2021.10.02.15.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Oct 2021 15:38:58 -0700 (PDT)
From: David Michael <fedora.dm0@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com,
 miaoxie@huawei.com, fangwei1@huawei.com
Subject: [PATCH] erofs-utils: dump: fix linking when using --with-selinux
Date: Sat, 02 Oct 2021 18:38:57 -0400
Message-ID: <875yufoxvi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: yuchao0@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The libselinux functions selabel_open and selabel_close are called
by lib/config.c, so include libselinux in CFLAGS and LIBS to fix
building dump.erofs.

Signed-off-by: David Michael <fedora.dm0@gmail.com>
---

Hi,

I tried building the dev branch with SELinux support and got this:

/bin/sh ../libtool  --tag=CC   --mode=link x86_64-pc-linux-gnu-gcc -Wall -Werror -I../include -O2 -pipe  -Wl,-O1 -Wl,--as-needed -o dump.erofs dump_erofs-main.o ../lib/liberofs.la -luuid  
libtool: link: x86_64-pc-linux-gnu-gcc -Wall -Werror -I../include -O2 -pipe -Wl,-O1 -o dump.erofs dump_erofs-main.o  -Wl,--as-needed ../lib/.libs/liberofs.a -luuid
/usr/lib/gcc/x86_64-pc-linux-gnu/10.3.0/../../../../x86_64-pc-linux-gnu/bin/ld: ../lib/.libs/liberofs.a(liberofs_la-config.o): in function `erofs_exit_configure':
config.c:(.text+0xe2): undefined reference to `selabel_close'
/usr/lib/gcc/x86_64-pc-linux-gnu/10.3.0/../../../../x86_64-pc-linux-gnu/bin/ld: ../lib/.libs/liberofs.a(liberofs_la-config.o): in function `erofs_selabel_open':
config.c:(.text+0x180): undefined reference to `selabel_open'
collect2: error: ld returned 1 exit status

Should it just link libselinux to fix the build?

Thanks.

David

 dump/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dump/Makefile.am b/dump/Makefile.am
index 0bb7b4e..f0246d7 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -6,4 +6,4 @@ bin_PROGRAMS     = dump.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
 dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
-dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libuuid_LIBS}
\ No newline at end of file
+dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${libuuid_LIBS}
-- 
2.31.1
