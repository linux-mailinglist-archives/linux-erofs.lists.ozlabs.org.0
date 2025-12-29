Return-Path: <linux-erofs+bounces-1637-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C046CE6D3C
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 14:08:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dfxNX21tLz2xgv;
	Tue, 30 Dec 2025 00:08:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767013692;
	cv=none; b=Niwhq6UyC6voATjnla5Fjz+rDscn3F43kOF2+7+VHl3SJ0CDh/tXn1hXo3QLr3w+OH2nQXzVg7VQHj/tnTYBYPghWIt+Kl4/QPzEP+rXrYI2dfilE3FPoodd1B/QXb9N6FIIYywxuZD9uWuWlLLavimjpPFdXinpsHS/kvN4rJ+1BvE5phWpwboEYtIFo6d6Yg86xiZCAGqB8XiXch4z/EP3Dfe+ZJZ8FV9bxsf/YiP9aufc5yVPwVuNhs1nhFP0kgbqJQa+34uRbzVYvOAcOEmOU66mHop3OzAnB4xaMBLOGWI8J0cN7E6SH0e5WGTC3C8AYKN2ZiHoKMFAhCmaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767013692; c=relaxed/relaxed;
	bh=wVtBJnLYAyYs2nBgvigjl22s3/CqX4Ze4GPAjHi8i2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HaYNipsMHNnKQXBuXrX2G6Pt1g3K1HT/d2umQSfBW9tl/lmobm6Xh9rUQHYcpEp/3o9cnAau2K8mm1Sj71PqNDJOzU6Xb3RyvY7yCME0lD2r1BYOdV2IwzF3Va6CVV1U1ywRmWF54DkygheVq5okKz1kYNt7nZLVS0TbNVkbB/+/b5EqOfUey5qoiK3XWgDHUp80hPHm7c9i7kzKxOHsA/Vom2WGeSOiCPMgB3LOofq/rgENCcgLqAV4rnAosgw8UAQZBfjNMRZpvRYk6uSGzssZWNwUBXceCGI3ZwtPKoMq5n8N8Ffan9z6cM+uj7X8QW+8GUHPM/oum+d8L+vKzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=iwscrRra; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=iwscrRra;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dfxNW2dRJz2xdV
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 00:08:11 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wVtBJnLYAyYs2nBgvigjl22s3/CqX4Ze4GPAjHi8i2c=;
	b=iwscrRram2tBFVgPs3ctyobaNDXGo8pBKEaVIYQn0e9dQZlk6Qk3050+Vtk6asujZbVOHieNv
	hnqB22ljDRafANipxH3KcEpbt1LWyrdQGF8ZXrCtnKVRKsEMRwgmg+HcrEZGH9mUNdp1N3xnj79
	4YJJe6W/TMMSqjUizy8tWvc=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dfxJn533Gz12Lct
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 21:04:57 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AEC84056A
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 21:08:07 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Dec 2025 21:08:06 +0800
Message-ID: <00d1615e-fe89-4637-8a15-0af816140773@huawei.com>
Date: Mon, 29 Dec 2025 21:08:05 +0800
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
Subject: Re: [PATCH 1/4] erofs: fix incorrect early exits for invalid
 metabox-enabled images
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20251229092949.2316075-1-hsiangkao@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251229092949.2316075-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/29 17:29, Gao Xiang wrote:
> Crafted EROFS images with metadata compression enabled can trigger
> incorrect early returns, leading to folio reference leaks.
> 
> However, this does not cause system crashes or other severe issues.
> 
> Fixes: 414091322c63 ("erofs: implement metadata compression")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   fs/erofs/super.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..2e4d0ea2ffa1 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -330,12 +330,13 @@ static int erofs_read_superblock(struct super_block *sb)
>   	}
>   	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
>   	if (erofs_sb_has_metabox(sbi)) {
> +		ret = -EFSCORRUPTED;
>   		if (sbi->sb_size <= offsetof(struct erofs_super_block,
>   					     metabox_nid))
> -			return -EFSCORRUPTED;
> +			goto out;
>   		sbi->metabox_nid = le64_to_cpu(dsb->metabox_nid);
>   		if (sbi->metabox_nid & BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT))
> -			return -EFSCORRUPTED;	/* self-loop detection */
> +			goto out;		/* self-loop detection */
>   	}
>   	sbi->inos = le64_to_cpu(dsb->inos);
>   

