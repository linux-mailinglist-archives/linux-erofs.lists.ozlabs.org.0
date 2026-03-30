Return-Path: <linux-erofs+bounces-3108-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB3GFJYqymnX5gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3108-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 09:47:34 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623C13569EA
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 09:47:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkjyV2mlyz2xpt;
	Mon, 30 Mar 2026 18:47:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774856850;
	cv=none; b=MOgzxbdln9/R9/eDFTpIwFyAUQGS0SE8Zd341bfkChm8NGHi2n3YfDnNH05TPMZOJdNq+iatut325G45woNFar2ByMZZlKTwlCuoLFnPkrV9IiHtU9laWgZwMmULU9eKCER1mTakJboZaMNoPNcxZykpPdI1BtMZb5bMuUECDRW6n3+iRBYaBW9SOw2JkZp6lXbXoLSba2zi/non67cEaY/xUdoFjTxbkpB7SokdN6++6VThXBBW5mp5ffkuFQ6thr7CHS6SI9H9ukLZ5hq7b/2AyPiuFjHtQrcGCcXAb90CdLSxTpLp5imcK6RnKKNyNrCinIMzUHgfEX2v76nGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774856850; c=relaxed/relaxed;
	bh=s+PX6W5DVFgyIkA2yzyjNJNcTYqCzfscgZNN2GdHO6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWb0pwOC5PjV0ZPR8/3zOh4Hb9KvF8oqsggulAWWzW/TurCMuyM5H+5GiqTtHHA/xjcoxpu069jtts/Fx5X2UkftmsTRYgxbGDorwHPZ2XJj+Cc4YIMGEt0RFJ0Gumeh9RJFlaJQz5+4wqN/MxtAq3fcxAjDUL/sqVQ0xGEjvVxO9OviXo/ItaTg0mTuBk7tFGGONbV5pSeudXWEkpCO3Fx/y5tFtJyuSM/ZNuCpDvxKQCZiQYhYLevvMXMmnkT46LfUHs8A0MYth6OuE/PDHGfei9Wj7orSxE0kc+qu5DrdQztQdMpo5utXQ+3konDczIfGz4sNePgc1wkAvZbSCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F6YLhD1Q; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F6YLhD1Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkjyR5bMxz2xlK
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 18:47:26 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774856841; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=s+PX6W5DVFgyIkA2yzyjNJNcTYqCzfscgZNN2GdHO6w=;
	b=F6YLhD1QF9CwIg+ETdnsuSmS5ZN87xoaPLYF0LwMJeZbuMVByIx2TPyQFk9Y8fg2lBTsSc3EJ843wZLmjhXNMD3RdoM+643XnPSxMscVp4kZfLLNyaeWzBfZDu93szwUJxV9IkesBZfyz43HTcX3nUWQm8Mv85zK/myi8PDCDJM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X.wSq8H_1774856838;
Received: from 30.221.131.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.wSq8H_1774856838 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Mar 2026 15:47:19 +0800
Message-ID: <bc6ac6ae-ef88-4ff9-96ff-3395f84ce4ef@linux.alibaba.com>
Date: Mon, 30 Mar 2026 15:47:18 +0800
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
To: Yuezhang Mo <Yuezhang.Mo@sony.com>, linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, Friendy Su <friendy.su@sony.com>,
 Daniel Palmer <daniel.palmer@sony.com>
References: <20260330073235.3328579-2-Yuezhang.Mo@sony.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260330073235.3328579-2-Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3108-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Yuezhang.Mo@sony.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:friendy.su@sony.com,m:daniel.palmer@sony.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,sony.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 623C13569EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yuezhang,

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

`domain_id` is a user-sensitive information for the page cache
sharing feature (much like passwd), so it shouldn't be shown
in the mount option by design, and only the mounter should
know what it was set.

Thanks,
Gao Xiang

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
>   	if (sbi->dif0.fsoff)
>   		seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
>   	if (test_opt(opt, INODE_SHARE))


