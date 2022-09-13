Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 327115B6C01
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 12:55:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MRgNv5Bm9z3brh
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 20:55:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=SDpkpB4H;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=SDpkpB4H;
	dkim-atps=neutral
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MRgNp3Q4lz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 20:55:36 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id l10so11409894plb.10
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 03:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3UCMleA6OQl8MXCB16VwW7JyRNDWI+SLdw5vmnTo7pw=;
        b=SDpkpB4HkgZ7c0dSmxfNxqcQFap/cozqUYpBUdBMnKHu58Oav1JM3evC3YM+C/+BXY
         pUqqdkUiCL77dkYALhmHEDvCswCxbvUtvqkm+tJHai9As82Ly0KRT4wGRUJrWKlH7NqA
         Jt4TujdEkc8ZK0bgpoKNuw+MLwiu36QJUv+JUiZGcuiJ6lP7H2mLkbrg5jzYf6Qt0CI9
         5VrW0sV4Js6wjRBKORHANSP+o77Uz5yKfTvkNEytIH8gim66/fdPUzJ13a7oeUZ353Sa
         ngnnNkyNhGlo0GWMw84emCAJFrMJ59xDleCCEFDm6Qm6FGSVv/xfhMIz0C4bFl6AEA4H
         2n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3UCMleA6OQl8MXCB16VwW7JyRNDWI+SLdw5vmnTo7pw=;
        b=qGbZe6hPm25hn57SW9PZBZcW61MhcejGwXKWKqNB3HClX8DZhFaksc3vjihRqKvUnJ
         BR16JsJPWQE2HkMJ0Jn9nOU81fXSYdobdl1bTSufaPNkxEP0GU5xyt80du9tIXQGv8LQ
         wFIV7Oalvfo+Um6yFbL/Vhid7IyFVB53eQNRHpdEWSt236yQygMXfHfSckgbRfJo0ac9
         GOvD7z466vC4Wm7/IHVbI7GctOlTglvpRQoA/v0gPB90mR0NPKITDaQQ8nA1VXyk4xIe
         DqI3V4ENJ6EbIkA12aYOPXFHUZeWlk8VkJhU7On8S+87kY4v2+V/O1hGIzGUMUVXCcNi
         dSsA==
X-Gm-Message-State: ACgBeo0fphHTF+J6Y1KE9E01rL64SkKdsNhGmcO66k5ZEqWZWYlx1j8i
	Seol77NxCnBvSgC0ejvqStq11O5BHFk=
X-Google-Smtp-Source: AA6agR4Czma9DgKtxqEbuVppW02vrXJmRq7RyomSznxmSnwbUNZPug4FLQy2nxC9PLgpsvjw1aadNQ==
X-Received: by 2002:a17:90b:1e01:b0:202:ee2b:c856 with SMTP id pg1-20020a17090b1e0100b00202ee2bc856mr3336015pjb.29.1663066533619;
        Tue, 13 Sep 2022 03:55:33 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id g17-20020aa796b1000000b0054097cb2da6sm7475290pfk.38.2022.09.13.03.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 03:55:33 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v8 0/4] erofs-utils: compressed fragments feature
Date: Tue, 13 Sep 2022 18:54:45 +0800
Message-Id: <cover.1663065968.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

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

Changes since v7:
 - fix is_packed_inode;
 - support 64bits fragment offset for fragment inode and legacy compress;
 - sync with zmap changes in kernel modified by Xiang;

Changes since v6/v5:
 - mainly optimize the packed inode related pointed out in v6 by Xiang (v6)
 - mainly optimize interlaced uncompress data code (v5)

Changes since v4:
 - naming on-disk offset as interlaced offset and add a advise to hint the data
   layout (Gao Xiang);
 - improve the packed inode pcluster size checking condition (Gao Xiang);
 - add field is_packed_inode instead of using is_src parameter passed (Gao Xiang);
 - per-inode eof bug_on (Gao Xiang);
 - extract the interlaced data layout part as a seprate patch;
 - change the advise bit of fragment feature.
 - re-implement the function to read interlaced data;
 - update compresstion ratio check;

Changes since v3:
 - fuse minor change and modify fragments naming related suggested by Xiang;
 - refator fragments build code;
 - rebase to latest commit 547bea3cb71a.

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

Yue Hu (4):
  erofs-utils: fuse: support interlaced uncompressed pcluster
  erofs-utils: lib: support fragments data decompression
  erofs-utils: mkfs: support interlaced uncompressed data layout
  erofs-utils: mkfs: introduce compressed fragments support

 include/erofs/compress.h   |   8 ++-
 include/erofs/config.h     |   3 +-
 include/erofs/decompress.h |   3 ++
 include/erofs/fragments.h  |  28 ++++++++++
 include/erofs/inode.h      |   1 +
 include/erofs/internal.h   |   9 ++++
 include/erofs_fs.h         |  28 +++++++---
 lib/Makefile.am            |   4 +-
 lib/compress.c             | 106 +++++++++++++++++++++++++++----------
 lib/data.c                 |  37 ++++++++++++-
 lib/decompress.c           |  17 +++++-
 lib/fragments.c            |  59 +++++++++++++++++++++
 lib/inode.c                |  47 ++++++++++++++--
 lib/super.c                |   1 +
 lib/zmap.c                 |  42 ++++++++++++++-
 mkfs/main.c                |  61 ++++++++++++++++++---
 16 files changed, 405 insertions(+), 49 deletions(-)
 create mode 100644 include/erofs/fragments.h
 create mode 100644 lib/fragments.c

-- 
2.17.1

