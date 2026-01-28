Return-Path: <linux-erofs+bounces-2228-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ms1C8W3eWlHygEAu9opvQ
	(envelope-from <linux-erofs+bounces-2228-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 08:16:21 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97CA9DA3E
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 08:16:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1D8d30Txz2xT6;
	Wed, 28 Jan 2026 18:16:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769584577;
	cv=none; b=Fo26mF6r+CYIAN/2OFHhPvv8SMQ/PTqqpAaTDvbEs+bLyfLNuBFBhmm0dRq5J5wHbtL17lvMkYFox6pKx1H8N6mQ1QGFi4BqyFlJb2vOPNk6XAeuHBZW1CMq9KNqSc5o2Yak8XbjSy4Zku4xT30wpBLE495wHUMCXc9Gt/ZYBfmGx7jFLMPd1DfaNqWkjnSf3Xc+Tk3i/jF5bSARylZQZ1+w+J/R8HD9d7Vuk9If5Zs9YlIPByB3RGY5bp8qPvcq98/kdAVv5uNyerNNDYqFYdd1NpxbAIQSRrpP1+FidJKcCy7xz0XrOmzrs8x3axBzFtFkLOuEzOfMODl/3/7N7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769584577; c=relaxed/relaxed;
	bh=2agBpk5Okek288d3EdZ60BSPzu1QRxP0bRarNzWNgaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fTGQtqto5Gh/IDG+OdnSLwOxdilN9SUNIyA9o+n/1n8uMlg2MKkr2E227XYD1HN3THUPhaCXtiRZMfhIzJ9Y94Lyv/ywjiJxYHRctuRWY7sZ+Hd9hHskpnkv80uCC5yckt6OYA/LsGzYid0+Be63HUkEyxw+ydnqXsZVx0X4mghPTdejeKliQj9YJILPFe8QuiHQYB5lLXa2kmkAhFZMFk9pWnBQk9pXjkKWoJyTGvtJ4NR3n2EuJRIFvNtzp5RseDcU6a7/oenLm5GSF/tlQ6NghrXqHB1a/iB/tP1FrUBa6j4XOOUsCC7prajeGqCspGajryIEvBBfC08Hc4aw+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KaPrcUYl; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KaPrcUYl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1D8b3XF3z2xHt
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jan 2026 18:16:14 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2agBpk5Okek288d3EdZ60BSPzu1QRxP0bRarNzWNgaY=;
	b=KaPrcUYlUbBKV+SO7DO7QuAd9+joIp6bdipxeBjZ57kIipCNYTKKfXTiTitBuYkhz9OShkmW7
	X3OuI2PquibzU5I1YvioXIrhCLC/6XZpLXu4ZkI08PsPLLRzEHA4Lf+mcbS+KMEFR8GY4dgB748
	g6EJJBoSraJA6SftIxQqNYs=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4f1D4R4mPsz1prkq
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jan 2026 15:12:39 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 7673240538
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jan 2026 15:16:09 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Jan 2026 15:16:09 +0800
Message-ID: <d7a858e2-ea0e-443a-8ac6-f1edcbf50030@huawei.com>
Date: Wed, 28 Jan 2026 15:16:08 +0800
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
Subject: Re: [PATCH] erofs: use inode_set_cached_link()
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20260128045854.2266287-1-hsiangkao@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20260128045854.2266287-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2228-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_XOIP(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: C97CA9DA3E
X-Rspamd-Action: no action



On 2026/1/28 12:58, Gao Xiang wrote:
> Symlink lengths are now cached in in-memory inodes directly so that
> readlink can be sped up.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   fs/erofs/inode.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 2e02d4b466ce..6afe487eb9be 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -8,21 +8,23 @@
>   #include <linux/compat.h>
>   #include <trace/events/erofs.h>
>   
> -static int erofs_fill_symlink(struct inode *inode, void *kaddr,
> -			      unsigned int m_pofs)
> +static int erofs_fill_symlink(struct inode *inode, void *bptr, unsigned int ofs)
>   {
>   	struct erofs_inode *vi = EROFS_I(inode);
> -	loff_t off;
> -
> -	m_pofs += vi->xattr_isize;
> -	/* check if it cannot be handled with fast symlink scheme */
> -	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
> -	    check_add_overflow(m_pofs, inode->i_size, &off) ||
> -	    off > i_blocksize(inode))
> -		return 0;
> -
> -	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> -	return inode->i_link ? 0 : -ENOMEM;
> +	char *link;
> +	loff_t end;
> +
> +	ofs += vi->xattr_isize;
> +	/* check whether the symlink data is small enough to be inlined */
> +	if (vi->datalayout == EROFS_INODE_FLAT_INLINE &&
> +	    !check_add_overflow(ofs, inode->i_size, &end) &&
> +	    end <= i_blocksize(inode)) {
> +		link = kmemdup_nul(bptr + ofs, inode->i_size, GFP_KERNEL);
> +		if (!link)
> +			return -ENOMEM;
> +		inode_set_cached_link(inode, link, inode->i_size);
> +	}
> +	return 0;
>   }
>   
>   static int erofs_read_inode(struct inode *inode)

