Return-Path: <linux-erofs+bounces-2155-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGtWArktcmmadwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2155-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 15:01:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E99867A47
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 15:01:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxjQq5ztgz2yFm;
	Fri, 23 Jan 2026 01:01:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769090483;
	cv=none; b=iIfo2vW1bOx+n5RNWRA/u2AD7X/pzP2YH2AYlDeSTl0oTVPLPA4ucuONjNA7fyCafBtrjhxgXKjS9BMWbkI4JmcdFdZ8RTIEJOhp/b2kLP4S+b4Ix/A4Q3tQ8d/ZKdN3dFq4IsVDcE/w+6bc4wj0uqbdb148fn34bGaYH0viCKrTp5YGE99XdDKnfaw+7V5THZccEowicyGnijJdIxgDSRbWiTU6+nIJ50D9qmQkYJHIUThvWXeh4/QI0J6+E6pR1lGWOHSOF+1vVIJ7br2nlI4gkT+Q/yNJGa1YO5FPris1Zx/JK1/CjB6IGv3jATDVixCP9BvGacP8LSwV6uaBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769090483; c=relaxed/relaxed;
	bh=TvssjtYtiq5dAQbaQwGQ/5ZWXUGw/MpLR2p5AfsB+94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jggAclfIL9O45mNkUsbnjVr9XGANKGmVu4riKSVM45nq6EFTssGnoWnExGzKjX8EQBSVEt1LAobF0Ys3A22cO+iEnYhp89LoElblZe2hnvlVkFB5buQ7AhJVF+QhnimhPwOoBKTso3R5sIlmsyrXp1IUH/QFyePwJNXeYZplDs6uhkspcLp1cejpp0uOKUFXTmhmq3u07eYVgJMH46fK9xdxkOm17uWNWFlYq8tnuChRl4bOSACRYi0xBVhCIv0+P2Mv1bVMlxcGoQHlkmqOEishbLv0MUyKc0AQf+P3g4p/5TMQA0gGq1t+M7SfPkwd14byPb94e7Z+o1istrhyKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pngGM6Ip; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pngGM6Ip;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxjQm2qDPz2xl0
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 01:01:17 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769090472; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TvssjtYtiq5dAQbaQwGQ/5ZWXUGw/MpLR2p5AfsB+94=;
	b=pngGM6Ip/xJ8L1GDIE15+cKN3IqrM5EN1fS06VbjwIRyNMmI6xixNXWzhkep4SYji9mZgAC0Xpqvzk6RqXPXQsZl7YxC7tU/S3UcMiTA3QtHY3jDQ95G6e37WivRbCeMiTIi7ctlKMYIW5zSd6hHUWfJgW6FDbt9kW7NwV++v2Y=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wxca1-4_1769090469 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 22:01:10 +0800
Message-ID: <a59ef332-fc67-4890-94b1-9c3f2b37a9fa@linux.alibaba.com>
Date: Thu, 22 Jan 2026 22:01:09 +0800
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
Subject: Re: [PATCH v16 06/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org
Cc: hch@lst.de, djwong@kernel.org, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260122133718.658056-1-lihongbo22@huawei.com>
 <20260122133718.658056-7-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260122133718.658056-7-lihongbo22@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2155-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lihongbo22@huawei.com,m:chao@kernel.org,m:brauner@kernel.org,m:hch@lst.de,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1E99867A47
X-Rspamd-Action: no action



On 2026/1/22 21:37, Hongbo Li wrote:
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
> shared inode and use its page cache as shared. Reads for files
> with identical content will ultimately be routed to the page cache of
> the shared inode. In this way, a single page cache satisfies
> multiple read requests for different files with the same contents.
> 
> We introduce new mount option `inode_share` to enable the page
> sharing mode during mounting. This option is used in conjunction
> with `domain_id` to share the page cache within the same trusted
> domain.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   Documentation/filesystems/erofs.rst |   5 +
>   fs/erofs/Makefile                   |   1 +
>   fs/erofs/inode.c                    |   1 -
>   fs/erofs/internal.h                 |  31 ++++++
>   fs/erofs/ishare.c                   | 167 ++++++++++++++++++++++++++++
>   fs/erofs/super.c                    |  62 ++++++++++-
>   fs/erofs/xattr.c                    |  34 ++++++
>   fs/erofs/xattr.h                    |   3 +
>   8 files changed, 301 insertions(+), 3 deletions(-)
>   create mode 100644 fs/erofs/ishare.c
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 40dbf3b6a35f..bfef8e87f299 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -129,7 +129,12 @@ fsid=%s                Specify a filesystem image ID for Fscache back-end.
>   domain_id=%s           Specify a trusted domain ID for fscache mode so that
>                          different images with the same blobs, identified by blob IDs,
>                          can share storage within the same trusted domain.
> +                       Also used for different filesystems with inode page sharing
> +                       enabled to share page cache within the trusted domain.
>   fsoffset=%llu          Specify block-aligned filesystem offset for the primary device.
> +inode_share            Enable inode page sharing for this filesystem.  Inodes with
> +                       identical content within the same domain ID can share the
> +                       page cache.
>   ===================    =========================================================
>   
>   Sysfs Entries
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 549abc424763..a80e1762b607 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 389632bb46c4..202cbbb4eada 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -203,7 +203,6 @@ static int erofs_read_inode(struct inode *inode)
>   
>   static int erofs_fill_inode(struct inode *inode)
>   {
> -	struct erofs_inode *vi = EROFS_I(inode);

Why this line is in this patch other than
"erofs: add erofs_inode_set_aops helper to set the aops[.]"

And there is an unneeded dot at the end of the subject.

Could you check the patches carefully before sending
out the next version?

Thanks,
Gao Xiang

