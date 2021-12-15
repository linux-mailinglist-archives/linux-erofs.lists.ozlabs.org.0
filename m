Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3F847538C
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 08:14:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JDRMB2c9jz305p
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 18:14:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JDRM42Hr7z2ymt
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Dec 2021 18:14:23 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R381e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V-hGKoB_1639552453; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-hGKoB_1639552453) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 15 Dec 2021 15:14:15 +0800
Date: Wed, 15 Dec 2021 15:14:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v5 2/2] Add API to iterate over inodes in EROFS
Message-ID: <YbmVxZMWuaaBDfSa@B-P7TQMD6M-0146.local>
References: <YbhTuJV55KqqNQzG@B-P7TQMD6M-0146.local>
 <20211214173520.1944792-1-zhangkelvin@google.com>
 <20211214173520.1944792-2-zhangkelvin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214173520.1944792-2-zhangkelvin@google.com>
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

On Tue, Dec 14, 2021 at 09:35:20AM -0800, Kelvin Zhang wrote:
> Change-Id: Ia35708080a72ee204eaaddfc670d3cb8023a078c
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> ---

In brief, I've taken some time to clean up / polish / enhance such
logic and convert erofsfuse to use it:
https://lore.kernel.org/linux-erofs/20211215070017.83846-1-hsiangkao@linux.alibaba.com

PTAL and check if it helps your own scenario. I didn't update
the original author name, also I updated the license into
GPL-2.0+ OR Apache-2.0 dual license

since Apache-2.0 is incompatible with GPL.

If you have some other concerns, please drop me a word, thanks.

Some minor comments below.

>  include/erofs/iterate.h |  46 ++++++++++++
>  include/erofs_fs.h      |   4 +-
>  lib/Makefile.am         |   2 +-
>  lib/iterate.c           | 154 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 203 insertions(+), 3 deletions(-)
>  create mode 100644 include/erofs/iterate.h
>  create mode 100644 lib/iterate.c
> 
> diff --git a/include/erofs/iterate.h b/include/erofs/iterate.h
> new file mode 100644
> index 0000000..4e2c783
> --- /dev/null
> +++ b/include/erofs/iterate.h
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: Apache-2.0
> +
> +#ifndef ITERATE_ITERATE
> +#define ITERATE_ITERATE
> +
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
> +
> +#include "erofs/io.h"
> +#include "erofs/print.h"
> +
> +
> +struct erofs_inode_info {
> +	const char* name;

	const char *name;

> +	enum erofs_ftype ftype;
> +	struct erofs_inode* inode;

	struct erofs_inode *inode;

> +	void* arg;
> +};
> +// Callback function for iterating over inodes of EROFS
> +
> +typedef bool (*erofs_readdir_cb)(struct erofs_inode_info*);
> +
> +// Iterate over inodes that are in directory specified by |nid|.
> +// |parent_nid| is optional, if specified, additional sanity checks will
> +// be performed.
> +// |cb| will be called for every inode, regardless of type of inode.
> +// |arg| will be passed to the callback in |erofs_readdir_cb| struct's
> +// |arg| field.

erofs-utils follows linux kernel coding style, so apart from SPDX,
it'd be better to use C-style comments only.

Also you could run scripts/checkpatch.pl in advance to avoid most
style problems..

I'd be many thanks if code could follow the correct coding style,
so I could have much less extra work to do.

> +int erofs_iterate_dir(const struct erofs_sb_info* sbi,
> +									 erofs_nid_t nid,
> +									 erofs_nid_t parent_nid,
> +									 erofs_readdir_cb cb,
> +									 void* arg);

1 tab equals to 8 spaces in the kernel coding style.
So the indentation is somewhat weird for me.

Thanks,
Gao Xiang

