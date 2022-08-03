Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 429C65887F5
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 09:31:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LyNpC0kj7z306l
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 17:31:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=SjWQopna;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=SjWQopna;
	dkim-atps=neutral
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LyNp35L7Vz2xHs
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Aug 2022 17:31:22 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id q19so6369563pfg.8
        for <linux-erofs@lists.ozlabs.org>; Wed, 03 Aug 2022 00:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=9+LOOUFrapUmjaCqByrGopNKKcCHygRb1AODLxjfimY=;
        b=SjWQopnaxIgGDUL7bOP6VLrXoo2EYnsXVPFwTEyc3tvAQS9FG6TK9yGznnLi95iDKf
         rw3Gm+NqHAARZCRR04cQ/MO2EpfjI7onjveXRwNtTN4PTpbD6devQEOPBPMUeP9HbUm+
         3ABeggj5M5FPBYrSsmT9yhEpA2PHY2/m4SpG0tzYlzCWrDY+s66Kfsp17b16LHVTX5O1
         Ik/oEcCM8dFRQYhw4IYfwreBzFtP7Zr+dBMvxb9BMb17tDBvYs/I2k95H3W1sBn+znFB
         gk0cQxeYLrx6UcW1oJhQ/0MiPwq9bZNvU19qmjgzuzCz4ci5ALD7tt13yi2LKBl1iug5
         S/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9+LOOUFrapUmjaCqByrGopNKKcCHygRb1AODLxjfimY=;
        b=sVsMWl4Zxo0iTGgwI01OsXMGAXw427hvbKHT2h/VaA2jlMhJazqF6nMx/59lAWj/Cj
         tKoNW4XyVbTHb9wSUXYv8/8GXMQ8j7o1GybWk2DX3lXUi23Wh8ow/mkbYAqA/ByExM2H
         1q3AH07I6L6JS/NN4Qpj3511VBleiUGQke08W1Uq8WiQQA+hZkBhiGm1SmDiw4jyS0UG
         OGkpw//JTxbSlBhgnAwom/sGxydypdWRw3+RrkCy5RubcBmNuHhZA37LeI/fAV0oAKoz
         VUONOv4Hvq0qS6M0kxynXf/y+goNA8NckcZ48DPzRcDtu5EHKcYdXz3CJQAaIK1Mm4qd
         Ixug==
X-Gm-Message-State: AJIora9JsDaVwEudx4pwECRxSjJjcdMe3oR+46jopkfsRNAXdLL6ZmM7
	MW1bSpvmf3b5D25WK0PJTtM=
X-Google-Smtp-Source: AGRyM1v7f0vf3EkemGPyIiG8je5JyZYnAGV8s2rJRQjlbiYzM48EwwOWczdm2vykzHxovVtV96OENg==
X-Received: by 2002:aa7:88d5:0:b0:52a:ea1f:50c6 with SMTP id k21-20020aa788d5000000b0052aea1f50c6mr24316393pff.81.1659511878317;
        Wed, 03 Aug 2022 00:31:18 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w13-20020a17090a4f4d00b001ef8ab65052sm827075pjl.11.2022.08.03.00.31.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Aug 2022 00:31:18 -0700 (PDT)
Date: Wed, 3 Aug 2022 15:33:05 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH v3 0/3] erofs-utils: compressed fragments feature
Message-ID: <20220803153305.00000ec4.zbestahu@gmail.com>
In-Reply-To: <YuoQnLQTcp/bTere@B-P7TQMD6M-0146.local>
References: <cover.1659496805.git.huyue2@coolpad.com>
	<YuoQnLQTcp/bTere@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, zbestahu@163.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Wed, 3 Aug 2022 14:07:24 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Wed, Aug 03, 2022 at 11:51:27AM +0800, Yue Hu wrote:
> > In order to achieve greater compression ratio, let's introduce
> > compressed fragments feature which can merge tail of per-file or the
> > whole files into one special inode to reach the target.
> > 
> > And we can also set pcluster size to fragments inode for different
> > compression requirments.
> > 
> > In this patchset, we also improve the uncompressed data layout of
> > compressed files. Just write it from 'clusterofs' instead of 0 since it
> > can benefit from in-place I/O. For now, it only goes with fragments.
> > 
> > The main idea above is from Xiang.  
> 
> Thanks for your hard work! I will take a deep try this weekend,

Got it.

> 
> Also I'd like to enable logical cluster size != 4k for big pcluster with
> large pclustersize in order to reduce the size of compression indexes.

Let me think about this first.

Thanks.

> 
> In such cases, I think compact indexes are unnecessary.  I think it's
> already supported on the kernel side, so we just need to implement the
> userspace side.
> 
> Thanks,
> Gao Xiang
> 
> > 
> > Here is some test data of Linux 5.10.87 source code under Ubuntu 18.04:
> > 
> > linux-5.10.87 (erofs, uncompressed)                1.1G
> > 
> > linux-5.10.87 (erofs, lz4hc,12 4k fragments,4k)    301M
> > linux-5.10.87 (erofs, lz4hc,12 8k fragments,8k)    268M
> > linux-5.10.87 (erofs, lz4hc,12 16k fragments,16k)  242M
> > linux-5.10.87 (erofs, lz4hc,12 32k fragments,32k)  225M
> > linux-5.10.87 (erofs, lz4hc,12 64k fragments,64k)  217M
> > 
> > linux-5.10.87 (erofs, lz4hc,12 4k vanilla)         396M
> > linux-5.10.87 (erofs, lz4hc,12 8k vanilla)         376M
> > linux-5.10.87 (erofs, lz4hc,12 16k vanilla)        364M
> > linux-5.10.87 (erofs, lz4hc,12 32k vanilla)        359M
> > linux-5.10.87 (erofs, lz4hc,12 64k vanilla)        358M
> > 
> > Usage:
> > mkfs.erofs -zlz4hc,12 -C65536 -Efragments,65536 foo.erofs.img foo/
> > 
> > Changes since v2:
> >  - mainly reimplment the decompression logic for fragment inode due to
> >    kernel side;
> >  - fix compatibility issue to old image with ztailpacking feature;
> >  - move code of super.c in patch 3/3 to patch 1/3;
> >  - minor naming change.
> > 
> > Changes since v1:
> >  - mainly optimize index space for fragment inode;
> >  - add merging tail with len <= pclustersize into fragments directly;
> >  - use a inode instead of nid to avoid multiple load fragments;
> >  - fix memory leak of building fragments;
> >  - minor change to diff special fragments with normal inode.
> >  - rebase to commit cb058526 with patch [1];
> >  - code cleanup.
> > 
> > Note that inode will be extended version (64 bytes) due to mtime, may
> > use 'force-inode-compact' option to reduce the size if mtime careless.
> > 
> > [1] https://lore.kernel.org/linux-erofs/20220722053610.23912-1-huyue2@coolpad.com/
> > 
> > Yue Hu (3):
> >   erofs-utils: lib: add support for fragments data decompression
> >   erofs-utils: lib: support on-disk offset for shifted decompression
> >   erofs-utils: introduce compressed fragments support
> > 
> >  include/erofs/compress.h   |   3 +-
> >  include/erofs/config.h     |   3 +-
> >  include/erofs/decompress.h |   3 ++
> >  include/erofs/fragments.h  |  25 +++++++++
> >  include/erofs/inode.h      |   2 +
> >  include/erofs/internal.h   |   9 ++++
> >  include/erofs_fs.h         |  27 +++++++---
> >  lib/Makefile.am            |   4 +-
> >  lib/compress.c             | 108 +++++++++++++++++++++++++++----------
> >  lib/data.c                 |  28 +++++++++-
> >  lib/decompress.c           |  10 +++-
> >  lib/fragments.c            |  76 ++++++++++++++++++++++++++
> >  lib/inode.c                |  43 ++++++++++-----
> >  lib/super.c                |  24 ++++++++-
> >  lib/zmap.c                 |  26 +++++++++
> >  mkfs/main.c                |  64 +++++++++++++++++++---
> >  16 files changed, 393 insertions(+), 62 deletions(-)
> >  create mode 100644 include/erofs/fragments.h
> >  create mode 100644 lib/fragments.c
> > 
> > -- 
> > 2.17.1  

