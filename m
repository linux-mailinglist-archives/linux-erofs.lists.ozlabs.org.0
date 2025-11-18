Return-Path: <linux-erofs+bounces-1405-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01240C66FD4
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Nov 2025 03:14:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9Spl5x5tz2yG5;
	Tue, 18 Nov 2025 13:14:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763432047;
	cv=none; b=L3HfWxPV/KizE0GSWlBQSl9j7k5t4vtKBYdGdw9UC1s9JFRGp/aZO01fV+C+VqPTPQTFiy7cV6nUcgC9Cek7b8788zQmOJLdMTYiPRLUYr+qGu3T0CYXqfpZI+DE4O/mX0xVVYZ0zM4R/c/+UYmrpJ13LtjqHHgRguAbTKZ3T+f5i4l2mspIAieL4NnXNNfrA+/Ytc8xhqFr1Ncp7rJ6ddXWQSm/E0mLCw3njU7oAZRMzYRVMoEiti7b4E1dMso/nv7FG0GPIHTgoA9f/kduwoZ2tsdrgP8i9HAROiXkr3cXaq79Ye+NalaGh0AZqJjmGNDikWxJlTjb8992YJ+7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763432047; c=relaxed/relaxed;
	bh=wSOAFmlNdob6fSDMbjgR+Mf9EVImsGbW7KpF3Ups8U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZjWKtCtVQ5kTOKKj8FH5hW5yGG0GNModay4mnvKZDMcwG3Jc8etK4rSi7rwcmRHEPhDAcLPY+w2M1M3TB9+DR3ZKqP4/YQIFvhj5kd6fiqG2J3rTV6jamzAQiQ5DbAB7m/K1QCcAlqIBTeuvS/pj/AM2c68I5nz5kDLfuMw8KJYKafN9O1Cf/3i1c+JQ34DahJzoDgg/MsxJwJ3Fywo2VXuogZZy0txupdv/M8qTq+onkAdCQe85gmT7LXzmiGhbdePSyr/y2Q3ajOQzXT74mQwyit0PJuaYRGHxnkF00Jy2pLOUm91BCc/2vx5SzKY+YrfVbS87UQt0+RJPsbRkGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=onBcmsoW; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=onBcmsoW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9SpT2vXYz2xqr
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Nov 2025 13:13:53 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wSOAFmlNdob6fSDMbjgR+Mf9EVImsGbW7KpF3Ups8U4=;
	b=onBcmsoWnXriKu9DdpohUSe+xWBHC9up5xftbZKs0WLJDfh4YLlr+NNBJ4RaJnNjfWeAMBSG9
	GFn8OKg0zp5yNmIwyUe3ctwA42QwJ8llK4xG3a/k2sr6FG1kCcwnVdvmuL+YHf1aUweSM6MU+4m
	F3ItNdQiYSVa+ZxDmYqov/g=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d9Slg6HX0zLlST;
	Tue, 18 Nov 2025 10:11:27 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B8F21A0188;
	Tue, 18 Nov 2025 10:13:10 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 10:13:09 +0800
Message-ID: <5b37bbf8-0777-47f7-8110-c34885244afe@huawei.com>
Date: Tue, 18 Nov 2025 10:13:09 +0800
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
Subject: Re: [PATCH v9 08/10] erofs: support unencoded inodes for page cache
 share
Content-Language: en-US
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
 <20251117132537.227116-9-lihongbo22@huawei.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251117132537.227116-9-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi,

On 2025/11/17 21:25, Hongbo Li wrote:
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
>   fs/erofs/inode.c    |  4 ++++
>   fs/erofs/internal.h | 17 +++++++++++++++++
>   fs/erofs/ishare.c   | 31 +++++++++++++++++++++++++++++++
>   4 files changed, 75 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 71e23d91123d..862df0c7ceb7 100644
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
> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.realinode	= erofs_ishare_iget(inode),
> +	};
>   
> +	if (!iter_ctx.realinode)
> +		return -EIO;
>   	trace_erofs_read_folio(folio, true);
>   
>   	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
> +	erofs_ishare_iput(iter_ctx.realinode);
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
> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.realinode	= erofs_ishare_iget(inode),
> +	};
>   
> +	if (!iter_ctx.realinode)
> +		return;
>   	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>   					readahead_count(rac), true);
>   
>   	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
> +	erofs_ishare_iput(iter_ctx.realinode);
>   }
>   
>   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> @@ -423,7 +437,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
>   #endif
>   	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev) {
> -		struct erofs_iomap_iter_ctx iter_ctx = {};
> +		struct erofs_iomap_iter_ctx iter_ctx = {
> +			.realinode = inode,
> +		};
>   
>   		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
>   				    NULL, 0, &iter_ctx, 0);
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index cb780c095d28..3be4614d1add 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -215,6 +215,10 @@ static int erofs_fill_inode(struct inode *inode)
>   	case S_IFREG:
>   		inode->i_op = &erofs_generic_iops;
>   		inode->i_fop = &erofs_file_fops;
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +		if (erofs_ishare_fill_inode(inode))
> +			inode->i_fop = &erofs_ishare_fops;
> +#endif
>   		break;
>   	case S_IFDIR:
>   		inode->i_op = &erofs_dir_iops;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 93ad34f2b488..37b536eebc3d 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -197,6 +197,19 @@ static inline bool erofs_is_fscache_mode(struct super_block *sb)
>   			!erofs_is_fileio_mode(EROFS_SB(sb)) && !sb->s_bdev;
>   }
>   
> +#if defined(CONFIG_EROFS_FS_INODE_SHARE)

-#if defined(CONFIG_EROFS_FS_INODE_SHARE)
+#if defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)

I forgot updating here, and will update in the next version.

Thanks,
Hongbo

> +static inline bool erofs_is_ishare_inode(struct inode *inode)
> +{
> +	/* we have assumed FS_ONDEMAND is excluded with FS_INODE_SHARE feature */
> +	return inode->i_sb->s_type == &erofs_anon_fs_type;
> +}
> +#else
> +static inline bool erofs_is_ishare_inode(struct inode *inode)
> +{
> +	return false;
> +}
> +#endif
> +
>   enum {
>   	EROFS_ZIP_CACHE_DISABLED,
>   	EROFS_ZIP_CACHE_READAHEAD,
> @@ -563,11 +576,15 @@ int erofs_ishare_init(struct super_block *sb);
>   void erofs_ishare_exit(struct super_block *sb);
>   bool erofs_ishare_fill_inode(struct inode *inode);
>   void erofs_ishare_free_inode(struct inode *inode);
> +struct inode *erofs_ishare_iget(struct inode *inode);
> +void erofs_ishare_iput(struct inode *realinode);
>   #else
>   static inline int erofs_ishare_init(struct super_block *sb) { return 0; }
>   static inline void erofs_ishare_exit(struct super_block *sb) {}
>   static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
>   static inline void erofs_ishare_free_inode(struct inode *inode) {}
> +static inline struct inode *erofs_ishare_iget(struct inode *inode) { return inode; }
> +static inline void erofs_ishare_iput(struct inode *realinode) {}
>   #endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>   
>   long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index f386efb260da..da735d69f21f 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -239,3 +239,34 @@ const struct file_operations erofs_ishare_fops = {
>   	.get_unmapped_area = thp_get_unmapped_area,
>   	.splice_read	= filemap_splice_read,
>   };
> +
> +/*
> + * erofs_ishare_iget - find the backing inode.
> + */
> +struct inode *erofs_ishare_iget(struct inode *inode)
> +{
> +	struct erofs_inode *vi, *vi_dedup;
> +	struct inode *realinode;
> +
> +	if (!erofs_is_ishare_inode(inode))
> +		return igrab(inode);
> +
> +	vi_dedup = EROFS_I(inode);
> +	spin_lock(&vi_dedup->lock);
> +	/* fall back to all backing inodes */
> +	DBG_BUGON(list_empty(&vi_dedup->backing_head));
> +	list_for_each_entry(vi, &vi_dedup->backing_head, backing_link) {
> +		realinode = igrab(&vi->vfs_inode);
> +		if (realinode)
> +			break;
> +	}
> +	spin_unlock(&vi_dedup->lock);
> +
> +	DBG_BUGON(!realinode);
> +	return realinode;
> +}
> +
> +void erofs_ishare_iput(struct inode *realinode)
> +{
> +	iput(realinode);
> +}

