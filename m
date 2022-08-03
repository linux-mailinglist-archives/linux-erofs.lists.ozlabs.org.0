Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E081358871B
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 08:07:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LyLxV2bx7z305p
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 16:07:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LyLxM1gNdz2xkc
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Aug 2022 16:07:33 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VLFZLtA_1659506845;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VLFZLtA_1659506845)
          by smtp.aliyun-inc.com;
          Wed, 03 Aug 2022 14:07:26 +0800
Date: Wed, 3 Aug 2022 14:07:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [RFC PATCH v3 0/3] erofs-utils: compressed fragments feature
Message-ID: <YuoQnLQTcp/bTere@B-P7TQMD6M-0146.local>
References: <cover.1659496805.git.huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1659496805.git.huyue2@coolpad.com>
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

Hi Yue,

On Wed, Aug 03, 2022 at 11:51:27AM +0800, Yue Hu wrote:
> In order to achieve greater compression ratio, let's introduce
> compressed fragments feature which can merge tail of per-file or the
> whole files into one special inode to reach the target.
> 
> And we can also set pcluster size to fragments inode for different
> compression requirments.
> 
> In this patchset, we also improve the uncompressed data layout of
> compressed files. Just write it from 'clusterofs' instead of 0 since it
> can benefit from in-place I/O. For now, it only goes with fragments.
> 
> The main idea above is from Xiang.

Thanks for your hard work! I will take a deep try this weekend,

Also I'd like to enable logical cluster size != 4k for big pcluster with
large pclustersize in order to reduce the size of compression indexes.

In such cases, I think compact indexes are unnecessary.  I think it's
already supported on the kernel side, so we just need to implement the
userspace side.

Thanks,
Gao Xiang

> 
> Here is some test data of Linux 5.10.87 source code under Ubuntu 18.04:
> 
> linux-5.10.87 (erofs, uncompressed)                1.1G
> 
> linux-5.10.87 (erofs, lz4hc,12 4k fragments,4k)    301M
> linux-5.10.87 (erofs, lz4hc,12 8k fragments,8k)    268M
> linux-5.10.87 (erofs, lz4hc,12 16k fragments,16k)  242M
> linux-5.10.87 (erofs, lz4hc,12 32k fragments,32k)  225M
> linux-5.10.87 (erofs, lz4hc,12 64k fragments,64k)  217M
> 
> linux-5.10.87 (erofs, lz4hc,12 4k vanilla)         396M
> linux-5.10.87 (erofs, lz4hc,12 8k vanilla)         376M
> linux-5.10.87 (erofs, lz4hc,12 16k vanilla)        364M
> linux-5.10.87 (erofs, lz4hc,12 32k vanilla)        359M
> linux-5.10.87 (erofs, lz4hc,12 64k vanilla)        358M
> 
> Usage:
> mkfs.erofs -zlz4hc,12 -C65536 -Efragments,65536 foo.erofs.img foo/
> 
> Changes since v2:
>  - mainly reimplment the decompression logic for fragment inode due to
>    kernel side;
>  - fix compatibility issue to old image with ztailpacking feature;
>  - move code of super.c in patch 3/3 to patch 1/3;
>  - minor naming change.
> 
> Changes since v1:
>  - mainly optimize index space for fragment inode;
>  - add merging tail with len <= pclustersize into fragments directly;
>  - use a inode instead of nid to avoid multiple load fragments;
>  - fix memory leak of building fragments;
>  - minor change to diff special fragments with normal inode.
>  - rebase to commit cb058526 with patch [1];
>  - code cleanup.
> 
> Note that inode will be extended version (64 bytes) due to mtime, may
> use 'force-inode-compact' option to reduce the size if mtime careless.
> 
> [1] https://lore.kernel.org/linux-erofs/20220722053610.23912-1-huyue2@coolpad.com/
> 
> Yue Hu (3):
>   erofs-utils: lib: add support for fragments data decompression
>   erofs-utils: lib: support on-disk offset for shifted decompression
>   erofs-utils: introduce compressed fragments support
> 
>  include/erofs/compress.h   |   3 +-
>  include/erofs/config.h     |   3 +-
>  include/erofs/decompress.h |   3 ++
>  include/erofs/fragments.h  |  25 +++++++++
>  include/erofs/inode.h      |   2 +
>  include/erofs/internal.h   |   9 ++++
>  include/erofs_fs.h         |  27 +++++++---
>  lib/Makefile.am            |   4 +-
>  lib/compress.c             | 108 +++++++++++++++++++++++++++----------
>  lib/data.c                 |  28 +++++++++-
>  lib/decompress.c           |  10 +++-
>  lib/fragments.c            |  76 ++++++++++++++++++++++++++
>  lib/inode.c                |  43 ++++++++++-----
>  lib/super.c                |  24 ++++++++-
>  lib/zmap.c                 |  26 +++++++++
>  mkfs/main.c                |  64 +++++++++++++++++++---
>  16 files changed, 393 insertions(+), 62 deletions(-)
>  create mode 100644 include/erofs/fragments.h
>  create mode 100644 lib/fragments.c
> 
> -- 
> 2.17.1
