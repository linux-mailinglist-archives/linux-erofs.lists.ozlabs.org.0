Return-Path: <linux-erofs+bounces-3109-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APqYOukqymmQ5wUAu9opvQ
	(envelope-from <linux-erofs+bounces-3109-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 09:48:57 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E28356A17
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 09:48:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkk062st0z2xpt;
	Mon, 30 Mar 2026 18:48:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774856934;
	cv=none; b=Wick8ShjNPVzxdeYoqSfRd0x8aofaFO902wrn2ymiN5OL5jPFuBG4AcGtSVNnsPgjhxpwCo7V+ZBQs3bVFuVzy1fKwJwHyWI9Jct4Tfk0+qJa47hUZwnYFoubh4C6vQnVg95mvpAwfPCeEi9nyN7kQRFANLlZtpWcF1aJs8tCifr73jRYwWsLYiw1cdi+3f/lXOlj2X7i5+t2bQQTzHemc+ib/bkAUIhx+Mt7kuUAXauYxuePvG1HnBpRwNMEdk2AFjOsjeZxkag1PUkHxat2UGY+hVQ8Gcn6kVmQHbOlkiCKMMAIGlRrmBGrS2Xwb+nfa7at4t4VAW4aaAdL+Ceqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774856934; c=relaxed/relaxed;
	bh=zLbmgTLuJOvxWetia92ZsU58nUqs1JPA8nLWA2cX/8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YDgjhH8ofuNxyXxEO5pt1p2zJ73t2alnVzYtJxpG5KJ7Jnd5i4nVOCXsI16PIZBVuR+5RU9R9iFAqeUpX4nEt7foci5IIulk2YNM01qqNv91zE+wSfGzyh2gfCCg1+m6NgG8Ia8ntxImQXi+wmi9o2VGR0k0uAYacxMtWlrUwonyJu7LgjXYelZ4ZK7vFXje0QFqFXvJuQwRKWpmJVzEZyPXiMuYOvyPy+vu/zqSHoRpeobluYzgUTiqxtnJ4sX80npPD4C8YFH0/dadK/0xd99bdl07afsFnZbZ9r8c4yTztVZf+fl0kHKM5t4tNSdHI9f9ejG4eD5n98KUdO4oNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WQgXKaQv; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WQgXKaQv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkk044LWHz2xlK
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 18:48:52 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zLbmgTLuJOvxWetia92ZsU58nUqs1JPA8nLWA2cX/8I=;
	b=WQgXKaQvRCiKUqvFQ39Sf5/yeQHCoimzXjZRKVp5aeoBbSiMA+sRzbCBGTGqlzEuOvC4YyAhd
	PSHbtBu5iBLdZU22MWAogUU+F6SDZseabF3Z9a8c28v49moqLieIhuheIKThRqs0Sb/nRFwMa6l
	JGG3MmUL2t6QPROifK4n1GQ=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fkjrw6YNKz1cyPj;
	Mon, 30 Mar 2026 15:42:40 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id A7C9440563;
	Mon, 30 Mar 2026 15:48:48 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Mar 2026 15:48:48 +0800
Message-ID: <275a0a1e-7d83-449d-87de-355c2e1e0918@huawei.com>
Date: Mon, 30 Mar 2026 15:48:47 +0800
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
Subject: Re: [PATCH v1] erofs: remove the guard of showing domain_id and fsid
Content-Language: en-US
To: Yuezhang Mo <Yuezhang.Mo@sony.com>, <linux-erofs@lists.ozlabs.org>
CC: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu
	<zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
	<dhavale@google.com>, Chunhai Guo <guochunhai@vivo.com>, Friendy Su
	<friendy.su@sony.com>, Daniel Palmer <daniel.palmer@sony.com>
References: <20260330073235.3328579-2-Yuezhang.Mo@sony.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20260330073235.3328579-2-Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,vivo.com,sony.com];
	TAGGED_FROM(0.00)[bounces-3109-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Yuezhang.Mo@sony.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:guochunhai@vivo.com,m:friendy.su@sony.com,m:daniel.palmer@sony.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,huawei.com:dkim,huawei.com:mid,sony.com:email]
X-Rspamd-Queue-Id: B7E28356A17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yuezhang

On 2026/3/30 15:32, Yuezhang Mo wrote:
> This change fixes an issue where domain_id was not shown when
> CONFIG_EROFS_FS_PAGE_CACHE_SHARE is enabled, as this configuration
> is mutually exclusive with CONFIG_EROFS_FS_ONDEMAND.
> 
> Both domain_id and fsid fields are present in struct erofs_sb_info
> regardless of configuration. They are not set if the configurations
> are not enabled, and remain NULL. Therefore, the conditional guard
> in erofs_show_options() are unnecessary and can be removed.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
> ---
>   fs/erofs/super.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 972a0c82198d..be028cdf902c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -1095,12 +1095,10 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   		seq_puts(seq, ",dax=never");
>   	if (erofs_is_fileio_mode(sbi) && test_opt(opt, DIRECT_IO))
>   		seq_puts(seq, ",directio");
> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND)) {
> -		if (sbi->fsid)
> -			seq_printf(seq, ",fsid=%s", sbi->fsid);
> -		if (sbi->domain_id)
> -			seq_printf(seq, ",domain_id=%s", sbi->domain_id);
> -	}
> +	if (sbi->fsid)
> +		seq_printf(seq, ",fsid=%s", sbi->fsid);
> +	if (sbi->domain_id)
> +		seq_printf(seq, ",domain_id=%s", sbi->domain_id);

The domain_id in CONFIG_EROFS_FS_PAGE_CACHE_SHARE case means the trusted 
domain. We cannot show it to user.

Thanks,
Hongbo

>   	if (sbi->dif0.fsoff)
>   		seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
>   	if (test_opt(opt, INODE_SHARE))

