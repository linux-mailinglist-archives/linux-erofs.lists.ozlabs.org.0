Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2266A4B0DB2
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Feb 2022 13:43:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jvbyq3KnGz3bWj
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Feb 2022 23:43:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jvbyd5sTpz2yQ8
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Feb 2022 23:43:32 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V44OMp2_1644497000; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V44OMp2_1644497000) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Feb 2022 20:43:23 +0800
Date: Thu, 10 Feb 2022 20:43:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 0/5] fs/erofs: new filesystem
Message-ID: <YgUIaIWOpfOJfukN@B-P7TQMD6M-0146.local>
References: <20210823123646.9765-1-jnhuang95@gmail.com>
 <20220208140513.30570-1-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220208140513.30570-1-jnhuang95@gmail.com>
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Tom,

Would you mind taking some time having a look at this version
if it meets what's needed, so we could have a chance to be
merged in the next u-boot version?

It's almost in sync with the latest erofs-utils soruce code,
so it can be upgraded easily in the future together with the
later erofs-utils versions.

Thanks,
Gao Xiang

On Tue, Feb 08, 2022 at 10:05:08PM +0800, Huang Jianan wrote:
> Changes since v2:
>  - sync up with erofs-utils 1.4;
>  - update lib/lz4 to v1.8.3;
>  - add test for filesystem functions;
> 
> Changes since v1:
>  - fix the inconsistency between From and SoB;
>  - add missing license header;
> 
> Huang Jianan (5):
>   fs/erofs: add erofs filesystem support
>   lib/lz4: update LZ4 decompressor module
>   fs/erofs: add lz4 decompression support
>   fs/erofs: add filesystem commands
>   test/py: Add tests for the erofs
> 
>  MAINTAINERS                         |   9 +
>  cmd/Kconfig                         |   6 +
>  cmd/Makefile                        |   1 +
>  cmd/erofs.c                         |  42 ++
>  configs/sandbox_defconfig           |   1 +
>  fs/Kconfig                          |   2 +
>  fs/Makefile                         |   1 +
>  fs/erofs/Kconfig                    |  21 +
>  fs/erofs/Makefile                   |   9 +
>  fs/erofs/data.c                     | 311 +++++++++++++
>  fs/erofs/decompress.c               |  78 ++++
>  fs/erofs/decompress.h               |  24 +
>  fs/erofs/erofs_fs.h                 | 436 ++++++++++++++++++
>  fs/erofs/fs.c                       | 267 +++++++++++
>  fs/erofs/internal.h                 | 313 +++++++++++++
>  fs/erofs/namei.c                    | 252 +++++++++++
>  fs/erofs/super.c                    | 105 +++++
>  fs/erofs/zmap.c                     | 601 ++++++++++++++++++++++++
>  fs/fs.c                             |  22 +
>  include/erofs.h                     |  19 +
>  include/fs.h                        |   1 +
>  include/u-boot/lz4.h                |  49 ++
>  lib/lz4.c                           | 679 ++++++++++++++++++++--------
>  lib/lz4_wrapper.c                   |  23 +-
>  test/py/tests/test_fs/test_erofs.py | 211 +++++++++
>  25 files changed, 3268 insertions(+), 215 deletions(-)
>  create mode 100644 cmd/erofs.c
>  create mode 100644 fs/erofs/Kconfig
>  create mode 100644 fs/erofs/Makefile
>  create mode 100644 fs/erofs/data.c
>  create mode 100644 fs/erofs/decompress.c
>  create mode 100644 fs/erofs/decompress.h
>  create mode 100644 fs/erofs/erofs_fs.h
>  create mode 100644 fs/erofs/fs.c
>  create mode 100644 fs/erofs/internal.h
>  create mode 100644 fs/erofs/namei.c
>  create mode 100644 fs/erofs/super.c
>  create mode 100644 fs/erofs/zmap.c
>  create mode 100644 include/erofs.h
>  create mode 100644 test/py/tests/test_fs/test_erofs.py
> 
> -- 
> 2.25.1
