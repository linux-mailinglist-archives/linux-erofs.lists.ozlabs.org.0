Return-Path: <linux-erofs+bounces-104-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CC3A6C6DF
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Mar 2025 02:22:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKM4s3vBWz2ytg;
	Sat, 22 Mar 2025 12:22:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742606573;
	cv=none; b=OKQsiMq4N9pSCcZTZ7hMHVHVdqnmz4NlOR9Qn1bqMgx80g2VsDp4Lc15bW9Vbdtnarc6XlVzUt4YdKGY/RX55FhNp606RTQxkexnSldWjj+mLF9R56RjKmi3xjCrFqjlKrNme9t2KXOOl40s8PIcrpCeow5FW/Gb5VM17ZvJhPBBrh7QW0hOzVpdUN3oA6d889M43gBYUk4qoXMQGy+4fySn7y8HLJkiQwpDNgwdurNM4aB+10/zaQoR4sBzLgMmKBEsCX1nuE7nRd6ybOb+IVtbDvTFfI5rnnVPuHes3JKoHs8QN8WMSK+N2PkgPuw5LrTUHTCjBC3iZLdC16rDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742606573; c=relaxed/relaxed;
	bh=Whi0+D9X3ZV2w4nG1x+bBNyDlslenHwDy7JMgCI9WOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yqi7geMCnKl1oGl5aviKTAG1nK9OOPcb4cKP8399l7QE3IU/fdI7X6yAhjvFklkVTccjGSfGyjSk1ntaLzI6MlbNVP7hEM8d40j5HUanEy83AEL7FAmFpKdfbTPBPqBXKVSKN8MVF0zhJkwgfgWWsJM+bw3oqs99w1ivUpVLlTsl9QO+dtz8MheyJDrDPRQe5B7PFhoiaXtyswT0kOtNljOeVhBUDmlIIY21OdV7aGPPPfSCitRAoyEEHs+92lcTz9YocSJF52/PT1sopDdw0a2/J3dc/7FrNgHr2WEQ6PdCyBsXQrxbT60fsG9A3dSLujnnUiR+aeLPz7JCmqM7Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKM4r3blrz2ydj
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Mar 2025 12:22:51 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZKM0x6fPkzFrCy
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Mar 2025 09:19:29 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A4D11800B4
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Mar 2025 09:22:45 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Mar 2025 09:22:44 +0800
Message-ID: <b9fccfab-77bc-4a77-b480-e8da1995e520@huawei.com>
Date: Sat, 22 Mar 2025 09:22:43 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 3/7] erofs: support domain-specific page cache
 share
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
 <20250301145002.2420830-4-hongzhen@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250301145002.2420830-4-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-3.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/3/1 22:49, Hongzhen Luo wrote:
> Only files in the same domain will share the page cache. Also modify
> the sysfs related content in preparation for the upcoming page cache
> share feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   fs/erofs/super.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 6af02cc8b8c6..ceab0c29b061 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -489,6 +489,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		if (!sbi->fsid)
>   			return -ENOMEM;
>   		break;
> +#endif
> +#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_INODE_SHARE)
>   	case Opt_domain_id:
>   		kfree(sbi->domain_id);
>   		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
> @@ -558,16 +560,16 @@ static void erofs_set_sysfs_name(struct super_block *sb)
>   {
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   
> -	if (sbi->domain_id)
> +	if (sbi->domain_id && !sbi->ishare_key)
>   		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
>   					     sbi->fsid);
>   	else if (sbi->fsid)
>   		super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
> -	else if (erofs_is_fileio_mode(sbi))
I think there is no need to change this, because the inode page cache is 
just a mode for reading, not like a super block type.
> +	else if (!sb->s_bdi || !sb->s_bdi->dev)
> +		super_set_sysfs_name_id(sb);
> +	else
>   		super_set_sysfs_name_generic(sb, "%s",
>   					     bdi_dev_name(sb->s_bdi));
> -	else
> -		super_set_sysfs_name_id(sb);
>   }
>   
>   static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
> @@ -965,6 +967,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>   	if (sbi->fsid)
>   		seq_printf(seq, ",fsid=%s", sbi->fsid);
> +#endif
> +#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_INODE_SHARE)
>   	if (sbi->domain_id)
>   		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
>   #endif

