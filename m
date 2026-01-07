Return-Path: <linux-erofs+bounces-1692-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FEECFC29A
	for <lists+linux-erofs@lfdr.de>; Wed, 07 Jan 2026 07:15:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmHpN59P4z2xbQ;
	Wed, 07 Jan 2026 17:15:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767766540;
	cv=none; b=P9wZuqcAbAX9iD/jKu7F0W6Os/LhpxOtkVhT1Y7mHRSlg/lTur9m4UpICpe3UvLj5OXcxRxnyGaIdOWmNkME4wNV6syrvzmzn2gduFrbEMZIlqx8yZmvOgsb4Oz2QiuCtws5+1NnknTgPHTfXhYcI3Ws1t1XWx0Fuu+6Ujlu8U7lPUU3EM8XNbjq0AHRZ6oZeWGMBr/ZR10Hm17J3ven40dMymu/iQvKNvWtPAJlYE7OOpLHQW9+udo4cj+Xgxu2qjUOcSsZsSp0kau9BOb5d7xSTN/lIrxzKlm6gE2UWZ32PppjMnO0y4l2svfTtZNp+J8q+k8E14AAiX3mU1lgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767766540; c=relaxed/relaxed;
	bh=kX0ibGMw8jtyCB1R4U6zfSTnINLFtE0rYeIUZULlvYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YeEM2lU8OsIc5oLkGFkYbKTnpBkCnMLnBWbG7p7ljtxOsMM+qB+wfv5Demn4ALlefqPPZifFRLtY1aTTv4sR2SXr8vsGe6dYBcFKHgcq8jRhDXu92/+m2vT/D5gDD5W2EW6obG/IoHRx9JyQJmXaZjddga6budGAT3ZaKia4oLOBUZ/zuKlM5FoqrVhG0MAxQ/AXThtdMebglviJPqLcCOQx3No7a1Y4Jwk/GfjTgNx+vE4Yj+ziqeM0/wpNNhU1QxkQiNcyQaPVpBwCu6/E2b7aSITuIG4ojgMH7BAjhH3Lb4nYHIFdkCq2RRR/hThYoMyYypx5PWDFMLCoHDzsMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ftxfr6Ww; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ftxfr6Ww;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmHpL5YtHz2xLR
	for <linux-erofs@lists.ozlabs.org>; Wed, 07 Jan 2026 17:15:35 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767766531; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kX0ibGMw8jtyCB1R4U6zfSTnINLFtE0rYeIUZULlvYE=;
	b=ftxfr6WwgBOpi/VgZacYd21paAaw5zPlNAvcKE2Yihef4d1xJRdtiZPlIcpwQvHDnUZkvlF9aaWaMoiSHPN3e/G1fwetmis1yNndbGsikxYWaugtZuBWGwi+zqvQuDbzWcrSeZZdVXu/5FaUyjzu6D7QFnizGoARcp4ExLSWzqo=
Received: from 30.221.132.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwXjML4_1767766529 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 Jan 2026 14:15:30 +0800
Message-ID: <ee332277-b19f-4c7c-9114-6fc19878ed43@linux.alibaba.com>
Date: Wed, 7 Jan 2026 14:15:29 +0800
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
Subject: Re: [PATCH v12 09/10] erofs: support compressed inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>, brauner@kernel.org
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-10-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251231090118.541061-10-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/31 17:01, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch adds page cache sharing functionality for compressed inodes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/zdata.c | 37 ++++++++++++++++++++++++-------------
>   1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 65da21504632..2697c703a4c4 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -493,7 +493,8 @@ enum z_erofs_pclustermode {
>   };
>   
>   struct z_erofs_frontend {
> -	struct inode *const inode;
> +	struct inode *inode;
> +	struct inode *sharedinode;

Let's combine these two lines into one for two related inodes?

	struct inode *inode, *sharedinode;

>   	struct erofs_map_blocks map;
>   	struct z_erofs_bvec_iter biter;
>   
> @@ -508,8 +509,8 @@ struct z_erofs_frontend {
>   	unsigned int icur;
>   };
>   
> -#define Z_EROFS_DEFINE_FRONTEND(fe, i, ho) struct z_erofs_frontend fe = { \
> -	.inode = i, .head = Z_EROFS_PCLUSTER_TAIL, \
> +#define Z_EROFS_DEFINE_FRONTEND(fe, i, si, ho) struct z_erofs_frontend fe = { \
> +	.inode = i, .sharedinode = si, .head = Z_EROFS_PCLUSTER_TAIL, \
>   	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .headoffset = ho }
>   
>   static bool z_erofs_should_alloc_cache(struct z_erofs_frontend *fe)
> @@ -1866,7 +1867,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
>   		pgoff_t index = cur >> PAGE_SHIFT;
>   		struct folio *folio;
>   
> -		folio = erofs_grab_folio_nowait(inode->i_mapping, index);
> +		folio = erofs_grab_folio_nowait(f->sharedinode->i_mapping, index);
>   		if (!IS_ERR_OR_NULL(folio)) {
>   			if (folio_test_uptodate(folio))
>   				folio_unlock(folio);
> @@ -1883,8 +1884,10 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
>   
>   static int z_erofs_read_folio(struct file *file, struct folio *folio)
>   {
> -	struct inode *const inode = folio->mapping->host;
> -	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
> +	struct inode *const sharedinode = folio->mapping->host;

Let's drop useless const annotation:

	struct inode *sharedinode = folio->mapping->host;

> +	bool need_iput;
> +	struct inode *realinode = erofs_real_inode(sharedinode, &need_iput);
> +	Z_EROFS_DEFINE_FRONTEND(f, realinode, sharedinode, folio_pos(folio));
>   	int err;
>   
>   	trace_erofs_read_folio(folio, false);
> @@ -1896,23 +1899,28 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
>   	/* if some pclusters are ready, need submit them anyway */
>   	err = z_erofs_runqueue(&f, 0) ?: err;
>   	if (err && err != -EINTR)
> -		erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
> -			  err, folio->index, EROFS_I(inode)->nid);
> +		erofs_err(realinode->i_sb, "read error %d @ %lu of nid %llu",
> +			  err, folio->index, EROFS_I(realinode)->nid);
>   
>   	erofs_put_metabuf(&f.map.buf);
>   	erofs_release_pages(&f.pagepool);
> +
> +	if (need_iput)
> +		iput(realinode);
>   	return err;
>   }
>   
>   static void z_erofs_readahead(struct readahead_control *rac)
>   {
> -	struct inode *const inode = rac->mapping->host;
> -	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
> +	struct inode *const sharedinode = rac->mapping->host;

Same here.
	struct inode *sharedinode = rac->mapping->host;

Thanks,
Gao Xiang

