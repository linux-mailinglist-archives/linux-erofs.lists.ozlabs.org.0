Return-Path: <linux-erofs+bounces-1173-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D43BBCF142
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Oct 2025 09:38:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ckFp93KRGz2xlQ;
	Sat, 11 Oct 2025 18:38:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760168289;
	cv=none; b=QwpcsN/S4jqpVM/kC8jSmLMnR3FF5ykUeDA1lbhedIDJ6Eh9nMvCe7ghnsw2hBLR10kFAuydPGXWTfXvWr1nwQyBj17Pb7lRoatlGZxmtnUGl3PCwBJatM/El34T2lnIQ32nKcRMWfk5ONNJ6P1v/DtD6UVAuJdlRgtfsKJVHF5en5EeA+9KSn06Y09o72uVJLIxMeAD1wMUlKrg9q49PcolrU8B2aUL48jDkOrpWdNneQVHVDTHS+NPN5EOe/7E96ax6XNpVRe1CCGmW/hxvlNw2+a4+qY147gDbkiPwHFjHtZmU3Y6eAWpGY56jfBCqioHXx+WlE/q7lSiNIq/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760168289; c=relaxed/relaxed;
	bh=20OGhUCWIqf+Si8Pdzrj06fcmPvDGqe68vHLRNRTdJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=H8IvgRv3MK1/JIJ33OrO0TyfVbvqQNECzVRKToRJYrmrWg5m7AOO/xPzGnuA5cQGj9CsY1/nTgPcbAES6x+C8KcMrbL4OwE78f4mrXQxVVoqOnAVq8AWQVD0Z7XjszSBvg0qgpuo6TXk5NDTBRkD6iwDCuukVgA6TbnAW/XHUaAdILCKvI/Zz3sPa5QWQQ7ZfnzwYcR3SauqpQQX8zYp1t20fPYqNDaXLPWm3iugCwwCwHyhpn7lLnot7l4HQGqf4uzubaLYcfp/JBXqJHRjClaLWtL6A7tRANM2af43c5c4K2238V6dQw2oVmmdhb0VQrJKhlePEdblIQluizrYxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=G0W9eO6Q; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=G0W9eO6Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ckFp65Dk2z2xWc
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Oct 2025 18:38:06 +1100 (AEDT)
Received: from canpmsgout06.his.huawei.com (unknown [172.19.92.157])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ckFhc6tS0z13NnQ
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Oct 2025 15:33:20 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=20OGhUCWIqf+Si8Pdzrj06fcmPvDGqe68vHLRNRTdJg=;
	b=G0W9eO6QYZeTJcsKZJSD1MZHq38DOIH9yvhW4qUDouHz/OdkJUx9ct/JzhfBIrj8hfwLNSC99
	ZauiYmsWA0g0ZvKWgaJf39fphBXK2PbbYWvewoKj2Dljlc4gk91hGP7k5h0WRvSTTGDZainHyNo
	I5xV9pQKx+SDqVruJNJj7SU=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4ckFnW39fMzRhR7;
	Sat, 11 Oct 2025 15:37:35 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F961180064;
	Sat, 11 Oct 2025 15:37:53 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 11 Oct 2025 15:37:52 +0800
Message-ID: <0a7abd75-86d5-4c38-bc25-0d20df8747ff@huawei.com>
Date: Sat, 11 Oct 2025 15:37:55 +0800
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
Subject: Re: [PATCH] erofs: fix crafted invalid cases for encoded extents
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20251011025252.1714898-1-hsiangkao@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251011025252.1714898-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Xiang,

On 2025/10/11 10:52, Gao Xiang wrote:
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
>      then "cur [fffffffffffff000] += bvec.bv_len [0x1000]" in
>      "} while ((cur += bvec.bv_len) < end);" wraps around, causing an
>      out-of-bound access of pcl->compressed_bvecs[] in
>      z_erofs_submit_queue().  EROFS only supports 48‑bit physical
>      addresses (up to 1 EiB), so add a sanity check to enforce this.
> 
> Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
> Reported-by: Robert Morris <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/r/75022.1759355830@localhost
> Closes: https://lore.kernel.org/r/80524.1760131149@localhost
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/zmap.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index e5581dbeb4c2..c346397dc859 100644
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
> +	/* Filesystems beyond 48-bit physical addresses are invalid */
> +	if (unlikely(check_add_overflow(map->m_pa, map->m_plen, &pend) ||
> +		     pend >= BIT_ULL(48)))

Should we consider the non 48-bit block layout which the max is 
BIT_ULL(32) ?

Thanks,
Hongbo

> +		return -EFSCORRUPTED;
>   	return 0;
>   }
>   

