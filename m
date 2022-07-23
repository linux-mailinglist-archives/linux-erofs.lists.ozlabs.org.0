Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00E357EC69
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jul 2022 09:17:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lqd1R0rwcz3bxp
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jul 2022 17:17:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=I0Ls7QDr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=I0Ls7QDr;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lqd1J6xWtz2xmg
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jul 2022 17:17:39 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so5939125pjf.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jul 2022 00:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=PC66+4+YT3ZBRVvgOLMJXcnU2Ik04X9Dtm2qlRs/X8k=;
        b=I0Ls7QDrG18CA5ariGrHA5giNsYxGBfVc+BftI9/twk5yc8uyUgyVa5ek5CEoklfkN
         lAnrnoY7RQIXLcFdHYKuywrz+4sE8HdiJ3b4nGvruTv/H1Foyjx0dkGbmyRh1JtQ3ZSl
         SigvMBNW+38AQ7EgP+Kq8XcjYanf36ymlEDd3QBD4ugwgTM7lZpQZJ5f3vzOMQTFrTsc
         jXkV7xSEBCTjdJHtiJi2XxujTIFjjn8EhwL8oOUMdp5swtep90JEeBnkfTTIlG0lwelw
         en4RRpNRtwECDPeBtnfLBorgfB1rDXnjDcZE4I+OaTS3GduYILqCB9umuGymIPJSpNfl
         MRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PC66+4+YT3ZBRVvgOLMJXcnU2Ik04X9Dtm2qlRs/X8k=;
        b=hqwhz1/tWv/kb/2mViZN/Izg6mGPbBmk2pWl2FMn/T4CZvLaTV8v9k0PwD0173wr5o
         3mg/4KW/o0uCoO03OaNMILRIpFpogl/I9XplI3h0rlRRT5EyCLWsLswsmw+MeKxFPk9t
         x8nXWD1tziAUSk8UipYykyioVamxDDFhq8MBPfZmssm8hhCeUwmlYHEa/3pAEV5FSeNu
         nyht7rQKoA2EvrKM1Y6hPpJ8aRWSFrLBeW75NiRjA0SWOpEA6UyYd+g6fMWk5pxMm79T
         0aKOQ2KxO9/tQFnGBWq7WNV9ReVI4+902J5tNDKMV/Lczolk7ZmN4PuZ1XxZemoBCOrV
         Clvg==
X-Gm-Message-State: AJIora8+Lar63LF+DCVbKYFMme7rJTuSrJrNNyDjZUqwmT5fz5iC5aQ7
	YW3UylM8cy3yPGQm6s5ukNS6mtrzKZY=
X-Google-Smtp-Source: AGRyM1uru1to8eUp7Z+rMj78kVNG+vjNH8+HXP+O7q6gUbS9EsC3iMbqc0jB26s4OHYLhVyDFFd6Tw==
X-Received: by 2002:a17:902:ab48:b0:16d:1175:9ed5 with SMTP id ij8-20020a170902ab4800b0016d11759ed5mr3419637plb.19.1658560653542;
        Sat, 23 Jul 2022 00:17:33 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id y66-20020a633245000000b00411955c03e5sm4535290pgy.29.2022.07.23.00.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 00:17:33 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v2 0/3] erofs-utils: compressed fragments feature
Date: Sat, 23 Jul 2022 15:17:12 +0800
Message-Id: <cover.1658556336.git.huyue2@coolpad.com>
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
 include/erofs/internal.h   |  14 +++++
 include/erofs_fs.h         |  24 ++++++---
 lib/Makefile.am            |   4 +-
 lib/compress.c             | 108 +++++++++++++++++++++++++++----------
 lib/data.c                 |  58 ++++++++++++++++++--
 lib/decompress.c           |  10 +++-
 lib/fragments.c            |  76 ++++++++++++++++++++++++++
 lib/inode.c                |  43 ++++++++++-----
 lib/super.c                |  24 ++++++++-
 lib/zmap.c                 |  18 +++++--
 mkfs/main.c                |  64 +++++++++++++++++++---
 16 files changed, 412 insertions(+), 67 deletions(-)
 create mode 100644 include/erofs/fragments.h
 create mode 100644 lib/fragments.c

-- 
2.17.1

