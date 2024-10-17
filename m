Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F859A1C26
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 09:58:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XTgF82HNvz3bgl
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 18:58:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729151898;
	cv=none; b=XZxIchaQY/DnFTzQ5W5IopL/0RrOq0Qi0FRlqGk59CfWbwtAjuTA+qlX5PKIHWcUZjcStIU86IQfNlBWRWPZuwgOgUKU/G6ooB5zio3r2+pAcnjlZKG3qmkCoUMvVzakxA8nOGKQHVLo0H0reCkg2/x5rMgpkJcOCnCu4gzlKeltgQPlArEzHj5NvdG/GbyKWvBvG7eDM33yIjNccsIBodCuW2JdMSDBIR/Dk8UajBWLW+gk9LtRyZVv6WIh/V2mc7v5QM73raeWpBaf7DLKn5w3m/97Vm55CRNj7upgC8o8DQdmnU0iNDmNvqkKw0Xj0DkyKCAryHeQfNKp8kBzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729151898; c=relaxed/relaxed;
	bh=xSQuZ3RrlX5HhMVvn9kUolFt+7zp3/8AJ7mdOCoylNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9SKCygoWsTEjISri9/80Xp7b1ho4H0QHm4+On8C64v5B+gGAbiLrkSFWrcIKsEnarRJt7/CTM0RjgESApjeEacnlpclS1EAUcmMLJW4j+w/IdIFEuso2K7QVZnqtyLx086gpV/nd5ZVpAbZ+1LCoUV3z1F4cU00aFJlFSeYJHcBv5KqrDyjnp5l1eTZZnj7BBch6gb6WYmd9r0MhyFBs3imIP6+fdjdwt5g6Urto364dTT9Y3mS6Y9pSxJ4XI5Mmc6a17PgPKOCjXXbm48Lnx/OiLTCEX14dCzWiMHZNH25hJitrsUY8644QD+LkXTfbP70cl/tRpVvYNq17KZNSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x4BcnzJZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x4BcnzJZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XTgF31Jn6z2xl5
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Oct 2024 18:58:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729151888; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xSQuZ3RrlX5HhMVvn9kUolFt+7zp3/8AJ7mdOCoylNA=;
	b=x4BcnzJZn2ssdKBhKsen2/D/qzN6m7h/p5OJl/olW+iW/sNjJkPl1GpYu3i7fEeLxMAs3N0qD3O3OyfkkIgom9iUad6ABEbf5CiJM8A06ZXJDeIvN5urHpnty03qJjVsBescJQ3ACQ8sOX8C6sW6AfyyFmBIefY2SMqZ0nCHKN4=
Received: from 30.221.129.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHK.xZK_1729151886 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 15:58:06 +0800
Message-ID: <ca27aa75-40a4-4c82-8d84-7968b2ab89d4@linux.alibaba.com>
Date: Thu, 17 Oct 2024 15:58:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fs: erofs: support PG_mappedtodisk flag for folios
 with zero-filled
To: Barry Song <21cnbao@gmail.com>, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20241017074346.35284-1-21cnbao@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241017074346.35284-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Barry Song <v-songbaohua@oppo.com>, huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Barry,

On 2024/10/17 15:43, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> When a folio has never been zero-filled, mark it as mappedtodisk
> to allow other software components to recognize and utilize the
> flag.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Thanks for this!

It looks good to me as an improvement as long as PG_mappedtodisk
is long-term lived and useful to users.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/fileio.c | 2 ++
>   fs/erofs/zdata.c  | 6 +++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index 3af96b1e2c2a..aa4cb438ea95 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -88,6 +88,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>   	struct erofs_map_blocks *map = &io->map;
>   	unsigned int cur = 0, end = folio_size(folio), len, attached = 0;
>   	loff_t pos = folio_pos(folio), ofs;
> +	bool fully_mapped = true;
>   	struct iov_iter iter;
>   	struct bio_vec bv;
>   	int err = 0;
> @@ -124,6 +125,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>   			erofs_put_metabuf(&buf);
>   		} else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
>   			folio_zero_segment(folio, cur, cur + len);
> +			fully_mapped = false;
>   			attached = 0;
>   		} else {
>   			if (io->rq && (map->m_pa + ofs != io->dev.m_pa ||
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 8936790618c6..0158de4f3d95 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -926,7 +926,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
>   	const loff_t offset = folio_pos(folio);
>   	const unsigned int bs = i_blocksize(inode);
>   	unsigned int end = folio_size(folio), split = 0, cur, pgs;
> -	bool tight, excl;
> +	bool tight, excl, fully_mapped = true;
>   	int err = 0;
>   
>   	tight = (bs == PAGE_SIZE);
> @@ -949,6 +949,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
>   
>   		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
>   			folio_zero_segment(folio, cur, end);
> +			fully_mapped = false;
>   			tight = false;
>   		} else if (map->m_flags & EROFS_MAP_FRAGMENT) {
>   			erofs_off_t fpos = offset + cur - map->m_la;
> @@ -1009,6 +1010,9 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
>   			tight = (bs == PAGE_SIZE);
>   		}
>   	} while ((end = cur) > 0);
> +
> +	if (fully_mapped)
> +		folio_set_mappedtodisk(folio);
>   	erofs_onlinefolio_end(folio, err);
>   	return err;
>   }

