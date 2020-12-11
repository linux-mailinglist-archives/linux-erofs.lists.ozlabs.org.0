Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 048CE2D6E24
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Dec 2020 03:30:10 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CsZWF400YzDqrm
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Dec 2020 13:30:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f44;
 helo=mail-qv1-xf44.google.com; envelope-from=fedora.dm0@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=r8qRrMCi; dkim-atps=neutral
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CsZW733yyzDqmF
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Dec 2020 13:29:49 +1100 (AEDT)
Received: by mail-qv1-xf44.google.com with SMTP id 4so3545325qvh.1
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Dec 2020 18:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=s3wk+4D8Ryz0s3qJDcO04gNFZLKlupTtvJ49ufzGoJI=;
 b=r8qRrMCiF/VmaXVbS7glj96MKUr3eUrUcdTKDo8Q5gR7nDICS4mif+GnsaeSUyeKIr
 VHrUeNIybxN8sZbrtPGzSc289SvzwXf8f9rrR9HsIQN7TtX6WHPVkILT4ntgaJH/0Pn9
 OxI3uDphq3uhUBkofAE/jvvxvMEZtRaMcgbT7u22S4L9/wB3Ju7ZDZp4WWB64HXnh2je
 +xXNoR+O7QcYPT6mz1AhYZNe9erMNAtCebgkIulcsOEbCmUC7jEOB9n3uhyMfEPmBYlH
 R2val/Yu/WIc9cq41zEgUDPlxbLmpnid5SVa1v9Omw8qDzeFkqx4ZvMtcwnP6uip8L+O
 m0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=s3wk+4D8Ryz0s3qJDcO04gNFZLKlupTtvJ49ufzGoJI=;
 b=ENqD4q1KM8nxzmB1KEEEj2/4dW4xWHNaoV6XdvY76AD8gvsFRWHzaoZ8PMOR68uOAP
 /w95LwFWXbFbvrpJJGilSRkc37DRi0UBZ9o8br2Ct7yoMo28ERElJDSP8YXQNjv9OmQu
 HQs5aDccIyinsNPKxp9HvT0Mt42CIOFXo2x47U0vq9cLu/QJ7wYiRL6mSEEwBp9XrGSw
 VNi9WgcTVekERlBcU8ZT4LeCeCztCutOLTJCMtp+iCGCkBEiaOGZankpNhZwcQro8tkK
 86owhGwzaE/eB0huboqzh3auwHaaibIbrOdATfl13Lgv+lPDd4Cw1ERqT19izERzSp2f
 XLPw==
X-Gm-Message-State: AOAM530i6FtM/BAEHikcQdFxISvwrU95f4Qms6WVSNwlRBQ6YdO/ddCp
 lm5mHMeqUzWIXZ2BbZFap/k=
X-Google-Smtp-Source: ABdhPJzYzbyQiz6vsqsw9FIAyTXdWUTxx9dFe8nEFtWijdDKvcXOc3V4MdP8hEKHCu5nvSJZj+uJCQ==
X-Received: by 2002:ad4:4842:: with SMTP id t2mr12950593qvy.61.1607653785808; 
 Thu, 10 Dec 2020 18:29:45 -0800 (PST)
Received: from callisto (c-73-175-137-55.hsd1.pa.comcast.net. [73.175.137.55])
 by smtp.gmail.com with ESMTPSA id
 f17sm5262006qtv.68.2020.12.10.18.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 18:29:45 -0800 (PST)
From: David Michael <fedora.dm0@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com,
 miaoxie@huawei.com, fangwei1@huawei.com
Subject: [PATCH] erofs-utils: fuse: fix linking when using --with-selinux
Date: Thu, 10 Dec 2020 21:29:43 -0500
Message-ID: <87360dnkh4.fsf@gmail.com>
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
Cc: gaoxiang25@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The libselinux functions selabel_open and selabel_close are called
by lib/config.c, so include libselinux in CFLAGS and LIBS to fix
building erofsfuse.

Signed-off-by: David Michael <fedora.dm0@gmail.com>
---

Hi,

Trying to build both mkfs.erofs with SELinux and erofsfuse at the same
time (with both --enable-fuse and --with-selinux) results in the
following linking errors:

/usr/bin/ld: ../lib/.libs/liberofs.a(liberofs_la-config.o): in function `erofs_selabel_open':
/home/dm0/rpmbuild/BUILD/erofs-utils-1.2/lib/config.c:75: undefined reference to `selabel_open'
/usr/bin/ld: ../lib/.libs/liberofs.a(liberofs_la-config.o): in function `erofs_exit_configure':
/home/dm0/rpmbuild/BUILD/erofs-utils-1.2/lib/config.c:42: undefined reference to `selabel_close'

Are these programs supposed to be configured separately?  If this build
configuration is supposed to work, this change fixes linking.

Thanks.

David

 fuse/Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index f14f6fd..e7757bc 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -5,6 +5,6 @@ AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
 erofsfuse_SOURCES = dir.c main.c
 erofsfuse_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
-erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS}
-erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS}
+erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} ${libselinux_LIBS}
 
-- 
2.29.2
