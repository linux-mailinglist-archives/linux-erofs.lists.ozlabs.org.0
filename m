Return-Path: <linux-erofs+bounces-1587-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E98CCDBA58
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 09:15:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbl7M4n1Xz2yFY;
	Wed, 24 Dec 2025 19:15:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766564143;
	cv=none; b=VVVdB3yz38XcC4btx3V8rPdUOK/7cY0DrSzoOBw+TbMtI6afxeEcX4VfmiUrN0STzjD8TTWKlOyBmARCLg7GOqf8L7KugiGGPQpSTmF0803d/kQW/E18hzBcMJrDgPZlff1SVgZggSaBx+iQxoV3d7VGXkWjr87FlMmM6ZWt9UKEWFGARB9EyWqtlDTg7dna8F4CpOjVCctEhU+eqAPhwo0IBWlOI2j2I6PsJzNxv2H6F8s+OmcIEuYPq+3IA5IlXM3uSyZcku1lT85cVZPg35kYWDli9mDn9AU4M515U+GEzC/iZyV809x7R1YAt15/bmr2oTlqsU6wXaBnNUFyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766564143; c=relaxed/relaxed;
	bh=HvNtWBYHjlKadnKRSAAlto1QAZJUw+2Q2TRFjKQurLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xio3Iw3hpAKSgPjOBVFztRKG4na1KGmdQJhG2LWgK4KDf4PX1mTOOdIQUdmnk0IKnqVG/xjn1IGBlw8OdH5ktHibSWa04A8Vw7eFbVgsnK0U4Hj1BlPpgUJSzG43jFJOadUHFEkaLmXgLIeoDSYA/sk463/aui63fn3cs99SMaQL4VxqP/m+ZZ2ZBhFfgn+1nDmOmN5ZbCEmFigpRj85DGC+EAzXKfhD62asV9yJAMeNpXAl2lNjcVEJJNMgFJj7OOmTG5RrfGpK/hkr7Z/gdVxRPzhRUog/sN5c0Gv9khLQCgerblN2msjfiEUPD+koJDdrQzRnVRR+uzDKb/5m7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YJPvI79j; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YJPvI79j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbl7K44x0z2xqm
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 19:15:39 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766564136; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HvNtWBYHjlKadnKRSAAlto1QAZJUw+2Q2TRFjKQurLY=;
	b=YJPvI79je6MmYhylAaQClO8DAW2oDidVfdrrqFzxzZok+GtqgQfYh0Nn2un2P4Mt75dH8/eu9OX6qZA1Wytt//kRZk7MkxEYMpRtty64R1Cp0C2vcxKNh8BJXGSPpEc82/MCFgk/uneoae3JWBqbFeYvnRZhBCPs6p14gjqOvIc=
Received: from 30.221.133.159(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvaNGZF_1766564134 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 16:15:35 +0800
Message-ID: <7898bedf-0c02-432b-999a-01437265b51b@linux.alibaba.com>
Date: Wed, 24 Dec 2025 16:15:34 +0800
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
Subject: Re: [PATCH v11 08/10] erofs: support unencoded inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-9-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251224040932.496478-9-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/24 12:09, Hongbo Li wrote:
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
>   fs/erofs/data.c     | 32 +++++++++++++++++++++++++-------
>   fs/erofs/inode.c    |  4 ++++
>   fs/erofs/internal.h |  2 ++
>   fs/erofs/ishare.c   | 31 +++++++++++++++++++++++++++++++
>   4 files changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 71e23d91123d..cbe7ac194b09 100644
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
> @@ -379,30 +381,44 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>    */
>   static int erofs_read_folio(struct file *file, struct folio *folio)
>   {
> +	struct inode *inode = folio_inode(folio);
>   	struct iomap_read_folio_ctx read_ctx = {
>   		.ops		= &iomap_bio_read_ops,
>   		.cur_folio	= folio,
>   	};
> -	struct erofs_iomap_iter_ctx iter_ctx = {};
> +	bool need_iput = false;

	`bool need_iput` is enough, see below.

> +	struct erofs_iomap_iter_ctx iter_ctx = {> +		.realinode	= erofs_real_inode(inode, &need_iput),
> +	};
>   
> +	DBG_BUGON(!iter_ctx.realinode);

just remove this line, since erofs_real_inode() already has this check.


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
> +	bool need_iput = false;

	`bool need_iput` is enough, see below.

> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.realinode	= erofs_real_inode(inode, &need_iput),
> +	};
>   
> +	DBG_BUGON(!iter_ctx.realinode);

just remove this line, since erofs_real_inode() already has this check.

>   	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>   					readahead_count(rac), true);
>   
>   	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
> +	if (need_iput)
> +		iput(iter_ctx.realinode);
>   }
>   
>   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> @@ -423,7 +439,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
> index bce98c845a18..8116738fe432 100644
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
> index a2b2434ee3c8..6930cce8f1fb 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -565,11 +565,13 @@ int __init erofs_init_ishare(void);
>   void erofs_exit_ishare(void);
>   bool erofs_ishare_fill_inode(struct inode *inode);
>   void erofs_ishare_free_inode(struct inode *inode);
> +struct inode *erofs_real_inode(struct inode *inode, bool *need_iput);
>   #else
>   static inline int erofs_init_ishare(void) { return 0; }
>   static inline void erofs_exit_ishare(void) {}
>   static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
>   static inline void erofs_ishare_free_inode(struct inode *inode) {}
> +static inline struct inode *erofs_real_inode(struct inode *inode, bool *need_iput) { return inode; }

static inline struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
{
	*need_iput = false;
	return inode;
}

>   #endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>   
>   long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 09ea456f2eab..634b7ea63738 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -11,6 +11,12 @@
>   
>   static struct vfsmount *erofs_ishare_mnt;
>   
> +static inline bool erofs_is_ishare_inode(struct inode *inode)
> +{
> +	/* assumed FS_ONDEMAND is excluded with FS_PAGE_CACHE_SHARE feature */
> +	return inode->i_sb->s_type == &erofs_anon_fs_type;
> +}
> +
>   static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
>   {
>   	struct erofs_inode_fingerprint *fp1 = &EROFS_I(inode)->fingerprint;
> @@ -157,6 +163,31 @@ const struct file_operations erofs_ishare_fops = {
>   	.splice_read	= filemap_splice_read,
>   };
>   
> +struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
> +{
> +	struct erofs_inode *vi, *vi_dedup;
> +	struct inode *realinode;

	*need_iput = false;
here

Thanks,
Gao Xiang

> +
> +	if (!erofs_is_ishare_inode(inode))
> +		return inode;
> +
> +	vi_dedup = EROFS_I(inode);
> +	spin_lock(&vi_dedup->ishare_lock);
> +	/* fetch any one as real inode */
> +	DBG_BUGON(list_empty(&vi_dedup->ishare_list));
> +	list_for_each_entry(vi, &vi_dedup->ishare_list, ishare_list) {
> +		realinode = igrab(&vi->vfs_inode);
> +		if (realinode) {
> +			*need_iput = true;
> +			break;
> +		}
> +	}
> +	spin_unlock(&vi_dedup->ishare_lock);
> +
> +	DBG_BUGON(!realinode);
> +	return realinode;
> +}
> +
>   int __init erofs_init_ishare(void)
>   {
>   	erofs_ishare_mnt = kern_mount(&erofs_anon_fs_type);


