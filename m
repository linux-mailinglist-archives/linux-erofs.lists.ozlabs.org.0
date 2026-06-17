Return-Path: <linux-erofs+bounces-3658-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T6hiM/UYMmpIuwUAu9opvQ
	(envelope-from <linux-erofs+bounces-3658-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jun 2026 05:48:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0005769656D
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jun 2026 05:48:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=xz2EQtVo;
	dkim=pass header.d=huawei.com header.s=dkim header.b=xz2EQtVo;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3658-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3658-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gg8vf3S1Bz3c7S;
	Wed, 17 Jun 2026 13:47:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781668078;
	cv=none; b=E3aNFB9UtCBJEQoTr+p/3RArf2MyTck6neJIkUFDk9KTe0h4ptPJ/2yYMhO9oQ7SkfvySCWRhushgUAVDuOMkhTA9asy6POg2JqqJGfUn+3NnGp2MUX7FnGEiXK+swUe8jFcXzBIdVilq51+7Yq3FohEGlUqUNWdncP05m+cDt04CvQtF8rwHwhJUwPSIZNUNepaIbAvCWjsfiyEM3mcNILHfsUr+gBQuRfU6sW22KMYsJUtK/amiQqdu1UMHzfSRsToMEQ1o2AnVWcbhGXgqfz+4Z09KEXeBLYhrsbnQarV1ibudu3qa9/Mm/EjxesKrfCNlKLQo35GDhiBpgrHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781668078; c=relaxed/relaxed;
	bh=U7QW899xrUiPp2kje476C2GXZU1N3b4zG+ActFFibQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O9i5k+cPRKzexuvmJ9RVQnw5YZVRTX5rCyWBwzFDbA86ELfgiJ4A4Y2CcsGgYDLOLuqU1ytmXoWxfzkSHeyvW5Ba/pRV9RF85FONy3lAjFojsW3JuVjX3LzBUqowBiCWsHFb7Y+6veCcUXbwoBCNVOsKVLSpkl5AVhoqMvqZqLCrOVzQxD1bOoq1HMN7kRWUowVwz7iHHaeBSdNXjON/IUIF+8U79pPMqA5Oj0ccfGrmJBYQPNm8djQYA83NkyDoLPrCUkso4LnkOWE0WcnG6Zns6oq9XnPlh15U+Waug5uW1ieI3YmRyWoRGk/qR/jHxctHcbbWJ7TBopwEh5QuGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xz2EQtVo; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xz2EQtVo; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gg8vb5HCjz2yv0
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 13:47:55 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=U7QW899xrUiPp2kje476C2GXZU1N3b4zG+ActFFibQM=;
	b=xz2EQtVoyl/b5/Qc0S1EMYffoxS6vfASsC6hoFMA6kN0TcQZ5kvSUwWVwkjjIrnJyiGsAdgLu
	vwOTpXFFKnX4sb1qfGyvNf05VaGHq8leU30giULdpVdzBNYQnvULemioRZv7tfE19yTPI+1NNAn
	SNvJx55Bmv6pooUJVN1iJ8k=
Received: from canpmsgout02.his.huawei.com (unknown [172.19.92.185])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gg8tz5gGmz1BG4k
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 11:47:23 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=U7QW899xrUiPp2kje476C2GXZU1N3b4zG+ActFFibQM=;
	b=xz2EQtVoyl/b5/Qc0S1EMYffoxS6vfASsC6hoFMA6kN0TcQZ5kvSUwWVwkjjIrnJyiGsAdgLu
	vwOTpXFFKnX4sb1qfGyvNf05VaGHq8leU30giULdpVdzBNYQnvULemioRZv7tfE19yTPI+1NNAn
	SNvJx55Bmv6pooUJVN1iJ8k=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gg8jf02NGzcbPb;
	Wed, 17 Jun 2026 11:39:18 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EA7840571;
	Wed, 17 Jun 2026 11:47:42 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jun 2026 11:47:41 +0800
Message-ID: <c7d104d8-5adc-433f-bfb9-a084fa904ca6@huawei.com>
Date: Wed, 17 Jun 2026 11:47:41 +0800
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
Subject: Re: [PATCH] erofs: call erofs_exit_ishare() before rcu_barrier()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <oliver.yang@linux.alibaba.com>
References: <20260617031459.3980804-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20260617031459.3980804-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3658-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:oliver.yang@linux.alibaba.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0005769656D



On 2026/6/17 11:14, Gao Xiang wrote:
> Ensure all inode free callbacks have completed before
> destroying the inode slab cache.
> 
> Fixes: 5ef3208e3be5 ("erofs: introduce the page cache share feature")
> Cc: Hongbo Li <lihongbo22@huawei.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   fs/erofs/super.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 802add6652fd..579443e6acfe 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -1048,11 +1048,11 @@ static int __init erofs_module_init(void)
>   static void __exit erofs_module_exit(void)
>   {
>   	unregister_filesystem(&erofs_fs_type);
> +	erofs_exit_ishare();
>   
> -	/* Ensure all RCU free inodes / pclusters are safe to be destroyed. */
> +	/* ensure all delayed rcu free inodes & pclusters are flushed */
>   	rcu_barrier();
>   
> -	erofs_exit_ishare();
>   	erofs_exit_sysfs();
>   	z_erofs_exit_subsystem();
>   	erofs_exit_shrinker();

