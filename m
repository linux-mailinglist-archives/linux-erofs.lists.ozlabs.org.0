Return-Path: <linux-erofs+bounces-3858-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lSmqMMfuTWoeAQIAu9opvQ
	(envelope-from <linux-erofs+bounces-3858-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 08:31:35 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAF4722316
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 08:31:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b="AV/oEb6m";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3858-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3858-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw7Xg1qkjz2xll;
	Wed, 08 Jul 2026 16:31:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783492291;
	cv=none; b=T29/R0xrTLOIFWX9fRTkeyUA/mx6Qz0aNmffrtpw2xc+vV6+kNRZlrnMrG3rpWlniQKa133sDr2tqdDd+K7FepFYqmMWrcJcjMVGD1NbzxXm9BiVpTfuomrnynOljMBeGhG+Ejl9Z8orBkF5J02YpSaIZ9jV9gIQZWnktolYynBi/lebyPWm2mqecxPb3uqFc0pOIKfS9cy2jb+txPfAdwoyqBJBLXrEHVqxRb45j5QFqGQWpqcKLUN1rAqA3labO+xdxfo+MOXNdFWOm2t+Sm3+8uzIaWFM8vGvC1vzJeLMVaX1dM4edyWOq4d7j4OYy5I0wD5RJebSiSVMEBbocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783492291; c=relaxed/relaxed;
	bh=icNO0ujdC8rwAR01AkwzEwiJl1sGeqp3GCQX4eaMYs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nL360NWLyPticBGFuHIKexjOOjATvi3oIodVrpDvmuhLQhSZuo9Gs2fSKQ/tabWLnWKYMt+XltT5Qu0oi0t2YNnKU3Tm3HIa9DuwhvNUjoH6G3XXTkZjnXMsc3yq88p65xTt1ms4d0Y6TV58GzjDtFIgJT4Eq8xxlB9OXYZMIuT27qAHi58z+k89E6FPHQ9gBI6HvCHYIgqICuPe3JNTTkSp8fZSlXaxSG4hNdm8c+KIUu3K+FLFIeDGRJBebhqvtDV0Ezbk/pdd9eGgLG1JSL8PnjXx7E2VmcFxvme9Ru6b0ospcgcT4W1YdpGcvZTvfW8gYWYWwG81B1fbaISJ+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AV/oEb6m; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw7Xc5vMNz2xKh
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Jul 2026 16:31:26 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=icNO0ujdC8rwAR01AkwzEwiJl1sGeqp3GCQX4eaMYs8=;
	b=AV/oEb6mWYn6tlABODgoB5iDCO9V8l9uEDKLjImPcSNGMxVx4PTVbNQvWkoOrglgNR9htTahj
	0h58jvAKNgrSEIqxuU/ZKLmLs75sS7mOp2TF1iTo1nUUxxCHNb4tv6ZvY0kRDVTQinP/cOTblrX
	1lcFnPandPGeEu4GQNb+GfE=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gw7Kl1rJGzmVZr;
	Wed,  8 Jul 2026 14:22:03 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 6424C40565;
	Wed,  8 Jul 2026 14:31:17 +0800 (CST)
Received: from [100.102.28.251] (100.102.28.251) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 8 Jul 2026 14:31:16 +0800
Message-ID: <59ac7e7d-a27b-4260-8213-9daeca689f50@huawei.com>
Date: Wed, 8 Jul 2026 14:31:16 +0800
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
Subject: Re: [PATCH v2] erofs: relax sanity check for tail pclusters due to
 ztailpacking
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: Alberto Salvia Novella <es20490446e@gmail.com>
References: <20260707132152.1176967-1-hsiangkao@linux.alibaba.com>
 <20260708031845.2300538-1-hsiangkao@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20260708031845.2300538-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.102.28.251]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3858-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:es20490446e@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:from_mime,huawei.com:email,huawei.com:mid,huawei.com:dkim,lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DAF4722316

Tested-by: Yifan Zhao <zhaoyifan28@huawei.com>

On 2026/7/8 11:18, Gao Xiang wrote:
> If the tail data can be inlined into the inode meta block, it should
> be converted into a regular tail pcluster.
>
> In principle, it should be converted into an uncompressed pcluster if
> there is not enough gain to use compression (map->m_llen < map->m_plen);
> but since there are various shipped images, relax the condition for
> ztailpacking tail pcluster fallback instead of reporting corruption
> incorrectly.
>
> Reported-by: Yifan Zhao <zhaoyifan28@huawei.com>
> Reported-by: Alberto Salvia Novella <es20490446e@gmail.com>
> Closes: https://github.com/erofs/erofs-utils/issues/51
> Fixes: a5242d37c83a ("erofs: error out obviously illegal extents in advance")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2:
>   - Drop ztailpacking sb feature check since it might not be set for
>     single-file ztailpacking fallback images.
>
>   fs/erofs/zmap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index bab521613552..5811556a7b71 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -732,7 +732,8 @@ static int z_erofs_map_sanity_check(struct inode *inode,
>   				  map->m_algorithmformat, EROFS_I(inode)->nid);
>   			return -EFSCORRUPTED;
>   		}
> -		if (EROFS_MAP_FULL(map->m_flags) && map->m_llen < map->m_plen) {
> +		if (EROFS_MAP_FULL(map->m_flags) && map->m_llen < map->m_plen &&
> +		    map->m_la + map->m_llen < inode->i_size) {
>   			erofs_err(inode->i_sb, "too much compressed data @ la %llu of nid %llu",
>   				  map->m_la, EROFS_I(inode)->nid);
>   			return -EFSCORRUPTED;

