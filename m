Return-Path: <linux-erofs+bounces-1552-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D52CD861F
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 08:25:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db6434vQJz2xlP;
	Tue, 23 Dec 2025 18:25:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766474739;
	cv=none; b=m3ci22yqRbtI/aLnO7Hx0WAhCtMgw6EsKNgzXkJrnVuJCdEXgSlDN7dBz7Cda8HUD42cDv7Vd+ToByj8/SccYVzlf0CNrlTnzwOmiy9JUaks5ru6UogIupUWqSw2A+HsXObK06zS/QPYh0kHhcBLTTELSL41I+iFrnx7+j5TLZYI3nLiX3bWcZ9wxDiCtyxx+ooLSBDlHQWQDpe5v43kdJbS9BZCRifYFQjAes8uDQyL1/tgNTeDinKapX4yurxDl4ULPwY1Ztb0pLAkAWQ+ywlF8uThNa12q0g5XP6S6aO6D9LbWm/dqFzHlhCR3Tk6MQ7u9D3DS7QUgJCMSI2GhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766474739; c=relaxed/relaxed;
	bh=tQ5aaW+JIVi4pwu5f+2uAzYLLI/373W8689SDLPl7io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhszZaSGHHHTvnW7+OjOG+Nxp5GvUSYclVVOxedlhOwpO2M5hL5rlzaY/3kjwyoLoqy08j6NLhp21RYxyLjboApMJOY24CDleIvG8o1kbTdvDSme1pCSHCjIofnSo2Za49N0RRM735I95kP3jL6rAuHwePncN49uXUtUtClyEAkyJAKFV8utMvky5jOWLaX8t45usbSQgLZWWRXfjJfJAy/eotwwIaflOfEIidQICcztXVMiENdMid4xoAFtwY+7LP3nhz0FcK4j6MCw4VtdMn4+i2un9Z4TMUhnhrHZ/k/LJcDMJqS2Bof4EIoOCPchSDhrEZbDkeKR7OycEPNPiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o1h0nrTa; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o1h0nrTa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db6420MLFz2x99
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 18:25:37 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766474732; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tQ5aaW+JIVi4pwu5f+2uAzYLLI/373W8689SDLPl7io=;
	b=o1h0nrTaRdQTl5yRD+CUCJjuDf83RjK233lj5qho8wy/ySDtC84NNM6t6HoCosbddyKYQKTHYLOuwpSPVifg4RCKDM2OUqsluah7UHLrFeQIqt9cOfG/nrodVusTuRG6j6pS0pqxA/JGMHDuOVjb0kaF2w/SprpReD2KLkEgh9g=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvWoHI2_1766474731 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 15:25:31 +0800
Message-ID: <94872052-84c3-4163-9bea-3ec9d5778b23@linux.alibaba.com>
Date: Tue, 23 Dec 2025 15:25:30 +0800
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
Subject: Re: [PATCH v10 06/10] erofs: support domain-specific page cache share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-7-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-7-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/23 09:56, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Only files in the same domain will share the page cache. Also modify
> the sysfs related content in preparation for the upcoming page cache
> share feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/super.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 68480f10e69d..be9f96252c6c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -518,6 +518,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		if (!sbi->fsid)
>   			return -ENOMEM;
>   		break;
> +#endif
> +#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
>   	case Opt_domain_id:
>   		kfree(sbi->domain_id);
>   		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
> @@ -618,7 +620,7 @@ static void erofs_set_sysfs_name(struct super_block *sb)
>   {
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   
> -	if (sbi->domain_id)
> +	if (sbi->domain_id && !erofs_sb_has_ishare_xattrs(sbi))
>   		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
>   					     sbi->fsid);
>   	else if (sbi->fsid)
> @@ -1052,6 +1054,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   #ifdef CONFIG_EROFS_FS_ONDEMAND

here.

>   	if (sbi->fsid)
>   		seq_printf(seq, ",fsid=%s", sbi->fsid);
> +#endif
> +#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)

I think we could just kill these `#if` entirely since
`sbi->domain_id` and `sbi->fsid` are defined
unconditionally.

Otherwise it looks good to me:
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

