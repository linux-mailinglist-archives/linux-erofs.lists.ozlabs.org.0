Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6622A0570
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Oct 2020 13:31:56 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CN1s527H3zDqpd
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Oct 2020 23:31:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YfVjubOV; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YfVjubOV; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CN1rt34pfzDqg6
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Oct 2020 23:31:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=KGn+9fQj32td4Mfo+kEbprLGv2SA3INQzOFo8NJ8EwU=;
 b=YfVjubOVK77XBKYdxw3CtyF9eDT2YaDUK5CTy0+icP8vujCnkqHX0BR4H58H5X7znnGe0s
 mrEZvWEhSMgIWP/YMNFn0xjx9aFrPRlDiIV5DhQkFePS1kLMn+KpCHuVQInf8qLYTRpOof
 V01kerPFvEFfFPhcf7BZYP7hcvGsbjI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=KGn+9fQj32td4Mfo+kEbprLGv2SA3INQzOFo8NJ8EwU=;
 b=YfVjubOVK77XBKYdxw3CtyF9eDT2YaDUK5CTy0+icP8vujCnkqHX0BR4H58H5X7znnGe0s
 mrEZvWEhSMgIWP/YMNFn0xjx9aFrPRlDiIV5DhQkFePS1kLMn+KpCHuVQInf8qLYTRpOof
 V01kerPFvEFfFPhcf7BZYP7hcvGsbjI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-MeD4acV7N1-56hmE52M0OA-1; Fri, 30 Oct 2020 08:31:29 -0400
X-MC-Unique: MeD4acV7N1-56hmE52M0OA-1
Received: by mail-pf1-f200.google.com with SMTP id z12so4714320pfa.22
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Oct 2020 05:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=KGn+9fQj32td4Mfo+kEbprLGv2SA3INQzOFo8NJ8EwU=;
 b=XJluhZCVXzjFCybKlJRw8CFD4PT8TxcMydm9CsPNJx70ExDQrJvWi+U8QahK2J2hNx
 gpRo7adRtBrkuOCcfNhgKZM//nEPuUXXOt3jKUMTTKNjRElrB3a5fS+rdoQ7RAgotY8J
 SxRzJ/1dnzgwcTrwvSG94JTIVdnYV51w9rS5kdpNBr5rlkylF7iA5qF6jYaitLqPn8ll
 zo4SlkviSAHA/ser29aloIu4JBRIOTSFH4MeBVB6mci571sVRhSh2uMw2wricuhtNj1g
 2ygSBOFdqPo2Vb1rtoqO+Lz+ZYMsP6KSiibwFxJD3OEydmGcRCI4MyrcXAHkZUVIgnPd
 aM6A==
X-Gm-Message-State: AOAM532nsJfpN6VXzLQwjrfjYwlddfy5joj0/W3z+C0K2JDfy3lfKpTZ
 ShonH0ro36EBLQLUQ66OVH0rNNuJOaCXlA/mfyzS2LuzdjkNX8Gl2EyBTNhgG7sfF6Dm+TjZQMk
 2VOQb6BhixKVH+rx6epICrdVO
X-Received: by 2002:a17:902:748a:b029:d6:9d17:44f3 with SMTP id
 h10-20020a170902748ab02900d69d1744f3mr3186313pll.45.1604061088500; 
 Fri, 30 Oct 2020 05:31:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxJpwyH5/7O8G7heJqWdq0lu5O8ICKGLxIfP5k/R4BlsNaRHRk1PjIrkrpBPryqKCswlEhuQ==
X-Received: by 2002:a17:902:748a:b029:d6:9d17:44f3 with SMTP id
 h10-20020a170902748ab02900d69d1744f3mr3186301pll.45.1604061088247; 
 Fri, 30 Oct 2020 05:31:28 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b128sm5415458pga.80.2020.10.30.05.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:31:27 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/4] erofs-utils: fix build error without lz4 library
Date: Fri, 30 Oct 2020 20:30:17 +0800
Message-Id: <20201030123020.133084-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This fixes a recent build error if lz4 library doesn't install,

/bin/sh ../libtool  --tag=CC   --mode=link gcc -Wall -Werror -I../include -g -O2   -o mkfs.erofs mkfs_erofs-main.o -luuid  ../lib/liberofs.la  -llz4
libtool: link: gcc -Wall -Werror -I../include -g -O2 -o mkfs.erofs mkfs_erofs-main.o  -luuid ../lib/.libs/liberofs.a -llz4
/usr/bin/ld: cannot find -llz4

Fixes: c497d89e5eac ("erofs-utils: enhance static linking for lz4 1.8.x")
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 configure.ac     | 2 ++
 mkfs/Makefile.am | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 0f40a84..bff1e29 100644
--- a/configure.ac
+++ b/configure.ac
@@ -240,7 +240,9 @@ if test "x${have_lz4}" = "xyes"; then
   else
     test -z "${with_lz4_libdir}" || LZ4_LIBS="-R${with_lz4_libdir} $LZ4_LIBS"
   fi
+  liblz4_LIBS="${LZ4_LIBS}"
 fi
+AC_SUBST([liblz4_LIBS])
 
 AC_CONFIG_FILES([Makefile
 		 man/Makefile
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index ecc468c..8b8e051 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -6,5 +6,5 @@ bin_PROGRAMS     = mkfs.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS} ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
-mkfs_erofs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${LZ4_LIBS}
+mkfs_erofs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${liblz4_LIBS}
 
-- 
2.18.1

