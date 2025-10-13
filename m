Return-Path: <linux-erofs+bounces-1180-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D740BD15DC
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Oct 2025 06:16:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4clPDn73kpz2yrT;
	Mon, 13 Oct 2025 15:16:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760329001;
	cv=none; b=Qw/zgJaEXf2F7qYsYGLZYMUHGKprMpbd/OPkLZwfDqOSYh8QIyMdpPf/IMBrxsPmVOTPamJwLAyX+7BDPS2jJaoohq2D2bRSyCGGihnIE+MRA2AoB6Tv7SMhP+OUjhvQfmLYwIrFLsvxBFIwcWl/PRB7BHF+d94LeNqM5y+2nGpuw+5oeq5QPj5Exxx1XThAZlOwVpil1AmhLOvqVuHWOpPjwbLs7/doW4YixeLxGRwW9kwf9XLMamOG/VVo9G0OnrsPaBDoWJ79VQLQGYmn98mvutwUnceITtJ0WrZd0Imq60hn+nODZenwtJcTyVudXTM02DJSYEWGtw1vf36MQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760329001; c=relaxed/relaxed;
	bh=LKAFH59CbQyepEzpm1HPlJx8KhoAqmWuzmeytifxrvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WeFuavHCeqp3jsJ33PAUbVaqw0rxAJxO+LY6JqUuw3c4AHVa/xKGJ9GMqYqHSTVIOpNmvjUU4NiAXTWIKOSsjXZW3lB4TmUWQhnNNF9sfhnX13PYlvri4s5g03PiyjxZEWR1EOvOYox0SIylZor+oeeJxUTLfi/aOlxuMbK4ldAdKQ3F1CE3Vx3hCx9/qBVdXdhNhBSDC7w55CquGYvwuv1ljEQ5YriR3R5GSic9eHCRAsqFFMINNY7a0sFg8zUa5dhDmgwFZFsy6BvxNp4RKY+1rBWHvcuJIc8ivSpksmEROhqJFL96YXXjXOVfKjch6fd3N9zu/gsVvKoX3lKK+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OS5QkaqD; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OS5QkaqD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 160718 seconds by postgrey-1.37 at boromir; Mon, 13 Oct 2025 15:16:39 AEDT
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4clPDl0rQ7z2xQD
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Oct 2025 15:16:37 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LKAFH59CbQyepEzpm1HPlJx8KhoAqmWuzmeytifxrvM=;
	b=OS5QkaqDosO3GrDu1jOEC4SD20IOt7dwm28/90MrTUxz62JvZp8saTOTXMcJogSh726P2MujG
	rwwwpmFI4aZibjX7IiTpvXsCRqZgHPyIkLYX7t7IarMxNf35JRm6o87PNcm8ezjD4OnbJV7L+xQ
	mkW6seR0ua2DnZc+2O4zRYo=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4clPDD6tkRz1cyQ3;
	Mon, 13 Oct 2025 12:16:12 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id D84721A0171;
	Mon, 13 Oct 2025 12:16:31 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 12:16:31 +0800
Message-ID: <62036acc-04f3-4dec-98c9-343def13d3c4@huawei.com>
Date: Mon, 13 Oct 2025 12:16:33 +0800
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
Subject: Re: [PATCH v2] erofs: fix crafted invalid cases for encoded extents
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: LKML <linux-kernel@vger.kernel.org>, Robert Morris <rtm@mit.edu>, Robert
 Morris <rtm@csail.mit.edu>
References: <2cda3cc5-f837-4627-9587-051ed10839b9@linux.alibaba.com>
 <20251012135925.158921-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251012135925.158921-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/10/12 21:59, Gao Xiang wrote:
> Robert recently reported two corrupted images that can cause system
> crashes, which are related to the new encoded extents introduced
> in Linux 6.15:
> 
>    - The first one [1] has plen != 0 (e.g. plen == 0x2000000) but
>      (plen & Z_EROFS_EXTENT_PLEN_MASK) == 0. It is used to represent
>      special extents such as sparse extents (!EROFS_MAP_MAPPED), but
>      previously only plen == 0 was handled;
> 
>    - The second one [2] has pa 0xffffffffffdcffed and plen 0xb4000,
>      then "cur [0xfffffffffffff000] += bvec.bv_len [0x1000]" in
>      "} while ((cur += bvec.bv_len) < end);" wraps around, causing an
>      out-of-bound access of pcl->compressed_bvecs[] in
>      z_erofs_submit_queue().  EROFS only supports 48-bit physical block
>      addresses (up to 1EiB for 4k blocks), so add a sanity check to
>      enforce this.
> 
> Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
> Reported-by: Robert Morris <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/r/75022.1759355830@localhost
> Closes: https://lore.kernel.org/r/80524.1760131149@localhost
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
> v2:
>   - `pend` should be converted to blocks and then be compared.
> 
>   fs/erofs/zmap.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 798223e6da9c..87032f90fe84 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -596,7 +596,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
>   			vi->z_fragmentoff = map->m_plen;
>   			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
>   				vi->z_fragmentoff |= map->m_pa << 32;
> -		} else if (map->m_plen) {
> +		} else if (map->m_plen & Z_EROFS_EXTENT_PLEN_MASK) {
>   			map->m_flags |= EROFS_MAP_MAPPED |
>   				EROFS_MAP_FULL_MAPPED | EROFS_MAP_ENCODED;
>   			fmt = map->m_plen >> Z_EROFS_EXTENT_PLEN_FMT_BIT;
> @@ -715,6 +715,7 @@ static int z_erofs_map_sanity_check(struct inode *inode,
>   				    struct erofs_map_blocks *map)
>   {
>   	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
> +	u64 pend;
>   
>   	if (!(map->m_flags & EROFS_MAP_ENCODED))
>   		return 0;
> @@ -732,6 +733,10 @@ static int z_erofs_map_sanity_check(struct inode *inode,
>   	if (unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
>   		     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
>   		return -EOPNOTSUPP;
> +	/* Filesystems beyond 48-bit physical block addresses are invalid */
> +	if (unlikely(check_add_overflow(map->m_pa, map->m_plen, &pend) ||
> +		     (pend >> sbi->blkszbits) >= BIT_ULL(48)))
> +		return -EFSCORRUPTED;
>   	return 0;
>   }
>   

