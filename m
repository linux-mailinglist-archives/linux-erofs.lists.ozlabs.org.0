Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF64582EE
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Nov 2021 11:31:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hxmt34cs1z301k
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Nov 2021 21:31:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=hsiangkao@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hxmsw4Z5gz2xF8
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Nov 2021 21:31:44 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UxVc9t9_1637490675; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UxVc9t9_1637490675) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 21 Nov 2021 18:31:17 +0800
Date: Sun, 21 Nov 2021 18:31:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v1 0/3] Make erofs-utils more library friendly
Message-ID: <YZof8UmtEdO+azTa@B-P7TQMD6M-0146.local>
References: <20211121053920.2580751-1-zhangkelvin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211121053920.2580751-1-zhangkelvin@google.com>
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Chao Yu <yuchao0@huawei.com>, Li Guifu <bluce.liguifu@huawei.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Kelvin,

On Sat, Nov 20, 2021 at 09:39:17PM -0800, Kelvin Zhang wrote:
> EROFS-utils contains several usage of global variables, namely
> 
> 1. int erofs_devfd, stores the file descriptor to open'ed block devices.
> This is referened in many places.
> 2. struct erofs_sb_info sbi; Stores parsed super block.
> 
> These global variables make embedding erofs library diffcult. To make
> library usage easier, a series of 3 patches are drafted to refactor away
> the global variables. Each patch has been built and tested by calling
> mkfs.erofs and ensure the same output is generated.

Agreed, that is mainly due to fast iterative development. If we consider
to export liberofs as a real library, these all needs to be resolved in
advance, and it'd be better to stablize all liberofs APIs as well.

However, let's postpone this work until 1.4 is out, I have to admit I'm
a bit delay of releasing v1.4 due to my busy work.
Now I'm working on pre-releasing..

Thanks,
Gao Xiang

> 
> Kelvin Zhang (3):
>   Make erofs_devfd a parameter for most functions
>   Mark certain callback function pointers as const
>   Make super block info struct a paramater instead of globals
> 
>  Android.bp                 |  44 +++++++-
>  dump/main.c                |  84 ++++++++------
>  fsck/main.c                |  90 +++++++++------
>  fuse/dir.c                 |   8 +-
>  fuse/main.c                |  19 ++--
>  include/erofs/blobchunk.h  |   7 +-
>  include/erofs/cache.h      |  15 +--
>  include/erofs/compress.h   |  10 +-
>  include/erofs/config.h     |  15 +--
>  include/erofs/decompress.h |   5 +-
>  include/erofs/defs.h       |  21 ++++
>  include/erofs/inode.h      |   9 +-
>  include/erofs/internal.h   |  72 ++++++------
>  include/erofs/io.h         |  48 +++++---
>  include/erofs/iterate.h    |  35 ++++++
>  include/erofs/xattr.h      |   2 +-
>  iterate/main.c             |  51 +++++++++
>  lib/blobchunk.c            |  11 +-
>  lib/cache.c                |  33 +++---
>  lib/compress.c             | 104 ++++++++++-------
>  lib/compressor.c           |   9 +-
>  lib/compressor.h           |  13 ++-
>  lib/compressor_liblzma.c   |   4 +-
>  lib/compressor_lz4.c       |   8 +-
>  lib/compressor_lz4hc.c     |   6 +-
>  lib/config.c               |  64 ++++++-----
>  lib/data.c                 |  54 +++++----
>  lib/decompress.c           |  12 +-
>  lib/inode.c                | 129 ++++++++++++---------
>  lib/io.c                   |  74 ++++++------
>  lib/iterate.c              | 223 +++++++++++++++++++++++++++++++++++++
>  lib/namei.c                |  44 +++++---
>  lib/super.c                |  28 ++---
>  lib/xattr.c                |  10 +-
>  lib/zmap.c                 |  92 +++++++++------
>  mkfs/main.c                |  92 +++++++--------
>  36 files changed, 1069 insertions(+), 476 deletions(-)
>  create mode 100644 include/erofs/iterate.h
>  create mode 100644 iterate/main.c
>  create mode 100644 lib/iterate.c
> 
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
