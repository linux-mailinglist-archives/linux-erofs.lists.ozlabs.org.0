Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B96593F4E5
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2024 14:10:02 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GNNhM86y;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WXccQ1RJtz3cWY
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2024 22:09:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GNNhM86y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WXccK120Hz3c8n
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jul 2024 22:09:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722254986; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/LiwTxEWozLcI89KBfc1cfMrnDgkB2zQBY9g4RvgDNQ=;
	b=GNNhM86yTmXeSQmwosR1dYIRXEvnpUDORTg5hEeNPmzPi0sxHWDx14SRgYZlbHoZAK+DYK+RCVR5/ZgqAmo7Qdb7NOEhshAp+g0BfnQDI1XeKe06Ook4rhYHGcwhOe0TWubHMUky2pg/1Yjv569vIVXEu/pc9Ub8uPZw1tfN6cQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0WBa6r47_1722254984;
Received: from 30.221.145.83(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WBa6r47_1722254984)
          by smtp.aliyun-inc.com;
          Mon, 29 Jul 2024 20:09:45 +0800
Message-ID: <96478e11-a473-47cc-af7b-1b5c079cf12d@linux.alibaba.com>
Date: Mon, 29 Jul 2024 20:09:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: support direct IO for ondemand mode
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, dhavale@google.com, dhowells@redhat.com
References: <20240726020627.2873693-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240726020627.2873693-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Cc: netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 7/26/24 10:06 AM, Hongbo Li wrote:
> erofs over fscache cannot handle the direct read io. When the file
> is opened with O_DIRECT flag, -EINVAL will reback. We support the
> DIO in erofs over fscache by bypassing the erofs page cache and
> reading target data into ubuf from fscache's file directly.
> 
> The alignment for buffer memory, offset and size now is restricted
> by erofs, since `i_blocksize` is enough for the under filesystems.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> ---
> v2:
>   - Change the directIO helper name to erofs_fscache_direct_io
>   - Add some io interception when begin direct io
>   - Optimize the direct io logical in erofs_fscache_data_read_slice
> 
> v1:
>   - https://lore.kernel.org/linux-erofs/6f1a5c1c-d44d-4561-9377-b935ff4531f2@huawei.com/T/#t
> ---
>  fs/erofs/data.c    |  3 ++
>  fs/erofs/fscache.c | 84 +++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 78 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 8be60797ea2f..dbfafe358de4 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -391,6 +391,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		     iov_iter_alignment(to)) & blksize_mask)
>  			return -EINVAL;
>  
> +		if (erofs_is_fscache_mode(inode->i_sb))
> +			return generic_file_read_iter(iocb, to);
> +
>  		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
>  				    NULL, 0, NULL, 0);
>  	}
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index fda16eedafb5..e3e6c579eb81 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -35,6 +35,8 @@ struct erofs_fscache_io {
>  
>  struct erofs_fscache_rq {
>  	struct address_space	*mapping;	/* The mapping being accessed */
> +	struct iov_iter		*iter;		/* Destination for direct io */
> +	struct completion	done;		/* Sync for direct io */
>  	loff_t			start;		/* Start position */
>  	size_t			len;		/* Length of the request */
>  	size_t			submitted;	/* Length of submitted */
> @@ -76,7 +78,11 @@ static void erofs_fscache_req_put(struct erofs_fscache_rq *req)
>  {
>  	if (!refcount_dec_and_test(&req->ref))
>  		return;
> -	erofs_fscache_req_complete(req);
> +
> +	if (req->iter)
> +		complete(&req->done);
> +	else
> +		erofs_fscache_req_complete(req);
>  	kfree(req);
>  }
>  
> @@ -88,6 +94,7 @@ static struct erofs_fscache_rq *erofs_fscache_req_alloc(struct address_space *ma
>  	if (!req)
>  		return NULL;
>  	req->mapping = mapping;
> +	req->iter = NULL;
>  	req->start = start;
>  	req->len = len;
>  	refcount_set(&req->ref, 1);
> @@ -258,6 +265,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
>  	struct address_space *mapping = req->mapping;
>  	struct inode *inode = mapping->host;
>  	struct super_block *sb = inode->i_sb;
> +	struct iov_iter *dest_iter = req->iter;
>  	struct erofs_fscache_io *io;
>  	struct erofs_map_blocks map;
>  	struct erofs_map_dev mdev;
> @@ -270,33 +278,45 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
>  	if (ret)
>  		return ret;
>  
> +	count = req->len - req->submitted;
>  	if (map.m_flags & EROFS_MAP_META) {
>  		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  		struct iov_iter iter;
> -		size_t size = map.m_llen;
> +		struct iov_iter *iterp;
> +		size_t size = min_t(size_t, map.m_llen, count);
>  		void *src;
> +		ssize_t filled = 0;
>  
>  		src = erofs_read_metabuf(&buf, sb, map.m_pa, EROFS_KMAP);
>  		if (IS_ERR(src))
>  			return PTR_ERR(src);
>  
>  		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, PAGE_SIZE);
> -		if (copy_to_iter(src, size, &iter) != size) {
> +		iterp = (dest_iter) ?: &iter;

Could we also reuse erofs_fscache_rq->iter for the non-direct-IO case?
That is, initializing erofs_fscache_rq->iter before calling
erofs_fscache_data_read() just like what erofs_fscache_direct_io() does,
so that we don't need disturbing the iter here inside
erofs_fscache_data_read_slice().

> +		if (copy_to_iter(src, size, iterp) != size) {
>  			erofs_put_metabuf(&buf);
>  			return -EFAULT;
>  		}
> -		iov_iter_zero(PAGE_SIZE - size, &iter);
> +
> +		filled += size;
> +		if (!dest_iter) {
> +			iov_iter_zero(PAGE_SIZE - size, iterp);
> +			filled += (PAGE_SIZE - size);
> +		}
> +

Don't we need also zeroing the remaining part for direct IO, e.g. when
direct reading the last inlined part of a file of
EROFS_INODE_FLAT_INLINE layout?

>  		erofs_put_metabuf(&buf);
> -		req->submitted += PAGE_SIZE;
> +		req->submitted += filled;
>  		return 0;
>  	}
>  
> -	count = req->len - req->submitted;
>  	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
>  		struct iov_iter iter;
>  
> -		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, count);
> -		iov_iter_zero(count, &iter);
> +		if (!dest_iter) {
> +			iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, count);
> +			iov_iter_zero(count, &iter);
> +		}
> +

Ditto.  Don't we need handling the unmapped case for direct IO, e.g.
when direct reading a sparse file?


>  		req->submitted += count;
>  		return 0;
>  	}
> @@ -315,9 +335,17 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
>  	io = erofs_fscache_req_io_alloc(req);
>  	if (!io)
>  		return -ENOMEM;
> -	iov_iter_xarray(&io->iter, ITER_DEST, &mapping->i_pages, pos, count);
> +
> +	if (dest_iter)
> +		iov_iter_ubuf(&io->iter, ITER_DEST,
> +			dest_iter->ubuf + dest_iter->iov_offset, count);
> +	else
> +		iov_iter_xarray(&io->iter, ITER_DEST, &mapping->i_pages, pos, count);
> +
>  	ret = erofs_fscache_read_io_async(mdev.m_fscache->cookie,
>  			mdev.m_pa + (pos - map.m_la), io);
> +	if (dest_iter)
> +		iov_iter_advance(dest_iter, io->iter.iov_offset);
>  	erofs_fscache_req_io_put(io);
>  
>  	req->submitted += count;
> @@ -373,6 +401,43 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
>  	erofs_fscache_req_put(req);
>  }
>  
> +static ssize_t erofs_fscache_direct_io(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	struct file *file = iocb->ki_filp;
> +	size_t count = iov_iter_count(iter);
> +	size_t i_size = i_size_read(file->f_inode);
> +	struct erofs_fscache_rq *req;
> +	struct completion *ctr;
> +	ssize_t rsize;
> +	int ret;
> +
> +	if (unlikely(iov_iter_rw(iter) == WRITE))
> +		return -EROFS;

We will get here by no way since .write_iter() is not implemented at
all, right?

> +
> +	if (unlikely(iocb->ki_pos >= i_size))
> +		return 0;
> +
> +	if (count + iocb->ki_pos > i_size)
> +		count = i_size - iocb->ki_pos;
> +
> +	if (!count)
> +		return 0;
> +
> +	req = erofs_fscache_req_alloc(file->f_mapping, iocb->ki_pos, count);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->iter = iter;
> +	init_completion(&req->done);
> +	ctr = &req->done;
> +	ret = erofs_fscache_data_read(req);
> +	rsize = (ret == 0) ? (ssize_t)req->submitted : ret;
> +	erofs_fscache_req_put(req);

If we get error in erofs_fscache_data_read(), the above
erofs_fscache_req_put() will put the last reference of erofs_fscache_rq
and free the erofs_fscache_rq structure.  Then the following
wait_for_completion() will cause UAF.

> +	wait_for_completion(ctr);
> +
> +	return rsize;
> +}
> +
>  static const struct address_space_operations erofs_fscache_meta_aops = {
>  	.read_folio = erofs_fscache_meta_read_folio,
>  };
> @@ -380,6 +445,7 @@ static const struct address_space_operations erofs_fscache_meta_aops = {
>  const struct address_space_operations erofs_fscache_access_aops = {
>  	.read_folio = erofs_fscache_read_folio,
>  	.readahead = erofs_fscache_readahead,
> +	.direct_IO = erofs_fscache_direct_io,
>  };
>  
>  static void erofs_fscache_domain_put(struct erofs_domain *domain)

-- 
Thanks,
Jingbo
