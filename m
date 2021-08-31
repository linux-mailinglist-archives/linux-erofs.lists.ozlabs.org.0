Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7947F3FCBD2
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 18:51:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzY9y5bzBz2yLg
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Sep 2021 02:51:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=nW+aImNK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b;
 helo=mail-pj1-x102b.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=nW+aImNK; dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GzY9p6vBRz2yHC
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Sep 2021 02:51:25 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id
 j4-20020a17090a734400b0018f6dd1ec97so2912447pjs.3
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Aug 2021 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y0s0MrYOmUNHe3h1PUAl9OSTO/q9GLMug83JTJSA3Lw=;
 b=nW+aImNKWT6nPWzwnVz61Z5sRQcKlUKXHYZZ5qlb/4m0PytW1gTPxUPqFEH98wCJ5O
 FBjVfNdKrwhI8I+/0Ya2WqZlCxIQPPdNinoJKoR84pzQQutfhNBf/cQUbAkZtGTPRk+l
 SzCjkndmQf3EeIQ0zp/NZ+GSJY5fh86qscRhdEP/GtviLrHtKfGRFPPpRPcVl67WYfr3
 zSEwWrzQ8hxgf7mKl3hZP1F4Km2YkJXeLu68LusXNQZrlbQInrTxnwEN1c9A0lsCkwoN
 az5d0tR6/gujptDcW7trXoWeGTyNOla7EZDbtaUgZMSXfsiC2ACjej1ufUEL+b7yNjiB
 cxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y0s0MrYOmUNHe3h1PUAl9OSTO/q9GLMug83JTJSA3Lw=;
 b=l26pHwt11FK+Utq0n+b4sE+5R4h7YXEbtqXcWK145Os4wMGpuOcV+R5onsHxKkFva0
 UUTrAT/UEhmWwvNR/cRWig/fLb+wdpY5laWc3Qc6do2OYBR2UIndHJlTOc9UYYxGMhjt
 EsxMv/IJeqJmurKawoQyTzDAxJqDSFxOXHIDRYzOaYsUc/5ZKUEoSOtK6QBDYDa19Hbc
 bpXMW/s1F/6TrqN484xeoeKxu9ym0QqBDE/oaM4YF/txNDPcQ1fZCdLKp1GJC6o9+Tj0
 /nlwbyn5ox0AmBau74qo67qT7xwt9lNKffhSH6cqV6mD+HvCBhdkTRDjuJIzw/ln7rry
 108A==
X-Gm-Message-State: AOAM533D4tsBzdkg4otbIE37TImlud+eYopd24KBEkR6Y3qEowq46mU9
 7tiAwg+c6W7jCSR857vE3dccYUmlS13wow==
X-Google-Smtp-Source: ABdhPJzK86zdBqv3mVR4Df01btu8f51UfkfK1uEuDLkv7GEgl77rUAUZ/3xw3oe5NIlEIogc6sQqEw==
X-Received: by 2002:a17:90a:2dc7:: with SMTP id
 q7mr6557053pjm.231.1630428683294; 
 Tue, 31 Aug 2021 09:51:23 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id u6sm20697487pgr.3.2021.08.31.09.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 09:51:22 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/5] erofs-utils: fix checkpatch.pl complains
Date: Wed,  1 Sep 2021 00:51:11 +0800
Message-Id: <20210831165116.16575-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Huang Jianan <huangjianan@oppo.com>

This patchset fix most of checkpatch.pl complains in erofs-utils, some
problems that also exist in the kernel haven't been fixed.

Huang Jianan (5):
  erofs-utils: remove filename in the file
  erofs-utils: fix SPDX comment style
  erofs-utils: fix general style problem
  erofs-utils: remove unnecessary codes and comments
  erofs-utils: fix print style

 Makefile.am                |  1 -
 fuse/Makefile.am           |  1 -
 fuse/dir.c                 |  2 --
 fuse/macosx.h              |  1 +
 fuse/main.c                |  7 +------
 include/erofs/block_list.h |  8 +++-----
 include/erofs/cache.h      |  2 --
 include/erofs/compress.h   |  2 --
 include/erofs/config.h     |  2 --
 include/erofs/decompress.h |  2 --
 include/erofs/defs.h       |  2 --
 include/erofs/err.h        |  2 --
 include/erofs/exclude.h    |  2 --
 include/erofs/hashtable.h  |  2 --
 include/erofs/inode.h      |  2 --
 include/erofs/internal.h   |  2 --
 include/erofs/io.h         |  2 --
 include/erofs/list.h       |  2 --
 include/erofs/print.h      |  2 --
 include/erofs/trace.h      |  2 --
 include/erofs/xattr.h      |  4 +---
 include/erofs_fs.h         |  1 -
 lib/Makefile.am            |  1 -
 lib/block_list.c           |  7 +------
 lib/cache.c                |  2 --
 lib/compress.c             | 11 ++++-------
 lib/compressor.c           |  4 +---
 lib/compressor.h           |  2 --
 lib/compressor_lz4.c       |  2 --
 lib/compressor_lz4hc.c     |  2 --
 lib/config.c               |  2 --
 lib/data.c                 |  2 --
 lib/decompress.c           |  2 --
 lib/exclude.c              |  2 --
 lib/inode.c                |  9 +--------
 lib/io.c                   |  5 +----
 lib/namei.c                |  5 ++---
 lib/super.c                |  2 --
 lib/xattr.c                |  4 +---
 lib/zmap.c                 |  6 +-----
 man/Makefile.am            |  1 -
 mkfs/Makefile.am           |  1 -
 mkfs/main.c                |  4 +---
 43 files changed, 19 insertions(+), 110 deletions(-)

-- 
2.25.1

