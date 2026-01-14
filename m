Return-Path: <linux-erofs+bounces-1865-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBD6D1F89B
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 15:51:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drpwl4bTKz2xNT;
	Thu, 15 Jan 2026 01:51:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768402311;
	cv=none; b=iShcWoMCIRrGRmxbzTnGSM9VtUlYwquZ/sfigfMo+oZ96o8AVmj1nV7/b/dM4lwuKnPAemNsoHvZhsmgpkAS13cE45A7aCdQmU7KjFRO4dkLpUEDt8bpq/thEKXwApz1IpK5ajvQjI971TtWE0VCoPmem8YAdNIiyC0LJMHwz3JEQkocBUysXPkcK3Cg67OAmg2oSGaHOuwuB9qhXGGhGgdJ15ndQa08kykrjVKHnVXLRsRpMC151x3pt8zb1U+dFs/jir9Ip87ILfpc6BRFYka6vKaOfXWrTXLplrfkRpl0TbYwqssns4q50SK/2pOaaB7vsKDASuE9Rkq30cTJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768402311; c=relaxed/relaxed;
	bh=tKEiYyztp7rnSuLNkwLOusLX/k6l5Kw33OzxJI4VSF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKuh03L3a6pSaOzwxtKJpWkfcQc7oMTIN+0c6ldWaaiZZ1foFpIMI1p4xS69vcqJrV32wqNR9nSpqqxv5q5X8eF0gcInTj00kNbZ0otHabaOZZx8f2TA9SlfLjxmM082xJD5dZQl1FOPH5MsuCWlIDkuxbWGZFx/siHbx5COdQ3+Sdli6+Q53DFTm0+AlC5c7kRUqWD9ISW8rUZlVW+7eGN1jI11VC+y/92Jnmn4sk6cM+agYC9b6YBUWmBLV9cTPLVdCzeiqrFa/xXh2WTLjyxyvfJhvoqWOjaJEpzGDATlzmqVFkD6uUTXtlh4+fgRBjCW7OhgHr6vFesBny9kbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uJJlmSrJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uJJlmSrJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drpwf2MXCz2xMt
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 01:51:44 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768402296; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tKEiYyztp7rnSuLNkwLOusLX/k6l5Kw33OzxJI4VSF0=;
	b=uJJlmSrJ4ibEm/EohE8/6iIAKgRvgiKTlqquzBOhYtls1twA8fEYo7F9nqB+OOW/q+bcYIWE2c9fXFTh77SN0a+6StZeoCfXEGFUea0GrpYmH9kkIolrjy7jnQMHI1dJCn0nC/G/RKyxWMxH5wn/T6z8XC9m4ylm75cbdZXkNA0=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx2jw0M_1768402294 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 22:51:34 +0800
Message-ID: <2d33cc2f-8188-4e62-b0be-bf985237bf24@linux.alibaba.com>
Date: Wed, 14 Jan 2026 22:51:33 +0800
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
Subject: Re: [PATCH v14 08/10] erofs: support unencoded inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-9-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260109102856.598531-9-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/9 18:28, Hongbo Li wrote:
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
>   fs/erofs/data.c              | 32 +++++++++++++++++++++++---------
>   fs/erofs/fileio.c            | 25 ++++++++++++++++---------
>   fs/erofs/inode.c             |  2 ++
>   fs/erofs/internal.h          |  6 ++++++
>   fs/erofs/ishare.c            | 34 ++++++++++++++++++++++++++++++++++
>   fs/erofs/zdata.c             |  2 +-
>   include/trace/events/erofs.h | 10 +++++-----
>   7 files changed, 87 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 71e23d91123d..7bbd94781170 100644
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
> @@ -383,11 +385,16 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
>   		.ops		= &iomap_bio_read_ops,
>   		.cur_folio	= folio,
>   	};
> -	struct erofs_iomap_iter_ctx iter_ctx = {};
> +	bool need_iput;
> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.realinode = erofs_real_inode(folio_inode(folio), &need_iput),
> +	};
>   
> -	trace_erofs_read_folio(folio, true);
> +	trace_erofs_read_folio(iter_ctx.realinode, folio, true);
>   
>   	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
> +	if (need_iput)
> +		iput(iter_ctx.realinode);
>   	return 0;
>   }
>   
> @@ -397,12 +404,17 @@ static void erofs_readahead(struct readahead_control *rac)
>   		.ops		= &iomap_bio_read_ops,
>   		.rac		= rac,
>   	};
> -	struct erofs_iomap_iter_ctx iter_ctx = {};
> +	bool need_iput;
> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.realinode = erofs_real_inode(rac->mapping->host, &need_iput),
> +	};
>   
> -	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
> +	trace_erofs_readahead(iter_ctx.realinode, readahead_index(rac),
>   					readahead_count(rac), true);

Is it possible to add a commit to update the tracepoints
to add the new realinode first?

Also please fix the indentation in that commit together.

>   
>   	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
> +	if (need_iput)
> +		iput(iter_ctx.realinode);
>   }
>   
>   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> @@ -423,7 +435,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index 932e8b353ba1..c1d0081609dc 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -88,9 +88,9 @@ void erofs_fileio_submit_bio(struct bio *bio)
>   						   bio));
>   }
>   
> -static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
> +static int erofs_fileio_scan_folio(struct erofs_fileio *io,
> +				   struct inode *inode, struct folio *folio)
>   {
> -	struct inode *inode = folio_inode(folio);
>   	struct erofs_map_blocks *map = &io->map;
>   	unsigned int cur = 0, end = folio_size(folio), len, attached = 0;
>   	loff_t pos = folio_pos(folio), ofs;
> @@ -158,31 +158,38 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>   
>   static int erofs_fileio_read_folio(struct file *file, struct folio *folio)
>   {
> +	bool need_iput;
> +	struct inode *realinode = erofs_real_inode(folio_inode(folio), &need_iput);
>   	struct erofs_fileio io = {};
>   	int err;
>   
> -	trace_erofs_read_folio(folio, true);
> -	err = erofs_fileio_scan_folio(&io, folio);
> +	trace_erofs_read_folio(realinode, folio, true);
> +	err = erofs_fileio_scan_folio(&io, realinode, folio);
>   	erofs_fileio_rq_submit(io.rq);
> +	if (need_iput)
> +		iput(realinode);
>   	return err;
>   }
>   
>   static void erofs_fileio_readahead(struct readahead_control *rac)
>   {
> -	struct inode *inode = rac->mapping->host;
> +	bool need_iput;
> +	struct inode *realinode = erofs_real_inode(rac->mapping->host, &need_iput);
>   	struct erofs_fileio io = {};
>   	struct folio *folio;
>   	int err;
>   
> -	trace_erofs_readahead(inode, readahead_index(rac),
> +	trace_erofs_readahead(realinode, readahead_index(rac),
>   			      readahead_count(rac), true);
>   	while ((folio = readahead_folio(rac))) {
> -		err = erofs_fileio_scan_folio(&io, folio);
> +		err = erofs_fileio_scan_folio(&io, realinode, folio);
>   		if (err && err != -EINTR)
> -			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
> -				  folio->index, EROFS_I(inode)->nid);
> +			erofs_err(realinode->i_sb, "readahead error at folio %lu @ nid %llu",
> +				  folio->index, EROFS_I(realinode)->nid);
>   	}
>   	erofs_fileio_rq_submit(io.rq);
> +	if (need_iput)
> +		iput(realinode);
>   }
>   
>   const struct address_space_operations erofs_fileio_aops = {
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index bce98c845a18..52179b706b5b 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -215,6 +215,8 @@ static int erofs_fill_inode(struct inode *inode)
>   	case S_IFREG:
>   		inode->i_op = &erofs_generic_iops;
>   		inode->i_fop = &erofs_file_fops;
> +		if (erofs_ishare_fill_inode(inode))
> +			inode->i_fop = &erofs_ishare_fops;

		inode->i_fop = erofs_ishare_fill_inode(inode) ?
			&erofs_ishare_fops : &erofs_file_fops;

Otherwise it looks good to me.

Thanks,
Gao Xiang

