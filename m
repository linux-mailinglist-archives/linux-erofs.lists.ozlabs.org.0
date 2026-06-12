Return-Path: <linux-erofs+bounces-3577-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UFb3OEutK2oMBwQAu9opvQ
	(envelope-from <linux-erofs+bounces-3577-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 08:55:07 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A2E6770A3
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 08:55:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=awYE8laJ;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3577-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3577-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc9Hp1vcSz2yd7;
	Fri, 12 Jun 2026 16:55:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781247302;
	cv=none; b=dwV5iQmL4MLOG3nWDskCGR8pcMwA2WfKu8saNKrnGvw9wuZXE6Cu0IcouhXHVBi27gEHhARBwkh3AYQiJvFe33g2yXLmefDoufbGeaqcNyTxXK38+SHBjM3b5b+b/WTo19ItSLNFA7JK8iffk1i/2Mo9qoQqt3dqVJVOHg+khpY3LkIisYYKSbcqEJ5HaN9L7fAq9zLoOqIM1CsZ3noyR3c7B4GRzye8VrNfPcVMJNfZy7wCfrN+Algd/7EV0OOEWJo8SatEiEAlHgYGZ8SPThKv0/3i7qukrkaFm6LnmZRXKKJWVBQyXSmpNfwnG9wmIav4cz+Y2iXKSdiBK6Bg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781247302; c=relaxed/relaxed;
	bh=ZphKWwyl+WGH86LGIXqyFlQlvne4chYGQBsEKFLt2d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOfNHG1hXpfZ6DJNmZczpMrUyJnv21Vqml6caRBnESa+GjIsKkhMfN/SHHGctBD01aoFQBJTQata3LJd6G2E4gg4xufoASUiIGJJzwauuPq30vODbsNt8vnsheSW73kn6Trl9baO73HjPUeMAhA2uJFnH4eGyH/voTyypN2BSJWVOFDf8s3c3qwSTbY5P9Ux8NCY3OT9p8v/OXwqF5NRtezVuqF2ZAOCh8du7DNjAXhlud6YFB+EuDoo1COMgA7WHi/RExFqxtMZfuU6cXkFZ8FhcuAqu1W6aSONF2MmhQzPM3SaC63b19SKTSyaqBhAUm8TeKv9dmlWaCn2zW3FpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=awYE8laJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc9Hk6fhDz2xYg
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jun 2026 16:54:56 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781247290; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZphKWwyl+WGH86LGIXqyFlQlvne4chYGQBsEKFLt2d0=;
	b=awYE8laJBdJHsDUe2+05LE6v4NQJGcAFtpWASdY2b5jZxz/bgPfVfjzq6dNuowdiy6GmRDDmC80nJIVQnr+urtRZR1uaPcQkM/7u38jNPFULiPGmU7pZmTb1J7Iredxn4VbLzMF/92dXtiEqEmnPnqbXSKzz+crLuj9vdKfrErQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X4hpKI3_1781247288;
Received: from 30.221.132.172(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4hpKI3_1781247288 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Jun 2026 14:54:48 +0800
Message-ID: <62f6e9bc-cfb3-441c-a3b7-301b8649f0ae@linux.alibaba.com>
Date: Fri, 12 Jun 2026 14:54:47 +0800
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
Subject: Re: don't merge bios over iomap boundaries, was: Re: [PATCH] erofs:
 prevent buffered read bio merges across device chunks
To: Christoph Hellwig <hch@infradead.org>
Cc: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, yekelu1@huawei.com, jingrui@huawei.com,
 zhukeqian1@huawei.com, Ritesh Harjani <ritesh.list@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>
References: <20260612033244.993507-1-zhaoyifan28@huawei.com>
 <58bef9af-0926-4948-b917-e38c3793f596@linux.alibaba.com>
 <aiumQL8LEWQX_Nag@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aiumQL8LEWQX_Nag@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3577-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:yekelu1@huawei.com,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,m:ritesh.list@gmail.com,m:djwong@kernel.org,m:linux-xfs@vger.kernel.org,m:joannelkoong@gmail.com,m:riteshlist@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,lists.ozlabs.org,vger.kernel.org,gmail.com,kernel.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,huawei.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6A2E6770A3

Hi Christoph,

On 2026/6/12 14:25, Christoph Hellwig wrote:
> On Fri, Jun 12, 2026 at 11:42:38AM +0800, Gao Xiang wrote:
>>> Reported-by: Kelu Ye <yekelu1@huawei.com>
>>> Assisted-by: Codex:GPT-5.5
>>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>>
>> I think it's an iomap bug instead, see:
>>
>> iomap_bio_read_folio_range(), we should fix iomap instead.
> 
> Yes.  iomap should not try to build bios over iomap boundaries.
> caused various issues.  Ritesh ran into that with the ext2 port
> back in the day, and I actually ran into it again with an under
> development xfs feature.
> 
> Can you try this patch?

hmm, currently erofs could return block-sized iomap (if the chunk
size is 4k) even it can be merged with the following chunks.

Previously it was fairly good since consecutive chunks will be
added to the current bio if possible, but after this patch,
there will be a lot of 4k bios.

But if iomap goes into this way, I could make iomap_begin maps
more chunks in one shot, but that needs more changes in erofs,
it's fine anyway.

... I was thinking the following diff (space-damaged):

diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
index 4504f4633f17..241df96a16a6 100644
--- a/fs/iomap/bio.c
+++ b/fs/iomap/bio.c
@@ -142,6 +142,7 @@ int iomap_bio_read_folio_range(const struct iomap_iter *iter,

         if (!bio ||
             bio_end_sector(bio) != iomap_sector(&iter->iomap, iter->pos) ||
+           bio->bi_bdev != iter->iomap.bdev ||
             bio->bi_iter.bi_size > iomap_max_bio_size(&iter->iomap) - plen ||
             !bio_add_folio(bio, folio, plen, offset_in_folio(folio, iter->pos)))
                 iomap_read_alloc_bio(iter, ctx, plen);


but either way works fine with me since it's an iomap design
stuff.

Thanks,
Gao Xiang

> 
> ---
>  From 297230cc3c08cbfef3670b08c4e35813c18c523e Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Sun, 7 Jun 2026 08:53:20 +0200
> Subject: iomap: submit read bio after each extent
> 
> This keeps bios from crossing RTG boundaries in XFS and probably fixes
> all kinds of other stuff..
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/iomap/buffered-io.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d55b936e6986..3642a11c102f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -597,12 +597,13 @@ void iomap_read_folio(const struct iomap_ops *ops,
>   
>   	trace_iomap_readpage(iter.inode, 1);
>   
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, ops)) > 0) {
>   		iter.status = iomap_read_folio_iter(&iter, ctx,
>   				&bytes_submitted);
> -
> -	if (ctx->read_ctx && ctx->ops->submit_read)
> -		ctx->ops->submit_read(&iter, ctx);
> +		if (ctx->read_ctx && ctx->ops->submit_read)
> +			ctx->ops->submit_read(&iter, ctx);
> +		ctx->read_ctx = NULL;
> +	}
>   
>   	if (ctx->cur_folio)
>   		iomap_read_end(ctx->cur_folio, bytes_submitted);
> @@ -664,12 +665,13 @@ void iomap_readahead(const struct iomap_ops *ops,
>   
>   	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
>   
> -	while (iomap_iter(&iter, ops) > 0)
> +	while (iomap_iter(&iter, ops) > 0) {
>   		iter.status = iomap_readahead_iter(&iter, ctx,
>   					&cur_bytes_submitted);
> -
> -	if (ctx->read_ctx && ctx->ops->submit_read)
> -		ctx->ops->submit_read(&iter, ctx);
> +		if (ctx->read_ctx && ctx->ops->submit_read)
> +			ctx->ops->submit_read(&iter, ctx);
> +		ctx->read_ctx = NULL;
> +	}
>   
>   	if (ctx->cur_folio)
>   		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);


