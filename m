Return-Path: <linux-erofs+bounces-1277-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BC8BF6AEA
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Oct 2025 15:12:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4crXkl4mJFz30D3;
	Wed, 22 Oct 2025 00:11:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761052319;
	cv=none; b=mP8EYzmXxLQfoiFaN61XxukZ7I90gfwVrA1GH5QLUMnXe52KBMme9KbzgP1ByZoHWWuIdVXkYTPvCAcarDU3hGusj4S6OhUAsL6cFSslA+/vh3TyUcfizKbFfIWNTQr12GxdqrdKACV1MtRJ70UwH40awKcnFCf3MABR4eEGSN16ondI9AS45pcauqkWKKDcp44fJkvwquYL6nNnv+4sD8YlO7NBfQVSG7qP1uTXhx29etKipfLAe5h+ILDik28U3Y4eDH07uN47aG7q9LFmg/uuIugASmiKYzv9VtcEOra4kFf+d2qsh8dQYOYT+Kgj2gCJBvFATmbQVPmOREoK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761052319; c=relaxed/relaxed;
	bh=VCTByEwFWcJXhery7PDfneEHZPqB+EV0usD/LLGzEQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LDcrIDRGwrF7v8p4LlmZt6A970NrU5lOf7raQEGIJVktunmmflEqXXxUR7JtK/t6E6nscTsblQl8teAh1bzi5OU1mU3sFUTRsyVkNcqdWv7Hv025LwMoSyfTQsRP4iWLlCG0DZlvUMIz2vXZ7KVMIuO96u2Dls+OjoGTt1Rrpvq6LV/+KHWAEmFAda7qWmYkDaj5K3LLfhfTRH6IgMYTR2szmwtqE45DwAKDJsQIAECkhhBsg9AysWh9sxmgEIbEgUNXuhLEwL14n66WmSiWpi5JtZj31BUw3uXreSP9ako0b+kaeuM7HuX2IOCpr7c8cnXhM0gjAIkVGp/8K0YLsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=GOZ4OFP1; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=GOZ4OFP1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4crXkh01NMz2yFq
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Oct 2025 00:11:55 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VCTByEwFWcJXhery7PDfneEHZPqB+EV0usD/LLGzEQQ=;
	b=GOZ4OFP1CvQxgY+YN5FGWG79AGtRxC+9DZI0mAryh/sAbZ+QGEwMki45kPzJbEQf6uvjRc7ob
	7R2Bct6uTqls8CXzcfkOdBTw5/BXSUF6lalNOWuzZ5er6auPwaCn1vLpobEKDKsKAEAY4qgmXFp
	2YuMsRh0Ms2/oEvRxIa8I8w=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4crXjH2yDrzpT0r
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Oct 2025 21:10:43 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 8810518007F
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Oct 2025 21:11:48 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 21:11:48 +0800
Message-ID: <4c3fa7c4-a919-425b-9745-e8798dbf8296@huawei.com>
Date: Tue, 21 Oct 2025 21:11:50 +0800
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
Subject: Re: [PATCH 1/2] erofs: avoid infinite loops due to corrupted subpage
 compact indexes
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20251017070539.901367-1-hsiangkao@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251017070539.901367-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/10/17 15:05, Gao Xiang wrote:
> Robert reported an infinite loop observed by two crafted images.
> 
> The root cause is that `clusterofs` can be larger than `lclustersize`
> for !NONHEAD `lclusters` in corrupted subpage compact indexes, e.g.:
> 
>    blocksize = lclustersize = 512   lcn = 6   clusterofs = 515
> 
> Move the corresponding check for full compress indexes to
> `z_erofs_load_lcluster_from_disk()` to also cover subpage compact
> compress indexes.
> 
> It also fixes the position of `m->type >= Z_EROFS_LCLUSTER_TYPE_MAX`
> check, since it should be placed right after
> `z_erofs_load_{compact,full}_lcluster()`.
> 
> Fixes: 8d2517aaeea3 ("erofs: fix up compacted indexes for block size < 4096")
> Fixes: 1a5223c182fd ("erofs: do sanity check on m->type in z_erofs_load_compact_lcluster()")
> Reported-by: Robert Morris <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/r/35167.1760645886@localhost
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

The clusterofs is unused in NONHEAD lcluster, so it is easy to understand.

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   fs/erofs/zmap.c | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index e5581dbeb4c2..6aca228cd2a5 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -55,10 +55,6 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
>   	} else {
>   		m->partialref = !!(advise & Z_EROFS_LI_PARTIAL_REF);
>   		m->clusterofs = le16_to_cpu(di->di_clusterofs);
> -		if (m->clusterofs >= 1 << vi->z_lclusterbits) {
> -			DBG_BUGON(1);
> -			return -EFSCORRUPTED;
> -		}
>   		m->pblk = le32_to_cpu(di->di_u.blkaddr);
>   	}
>   	return 0;
> @@ -240,21 +236,29 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
>   static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
>   					   unsigned int lcn, bool lookahead)
>   {
> +	struct erofs_inode *vi = EROFS_I(m->inode);
> +	int err;
> +
> +	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT) {
> +		err = z_erofs_load_compact_lcluster(m, lcn, lookahead);
> +	} else {
> +		DBG_BUGON(vi->datalayout != EROFS_INODE_COMPRESSED_FULL);
> +		err = z_erofs_load_full_lcluster(m, lcn);
> +	}
> +	if (err)
> +		return err;
> +
>   	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>   		erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
> -				m->type, lcn, EROFS_I(m->inode)->nid);
> +			  m->type, lcn, EROFS_I(m->inode)->nid);
>   		DBG_BUGON(1);
>   		return -EOPNOTSUPP;
> +	} else if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD &&
> +		   m->clusterofs >= (1 << vi->z_lclusterbits)) {
> +		DBG_BUGON(1);
> +		return -EFSCORRUPTED;
>   	}
> -
> -	switch (EROFS_I(m->inode)->datalayout) {
> -	case EROFS_INODE_COMPRESSED_FULL:
> -		return z_erofs_load_full_lcluster(m, lcn);
> -	case EROFS_INODE_COMPRESSED_COMPACT:
> -		return z_erofs_load_compact_lcluster(m, lcn, lookahead);
> -	default:
> -		return -EINVAL;
> -	}
> +	return 0;
>   }
>   
>   static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,

