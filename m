Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662E4458208
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Nov 2021 06:39:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HxfNl1l4hz301g
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Nov 2021 16:39:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1637473175;
	bh=IzKy1EgVqcK68qoK3CFiI2ab3tK4HB23D1BzUif1jSc=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=eNoCPUsQonyGP11krRzLkMRqzmfZWy9vZcoIQ148+grUqPeFrIleSQ9mSaLutZoaV
	 yt8F8ikhbuvxTSxtXVrfJZAMewvwKP8IRLmbfGDvBEBP+Xs7e/IgDYCChm6mB7mBSK
	 gQvl3BYto32t6chR12IR3YLk/rgT22n9r2IsAEn+mclGqhU6QVFHi4uDcd90rY1ovm
	 wmqETg4y27gVrgpZcnJGsaVKWgmU+9d2nnByH5a6bbBXLLfY9K9hVcy1X/9xbTqWTp
	 zMlkOu63z95J0VTEFS+8dCb5ap0xCJBeN6PLzEr47sIwOHr6L2ps9/TbVafzgev2aN
	 8tSgUyBNZ/n+w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::f49; helo=mail-qv1-xf49.google.com;
 envelope-from=3i9uzyqskc7w1jcpimgnxkpiqqing.eqonkpwz-gtqhunkuvu.q1ncdu.qti@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=S9V4GQaV; dkim-atps=neutral
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com
 [IPv6:2607:f8b0:4864:20::f49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HxfNg4MD0z2xv8
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Nov 2021 16:39:29 +1100 (AEDT)
Received: by mail-qv1-xf49.google.com with SMTP id
 fw10-20020a056214238a00b003c05d328ad2so13300528qvb.2
 for <linux-erofs@lists.ozlabs.org>; Sat, 20 Nov 2021 21:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=IzKy1EgVqcK68qoK3CFiI2ab3tK4HB23D1BzUif1jSc=;
 b=utqWmw8zMlh6fgIKmnf9HF6Ww5xw49mS8NlUF1azYSRve/KUmcq9JaCsKYc5snNune
 QLi8boq8X3nxw5tL+bUYaZYfyXF6xwCJvhQ+st0Y0DVuCzKZqKdr7g5TRcAeliAxDY77
 xOk2+6hTbXXBbYWoRf9d7ce8Iuc79IaK7yKTMG0ZmhnZ8T2zXfhd9G3q6CMSILZUff0b
 L88qAuJzulJs6SOIYVoexSC0OYvXljjA7Gf0iXemFhFfQw70Q1vDCkaRiTca6+0A+rqO
 29tyYrYh195ilJ3DgSDNkRUEhqjPwZciId+DChPSPJmBgNOcTKDal3PyX0U+lFys4yvC
 EMWA==
X-Gm-Message-State: AOAM531aSaDa9qeRsnYHs1mW349KJOm58jCoL8BLB4CQdA83o/ALmdQz
 Eu4Ajt974BPDeoSrDhDT/XckW683imemFcO7h1JN6OGoyBx+VZTDGE33d7aujA5IzifsxzQn1ZG
 RlRZm3pYUr/Gl+Z1bMS7IMobB0SHZvqZQrnwf0bj4DYf4bEGhcWA3HyOobsU/pvNQ24JlDlYm00
 fGeLukIQ4=
X-Google-Smtp-Source: ABdhPJz1OlRHe1TIlr7lAS9I6VxMVkVfbbcD60yNTLZUroMrIGQ2DpMl0NQA+okMhnZ9W32HaG6XNIuVtII+LXsfkQ==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:ac8:7f89:: with SMTP id
 z9mr20425429qtj.15.1637473163769; Sat, 20 Nov 2021 21:39:23 -0800 (PST)
Date: Sat, 20 Nov 2021 21:39:17 -0800
Message-Id: <20211121053920.2580751-1-zhangkelvin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v1 0/3] Make erofs-utils more library friendly
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Li Guifu <bluce.liguifu@huawei.com>, 
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>, Chao Yu <yuchao0@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

EROFS-utils contains several usage of global variables, namely

1. int erofs_devfd, stores the file descriptor to open'ed block devices.
This is referened in many places.
2. struct erofs_sb_info sbi; Stores parsed super block.

These global variables make embedding erofs library diffcult. To make
library usage easier, a series of 3 patches are drafted to refactor away
the global variables. Each patch has been built and tested by calling
mkfs.erofs and ensure the same output is generated.

Kelvin Zhang (3):
  Make erofs_devfd a parameter for most functions
  Mark certain callback function pointers as const
  Make super block info struct a paramater instead of globals

 Android.bp                 |  44 +++++++-
 dump/main.c                |  84 ++++++++------
 fsck/main.c                |  90 +++++++++------
 fuse/dir.c                 |   8 +-
 fuse/main.c                |  19 ++--
 include/erofs/blobchunk.h  |   7 +-
 include/erofs/cache.h      |  15 +--
 include/erofs/compress.h   |  10 +-
 include/erofs/config.h     |  15 +--
 include/erofs/decompress.h |   5 +-
 include/erofs/defs.h       |  21 ++++
 include/erofs/inode.h      |   9 +-
 include/erofs/internal.h   |  72 ++++++------
 include/erofs/io.h         |  48 +++++---
 include/erofs/iterate.h    |  35 ++++++
 include/erofs/xattr.h      |   2 +-
 iterate/main.c             |  51 +++++++++
 lib/blobchunk.c            |  11 +-
 lib/cache.c                |  33 +++---
 lib/compress.c             | 104 ++++++++++-------
 lib/compressor.c           |   9 +-
 lib/compressor.h           |  13 ++-
 lib/compressor_liblzma.c   |   4 +-
 lib/compressor_lz4.c       |   8 +-
 lib/compressor_lz4hc.c     |   6 +-
 lib/config.c               |  64 ++++++-----
 lib/data.c                 |  54 +++++----
 lib/decompress.c           |  12 +-
 lib/inode.c                | 129 ++++++++++++---------
 lib/io.c                   |  74 ++++++------
 lib/iterate.c              | 223 +++++++++++++++++++++++++++++++++++++
 lib/namei.c                |  44 +++++---
 lib/super.c                |  28 ++---
 lib/xattr.c                |  10 +-
 lib/zmap.c                 |  92 +++++++++------
 mkfs/main.c                |  92 +++++++--------
 36 files changed, 1069 insertions(+), 476 deletions(-)
 create mode 100644 include/erofs/iterate.h
 create mode 100644 iterate/main.c
 create mode 100644 lib/iterate.c

-- 
2.34.0.rc2.393.gf8c9666880-goog

