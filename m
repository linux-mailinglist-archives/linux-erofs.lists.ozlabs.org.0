Return-Path: <linux-erofs+bounces-622-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B314BB04DE7
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Jul 2025 04:40:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bh3Mr37K1z3by8;
	Tue, 15 Jul 2025 12:40:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752547256;
	cv=none; b=CGWE6QFSVJol6M/9Em6gOq/lNMcLd9ZjhyX90X/TJUrouD46r6M1Nft9lY2Hmcb/1ij3ek934lMQJgCYjL9SIlsuNzL2CS8vgBPufXiGelDvGolOPBy42lQZr0p2p7TSf2hIb3v96ipU9MC2J31iGDfIwvsl6Nktij3aJ6HrO/m6zarCjtu/y8TbU0QGZoeZ61eOAVpmdnkxm7xiFGTPWKstoUEUjeSu/kg6gxxARhH1dmMFaCidClFPAT2k4GNfb4RQmDWy4tPzjQewFVKjVOXGggve0X+xWLh8mH9Q3Vj0YB9m8SyeNFkRDMyUy8mFVinUaGhXOFJYIYHQ/DqnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752547256; c=relaxed/relaxed;
	bh=eMp9SekpA/hk1MuVf4hR4grFiLI//nlf6f4bjluGqs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGE1M6sJCUU81RdFb8+sDB5retmei6gilHqfR5KxB7AsmtqQzr4V8AtNI1Gnn4M2NUiK9k8zrK9Yune3Iu1rI9PlTum+u6dEAsdeOEyuFm6N0VSGTksVzw9lzjh8eVFkLWsXjIHmBmRZtHJbDUeotzEkqbn1mynntm28f+ekgosyVAh6kr6Zh9loG+W1dUzTC+N8NpcOcz646q3cLkGDoDlGl4SthNXOUe67Y8aSRCC8QRVIgpEOzWtKmKXQvco4EDQYhKwXcLq4YXK0rHNgn/VhTq6/DuRLqHbKdiU7vt3nVKeYeJUt2SrEsfsyDBNjQF/BvcdqvAp5Sx3hy6/QCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PLyLZtCo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PLyLZtCo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bh3Mq4hvKz3bxJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Jul 2025 12:40:55 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752547252; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eMp9SekpA/hk1MuVf4hR4grFiLI//nlf6f4bjluGqs0=;
	b=PLyLZtCocEIdnYHAylVmsw9pciFjF7QM8kEDIHCKau7+lwWcTMbnmEB57r0DgzC8QsxP73NhJSAzAdxSgoKpq6wnlpEpLaxEFnJJoumM1gZwQWIEgezp83Hd+KYM9p4OlndNjE6htZx3UnFEU22C/m8jlpYmkrNpM6WKOg523LU=
Received: from 30.221.131.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj-brfJ_1752547247 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 10:40:47 +0800
Message-ID: <e0a95041-f0b2-49e3-be7a-6a7f2c2c5851@linux.alibaba.com>
Date: Tue, 15 Jul 2025 10:40:47 +0800
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
Subject: Re: [PATCH 2/2] erofs: unify meta buffers in z_erofs_fill_inode()
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250714090907.4095645-1-hsiangkao@linux.alibaba.com>
 <20250714090907.4095645-2-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250714090907.4095645-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/14 17:09, Gao Xiang wrote:
> There is no need to keep additional local metabufs since we already
> have one in `struct erofs_map_blocks`.
> 
> This was actually a leftover when applying meta buffers to zmap
> operations, see commit 09c543798c3c ("erofs: use meta buffers for
> zmap operations").
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/zmap.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index ff1d0751fc61..9afc8a68bacb 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -620,13 +620,12 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
>   	return 0;
>   }
>   
> -static int z_erofs_fill_inode_lazy(struct inode *inode)
> +static int z_erofs_fill_inode(struct inode *inode, struct erofs_map_blocks *map)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
>   	struct super_block *const sb = inode->i_sb;
>   	int err, headnr;
>   	erofs_off_t pos;
> -	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>   	struct z_erofs_map_header *h;
>   
>   	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags)) {
> @@ -646,7 +645,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>   		goto out_unlock;
>   
>   	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
> -	h = erofs_read_metabuf(&buf, sb, pos);
> +	h = erofs_read_metabuf(&map->buf, sb, pos);
>   	if (IS_ERR(h)) {
>   		err = PTR_ERR(h);
>   		goto out_unlock;
> @@ -684,7 +683,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>   		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
>   			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
>   		err = -EOPNOTSUPP;
> -		goto out_put_metabuf;
> +		goto out_unlock;
>   	}
>   
>   	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
> @@ -693,7 +692,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>   		erofs_err(sb, "per-inode big pcluster without sb feature for nid %llu",
>   			  vi->nid);
>   		err = -EFSCORRUPTED;
> -		goto out_put_metabuf;
> +		goto out_unlock;
>   	}
>   	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
>   	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
> @@ -701,27 +700,20 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>   		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
>   			  vi->nid);
>   		err = -EFSCORRUPTED;
> -		goto out_put_metabuf;
> +		goto out_unlock;
>   	}
>   
>   	if (vi->z_idata_size ||
>   	    (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
> -		struct erofs_map_blocks map = {
> -			.buf = __EROFS_BUF_INITIALIZER
> -		};
> -
> -		err = z_erofs_map_blocks_fo(inode, &map,
> +		err = z_erofs_map_blocks_fo(inode, map,
>   					    EROFS_GET_BLOCKS_FINDTAIL);
> -		erofs_put_metabuf(&map.buf);
>   		if (err < 0)
> -			goto out_put_metabuf;
> +			goto out_unlock;

Note that it has a regression, so need to discard this part.

Thanks,
Gao Xiang

