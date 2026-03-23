Return-Path: <linux-erofs+bounces-2949-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGHhLOIAwWlUPgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2949-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 09:59:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A279D2EE90D
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 09:59:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffRtQ2J4gz2ySb;
	Mon, 23 Mar 2026 19:59:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774256350;
	cv=none; b=FM+476YHZlHuL5Yx/P5zoz69ca7rTv621PA8kusVjM/A3LXXky3HEkBfn+pLSzMrx9L8tLPdYCMIvKqHyhxItgi/oBHbXQdRMkX1iWecynPrA1bdG5NtQs2TiuR63ZMT8M3dM21fPKNoDbKq8HMAQm/6zJszBM91/THJli3Yn7eEsC00VWlroGziU9R8iZDnyfpnVzgyZGT2I+6xVJ+dp5JKY3HDBMfTPTykjdwMgM65BgeQdi7xeOprAnthjnTFoLQc0gNNUrQhk3KDFFjwQIlLiEmUbbWiUynmL5bZOVcBUzrZvCEjLueahMHfZmmfo6Wn3AyNXlgncmljufsutA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774256350; c=relaxed/relaxed;
	bh=H6naz5viM7Xu+VTy8JB833V7Y7xXzzJWGleVlAWy85U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gsc1sW7oFzzXwyy0mn3IogvLC8/9X2DWmn2MBNcGRiAal3ai6VG60z1B1CvzswIIcBzs9byX35AoVa8M0RnAKHE+6qbJhBg0WWYfFXC2X6jnEV2it/0+/AlloB4o85dqGJmdDzSnFdvmal+gpkJVwPunR6d5GDIQ/IT1KtQVxntOCwfK8O5ch05b6Jcl1/rgBdoYWpq+vypK9U/xVE5IPWSrLeWmDqn8agxf6CR06x7rCDRXB96vaZtgF69ER+fYquwiYCsRm0ucmAhCGhGAyh8Bi2OSmxxZF0ujiVl7Su6+HuKI7PDmTHm6jzGqH3qBWqB9zdaSbZxAnoRWERp/qA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BNIKejrC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BNIKejrC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffRtM5Q8zz2xly
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 19:59:06 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774256339; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H6naz5viM7Xu+VTy8JB833V7Y7xXzzJWGleVlAWy85U=;
	b=BNIKejrCJqSfwM2RNH2F1+bWX+hmprReusoqiVuWcrS0nDeAb+X+Xp3/aAeNsvZIsGJWhYA3cguwgCo2jDs4rxd39P9a5BNh0l9AcEzxKNu+OOFUbZNN/TicL3lntrL8/UPCOEVWk+yC76Zg/ozTn1oMuWJS8SXE1HXHcBktgx0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X.VeY6Q_1774256338;
Received: from 30.221.131.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.VeY6Q_1774256338 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 16:58:58 +0800
Message-ID: <8ac4cd88-3460-4a34-ad11-45f9d4f27a69@linux.alibaba.com>
Date: Mon, 23 Mar 2026 16:58:57 +0800
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
Subject: Re: [PATCH 6.1] erofs: Fix the slab-out-of-bounds in drop_buffers()
To: Denis Arefev <arefev@swemel.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+5b886a2e03529dbcef81@syzkaller.appspotmail.com
References: <20260323085216.7965-1-arefev@swemel.ru>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260323085216.7965-1-arefev@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2949-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:arefev@swemel.ru,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:xiang@kernel.org,m:chao@kernel.org,m:jefflexu@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:syzbot+5b886a2e03529dbcef81@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,5b886a2e03529dbcef81];
	DBL_BLOCKED_OPENRESOLVER(0.00)[swemel.ru:email,syzkaller.appspot.com:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A279D2EE90D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/23 16:52, Denis Arefev wrote:
> No upstream commit exists for this patch.

That is also strange, since people would ask why not submiting a patch
upstream, I think you still need to mention the upstream commit

ce529cc25b184e93397b94a8a322128fc0095cbb
("erofs: enable large folios for iomap mode").

also see another commit in linux 6.1 branch:
1ce9ebc96eda ("erofs: ensure that the post-EOF tails are all zeroed").

Thanks,
Gao Xiang

> 
> Syzbot reported that a KASAN slab-out-of-bounds bug was discovered in
> the drop_buffers() function [1].
> 
> The root cause is that erofs_raw_access_aops does not define .release_folio
> and .invalidate_folio. When using iomap-based operations, folio->private
> may contain iomap-specific data rather than buffer_heads. Without special
> handlers, the kernel may fall back to generic functions (such as
> drop_buffers), which incorrectly treat folio->private as a list of
> buffer_head structures, leading to incorrect memory interpretation and
> out-of-bounds access.
> 
> Fix this by explicitly setting .release_folio and .invalidate_folio to the
> values of iomap_release_folio and iomap_invalidate_folio, respectively.
> 
> [1] https://syzkaller.appspot.com/x/report.txt?x=12e5a142580000
> 
> Fixes: 7479c505b4ab ("fs: Convert iomap_readpage to iomap_read_folio")
> Reported-by: syzbot+5b886a2e03529dbcef81@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=c6aeabd0c4ad2466f63a274faf2a123103f8fbf7
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>   fs/erofs/data.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 7b648bec61fd..302e824827fc 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -406,6 +406,8 @@ const struct address_space_operations erofs_raw_access_aops = {
>   	.readahead = erofs_readahead,
>   	.bmap = erofs_bmap,
>   	.direct_IO = noop_direct_IO,
> +	.release_folio = iomap_release_folio,
> +	.invalidate_folio = iomap_invalidate_folio,
>   };
>   
>   #ifdef CONFIG_FS_DAX


