Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE584D59C2
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 05:47:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFD223QtHz2yLv
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 15:47:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFD1v3V59z2xTd
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 15:47:29 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V6sF7sM_1646974040; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V6sF7sM_1646974040) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 11 Mar 2022 12:47:21 +0800
Date: Fri, 11 Mar 2022 12:47:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Anderson <dvander@google.com>
Subject: Re: [PATCH] erofs: rename ctime to mtime
Message-ID: <YirUWDjLn21E382Q@B-P7TQMD6M-0146.local>
References: <20220311041829.3109511-1-dvander@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220311041829.3109511-1-dvander@google.com>
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Fri, Mar 11, 2022 at 04:18:29AM +0000, David Anderson via Linux-erofs wrote:
> EROFS images should inherit modification time rather than creation time,
> since users and host tooling have no easy way to control creation time.
> To reflect the new timestamp meaning, i_ctime and i_ctime_nsec are
> renamed to i_mtime and i_mtime_nsec.
> 
> Signed-off-by: David Anderson <dvander@google.com>

Thanks for the patch!

This patch looks good to me, yet, should we update
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/erofs.rst#n43

here as well? (I think "Inode timestamp" might be fine..)

Thanks,
Gao Xiang

> ---
>  fs/erofs/erofs_fs.h | 5 +++--
>  fs/erofs/inode.c    | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 3ea62c6fb00a..1238ca104f09 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -12,6 +12,7 @@
>  #define EROFS_SUPER_OFFSET      1024
>  
>  #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
> +#define EROFS_FEATURE_COMPAT_MTIME              0x00000002
>  
>  /*
>   * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
> @@ -186,8 +187,8 @@ struct erofs_inode_extended {
>  
>  	__le32 i_uid;
>  	__le32 i_gid;
> -	__le64 i_ctime;
> -	__le32 i_ctime_nsec;
> +	__le64 i_mtime;
> +	__le32 i_mtime_nsec;
>  	__le32 i_nlink;
>  	__u8   i_reserved2[16];
>  };
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index ff62f84f47d3..e8b37ba5e9ad 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -113,8 +113,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>  		set_nlink(inode, le32_to_cpu(die->i_nlink));
>  
>  		/* extended inode has its own timestamp */
> -		inode->i_ctime.tv_sec = le64_to_cpu(die->i_ctime);
> -		inode->i_ctime.tv_nsec = le32_to_cpu(die->i_ctime_nsec);
> +		inode->i_ctime.tv_sec = le64_to_cpu(die->i_mtime);
> +		inode->i_ctime.tv_nsec = le32_to_cpu(die->i_mtime_nsec);
>  
>  		inode->i_size = le64_to_cpu(die->i_size);
>  
> -- 
> 2.35.1.723.g4982287a31-goog
