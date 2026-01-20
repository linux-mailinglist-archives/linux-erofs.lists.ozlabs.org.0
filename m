Return-Path: <linux-erofs+bounces-2094-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E4hOHCqb2lUEwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2094-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 17:16:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E729473AE
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 17:16:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwTwx5N95z3c4d;
	Wed, 21 Jan 2026 01:19:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768918785;
	cv=none; b=I1vZ4jHshsdnTv7IygWzjxC7FJcR/I24oQ8tIlF6RRIvb999G7BAdEh0+nW2PBuWFud6WpV49ogHhiPDI8ff7Yx1myZuEE0e4yl5sMTU1yvKFPLEYWP4DQPK76+99H2I7BiI1T81j+pjTYcFB9QUNV/f6F8U5s+pAedrxLYBXCywy0I2maLXtLvuwVPnziaMXOvzfpk9gWEqdEAxSeB1rbL9yrXksg8+iFIILPy957SXmhmCNZs4sVTLWF389S8XSvFRf5pZ8pYadUmR9lensk1KZ71GzbC+O2jSWQ+2TBLAWq4x0Ne/PYUthyXEeJ5t+lf8aQOaXmqhuzcmV8W20A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768918785; c=relaxed/relaxed;
	bh=t9XjF+Fp4ZzFE08s04Xje48JD6vfHmVMwLgm8p8DZjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpI6qbn3r0/F65Vy9Tmm6R8b4Hpl9NXPhdC4OPXV035xaYFY5tff/2OCXRR7Efabf31sZRxj/NDVaMpkDR/ZuA8WvxI78No2mhdfRSpfkulmKc1FR0prj9hrw5KjOAxJUwTUB5cbxBYBTRMkd14YJ9uMiSHws6xULDmHtxpUddEIwk6qoOQcUURrI/WENdqsh8iKW6gUc3E1GUINMDwC5BJqVG9OlyJYLvFveJ+W38UzgBYjZojpa4KEQh/lf1VfoYFudunA89gOyM9xA4QU75GVfzrKlf3RxhhwAF1DrN697PQ2P2QfufF0WXbfVBFE3aw7w9vP5YIPZ4OjNQTM+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Pn0uxLWQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Pn0uxLWQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwTwq36YWz3c40
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jan 2026 01:19:37 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768918771; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=t9XjF+Fp4ZzFE08s04Xje48JD6vfHmVMwLgm8p8DZjA=;
	b=Pn0uxLWQF7o9MELZfgiapNfRwE2tcTgWIQBSqHjFX1/9FqvT5aHGq+uv3ViaSxp07B8TSgUF5t1jZEb8xc8772vRDo6xpfsyJ2lvjYaPZKdfJIbFLjzYJ1zZmtJGevc0GY95Elb0i+SSzoXx/LX2lAM8cw0TdzcArWhXLm+Szpc=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxUjUbr_1768918768 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Jan 2026 22:19:29 +0800
Message-ID: <3ae9078a-ba5c-460d-89ea-8fdbdf190a10@linux.alibaba.com>
Date: Tue, 20 Jan 2026 22:19:28 +0800
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
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260116095550.627082-6-lihongbo22@huawei.com>
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
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2094-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lihongbo22@huawei.com,m:chao@kernel.org,m:brauner@kernel.org,m:djwong@kernel.org,m:amir73il@gmail.com,m:hch@lst.de,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lst.de,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,huawei.com:email,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 5E729473AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/1/16 17:55, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Currently, reading files with different paths (or names) but the same
> content will consume multiple copies of the page cache, even if the
> content of these page caches is the same. For example, reading
> identical files (e.g., *.so files) from two different minor versions of
> container images will cost multiple copies of the same page cache,
> since different containers have different mount points. Therefore,
> sharing the page cache for files with the same content can save memory.
> 
> This introduces the page cache share feature in erofs. It allocate a
> deduplicated inode and use its page cache as shared. Reads for files
> with identical content will ultimately be routed to the page cache of
> the deduplicated inode. In this way, a single page cache satisfies
> multiple read requests for different files with the same contents.
> 
> We introduce inode_share mount option to enable the page sharing mode
> during mounting.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   Documentation/filesystems/erofs.rst |   5 +
>   fs/erofs/Makefile                   |   1 +
>   fs/erofs/inode.c                    |  24 +----
>   fs/erofs/internal.h                 |  57 ++++++++++
>   fs/erofs/ishare.c                   | 161 ++++++++++++++++++++++++++++
>   fs/erofs/super.c                    |  56 +++++++++-
>   fs/erofs/xattr.c                    |  34 ++++++
>   fs/erofs/xattr.h                    |   3 +
>   8 files changed, 316 insertions(+), 25 deletions(-)
>   create mode 100644 fs/erofs/ishare.c
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 08194f194b94..27d3caa3c73c 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -128,7 +128,12 @@ device=%s              Specify a path to an extra device to be used together.
>   fsid=%s                Specify a filesystem image ID for Fscache back-end.
>   domain_id=%s           Specify a domain ID in fscache mode so that different images
>                          with the same blobs under a given domain ID can share storage.
> +                       Also used for inode page sharing mode which defines a sharing
> +                       domain.

I think either the existing or the page cache sharing
here, `domain_id` should be protected as sensitive
information, so it'd be helpful to protect it as a
separate patch.

And change the description as below:
                            Specify a trusted domain ID for fscache mode so that
                            different images with the same blobs, identified by blob IDs,
                            can share storage within the same trusted domain.
                            Also used for different filesystems with inode page sharing
                            enabled to share page cache within the trusted domain.


>   fsoffset=%llu          Specify block-aligned filesystem offset for the primary device.
> +inode_share            Enable inode page sharing for this filesystem.  Inodes with
> +                       identical content within the same domain ID can share the
> +                       page cache.
>   ===================    =========================================================

...


>   	erofs_exit_shrinker();
> @@ -1062,6 +1111,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   		seq_printf(seq, ",domain_id=%s", sbi->domain_id);

I think we shouldn't show `domain_id` to the userspace
entirely.

Also, let's use kfree_sentitive() and no_free_ptr() to
replace the following snippet:

          case Opt_domain_id:
                 kfree(sbi->domain_id); -> kfree_sentitive
                 sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
                      -> sbi->domain_id = no_free_ptr(param->string);
                 if (!sbi->domain_id)
                         return -ENOMEM;
                 break;

And replace with kfree_sentitive() for domain_id everywhere.

Thanks,
Gao Xiang

