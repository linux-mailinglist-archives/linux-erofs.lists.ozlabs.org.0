Return-Path: <linux-erofs+bounces-1776-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FB3D0742B
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 06:55:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnWG54Y8Nz2xPB;
	Fri, 09 Jan 2026 16:55:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767938125;
	cv=none; b=K9ZrhMqNEmTL2Zo9K3xAH2xvQBlvdXoKOTHqJ674sOvB4HVgxoEjP8meXeRinKinWJ6TR/W+cVmAto5IcLRe8dv0AKXYqVgPjxRPjYzXuYf6AT2uW2nkZTmutVIeuTrSD4T1AUhiQ9nXPIWkh3KgvSur5kjg4MDA2XjqtuWaCu0sMZ3UbLtfryN1tz8lbJl+4eYpTJUks6afDblehsTGPm/Ugwm1qfoEOK3zQr2cm6YwZl0eD0KzKn6fbsx1Pw6Knd6VL+37Hy2FQFszTzZyKAeKVI8bxpUIoHtH7q2lAabQNXbb4m48BQ0lLBwDDTuqvgvph9RjWNIVYpo++rifDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767938125; c=relaxed/relaxed;
	bh=kwEry0PBTDpfE4oHiAHCyh7xXcMzLVzss6Nu/zqdczA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSEt7zSJsE3p6it7+HeoXlIGUgQMFqkDeOcLgXiogQihaqIRXGmHHeIr3un92UcMMB/DJucjmqbvU8wuzTjcCvKE4SVtEQ+q43Lez4/rYuOxVITLBFmNiACvOYIPy3Lb03cVoEDBuJ0XeSo9Ejr8HV92TKHiD8e0Gjd5cnlkwVdehWPw7u1ZGg+MCm8xIIQ5CNLTUAgSFPKdNSngdHXtcBm/j2IMvSpqVeMas9bJ+jAc3JQ/gOviquoigM+kZ913JGHwv9tvJk9spdAOKQbOvXbr4J8szbx4s9VTHWguLICPO0KU0Ko2tfzXUdSBt9GbQY/ZMv1U8I8HgvkorNMo6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=htg0wEyr; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=htg0wEyr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnWG42Bxvz2xP8
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 16:55:23 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767938120; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kwEry0PBTDpfE4oHiAHCyh7xXcMzLVzss6Nu/zqdczA=;
	b=htg0wEyrQ4Fpk19TxACmUh0o6FjJRkPRFLOjxwOMOfG/gD+pkcuwHbQMuQoNOkvUR+JyC+k4w4Nqx6z55gtYlQgZv+I8eODHMel79beZP99Vb74kKGxxryWGtaM6L3Mp8j5xyiphzW1hWxPZ/Mw3YppMRyHlALYsFiWXEI3HXTU=
Received: from 30.221.131.232(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwf3JGr_1767938118 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 13:55:18 +0800
Message-ID: <c7544d82-416d-4980-ac39-b5f83c540f38@linux.alibaba.com>
Date: Fri, 9 Jan 2026 13:55:16 +0800
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
Subject: Re: [PATCH v13 08/10] erofs: support unencoded inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, chao@kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <20260109030140.594936-1-lihongbo22@huawei.com>
 <20260109030140.594936-9-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260109030140.594936-9-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/9 11:01, Hongbo Li wrote:
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
>   fs/erofs/data.c     | 30 +++++++++++++++++++++++-------
>   fs/erofs/inode.c    |  2 ++
>   fs/erofs/internal.h |  6 ++++++
>   fs/erofs/ishare.c   | 32 ++++++++++++++++++++++++++++++++
>   4 files changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 71e23d91123d..5fc8e3ce0d9e 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -269,6 +269,7 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>   struct erofs_iomap_iter_ctx {
>   	struct page *page;
>   	void *base;
> +	struct inode *realinode;
>   };
>   
>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> @@ -276,14 +277,15 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   {
>   	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
>   	struct erofs_iomap_iter_ctx *ctx = iter->private;
> -	struct super_block *sb = inode->i_sb;
> +	struct inode *realinode = ctx ? ctx->realinode : inode;
> +	struct super_block *sb = realinode->i_sb;
>   	struct erofs_map_blocks map;
>   	struct erofs_map_dev mdev;
>   	int ret;
>   
>   	map.m_la = offset;
>   	map.m_llen = length;
> -	ret = erofs_map_blocks(inode, &map);
> +	ret = erofs_map_blocks(realinode, &map);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -296,7 +298,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		return 0;
>   	}
>   
> -	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(inode)) {
> +	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(realinode)) {
>   		mdev = (struct erofs_map_dev) {
>   			.m_deviceid = map.m_deviceid,
>   			.m_pa = map.m_pa,
> @@ -322,7 +324,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			void *ptr;
>   
>   			ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
> -						 erofs_inode_in_metabox(inode));
> +						 erofs_inode_in_metabox(realinode));
>   			if (IS_ERR(ptr))
>   				return PTR_ERR(ptr);
>   			iomap->inline_data = ptr;
> @@ -379,30 +381,42 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>    */
>   static int erofs_read_folio(struct file *file, struct folio *folio)
>   {
> +	struct inode *inode = folio_inode(folio);
>   	struct iomap_read_folio_ctx read_ctx = {
>   		.ops		= &iomap_bio_read_ops,
>   		.cur_folio	= folio,
>   	};
> -	struct erofs_iomap_iter_ctx iter_ctx = {};
> +	bool need_iput;
> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.realinode	= erofs_real_inode(inode, &need_iput),

I think you could just open-code it for now:

		.realinode = erofs_real_inode(folio_inode(folio), &need_iput),

> +	};
>   
>   	trace_erofs_read_folio(folio, true);
>   
>   	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
> +	if (need_iput)
> +		iput(iter_ctx.realinode);
>   	return 0;
>   }
>   
>   static void erofs_readahead(struct readahead_control *rac)
>   {
> +	struct inode *inode = rac->mapping->host;
>   	struct iomap_read_folio_ctx read_ctx = {
>   		.ops		= &iomap_bio_read_ops,
>   		.rac		= rac,
>   	};
> -	struct erofs_iomap_iter_ctx iter_ctx = {};
> +	bool need_iput;
> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.realinode	= erofs_real_inode(inode, &need_iput),

Same here:
		.realinode = erofs_real_inode(rac->mapping->host,
					      &need_iput),

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

