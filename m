Return-Path: <linux-erofs+bounces-2536-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOqYI6c4rmlyAgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2536-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 04:04:07 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C6123370F
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 04:04:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fThg75tv8z3bnm;
	Mon, 09 Mar 2026 14:04:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773025443;
	cv=none; b=ixfMMeGqWOP7kqDRWTZwFTdzRlRJtO44NPy3CXnJoGIipGJVm4JOTDCQXecgvfHIjtGoW586sL+aNDM1ToO7/Otqs1zZAo7q7SSvX2IYLN1cQaduJh3ZO5Cx1M4yUz+3EhpmsjiY3V6heTQsHntxdUlbOUptgZ8Mk602JTlf1VcYjE2h78XMykmKJpy7Ax3YFidHbz0u+zZl2zy7C7PaixmJ53j+tl7QWdcfTiG50eNumZ0m+FHGprnu9h0jyX6sjM0AJfKsTR6qIYswZ+HS2LYL/IdNKSuoACKrArrhg5CgTvVLCvML6msQEat+yQWodMeZ+kUXdSe4szEa2GaGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773025443; c=relaxed/relaxed;
	bh=wXruS7sYNNs5AqEinrpNUsbJNbVP+SAbifLRwxw2WSM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IITEy7yf9/esPadkI+pUEYRYiaH6Q21ozvBaVZEp8WbtPx/q1CmZfnsET5DfcOsetcPfonP4UyUAiEhR7Kke+ujMvoZs875MnCRF+eDWUomfgPiL5z9TnsVeAUxd//kMrYrHYoxYkj3EV96txFwW3ppCjKx6ByH5QtdIQlYGe1FFUDQxd9uK0URosoFLGvILZ5JV7lnociy76FNicW6ofFB9hREM7dC2iJWWVCy7aVtxOocfpbd/v2z/6hH9GI5ojttbr+l7HrCWpga/rcOUEIQw9gp3wCrromuYe5LBlhsMd6939n1A2+zksHCnfaRbSC60LDGlxDWpNhNiaGH0Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=R8Aovsa2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=R8Aovsa2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fThfw5Lkhz2xdL
	for <linux-erofs@lists.ozlabs.org>; Mon, 09 Mar 2026 14:03:50 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773025426; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=wXruS7sYNNs5AqEinrpNUsbJNbVP+SAbifLRwxw2WSM=;
	b=R8Aovsa2nqjv3kcnuAKsSnv9nART6aGXLCv5pxA1jIdtPdrGbEmU5YRmSYw3MzfrLpl0PujwjiNoxzsismhA+Vvv9GEa6UmbQAv5fbgzujtjJVgH8Xs2WSboUn+4e34GgSGQWFmA38N0IkQEgYcZTxiO5IB/ptHG4MnbejTIwvs=
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-TT8RS_1773025423 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Mar 2026 11:03:44 +0800
Message-ID: <02925ac8-64a6-4cd6-bbd4-c37d838f862a@linux.alibaba.com>
Date: Mon, 9 Mar 2026 11:03:43 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: introduce nolargefolio mount option
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Chunhai Guo <guochunhai@vivo.com>,
 Hongbo Li <lihongbo22@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260309023053.1685839-1-chao@kernel.org>
In-Reply-To: <20260309023053.1685839-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 92C6123370F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2536-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:guochunhai@vivo.com,m:lihongbo22@huawei.com,m:willy@infradead.org,m:jack@suse.cz,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com,linux.alibaba.com,google.com,vivo.com,huawei.com,infradead.org,suse.cz];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Chao,

(+cc -fsdevel, willy, Jan kara)

On 2026/3/9 10:30, Chao Yu wrote:
> This patch introduces a new mount option 'nolargefolio' for EROFS.
> When this option is specified, large folio will be disabled by
> default for all inodes, this option can be used for environments
> where large folio resources are limited, it's necessary to only
> let specified user to allocate large folios on demand.

For this kind of options, I think more real backgrounds
about avoiding high-order allocations are needed in the
commit message (at least for later reference) also like
what I observed in:
https://android-review.googlesource.com/c/kernel/common/+/3877981

because the entire community tends to enable large folios
unconditionally if possible.  Without enough clarification,
even I merge this, there will be endless questions again
and again about this.

And Jan once raised up if it should be a user interface
or auto-tuning one:
https://lore.kernel.org/r/z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5

My question is that if the needs are real, I wonder if
it should be a vfs generic decision instead (because
it's not due to the filesystem restriction but due to
real system memory pressure or heavy workload for
example).  However, if the answer is that others don't
really care about this, I'm fine to leave it as an
erofs-specific option as long as the actual case is
clear in the commit message.

Thanks,
Gao Xiang


> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   Documentation/filesystems/erofs.rst | 1 +
>   fs/erofs/inode.c                    | 3 ++-
>   fs/erofs/internal.h                 | 1 +
>   fs/erofs/super.c                    | 8 +++++++-
>   4 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index fe06308e546c..d692a1d9f32c 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -137,6 +137,7 @@ fsoffset=%llu          Specify block-aligned filesystem offset for the primary d
>   inode_share            Enable inode page sharing for this filesystem.  Inodes with
>                          identical content within the same domain ID can share the
>                          page cache.
> +nolargefolio           Disable large folio support for all files.
>   ===================    =========================================================
>   
>   Sysfs Entries
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 4b3d21402e10..26361e86a354 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -254,7 +254,8 @@ static int erofs_fill_inode(struct inode *inode)
>   		return 0;
>   	}
>   
> -	mapping_set_large_folios(inode->i_mapping);
> +	if (!test_opt(&EROFS_SB(inode->i_sb)->opt, NO_LARGE_FOLIO))
> +		mapping_set_large_folios(inode->i_mapping);
>   	aops = erofs_get_aops(inode, false);
>   	if (IS_ERR(aops))
>   		return PTR_ERR(aops);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index a4f0a42cf8c3..b5d98410c699 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -177,6 +177,7 @@ struct erofs_sb_info {
>   #define EROFS_MOUNT_DAX_NEVER		0x00000080
>   #define EROFS_MOUNT_DIRECT_IO		0x00000100
>   #define EROFS_MOUNT_INODE_SHARE		0x00000200
> +#define EROFS_MOUNT_NO_LARGE_FOLIO	0x00000400
>   
>   #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
>   #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 972a0c82198d..a353369d4db8 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -390,7 +390,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>   enum {
>   	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>   	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
> -	Opt_inode_share,
> +	Opt_inode_share, Opt_nolargefolio,
>   };
>   
>   static const struct constant_table erofs_param_cache_strategy[] = {
> @@ -419,6 +419,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>   	fsparam_flag_no("directio",	Opt_directio),
>   	fsparam_u64("fsoffset",		Opt_fsoffset),
>   	fsparam_flag("inode_share",	Opt_inode_share),
> +	fsparam_flag("nolargefolio",	Opt_nolargefolio),
>   	{}
>   };
>   
> @@ -541,6 +542,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		else
>   			set_opt(&sbi->opt, INODE_SHARE);
>   		break;
> +	case Opt_nolargefolio:
> +		set_opt(&sbi->opt, NO_LARGE_FOLIO);
> +		break;
>   	}
>   	return 0;
>   }
> @@ -1105,6 +1109,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   		seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
>   	if (test_opt(opt, INODE_SHARE))
>   		seq_puts(seq, ",inode_share");
> +	if (test_opt(opt, NO_LARGE_FOLIO))
> +		seq_puts(seq, ",nolargefolio");
>   	return 0;
>   }
>   


