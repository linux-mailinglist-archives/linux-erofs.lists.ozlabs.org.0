Return-Path: <linux-erofs+bounces-522-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0C3AF9BD3
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jul 2025 23:06:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYmQH4ld9z2xlL;
	Sat,  5 Jul 2025 07:06:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751663175;
	cv=none; b=QN6h3k/Zvb3oiiMBHaa/xvV1bRE6KBmO2+RbcUT5aYqzNT1CqvOJOY7VM0OMziuObi6sWz4SulNNjWMF2VKXRU96rO5bYSL68tqmXD2hs7WbUksFS/ZB4f8ibr9Fx2/q3JLzI6rPUIllGY+kSzpgXKtuM9NmLAILCt98V3t94Ep/3AIBIpRKHWqR7R2s7ZjJaQUKtlL5CIWxoXHs4befXRyRR4jdoapzKvTvr3VKMZ2C0rDW1lLUMn2CmK3qGTtcjpH2+6umTGc8uU1lskjPlzoWyHpH8oq8RGMp3D6hH/PwiWGq6xARHeWuLlFF24qwL+Xf9he6StFY1+MTcIz/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751663175; c=relaxed/relaxed;
	bh=tA4OVVKRBN0rUryPu1WB+4eG67vpUuf616E7ybrZgMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVCAC01U+Qu6IgfN9pd97vYBQOlrpwui2T/DszI9tpYiIYJqGPs3/NVek5wp8gBhE0ruTFMzoGMzKx/S+uX44hZ8dFvf6Ar7PMiNa0bxNlyQWDPjGG/7Jcsuc/xiPn8HJronzc5OMpS34YpkXYjuwxdbMtmng71GPhtEVsh8xskJ+4iZqnBBwVTrQd7P0MMvewgMQRnfb21JRToojFM4ugMBnCioCjYRNCxePMp+xobd0mYpdAEi9pYziQ5etImLAD+1o01xLUCEePi9r4o0xTok1c1iTCzqwkTA1CjL8fcbYpZ1FpTtm8viRwPwYaXcFq9a1Q4lark6nKsEk/hrZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LfgTzYtu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LfgTzYtu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYmQF2HL9z2xd3
	for <linux-erofs@lists.ozlabs.org>; Sat,  5 Jul 2025 07:06:11 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751663167; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tA4OVVKRBN0rUryPu1WB+4eG67vpUuf616E7ybrZgMo=;
	b=LfgTzYtuFssKYJU9yurw8e5ErFhkmDIwGBol5t1/+D+6uy0cAYpUjAQFJmBjIXHSrXQPFdPcH8DnpeJ2/mbKcJcPavg8L2NB/tmYVXaeFQolacCZR+EL8KSWfMqoWtboIZMGmr0IZveEL+wUPT4nQo+swqRf6vdu1S5lFGcOP/s=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WhMKHLM_1751663165 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 05 Jul 2025 05:06:06 +0800
Message-ID: <12e59170-7435-4fae-a485-9cb105c378d1@linux.alibaba.com>
Date: Sat, 5 Jul 2025 05:06:04 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/4] erofs: introduce page cache share feature
To: Christian Brauner <brauner@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 Hongzhen Luo <hongzhen@linux.alibaba.com>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
 <20250703-work-erofs-pcs-v1-2-0ce1f6be28ee@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250703-work-erofs-pcs-v1-2-0ce1f6be28ee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Christian,

On 2025/7/3 20:23, Christian Brauner wrote:

...

> diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
> new file mode 100644
> index 000000000000..309b33cc6c30
> --- /dev/null
> +++ b/fs/erofs/pagecache_share.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024, Alibaba Cloud
> + */
> +#include <linux/xxhash.h>
> +#include <linux/refcount.h>
> +#include "pagecache_share.h"
> +#include "internal.h"
> +#include "xattr.h"
> +
> +#define PCS_FPRT_IDX	4
> +#define PCS_FPRT_NAME	"erofs.fingerprint"
> +#define PCS_FPRT_MAXLEN (sizeof(size_t) + 1024)

One thing I told Hongzhen to work on is that I really
don't like a hardcode xattr like this.

Because EROFS can store common long xattr prefixes, see:
https://docs.kernel.org/filesystems/erofs.html#long-extended-attribute-name-prefixes

So it would be nice to just record a name prefix in the
ondisk superblock so that users can use their own xattr
names for this usage.

For example, users could use "overlay.metacopy" xattr
as page cache sharing fingerprint to identify different
inodes if overlayfs fsverity feature is on, see:
https://docs.kernel.org/filesystems/overlayfs.html#fs-verity-support

But if you really don't have more time to know the EROFS
internals here, you could just leave as-is.  I could
handle myself.

> +

...

> +}
> +
> +/*
> + * TODO: Hm, could we leverage our fancy new backing file infrastructure
> + * as for overlayfs and fuse?

If some code can be lifted up as a vfs helper, it would be
much helpful as the backing file infrastructure was lifted
from overlayfs.

But I'm not sure if it's really needed for now anyway
because it's only EROFS-specific, and I only maintain and
can speak of EROFS.

> + */
> +static struct file *erofs_pcs_alloc_file(struct file *file,
> +					 struct inode *ano_inode)
> +{
> +	struct file *ano_file;
> +
> +	ano_file = alloc_file_pseudo(ano_inode, erofs_pcs_mnt, "[erofs_pcs_f]",
> +				     O_RDONLY, &erofs_file_fops);
> +	file_ra_state_init(&ano_file->f_ra, file->f_mapping);
> +	ano_file->private_data = EROFS_I(file_inode(file));
> +	return ano_file;
> +}
> +

...

> +
> +/*
> + * TODO: Amir, you've got some experience in this area due to overlayfs
> + * and fuse. Does that work?
> + */



Hi Amir,

I do think it will work, if you have chance please help
take a quick look too.

It's much similar to overlayfs, the difference is that the real
inodes is not in some other fs, but anon inodes from a pseudo
sb which shares among the whole host to share page cache for
containers.

> +static int erofs_pcs_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct file *ano_file = file->private_data;
> +
> +	vma_set_file(vma, ano_file);
> +	vma->vm_ops = &generic_file_vm_ops;
> +	return 0;
> +}
> +
> +const struct file_operations erofs_pcs_file_fops = {
> +	.open		= erofs_pcs_file_open,
> +	/*
> +	 * TODO: Why doesn't .llseek require similar treatment as
> +	 * .read_iter?
> +	 */

I don't know some specific reason because it wrote by
Hongzhen.

Hongzhen is still at work until by the end of the month,
I hope he could answer some question.

> +	.llseek		= generic_file_llseek,
> +	.read_iter	= erofs_pcs_file_read_iter,
> +	.mmap		= erofs_pcs_mmap,
> +	.release	= erofs_pcs_file_release,
> +	.get_unmapped_area = thp_get_unmapped_area,
> +	.splice_read	= filemap_splice_read,
> +};
> diff --git a/fs/erofs/pagecache_share.h b/fs/erofs/pagecache_share.h
> new file mode 100644
> index 000000000000..b8111291cf79
> --- /dev/null
> +++ b/fs/erofs/pagecache_share.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2024, Alibaba Cloud
> + */


BTW, it seems that this header is too small, maybe just
fold them into internal.h.

Thanks,
Gao Xiang

> +#ifndef __EROFS_PAGECACHE_SHARE_H
> +#define __EROFS_PAGECACHE_SHARE_H
> +
> +#include <linux/fs.h>
> +#include <linux/mount.h>
> +#include <linux/rwlock.h>
> +#include <linux/mutex.h>
> +#include "internal.h"
> +
> +int erofs_pcs_init_mnt(void);
> +void erofs_pcs_free_mnt(void);
> +void erofs_pcs_fill_inode(struct inode *inode);
> +
> +extern const struct vm_operations_struct generic_file_vm_ops;
> +
> +#endif
> 


