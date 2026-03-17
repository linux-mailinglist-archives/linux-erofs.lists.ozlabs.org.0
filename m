Return-Path: <linux-erofs+bounces-2785-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oABcOjoSuWmFowEAu9opvQ
	(envelope-from <linux-erofs+bounces-2785-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 09:35:06 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC76A2A5BC6
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 09:35:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZldL4vq5z2yhX;
	Tue, 17 Mar 2026 19:35:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773736502;
	cv=none; b=hKwoAsG8EsDuqbI1Eiy2ASiPHYwF2Zj6BUf+1MSBAbCfL2D7sswvZuzv2hpqR03J0scovY/THZQsvoZh5lChvRBzRSMnI/Xp6swl6ULKxvWYIpe14U2Y0crlzRxoNAbK76lvVklCPsA9M2gSkcT1wecBkXALBL4fuH936JfWtJMlpjcgRb/jIHCzeGWYWrh6GdUgAgGAQWSSI4xB36ITHv8LXm0MH7vWAa9tk/6HiIYtoMD/4A8X00LWt/+PCYNpzi4EVg9MBWC8NISw4kok88Ma0YO8T6hayYHKo7Jb3578z7z73PEnWZ5YWNP0VNKdhr9djilEJUT1cxRj4QFOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773736502; c=relaxed/relaxed;
	bh=+617tVtPG6jh5BqXOqC8LZ7hIA6aLjj2vWeYFpmqH8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=openX9yv9/bNpXoXpptgjV54UAiH0Sb2rYfqPK+dnHY8sTfoxon/ntlClkywrF+RGybvDyojP/JqnGaddJhk+NjjIenel4EtpOyeVtx5kW8YT5b4QjZ2ToZKhRc+xMsfnrD6M+pvzcdSbb1BVPX65D/UdBKYz4455urmkYHdU6BQ2SUBAFa15HZi5UwaZgSwSiWZ5mUt6W91xwVJlFeXSE6hrBQpXuZrhp735s14QkY0KPaOAYj3W7uvm3AsFus6OA706i/SltpB8iUezrtOx9O0DFEGTZflHfhefy7El+1sIPIxUjpKLjNMK3sbjO13mg0DlZx8XqjIh8CLvx+TvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xCXWjie2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xCXWjie2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZldH4YXmz2xb3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 19:34:58 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773736491; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+617tVtPG6jh5BqXOqC8LZ7hIA6aLjj2vWeYFpmqH8s=;
	b=xCXWjie2Kssr1BVXqPvraa0wj77V6wZsVJVgO9xyidXCK9ELdtU2VXamb5372vREfLI/4NXl8dk5bl4hfe0vVaWdIiQytn7/3+iwsonOREGUTOrG/NQxq+PlLlE6lFrArS8o/edXEqmmGJTP0ZoSTvLMMh6E0AfkzPrrPisXxaU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.APKiS_1773736489;
Received: from 30.221.133.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.APKiS_1773736489 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 16:34:50 +0800
Message-ID: <09e4e9bf-e214-4b40-8d2f-44596fd7c8e8@linux.alibaba.com>
Date: Tue, 17 Mar 2026 16:34:49 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: validate z_extents against inode size
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: yifan.yfzhao@foxmail.com
References: <20260317082115.34389-1-singhutkal015@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260317082115.34389-1-singhutkal015@gmail.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2785-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:yifan.yfzhao@foxmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[foxmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: AC76A2A5BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/17 16:21, Utkal Singh wrote:
> z_extents is read from on-disk metadata and used as the upper bound
> for extent lookups in z_erofs_map_blocks_ext().  A corrupted value
> can be arbitrarily large (up to 2^48-1), causing erofs_read_metabuf()
> to access offsets far beyond the actual extent table.  The resulting
> garbage is parsed as z_erofs_extent records, leading to wrong physical
> addresses used for I/O, silent data corruption, or crashes.

No, I don't think it needs to be fixed since it won't cause any
harmful behavior if the image is already corrupted.

Please don't submit any patches like this if you don't have any
reproducer and i_size is too long can cause overly long time,
but the image can be valid.


> 
> Since each extent covers at least one logical cluster, the extent
> count cannot exceed DIV_ROUND_UP(i_size, 1 << z_lclusterbits).
> Validate z_extents against this bound at inode initialization time
> and reject invalid values with -EFSCORRUPTED.
> 
> Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
> ---
>   lib/zmap.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 0e7af4e..2f679b7 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -675,8 +675,26 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
>   	vi->z_lclusterbits = sbi->blkszbits + (h->h_clusterbits & 15);
>   	if (vi->datalayout == EROFS_INODE_COMPRESSED_FULL &&
>   	    (vi->z_advise & Z_EROFS_ADVISE_EXTENTS)) {
> +		u64 max_extents;
> +
>   		vi->z_extents = le32_to_cpu(h->h_extents_lo) |
>   			((u64)le16_to_cpu(h->h_extents_hi) << 32);
> +
> +		/*
> +		 * Each extent covers at least one logical cluster, so
> +		 * the extent count must not exceed the number of lclusters.
> +		 * Reject bogus values to prevent out-of-bounds metadata
> +		 * reads in z_erofs_map_blocks_ext().
> +		 */
> +		max_extents = DIV_ROUND_UP(vi->i_size,
> +					   1ULL << vi->z_lclusterbits);

extents can be within 1ULL << vi->z_lclusterbits instead,
I don't think it's valid.

`up to 2^48-1 extents` is fine and valid, the users can
always interrupt this at any time.

Thanks,
Gao Xiang

> +		if (vi->z_extents > max_extents) {
> +			erofs_err("bogus z_extents %llu (max %llu) for nid %llu",
> +				  vi->z_extents | 0ULL, max_extents | 0ULL,
> +				  vi->nid | 0ULL);
> +			err = -EFSCORRUPTED;
> +			goto out_put_metabuf;
> +		}
>   		goto done;
>   	}
>   	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;


