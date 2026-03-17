Return-Path: <linux-erofs+bounces-2790-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKAqIqAkuWm1sQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2790-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 10:53:36 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954992A74CE
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 10:53:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZnMw6J5sz2yj1;
	Tue, 17 Mar 2026 20:53:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773741212;
	cv=none; b=foGU9ckS36vzKC2SK/Pr2u4ExjmGFeviKxPRTPKCBJ64+By8tYM8b4LpRqA5KX5T3lxz9DyvREtSDvyVFxp3SrKcC4EsgOWBI5xzK7WzUObW0zXIthZdSCShgd8RfLj7FXHqhz36IrxCf8nCmhDWAlo22jLcqGLcCD8eYOF1QDMTkqLN1EtAduvW61J1WiVO39UIWhy1cIdcPxoWxO2Mh5C4Z1yP5ip2S1PWEmcVwxm9Ggd4vVys1DhDl65D2jI/BpLZpM+7clelWcEiqJDauQAgLQ3uV4U/dHdT3vi/w9IB+6m1mMkzRhCZkB1fbHNrqSLlWh/yrQurkdNUeMCJow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773741212; c=relaxed/relaxed;
	bh=e+tmqyzkN7pKNV1N1eAugyyzJhD2oPmoBMpel1ln5x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQcGTbMvtEX3cM8i64px2nmbj/fJTaHGGxKYmKsZkv4YDY0oADx+TrDnvZcrlHk7cMnSs8AFJvLQDmimfALzN7u2TyJsrDd0QelOFeDLC+xuNPDVp6OIG/zpA7X64DvV2zhz9/Y7M4aTCeV1JttM04IS0/WNGUn/BEIThOP17z8db899uZLxMqKeb58QzEZgJEhB+nvUfezuzwTzOI9MNNAaIosqzJR14fzH9YlJ+Axdwjpe+oWecl81lYjZg0mWX4j0yxrsvz7xNKUQmFAkMqYJ1FHvq489sgKHj3TegmecRlH116iFnA3MXkyYJod7M8jgBt1eq0WjsP7/PyZjLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=I9m6GhE2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=I9m6GhE2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZnMt6xFrz2yfP
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 20:53:29 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773741204; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=e+tmqyzkN7pKNV1N1eAugyyzJhD2oPmoBMpel1ln5x4=;
	b=I9m6GhE2jQbclK8nyjbmH87ipqmr4BSdcLFx/AZ3GKDqZ8KAdqMqSoOX+seIGagKl2g5kYK4FmjlyHH5DiR8WzK0OOrfiDQdQucN0RvnME8Sk6meAtKYto20eHWWfZMnhoU+HnOp930/Ilxa3tWdDUKQ4J+0aPukhd+AOXlDU0o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.AcnW8_1773741203;
Received: from 30.221.133.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.AcnW8_1773741203 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 17:53:23 +0800
Message-ID: <a65ab6cb-3e98-433c-921c-fd0b7cc8c188@linux.alibaba.com>
Date: Tue, 17 Mar 2026 17:53:21 +0800
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
Subject: Re: [PATCH v2 1/2] erofs-utils: lib: validate ZSTD frame content size
 in decompression
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: yifan.yfzhao@foxmail.com
References: <20260317045537.9591-1-singhutkal015@gmail.com>
 <20260317045537.9591-2-singhutkal015@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260317045537.9591-2-singhutkal015@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2790-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 954992A74CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/17 12:55, Utkal Singh wrote:
> ZSTD_getFrameContentSize() reads the content size from the ZSTD
> frame header in the compressed data. This is untrusted on-disk
> metadata, independent from the extent map that provides
> rq->decodedlength via z_erofs_map_blocks_iter().
> 
> A crafted EROFS image can set the extent map to claim a decoded
> length larger than the actual ZSTD frame content size. When this
> happens, a buffer of the (smaller) frame content size is allocated
> and decompressed into, but the subsequent memcpy copies
> rq->decodedlength bytes from it -- a potential out-of-bounds read.
> 
> Additionally, the ZSTD_getDecompressedSize() legacy fallback
> returns 0 for frames without a content size field. This leads to
> malloc(0) followed by out-of-bounds access on the returned pointer.
> 
> Reject frames where the reported content size is zero or smaller
> than the expected decoded length.
> 
> Reproducer:
>    mkdir testdir
>    python3 -c "open('testdir/f','wb').write(b'A'*131072)"
>    mkfs.erofs -zzstd test.erofs testdir/
>    python3 -c "d=bytearray(open('test.erofs','rb').read());\
>      p=d.find(b'\x28\xb5\x2f\xfd');d[p+4]=0x20;d[p+5]=0x01;\
>      open('test.erofs','wb').write(d)"
>    fsck.erofs --extract=out test.erofs
>    # Expected: ZSTD frame content size 1 < decoded length 131072
> 
> Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
> ---
>   lib/decompress.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/lib/decompress.c b/lib/decompress.c
> index 3e7a173..fb81039 100644
> --- a/lib/decompress.c
> +++ b/lib/decompress.c
> @@ -48,7 +48,14 @@ static int z_erofs_decompress_zstd(struct z_erofs_decompress_req *rq)
>   #else
>   	total = ZSTD_getDecompressedSize(src + inputmargin,
>   					 rq->inputsize - inputmargin);
> +	if (!total)
> +		return -EFSCORRUPTED;

hmm, that is the difference between the kernel and erofs-utils
implementation.

the kernel uses zstd streaming APIs, so it won't malloc()
a new buffer in advance, actually I think erofs-utils should
switch to streaming APIs too, in order to avoid

ZSTD_getFrameContentSize() and ZSTD_getDecompressedSize()

dependencies as you said in the commit message.

Thanks,
Gao Xiang


