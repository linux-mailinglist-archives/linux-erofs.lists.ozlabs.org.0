Return-Path: <linux-erofs+bounces-1555-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682E3CD871A
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 09:19:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db7FX5Frcz2xlP;
	Tue, 23 Dec 2025 19:18:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766477936;
	cv=none; b=RJpq0S44Pdpmt30p3fWbVm31YX+uXaYwfB0DC9qDWXV10adtmnaLTaFXLG8wdDUfXrx0tZHHbzElH+RnpVpfSFFndTq55xQvL7N0qSyj9QtEUWwoDB+dWruiGCOZM40e9+N8KciJeO5cFPcZ3VmdCNit7s4MtmW5XPbvsKwGm27LFkNtvOYfPWJOEZnyppuMFEAvwQ6K+cyf56JUV60ldywU1Rv29MTs8EOzkf8Kp3NJMApp6ZpC42zf/XiaBJiLbiYuLyldsi3fGeaoIQmopuhM9O4TvTPzr3nNg0eu4uzryaKbbAYOpw34ypMz8UpoP/2rkGJjjZANjGMCRZs2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766477936; c=relaxed/relaxed;
	bh=Nl5MwHnazquKRYPLmeRjaf6HhBiE4sUlehAEkIPwR+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVKcSPRVzVxJ2cpNXjgYRib0Z+ySAn6N7cFnhcmN0yBvYbDbAIew8Ma6ButV9VfVSvmU4f3w4UorBAALAPjLlzkI3e8uh4jc+it+AQdfySAbUJ9lr+hlYCiCX1V0751RzQ7F+uu+GMS4aw2STGm+1CAt9eoDkKFpsbiIle1q+jbaCWIYuerYzpl0+nSWu+hRtw8XRXXUCW5fTpPilJjrucFHTWW+wMo9iz0lP+D4iFn31tLl+out2WVRUkyvTckurg6ECtPuOfLHWyWOBtVAePe28d8HGRw22t/g9qzgGoeU7KzrujQGRmyrpsFokcfLfEuUHoi34NtepQYIwd/rog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=INY67ck+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=INY67ck+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db7FT5PJRz2xQK
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 19:18:52 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766477928; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Nl5MwHnazquKRYPLmeRjaf6HhBiE4sUlehAEkIPwR+A=;
	b=INY67ck+Cx1+dDPNlxQ9ZT8vQNfXCKK24vi7GNzq3FwjOc3XqFX7WnfWSCvIzoKiW5noMmfSv2GKuQiB8uohfyAITADpROeSOJlyuyUnrOAdErVj1/iVM6DCGOIdtuIk8NXxlKHKtFl1UbQxjRPo3s1RlZ/xNTAIXZoegXPfviU=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvX2CYI_1766477924 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:18:45 +0800
Message-ID: <a43ac775-aa82-44cc-ab01-9126eba98e75@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:18:44 +0800
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
Subject: Re: [PATCH v10 09/10] erofs: support compressed inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
 Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-10-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-10-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/23 09:56, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch adds page cache sharing functionality for compressed inodes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/zdata.c | 42 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 65da21504632..465918093984 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -493,7 +493,7 @@ enum z_erofs_pclustermode {
>   };
>   
>   struct z_erofs_frontend {
> -	struct inode *const inode;
> +	struct inode *inode;
>   	struct erofs_map_blocks map;
>   	struct z_erofs_bvec_iter biter;
>   
> @@ -1883,10 +1883,18 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
>   
>   static int z_erofs_read_folio(struct file *file, struct folio *folio)
>   {
> -	struct inode *const inode = folio->mapping->host;
> -	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
> +	struct inode *const inode = folio->mapping->host, *realinode;
> +	Z_EROFS_DEFINE_FRONTEND(f, NULL, folio_pos(folio));
>   	int err;
>   
> +	if (erofs_is_ishare_inode(inode))
> +		realinode = erofs_ishare_iget(inode);
> +	else
> +		realinode = inode;

I don't think it makes any sense to differ those two cases, just

	struct inode *inode = folio->mapping->host;
	struct inode *realinode = erofs_get_real_inode(inode);
	Z_EROFS_DEFINE_FRONTEND(f, realinode, folio_pos(folio));

...

> +
> +	if (!realinode)
> +		return -EIO;

That is an impossible case, just `DBG_BUGON(!realinode);`

> +	f.inode = realinode;
>   	trace_erofs_read_folio(folio, false);
>   	z_erofs_pcluster_readmore(&f, NULL, true);
>   	err = z_erofs_scan_folio(&f, folio, false);
> @@ -1896,23 +1904,34 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
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
> +	if (erofs_is_ishare_inode(inode))
> +		erofs_ishare_iput(realinode);

	erofs_put_real_inode(realinode);

>   	return err;
>   }
>   
>   static void z_erofs_readahead(struct readahead_control *rac)
>   {
> -	struct inode *const inode = rac->mapping->host;
> -	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
> +	struct inode *const inode = rac->mapping->host, *realinode;
> +	Z_EROFS_DEFINE_FRONTEND(f, NULL, readahead_pos(rac));
>   	unsigned int nrpages = readahead_count(rac);
>   	struct folio *head = NULL, *folio;
>   	int err;
>   
> -	trace_erofs_readahead(inode, readahead_index(rac), nrpages, false);
> +	if (erofs_is_ishare_inode(inode))
> +		realinode = erofs_ishare_iget(inode);
> +	else
> +		realinode = inode;
> +
> +	if (!realinode)
> +		return;
> +	f.inode = realinode;

Same here.

Thanks,
Gao Xiang

