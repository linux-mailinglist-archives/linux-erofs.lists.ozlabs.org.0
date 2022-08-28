Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A5C5A3DDE
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Aug 2022 15:52:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MFw3h1T2Nz3bl0
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Aug 2022 23:52:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Uv8P30hv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Uv8P30hv;
	dkim-atps=neutral
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MFw3Q6Z9Fz30Lb
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Aug 2022 23:51:44 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id p185so5867239pfb.13
        for <linux-erofs@lists.ozlabs.org>; Sun, 28 Aug 2022 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=Posa0RGWo3rIN/pwMk3Z/b95gAytvvxMbPAKm6Rd//k=;
        b=Uv8P30hvnO12gSdNGYSsUHfaeo5hC2Ohm5YTdLl8Gw1QEvVbVlrrlk2Wv0a5eS6gDm
         BpmZ2xl+ZU9CFKGSsSdyy+wwn3SHu1qzC40uQpVo7KsPzPOAwUkziVt1D88DYsnFyURz
         iByQAYVjHrSq1PMQUIs6L8EnLqpb4xgUEh96j6/crVJV3FMGd50CvtEdcZg46DPYOzDR
         HCS0v3eW9NDSZZuX5xOXZxMdes8InqTu81eHxVrSynLpB78qdsmR0Ob8zyFyLfUvkaNb
         DX8RxosYAmTpshj9UWDGFpvo57FQEV5r6Oc3fF/6bmWlpoSGByks9nSPAaH1tGOSUecW
         9sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Posa0RGWo3rIN/pwMk3Z/b95gAytvvxMbPAKm6Rd//k=;
        b=T2MYGCau7Ma52Sphc8DX6bYUqwNbadNDdI/jNCp/Nh1uZmotcKTE/ZxgWhpkewJpQQ
         8NwlZNiTrsVIt2UX5BHiaoBCyBwqaQX1oXHXCWk1kNZnvpgpEPklnEiXpUHf106QrN3b
         3DS/03vgsCdu6d7ywVXpWjJAgxPTmqOWBWr+bgWsiPvzn6b3R/OFxPieoBvV+mXnsXja
         zZxeGlUPLYiQ4GzsJHoSspUAcqXG3nYp8Ow2wbi8rLAfKd4JeU9qpH5lCsQ7UkaVai+W
         hEVe5ufjxUDpl+DAR2IEAcgcpO9UhpqDoS7+nO1N1n5QaavIXZMXxO3n1tDmtNjKemJ8
         cgmw==
X-Gm-Message-State: ACgBeo2QbIsG6V7u4SMb8gf82t1hKTpvvsCQMmeQKJfRJ/nopWyRSDAM
	+7GTEnC5WNCj2wOBIhLDg2476rqnMnw=
X-Google-Smtp-Source: AA6agR5/WBSDI6fw6GpcJC6fb8HrobfRF/pfZQny4rpfsb7k0RpYrLUfQz82tsyq6Qr877FSaZj9Iw==
X-Received: by 2002:a05:6a00:27a0:b0:52f:8947:4cc5 with SMTP id bd32-20020a056a0027a000b0052f89474cc5mr12523085pfb.16.1661694701412;
        Sun, 28 Aug 2022 06:51:41 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090a4b4900b001fbb0f0b00fsm4795754pjl.35.2022.08.28.06.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 06:51:41 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v5 0/4] erofs-utils: compressed fragments feature
Date: Sun, 28 Aug 2022 21:51:05 +0800
Message-Id: <cover.1661687617.git.huyue2@coolpad.com>
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
  erofs-utils: fuse: support interlaced uncompressed data for compressed
    files
  erofs-utils: lib: support fragments data decompression
  erofs-utils: lib: support interlaced uncompressed data layout when
    compressing
  erofs-utils: mkfs: introduce compressed fragments support

 include/erofs/compress.h   |  2 +-
 include/erofs/config.h     |  3 +-
 include/erofs/decompress.h |  3 ++
 include/erofs/fragments.h  | 25 +++++++++++
 include/erofs/inode.h      |  1 +
 include/erofs/internal.h   |  8 ++++
 include/erofs_fs.h         | 28 +++++++++---
 lib/Makefile.am            |  4 +-
 lib/compress.c             | 92 ++++++++++++++++++++++++++++----------
 lib/data.c                 | 28 +++++++++++-
 lib/decompress.c           | 16 ++++++-
 lib/fragments.c            | 58 ++++++++++++++++++++++++
 lib/inode.c                | 47 ++++++++++++++++---
 lib/super.c                | 24 +++++++++-
 lib/zmap.c                 | 26 +++++++++++
 mkfs/main.c                | 61 ++++++++++++++++++++++---
 16 files changed, 379 insertions(+), 47 deletions(-)
 create mode 100644 include/erofs/fragments.h
 create mode 100644 lib/fragments.c

-- 
2.17.1

