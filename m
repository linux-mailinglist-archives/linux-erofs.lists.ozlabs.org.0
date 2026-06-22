Return-Path: <linux-erofs+bounces-3702-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6AQcE+eyOGohgQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3702-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 05:58:31 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1782F6AC5C9
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 05:58:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=fXXCpTwk;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3702-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3702-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkDvR56Ymz2yVP;
	Mon, 22 Jun 2026 13:58:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782100707;
	cv=none; b=ETrKzzac05YJ9Ld63brp6Stya02ymub7ZDvM/srzq+X6YixZkTHC/T6QJ+tXe8xF3AV3NCtXak7Wai6MKE7QU5oExvBEDQyhaOfx+RlxVJJTDZCo2GaiDRCXYWDu2aVCMbM3Edbr3fnsxI4zE4jOn6r7YWzjvVLt3hCyfvNs9vltxv4MTekh9zmILG1bRzhxfsXUxy+DR1BqtZqUJaP9A/+bmOzJyBIUKp3Ci44UPmzPOnelDmSMIMICEuWj5WaolTpxP9NeDu0viU9trIe13mSXogQCZDIshGZmddaH6F0Qw5XA4FhwRyB/nNKTo00sm5Zi07cwEkW9Dk3HAsEkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782100707; c=relaxed/relaxed;
	bh=DYatlw9mYUQIl6x7eztwURwpwH/TjTI4BjsXzDBqKxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BetP9HvjBx8J6qmeVkMYv0+1awHf7QCG3wl47xgbfJsLY3INjGVisP4lYgJQvTEOjve4w75a3oQNXa+MMzrmbs5mOFql5IAzJwI3UEFctf9g27eMwNWKXn/sWwWTegcrSF7gyegijC9msqZC74ssS9LGCDjyexaRIw7oiNUIFpfMAGPfDFQpYR/D4okP4vGmf1+opsTNZLrMRiRCrVAfzTabpN9u3f09NvLGfBNX2DFLR6/J2Yh8bISqKfUhuDWtWmGyGJrd+c9R8bZLjbw6/eA80aWDe/LoVXreSByMheQWc5M9eLtGXyKYBS8iq1SCn5IA7bP4GZot6YnyrU7s8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fXXCpTwk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkDvN2yxCz2xwH
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 13:58:22 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782100699; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DYatlw9mYUQIl6x7eztwURwpwH/TjTI4BjsXzDBqKxk=;
	b=fXXCpTwkyjb2Yh2t5tVkLNdzQLyLHAUk3pF/VwEnFrOCowoUrPOzFQsVfanO3xnb0Jcne1JbnSVxcbXBuR7D3LoLrCDiWZ3VpKNTqiPb+Lnb2hi/0Xphz3M8DtmGWD73114bMWJO+qVHlxBa/XkXCgPoIlMgw/Vejc04FeFIJzQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X5H6zrb_1782100696;
Received: from 30.221.130.114(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5H6zrb_1782100696 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 11:58:17 +0800
Message-ID: <7f1e369d-f3fe-4aab-976b-29c5e765fca3@linux.alibaba.com>
Date: Mon, 22 Jun 2026 11:58:16 +0800
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
Subject: Re: [RESEND PATCH 2/2] erofs-utils: lib: honor rebuild whiteouts for
 recreated dirs
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: zhukeqian1@huawei.com
References: <20260622034248.1047783-1-zhaoyifan28@huawei.com>
 <20260622034248.1047783-2-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260622034248.1047783-2-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3702-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:zhukeqian1@huawei.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1782F6AC5C9



On 2026/6/22 11:42, Yifan Zhao wrote:
> When rebuilding from upper to lower, a whiteout below an already
> recreated directory should keep that directory but stop older lower
> entries from being merged into it.
> 
> Mark the existing directory opaque before applying the generic
> non-directory bailout.
> 
> Reported-by: cayoub-oai <276123840+cayoub-oai@users.noreply.github.com>

I hope it could be a real email if the reporter
can give us, which helps us to give the exact
credits too..

> Closes: https://github.com/erofs/erofs-utils/issues/49
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   lib/rebuild.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/rebuild.c b/lib/rebuild.c
> index 51dfe18..108a464 100644
> --- a/lib/rebuild.c
> +++ b/lib/rebuild.c
> @@ -401,7 +401,13 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
>   			.nid = ctx->de_nid
>   		};
>   		ret = erofs_read_inode_from_disk(&src);
> -		if (ret || !S_ISDIR(src.i_mode))
> +		if (ret)
> +			goto out;

		if (S_ISDIR(d->inode->i_mode) &&
		    erofs_inode_is_whiteout(&src))

I guess?  If the upper is not a directory, I think
it should be ignored instead?

Thanks,
Gao Xiang

