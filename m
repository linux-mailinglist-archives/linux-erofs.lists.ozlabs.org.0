Return-Path: <linux-erofs+bounces-3345-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJqHJskm52nV4QEAu9opvQ
	(envelope-from <linux-erofs+bounces-3345-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 09:27:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99416437891
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 09:27:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0DSc55sjz2ySW;
	Tue, 21 Apr 2026 17:26:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776756416;
	cv=none; b=dDmEJ+nw1fyNeR9W4y4Jj+IPWafgqjBMzSEWILS7KrRNd86hSy7J2s95xi/tYrAcOFw8fMjG6pMggonbizulEgS2wQqxHSSvcH1pxAwCBatdxtTBLU9uXLl7crHwvOq6Adm2sJrzVaA9b0ZhcTwOM/gYPDsJo9vOBzS7Q5DJR7PVvyXm922B6KBJUULscHDYGGZ3uNLLeOvsFUZQ0/e9UPtC6QnavKgfi+jEfTOjt5BDykiT6wLOenDEtosRTNJ4E2tOYyIHRVW/5kl534clojxq5/4UhxsAYnmvL94/p4h2oWZG5UB3oGLKDxwKgqu4QHXu0eIyFk7si9bNmYZAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776756416; c=relaxed/relaxed;
	bh=YjrEyJFzu7aEHpE51YGNVhKPec6gOngGRlPUy9Bmano=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ly2PWbT+na8ZQBgYZhHPYG72T3DWQFovcYoKpNpMCISqLPc92CgKdy9edjCNvoS3+BFbB3wPDyVURogPHaF0shPV8RzsfiGoVK7H/hVAZuXrKJKwf83Nt4hDlR/mV6SNwos/IJZR5JLAFYwFpOsdwOvyPC9mV1LMGn2npipP5xvaP3I2imH4h6ofeMvqH8rOjl1fnqnnWYsYSSuJcEKNKANPofO9bH26frf4xQ09wQ4Dvp/AJqnQfnPU6HV9STMlEDqfnvo4nIMXdWT6tPVGFbF/eE4MF8MgKWGu9EFnlzklffvQnix6nq0OrIoRPR+45Y3ZWp8LqV8KaPY598uDfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XNkqpQ+p; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XNkqpQ+p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0DSb4Lhhz2yFl
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2026 17:26:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6BC2C6001A;
	Tue, 21 Apr 2026 07:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7ABC2BCB0;
	Tue, 21 Apr 2026 07:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776756413;
	bh=5zCagFjASgLa2FrIENVX5Yr4I78XpsHoo70zQSevNbc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XNkqpQ+pnZoqXioUQX0OuYCpQIO5IhgaGNanWqQ/+XNX+UJseMxcDWVSPoix7+cfw
	 qBiDghU2FgmGxCuWPtHP6Jjs9zoPzNgXzANdqmRnvTXfZtaeYMCSl2dRTP+23a9Wlj
	 AgRBHJF3YrMtb6rns/e4UF6L2SLDm/tuNjzxfqkERogUH5CAAfRqIlSRYwcMRJrEPn
	 ooTf8qRBehbnPCANef9PhdEtNQJdFnLE4rehe6POEyKX8gU7xtKfJ8E/w776WAy63r
	 TV0Kycd9afEV9xQFVP1qsZaJ3qfnjAK6jeO+7FSjdU4UZ9L2M9WfBLH196Qbjiz9LL
	 nxQgQmtBp7U8Q==
Message-ID: <b9d787ce-9020-4140-8d13-23a20809976d@kernel.org>
Date: Tue, 21 Apr 2026 15:26:50 +0800
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
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>, Junrui Luo <moonafterrain@outlook.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] erofs: fix the out-of-bounds nameoff handling for
 trailing dirents
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20260416063511.3173774-1-hsiangkao@linux.alibaba.com>
 <20260416094408.3466613-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260416094408.3466613-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3345-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,outlook.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:moonafterrain@outlook.com,m:stable@vger.kernel.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,outlook.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 99416437891
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/2026 5:44 PM, Gao Xiang wrote:
> Currently we already have boundary-checks for nameoffs, but the trailing
> dirents are special since the namelens are calculated with strnlen()
> with unchecked nameoffs.
> 
> If a crafted EROFS has a trailing dirent with nameoff >= maxsize,
> maxsize - nameoff can underflow, causing strnlen() to read past the
> directory block.
> 
> nameoff0 should also be verified to be a multiple of
> `sizeof(struct erofs_dirent)` as well [1].
> 
> [1] https://sashiko.dev/#/patchset/20260416063511.3173774-1-hsiangkao%40linux.alibaba.com
> Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
> Fixes: 33bac912840f ("staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Closes: https://lore.kernel.org/r/A0FD7E0F-7558-49B0-8BC8-EB1ECDB2479A@outlook.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v3:
>   - Disallow unaligned nameoff0 to avoid petential oob reads as well.
> 
>   fs/erofs/dir.c | 29 ++++++++++++++++-------------
>   1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index e5132575b9d3..d074fded1577 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -19,20 +19,18 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>   		const char *de_name = (char *)dentry_blk + nameoff;
>   		unsigned int de_namelen;
>   
> -		/* the last dirent in the block? */
> -		if (de + 1 >= end)
> -			de_namelen = strnlen(de_name, maxsize - nameoff);
> -		else
> +		/* non-trailing dirent in the directory block? */
> +		if (de + 1 < end)
>   			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
> +		else if (maxsize <= nameoff)
> +			goto err_bogus;
> +		else
> +			de_namelen = strnlen(de_name, maxsize - nameoff);
>   
> -		/* a corrupted entry is found */
> -		if (nameoff + de_namelen > maxsize ||
> -		    de_namelen > EROFS_NAME_LEN) {
> -			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
> -				  EROFS_I(dir)->nid);
> -			DBG_BUGON(1);
> -			return -EFSCORRUPTED;
> -		}
> +		/* a corrupted entry is found (including negative namelen) */
> +		if (!in_range32(de_namelen, 1, EROFS_NAME_LEN) ||
> +		    nameoff + de_namelen > maxsize)
> +			goto err_bogus;
>   
>   		if (!dir_emit(ctx, de_name, de_namelen,
>   			      erofs_nid_to_ino64(EROFS_SB(dir->i_sb),
> @@ -42,6 +40,10 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>   		ctx->pos += sizeof(struct erofs_dirent);
>   	}
>   	return 0;
> +err_bogus:
> +	erofs_err(dir->i_sb, "bogus dirent @ nid %llu", EROFS_I(dir)->nid);
> +	DBG_BUGON(1);
> +	return -EFSCORRUPTED;
>   }
>   
>   static int erofs_readdir(struct file *f, struct dir_context *ctx)
> @@ -88,7 +90,8 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   		}
>   
>   		nameoff = le16_to_cpu(de->nameoff);
> -		if (nameoff < sizeof(struct erofs_dirent) || nameoff >= bsz) {

You mean?

if (!nameoff || nameoff >= bsz || nameoff % sizeof(struct erofs_dirent))

Thanks,

> +		if (nameoff < sizeof(struct erofs_dirent) || nameoff >= bsz ||
> +		    (nameoff % sizeof(struct erofs_dirent))) {
>   			erofs_err(sb, "invalid de[0].nameoff %u @ nid %llu",
>   				  nameoff, EROFS_I(dir)->nid);
>   			err = -EFSCORRUPTED;


