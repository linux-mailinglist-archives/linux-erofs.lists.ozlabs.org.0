Return-Path: <linux-erofs+bounces-1036-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34674B597E8
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Sep 2025 15:40:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cR32J39f0z2ySY;
	Tue, 16 Sep 2025 23:40:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.32
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758030056;
	cv=none; b=ABst5gUFy/4cSFr5SYHoo0Ug8BdUuulRWv4cSKdTFwSQgBB1mOWOIX8f8I+CRF6kUfD/28eqwgq53n+lQZ7pifPZCPEEPQ33+iT66ywe3g6LCqkZkJDikY9sAGeE4HqC8q9C7XrJ4YpKwhwWrC9DVbczIKdzgBEw6i9R3EBSNd8OUC4zSJ+e1dPaj/WNr853jYdfQVBC7rkl5OSClA69AtlSlJDil2rfWj8AQTjCD3utPXlVxVHjQx1H7Pbw83xRuUaLn+sLr+5VdiuG/MYzSAbAbCm4PLKIHsMajR/5xlKKgSfcFv1jeU3MDEnG6Dx1gIFYoRq9mnppLO/sUiocLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758030056; c=relaxed/relaxed;
	bh=09YDwNpJc9lVwLF+5Hr8LZpRzPaWFEQrT6Wt9Ruqihs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YpU1dvxc3g6QGb+gavwMoEwHg7sp8v/RhwL8P88OSDpVdZB12He9dSu0EuSE25UCwuB89z9pQs/uQXjJ7YFDsPkZ2MXhgSCwHm6X8VPwy0saNwsVb/8dwGshivy8Qeg8RT6exF36R6a5vVanXFy7kMXuJdEDetZ8peJgeuGZL8bQN4R4oNZoVlXKT32LqqbhtNdbghohimTUIRIyPZWMza4CUpXc5n5o+EQF+8mXmiATJpd6e6pWc819PSizg0CCVUUqyxcQSE3xiuoZ1uz+KrgnMSJ0SuFGvEMso0qHjUCC1xrTAzTUHhfifRjNqpnfGXbFHIqd8ijCv+IK6bIdkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1066 seconds by postgrey-1.37 at boromir; Tue, 16 Sep 2025 23:40:54 AEST
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cR32G6Tzsz2yPS
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Sep 2025 23:40:53 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cR2g02MhFz27jJQ
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Sep 2025 21:24:12 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A82A1400DC
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Sep 2025 21:23:02 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Sep 2025 21:23:01 +0800
Message-ID: <2041918e-5f43-49e0-bde9-84e89b9d8b7e@huawei.com>
Date: Tue, 16 Sep 2025 21:23:01 +0800
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
Subject: Re: [PATCH] erofs: avoid reading more for fragment maps
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <68c8583d.050a0220.2ff435.03a3.GAE@google.com>
 <20250916084851.1759111-1-hsiangkao@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250916084851.1759111-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/16 16:48, Gao Xiang wrote:
> Since all real encoded extents (directly handled by the decompression
> subsystem) have a sane, limited maximum decoded length
> (Z_EROFS_PCLUSTER_MAX_DSIZE), and the read‑more policy is only applied
> if needed.
> 
> However, it makes no sense to read more for non‑encoded maps, such as
> fragment extents, since such extents can be huge (up to i_size) and
> there is no benefit to reading more at this layer.
> 
> For normal images, it does not really matter, but for crafted images
> generated by syzbot, excessively large fragment extents can cause
> read‑more to run for an overly long time.
> 
> Reported-by: syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/68c8583d.050a0220.2ff435.03a3.GAE@google.com
> Fixes: b44686c8391b ("erofs: fix large fragment handling")
> Fixes: b15b2e307c3a ("erofs: support on-disk compressed fragments data")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

>   fs/erofs/zdata.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 2d73297003d2..625b8ae8f67f 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1835,7 +1835,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
>   		map->m_la = end;
>   		err = z_erofs_map_blocks_iter(inode, map,
>   					      EROFS_GET_BLOCKS_READMORE);
> -		if (err)
> +		if (err || !(map->m_flags & EROFS_MAP_ENCODED))
>   			return;
>   
>   		/* expand ra for the trailing edge if readahead */
> @@ -1847,7 +1847,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
>   		end = round_up(end, PAGE_SIZE);
>   	} else {
>   		end = round_up(map->m_la, PAGE_SIZE);
> -		if (!map->m_llen)
> +		if (!(map->m_flags & EROFS_MAP_ENCODED) || !map->m_llen)
>   			return;
>   	}
>   

