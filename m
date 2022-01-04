Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF084842EB
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jan 2022 15:00:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JSvQM3XBvz2ywF
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jan 2022 01:00:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JSvQB3y5hz2xYQ
 for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jan 2022 01:00:15 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R991e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=13; SR=0; TI=SMTPD_---0V0ysn7A_1641304800; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0ysn7A_1641304800) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 04 Jan 2022 22:00:03 +0800
Date: Tue, 4 Jan 2022 22:00:00 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v1 05/23] netfs: add inode parameter to
 netfs_alloc_read_request()
Message-ID: <YdRS4AnHbWpHwl/8@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
 gerry@linux.alibaba.com, eguan@linux.alibaba.com,
 linux-kernel@vger.kernel.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-6-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211227125444.21187-6-jefflexu@linux.alibaba.com>
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 bo.liu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org, eguan@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 27, 2021 at 08:54:26PM +0800, Jeffle Xu wrote:
> When working as the local cache, the @file parameter of
> netfs_alloc_read_request() represents the backed file inside netfs. It
> is for two use: 1) we can derive the corresponding inode from file,
> 2) works as the argument for ops->init_rreq().
> 
> In the new introduced demand-read mode, netfs_readpage() will be called
> by the upper fs to read from backing files. However in this new mode,
> the backed file may not be opened, and thus the @file argument is NULL
> in this case.
> 
> For netfs_readpage(), @file parameter represents the backed file inside
> netfs, while @folio parameter represents one page cache inside the
> address space of this backed file. We can still derive the inode from
> the @folio parameter, even when @file parameter is NULL.
> 
> Thus refactor netfs_alloc_read_request() somewhat for this change.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

I'm not sure how other folks think.

Yet in principle, personally I think it's reasonable that
something like read_cache_page_gfp() could be used directly
with fscache backend as well.

So for such internal read requests, @file argument is
actually optional as a common practice.

Apart from the commit message itself (which I think it could
be simplified a bit), generally it looks good to me.

Thanks,
Gao Xiang


> ---
>  fs/netfs/read_helper.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index 8c58cff420ba..ca84918b6b5d 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -39,7 +39,7 @@ static void netfs_put_subrequest(struct netfs_read_subrequest *subreq,
>  
>  static struct netfs_read_request *netfs_alloc_read_request(
>  	const struct netfs_read_request_ops *ops, void *netfs_priv,
> -	struct file *file)
> +	struct inode *inode, struct file *file)
>  {
>  	static atomic_t debug_ids;
>  	struct netfs_read_request *rreq;
> @@ -48,7 +48,7 @@ static struct netfs_read_request *netfs_alloc_read_request(
>  	if (rreq) {
>  		rreq->netfs_ops	= ops;
>  		rreq->netfs_priv = netfs_priv;
> -		rreq->inode	= file_inode(file);
> +		rreq->inode	= inode;
>  		rreq->i_size	= i_size_read(rreq->inode);
>  		rreq->debug_id	= atomic_inc_return(&debug_ids);
>  		INIT_LIST_HEAD(&rreq->subrequests);
> @@ -870,6 +870,7 @@ void netfs_readahead(struct readahead_control *ractl,
>  		     void *netfs_priv)
>  {
>  	struct netfs_read_request *rreq;
> +	struct inode *inode = file_inode(ractl->file);
>  	unsigned int debug_index = 0;
>  	int ret;
>  
> @@ -878,7 +879,7 @@ void netfs_readahead(struct readahead_control *ractl,
>  	if (readahead_count(ractl) == 0)
>  		goto cleanup;
>  
> -	rreq = netfs_alloc_read_request(ops, netfs_priv, ractl->file);
> +	rreq = netfs_alloc_read_request(ops, netfs_priv, inode, ractl->file);
>  	if (!rreq)
>  		goto cleanup;
>  	rreq->mapping	= ractl->mapping;
> @@ -948,12 +949,13 @@ int netfs_readpage(struct file *file,
>  		   void *netfs_priv)
>  {
>  	struct netfs_read_request *rreq;
> +	struct inode *inode = folio_file_mapping(folio)->host;
>  	unsigned int debug_index = 0;
>  	int ret;
>  
>  	_enter("%lx", folio_index(folio));
>  
> -	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
> +	rreq = netfs_alloc_read_request(ops, netfs_priv, inode, file);
>  	if (!rreq) {
>  		if (netfs_priv)
>  			ops->cleanup(folio_file_mapping(folio), netfs_priv);
> @@ -1122,7 +1124,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	}
>  
>  	ret = -ENOMEM;
> -	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
> +	rreq = netfs_alloc_read_request(ops, netfs_priv, inode, file);
>  	if (!rreq)
>  		goto error;
>  	rreq->mapping		= folio_file_mapping(folio);
> -- 
> 2.27.0
