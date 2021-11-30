Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C90CD462AFC
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 04:19:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J36rf5XWrz3bWX
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 14:19:14 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J36rW3xj0z2ywH
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Nov 2021 14:19:03 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UypqxAw_1638242322; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UypqxAw_1638242322) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 30 Nov 2021 11:18:44 +0800
Date: Tue, 30 Nov 2021 11:18:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v1 0/2] Cosmetic changes to erofs-utils
Message-ID: <YaWYErBYsG4Yjboh@B-P7TQMD6M-0146.local>
References: <20211130030155.2804358-1-zhangkelvin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211130030155.2804358-1-zhangkelvin@google.com>
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
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Kelvin,

On Mon, Nov 29, 2021 at 07:01:53PM -0800, Kelvin Zhang wrote:
> The following patches make erofs-utils more C++ friendly. It does not
> perform any refactoring, instead it simply added extern "C" keywords so
> that C++ code can call into EROFS.
> 
> Kelvin Zhang (2):
>   Add android build target to build erofs as library

Thanks for your patches.

Once we discussed earlier, Android.bp is not a part of erofs-utils
since I couldn't maintain it without Android build environment.
Android build environment is somewhat hard for me to keep up
with....

I think Android.bp can be resolved when upgrading AOSP erofs-utils
code base.

>   Make erofs-utils more C++ friendly

At glance, it looks good to me, I will test later in the evening.

Btw, how about adding "erofs-utils:" prefix to each patch. It will be
easier for me to apply these...

Thanks,
Gao Xiang

> 
>  Android.bp                     | 38 +++++++++++++++++++++++++++++++---
>  include/erofs/blobchunk.h      | 10 +++++++++
>  include/erofs/block_list.h     | 10 +++++++++
>  include/erofs/cache.h          |  9 ++++++++
>  include/erofs/compress.h       |  9 ++++++++
>  include/erofs/compress_hints.h | 10 +++++++++
>  include/erofs/config.h         | 20 ++++++++----------
>  include/erofs/decompress.h     |  9 ++++++++
>  include/erofs/defs.h           | 20 ++++++++++++++++++
>  include/erofs/err.h            |  9 ++++++++
>  include/erofs/exclude.h        | 10 +++++++++
>  include/erofs/flex-array.h     |  9 ++++++++
>  include/erofs/hashmap.h        |  9 ++++++++
>  include/erofs/hashtable.h      |  9 ++++++++
>  include/erofs/inode.h          |  9 ++++++++
>  include/erofs/internal.h       |  9 ++++++++
>  include/erofs/io.h             | 11 ++++++++++
>  include/erofs/list.h           | 10 +++++++++
>  include/erofs/print.h          |  9 ++++++++
>  include/erofs/trace.h          |  9 ++++++++
>  include/erofs/xattr.h          |  9 ++++++++
>  include/erofs_fs.h             |  9 ++++++++
>  lib/config.c                   | 12 +++++++++++
>  lib/inode.c                    |  7 +++++++
>  lib/xattr.c                    | 12 +++++++++++
>  mkfs/main.c                    |  7 +++++++
>  26 files changed, 280 insertions(+), 14 deletions(-)
> 
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
