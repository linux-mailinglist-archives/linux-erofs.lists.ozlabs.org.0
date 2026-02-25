Return-Path: <linux-erofs+bounces-2406-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBY+HK5ynmmBVQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2406-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 04:55:26 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C090B191662
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 04:55:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLLMt0m76z3dK1;
	Wed, 25 Feb 2026 14:55:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771991722;
	cv=none; b=CX3t4peUsorAWnXn1YjxhV4Q+XfMvNKQhv/bIkwcYOmfrgnp+iDH9xijspWQyHYo0ES9hiFuetCkil1nxVWF89jwLEVfYWoAkGvzuSfsRPoauAYtd3H7ZTHMfsV6A1YdwYm/4eyMo7Vp+22I7trShXbVA9+3C+3cw8tlZ69sJaxgugjW49WdAOUVBXoHmirBEIVWXzAj4TgB2854TqEgcufJJI8yluVCJWF4lJUde2K5KsH219zhhKiud5WamUnP5sS5xsaJ5NNOiC8vBNiaSKM1GXmfsooiVBxJCAZaPl80oucYQDDqR9E1eQJDVLeEVoUMwauWJLmqQBJcXEU4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771991722; c=relaxed/relaxed;
	bh=rOaNlOKYE9wnK/GNUdS/PG4m0qPTZlR0nzr8wXLPraQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JASdDK/bVFG/pw9zggadoxyjeJI3mawZiD/ATLlq338AjtYmMMwAWuw6itbZKVHqEMuynnFgQw6hXTRRVasaDI4k8jd5bzBtB1GqzQfdaPIx+UHX/xfAnRKXH+NPRD2UKgxrsan965j+XrznD4Z4FRUlyUjXJolUpcgyZMY2aRdXoCYHPZe5tVizHfy5yjQHXc45Q5gi7+PX2AbxuxZnJ3zz6ewQKKsbHdWAkfbqHLg8tIxyE/LwlFlAxqTeMPLi9zF43iBcV+7JeO7oibhNpnvWcpADLH/caSlhrkZ8ze9UpMC/8ajeTPm+Ea4IumEFu/jDgdIVvNdIZnNXcfWHng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PgZUm2Ye; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PgZUm2Ye;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLLMn1G2Kz3dJg
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 14:55:15 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771991708; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rOaNlOKYE9wnK/GNUdS/PG4m0qPTZlR0nzr8wXLPraQ=;
	b=PgZUm2Yet4yWM2/Kc07jZ5r1HGR0JL5hpoK99JgnN3wzIywMDsPVnrG2gbP2xQk1nYq746BIp3TudfvK/y4BOZwud6ulRUi6p2NUXpnTN0yIzvFh8bSF50XcW03JJfp6pijc88bP2/BFy/VsW70hq760LxQbjfeVCju/5FzC5go=
Received: from 30.221.131.204(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzlBM5P_1771991707 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 11:55:07 +0800
Message-ID: <616015da-0938-44e2-9cb3-4d6bb37d8cd2@linux.alibaba.com>
Date: Wed, 25 Feb 2026 11:55:06 +0800
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
Subject: Re: [PATCH v3] erofs-utils: lib: fix 48bit addressing detection for
 chunk-based format
To: puneeth_aditya_5656 <myakampuneeth@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <20260224055712.14110-1-myakampuneeth@gmail.com>
 <20260224191316.2294-1-myakampuneeth@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260224191316.2294-1-myakampuneeth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:myakampuneeth@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2406-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: C090B191662
X-Rspamd-Action: no action



On 2026/2/25 03:13, puneeth_aditya_5656 wrote:
> The 48-bit chunk format flag was being set inside
> erofs_blob_write_chunked_file right after erofs_blob_getchunk returns.
> At that point chunk->blkaddr is the chunk's offset in the temporary
> blob buffer, not the final image address. The real address is only
> known after erofs_mkfs_dump_blobs applies remapped_base.
> 
> This means the detection was unreliable in both directions: a chunk
> whose blob offset looks large but fits in 32-bits after remapping gets
> flagged unnecessarily, and worse, a chunk that lands above UINT32_MAX

I think the first case is impossible for the current remapping
mechanism.

> after remapping may not get flagged at all, producing a corrupt image.
> 
> Fix this by introducing erofs_inode_fixup_chunkformat() which walks
> the chunk array after remapped_base is finalized and sets the 48-bit
> flag if any chunk address exceeds UINT32_MAX. The fixup is called from
> erofs_iflush so that the correct chunkformat is written into the
> on-disk inode header. Both blob chunks (remapped_base + chunk->blkaddr)
> and device chunks (chunk->blkaddr directly) are handled.
> 
> Signed-off-by: Puneeth Aditya <myakampuneeth@gmail.com>
> ---
>   include/erofs/blobchunk.h |  1 +
>   lib/blobchunk.c           | 40 +++++++++++++++++++++++++++++++++++----
>   lib/inode.c               |  2 ++
>   3 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
> index ef06773..48fca63 100644
> --- a/include/erofs/blobchunk.h
> +++ b/include/erofs/blobchunk.h
> @@ -16,6 +16,7 @@ extern "C"
>   
>   struct erofs_blobchunk *erofs_get_unhashed_chunk(unsigned int device_id,
>   		erofs_blk_t blkaddr, erofs_off_t sourceoffset);
> +void erofs_inode_fixup_chunkformat(struct erofs_inode *inode);
>   int erofs_write_chunk_indexes(struct erofs_inode *inode, struct erofs_vfile *vf,
>   			      erofs_off_t off);
>   int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index a051904..96c161b 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -136,6 +136,42 @@ static int erofs_blob_hashmap_cmp(const void *a, const void *b,
>   		      sizeof(ec1->sha256));
>   }
>   

...

> +
>   int erofs_write_chunk_indexes(struct erofs_inode *inode, struct erofs_vfile *vf,
>   			      erofs_off_t off)
>   {
> @@ -380,10 +416,6 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>   			goto err;
>   		}
>   
> -		/* FIXME! `chunk->blkaddr` is not the final blkaddr here */
> -		if (chunk->blkaddr != EROFS_NULL_ADDR &&
> -		    chunk->blkaddr >= UINT32_MAX)
> -			inode->u.chunkformat |= EROFS_CHUNK_FORMAT_48BIT;
>   		if (!erofs_blob_can_merge(sbi, lastch, chunk)) {
>   			erofs_update_minextblks(sbi, interval_start, pos,
>   						&minextblks);
> diff --git a/lib/inode.c b/lib/inode.c
> index 4a214f9..25087ca 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -794,6 +794,8 @@ int erofs_iflush(struct erofs_inode *inode)
>   	} else if (is_inode_layout_compression(inode)) {
>   		u1.blocks_lo = cpu_to_le32(inode->u.i_blocks);
>   	} else if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
> +		if (inode->chunkindexes)

It's a useless check, just remove this.

Thanks,
Gao Xiang

