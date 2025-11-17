Return-Path: <linux-erofs+bounces-1385-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD84C62432
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 04:44:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d8tsR1Pv8z2xS2;
	Mon, 17 Nov 2025 14:44:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763351067;
	cv=none; b=HJm/YxCchS8ZJEVcqHiM4TjI0yQ/JqF3ugaS2nqZX3I85/BJwoK6nZ9BivsSaasnsowLj74KUM4yI82KekBeXAaPjcGtg1Sh3evA15c2zWyjJQJqwsA5cuG1MkkTPUNm/DsTK+e9+va5kVJ9OfgwfU2Ar8/wI6+2aCp8Ykx60RJ4VYTRra7m+s6hYeAu3H16vdCk7ljzFg4ECLOloZ/zE1iGut/KYqkDJmPhwPq6eXPZYo3Y4kl5Li0Y2qodOKTI6U2oBJlVYHyqbaH8RjrTrJ51U0dFbnNUi5XsChZoFReprCRRA9WUvbdKV6nx/p0oKEkReIkyqGj2kA9/rvzWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763351067; c=relaxed/relaxed;
	bh=xM/7SlXR05QhJ9/aqpWKEmKID+CL6RpEJ9yf+AkBzU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ff+Ra9Gf+T9YTyhPvd97Kp+e4WvbfqFjN0V68FC3AahSp6KyN3yBLOfOP609s1+rk7b1OgGciW6aMiqiBBuoE9bDQPVKm6TtkITshcI/dFCyIA5vsxdmLaiS/gjtdwh3c5wteQjqzRaM6gZVxE1MClnwNmlHvcrCj1DQV4ZRnU/kls9e1k5xwyhma32bWbKG7WehCfDSwk13WxTSNiEV11BFcl+OQK7PbMjyHzAgzRQTDaeSHOoobvL7Gffh/8J4gkxoqJ1mvp19a2MTNwK6cyKpsG8fn6R+cn0HWg3Fdn0uGcDVtSalkuWeJmNeZarCApW0J4kTV22wRdHMjCZHtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kcy0hMvJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kcy0hMvJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d8tsN6B1tz2xQr
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Nov 2025 14:44:22 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763351058; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xM/7SlXR05QhJ9/aqpWKEmKID+CL6RpEJ9yf+AkBzU8=;
	b=Kcy0hMvJf6qLPwl35JJSXafm0mcN9MWnV/AUlrt3gPBEnFu0M0oM9SGJtICZKJ1+bJms5yT/ZwSi5PD4V/4tJAql0DdJkuDoOWH7BWdVKSQLEhI/49P/zWoS+mJhErtk1iWgDqw1HmOAKhKkcz+wREXdq9livGjZ5xFSE0ypHMw=
Received: from 30.221.131.30(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsU-ZOC_1763351056 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Nov 2025 11:44:17 +0800
Message-ID: <40b291a4-ea32-4450-ab67-0c9c96a3d601@linux.alibaba.com>
Date: Mon, 17 Nov 2025 11:44:16 +0800
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
Subject: Re: [PATCH v8 7/9] erofs: support unencoded inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-8-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-8-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/14 17:55, Hongbo Li wrote:
> This patch adds inode page cache sharing functionality for unencoded
> files.
> 
> I conducted experiments in the container environment. Below is the
> memory usage for reading all files in two different minor versions
> of container images:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     241     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     872     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     2771    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     926     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     390     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     924     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |     474     |      49%      |
> +-------------------+------------------+-------------+---------------+
> 
> Additionally, the table below shows the runtime memory usage of the
> container:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      35     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     149     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     1028    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  2.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     155     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      25     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     186     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |      98     |      48%      |
> +-------------------+------------------+-------------+---------------+
> 
> Co-developed-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/data.c     | 38 +++++++++++++++---
>   fs/erofs/inode.c    |  5 +++
>   fs/erofs/internal.h |  4 ++
>   fs/erofs/ishare.c   | 98 ++++++++++++++++++++++++++++++++++++++++++++-
>   fs/erofs/ishare.h   | 18 +++++++++
>   fs/erofs/super.c    | 11 +++--
>   6 files changed, 163 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index bd3d85c61341..c459104e4734 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2021, Alibaba Cloud
>    */
>   #include "internal.h"
> +#include "ishare.h"

Can we just get rid of another "ishare.h", these can be moved into
internal.h:

#ifdef CONFIG_EROFS_FS_INODE_SHARE

int erofs_ishare_init(struct super_block *sb);
void erofs_ishare_exit(struct super_block *sb);
bool erofs_ishare_fill_inode(struct inode *inode);
void erofs_ishare_free_inode(struct inode *inode);

#else

static inline int erofs_ishare_init(struct super_block *sb) { return 0; }
static inline void erofs_ishare_exit(struct super_block *sb) {}
static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
static inline void erofs_ishare_free_inode(struct inode *inode) {}

#endif // CONFIG_EROFS_FS_INODE_SHARE

>   #include <linux/sched/mm.h>
>   #include <trace/events/erofs.h>
>   
> @@ -269,23 +270,27 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>   struct erofs_iomap_iter_ctx {
>   	struct page *page;
>   	void *base;
> +	struct inode *realinode;
>   };
>   
>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
>   {
> -	int ret;
>   	struct erofs_iomap_iter_ctx *ctx;
> -	struct super_block *sb = inode->i_sb;
>   	struct erofs_map_blocks map;
>   	struct erofs_map_dev mdev;
>   	struct iomap_iter *iter;
> +	struct inode *realinode;
> +	struct super_block *sb;

	struct inode *realinode = ctx ? ctx->realinode : inode;
	struct super_block *sb = realinode->i_sb;

> +	int ret;
>   
>   	iter = container_of(iomap, struct iomap_iter, iomap);
>   	ctx = iter->private;
> +	realinode = ctx ? ctx->realinode : inode;
> +	sb = realinode->i_sb;
>   	map.m_la = offset;
>   	map.m_llen = length;
> -	ret = erofs_map_blocks(inode, &map);
> +	ret = erofs_map_blocks(realinode, &map);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -300,7 +305,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		return 0;
>   	}
>   
> -	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(inode)) {
> +	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(realinode)) {
>   		mdev = (struct erofs_map_dev) {
>   			.m_deviceid = map.m_deviceid,
>   			.m_pa = map.m_pa,
> @@ -326,7 +331,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>   
>   			ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
> -						 erofs_inode_in_metabox(inode));
> +						 erofs_inode_in_metabox(realinode));
>   			if (IS_ERR(ptr))
>   				return PTR_ERR(ptr);
>   			iomap->inline_data = ptr;

...

>   
> @@ -234,3 +248,83 @@ const struct file_operations erofs_ishare_fops = {
>   	.get_unmapped_area = thp_get_unmapped_area,
>   	.splice_read	= filemap_splice_read,
>   };
> +
> +void erofs_read_begin(struct erofs_read_ctx *rdctx)

I think if backing_head, backing_link (although I don't like
the naming) is valid, erofs_read_begin() and erofs_read_end()
is unneeded here.

Since we maintain the backing validity using .open() and
.release() hooks.

the odd erofs_read_{begin,end} can be avoided then...

Thanks,
Gao Xiang

