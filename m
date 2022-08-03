Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2769E588617
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 05:52:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LyHx11ff5z3bZ2
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 13:52:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=f/Neu5Et;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=f/Neu5Et;
	dkim-atps=neutral
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LyHwt3mBYz2xjf
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Aug 2022 13:51:57 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id q19so6024536pfg.8
        for <linux-erofs@lists.ozlabs.org>; Tue, 02 Aug 2022 20:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=MPN1gT8H5vr0Cme9PJzvHxH0Bj0aVtHO7CsB1rXg9j8=;
        b=f/Neu5Etsr7fyINEy8PmKKaq1BePgEb+sauruOhi46UBaJpnaDpPC1j3A3Ks0B7avH
         WYu425uCbC1jqM3P5wCKLU1zEUaK11vnt9MmAbkqowLDuvqjCeXDIoyBGYQhss2FFiPt
         ibdzrVKIPwALqrfWVFzegwrADJS4Vl4HOaL5p8zc8PqV6osbYw0a+S7EHW1JitmQLaa3
         DFOBE+OHOkaPfikmUso7M9sTzCGgE5q/inUhSSBEM7lG79LODgFBBh1aODvpxRSbm0zp
         n588LEnXzwXHbVr2R/4+K6Vw/uYKTiq6fIXeGbdVjhvzGTPJV6oSKGSHv8Fm2QyroFkO
         XUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MPN1gT8H5vr0Cme9PJzvHxH0Bj0aVtHO7CsB1rXg9j8=;
        b=eQYx6QsBl1wxaPQ6e46P3FtR/9zIT59yJRAA8QynBQdfA8MrI6mvVIKPbABzA9UVLT
         0kQtBvZ78XPA/bkN3hCeog8OXFnCgRaW68oAGt9uNnNAL5MJY4PCvh4eIsecHTqvE+ln
         Kce63o2G36p+MeBWxOi6TvQtvozw/9Y7aNw6XEqbnbxzYHDN2jCtCpYVtxKwl8G0zE+8
         uma/w8r1YtfE0cbSz47vQqCpEH6Knyg3K+n6ICIUJJmXmP2hW7Y/xZfw1SgsIBH20W1P
         fc7O5d+0ZPZSoh+Byv2+Ot2BArGwUydn0lbficIoAqpmfS/NGxdXbbWaMFJAUDWzuvyh
         cuLw==
X-Gm-Message-State: AJIora8t0Y45SddobZ8lUxoOYOPXToIV18XDP/FE5x3fuQ4snnv0Qptt
	tekCo2PIqpv/OxqUyXAWgSfHSRTLet0=
X-Google-Smtp-Source: AGRyM1uq6AH0d+IUar7Aknu+Qdh8XuA9Ib4acBlHzvPWjYPEPeqf+TgviQeRK8xlx00/oBnHwSOyaQ==
X-Received: by 2002:a63:d94a:0:b0:412:6e04:dc26 with SMTP id e10-20020a63d94a000000b004126e04dc26mr19732100pgj.539.1659498712719;
        Tue, 02 Aug 2022 20:51:52 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id e11-20020aa7980b000000b00528a097aeffsm2464629pfl.118.2022.08.02.20.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 20:51:52 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v3 0/3] erofs-utils: compressed fragments feature
Date: Wed,  3 Aug 2022 11:51:27 +0800
Message-Id: <cover.1659496805.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
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
Cc: huyue2@coolpad.com, zbestahu@163.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In order to achieve greater compression ratio, let's introduce
compressed fragments feature which can merge tail of per-file or the
whole files into one special inode to reach the target.

And we can also set pcluster size to fragments inode for different
compression requirments.

In this patchset, we also improve the uncompressed data layout of
compressed files. Just write it from 'clusterofs' instead of 0 since it
can benefit from in-place I/O. For now, it only goes with fragments.

The main idea above is from Xiang.

Here is some test data of Linux 5.10.87 source code under Ubuntu 18.04:

linux-5.10.87 (erofs, uncompressed)                1.1G

linux-5.10.87 (erofs, lz4hc,12 4k fragments,4k)    301M
linux-5.10.87 (erofs, lz4hc,12 8k fragments,8k)    268M
linux-5.10.87 (erofs, lz4hc,12 16k fragments,16k)  242M
linux-5.10.87 (erofs, lz4hc,12 32k fragments,32k)  225M
linux-5.10.87 (erofs, lz4hc,12 64k fragments,64k)  217M

linux-5.10.87 (erofs, lz4hc,12 4k vanilla)         396M
linux-5.10.87 (erofs, lz4hc,12 8k vanilla)         376M
linux-5.10.87 (erofs, lz4hc,12 16k vanilla)        364M
linux-5.10.87 (erofs, lz4hc,12 32k vanilla)        359M
linux-5.10.87 (erofs, lz4hc,12 64k vanilla)        358M

Usage:
mkfs.erofs -zlz4hc,12 -C65536 -Efragments,65536 foo.erofs.img foo/

Changes since v2:
 - mainly reimplment the decompression logic for fragment inode due to
   kernel side;
 - fix compatibility issue to old image with ztailpacking feature;
 - move code of super.c in patch 3/3 to patch 1/3;
 - minor naming change.

Changes since v1:
 - mainly optimize index space for fragment inode;
 - add merging tail with len <= pclustersize into fragments directly;
 - use a inode instead of nid to avoid multiple load fragments;
 - fix memory leak of building fragments;
 - minor change to diff special fragments with normal inode.
 - rebase to commit cb058526 with patch [1];
 - code cleanup.

Note that inode will be extended version (64 bytes) due to mtime, may
use 'force-inode-compact' option to reduce the size if mtime careless.

[1] https://lore.kernel.org/linux-erofs/20220722053610.23912-1-huyue2@coolpad.com/

Yue Hu (3):
  erofs-utils: lib: add support for fragments data decompression
  erofs-utils: lib: support on-disk offset for shifted decompression
  erofs-utils: introduce compressed fragments support

 include/erofs/compress.h   |   3 +-
 include/erofs/config.h     |   3 +-
 include/erofs/decompress.h |   3 ++
 include/erofs/fragments.h  |  25 +++++++++
 include/erofs/inode.h      |   2 +
 include/erofs/internal.h   |   9 ++++
 include/erofs_fs.h         |  27 +++++++---
 lib/Makefile.am            |   4 +-
 lib/compress.c             | 108 +++++++++++++++++++++++++++----------
 lib/data.c                 |  28 +++++++++-
 lib/decompress.c           |  10 +++-
 lib/fragments.c            |  76 ++++++++++++++++++++++++++
 lib/inode.c                |  43 ++++++++++-----
 lib/super.c                |  24 ++++++++-
 lib/zmap.c                 |  26 +++++++++
 mkfs/main.c                |  64 +++++++++++++++++++---
 16 files changed, 393 insertions(+), 62 deletions(-)
 create mode 100644 include/erofs/fragments.h
 create mode 100644 lib/fragments.c

-- 
2.17.1

