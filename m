Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25526DC2C6
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Apr 2023 04:37:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvtRW00jcz3chj
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Apr 2023 12:37:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=pxWB8fzv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=pxWB8fzv;
	dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PvtRM1vLxz3cL8
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Apr 2023 12:37:18 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id q15-20020a17090a2dcf00b0023efab0e3bfso6108721pjm.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 09 Apr 2023 19:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681094234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJAvQYUDOxzUKcGTIyZbrwZ4Tpc0SBrozV1xC/oTk4o=;
        b=pxWB8fzvDnc3amC3Tkk22AwcbpOHkozuAAgHGAYwjmeh7pmrTiBMTPBViLm7wKfpPw
         H9eZTQd2Ugy6J/M8cDHzg8cQwdpc+ufSUuuxUeQh0k8vcMC0lTTLMdZIKZRDNHlPKI70
         wuF2P03ZdW/1Oj0I/mV1SlatugFokBfgZ5nWTQ8xc1BGBIAdgLkW8LUqTqLdjH9+dX/2
         WSxMYAKLY24IWYi1XEeqoJsgqijRJnyCRAa3AIa0Z0A0yKM24XGub04KyN4ftO0G7x3m
         7qKb8kX1G7jV6ryDx9wS/xEuB6e0yB/Y5XczM+I0tPtetrES8H6zpACHk8U+swK4Of+C
         EY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681094234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJAvQYUDOxzUKcGTIyZbrwZ4Tpc0SBrozV1xC/oTk4o=;
        b=pCsk8dM7ibDo0OVBqgTW3xuKkxkkKJF6nsryO5sxZo6K3ZAiPIUGJSr14XN2stfF9k
         +vRS11RqYiZHIQBLhXQS9+8/4l1F56L5YsvmxFI7sCOEJITV+QMtkqlveKmO273F8Pu8
         GOVhxfeXwqFbvxPoiRvxvJAEfm/0qJe6tOiA0HaQ/x13U9AjtsO/IAV9q8jSx60eY2wx
         0TdVZt0uPukO7Z9elXRDHEXftBbIkDpISckokZ8O/FheJGfjcOadkwzh4FgDGf/9Quzt
         bS+YJI5exE19vW/AN8qgJeTmNULZiq4b3VJx/diz9T8aV6oGfYbFoMid/v98Eln2bwaQ
         G+Pw==
X-Gm-Message-State: AAQBX9cCRfzrOXppfFwjSSL1kDqVb3tEfTIN7z+MfqeNmjApw9uClNhH
	9I+MYnf6lplBRHeEG8LOYBg=
X-Google-Smtp-Source: AKy350YfAYtWo5umdFKRneFqqsLrxDAD/4Cpyd+QdhhY7iN32KeRimQobNKXGTAk/5NkGNamYUF44A==
X-Received: by 2002:a17:902:c942:b0:19e:6760:305b with SMTP id i2-20020a170902c94200b0019e6760305bmr14132268pla.47.1681094234481;
        Sun, 09 Apr 2023 19:37:14 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ea8200b001a1cf0744a2sm6509195plb.247.2023.04.09.19.37.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Apr 2023 19:37:14 -0700 (PDT)
Date: Mon, 10 Apr 2023 10:44:15 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 2/7] erofs: initialize packed inode after root inode is
 assigned
Message-ID: <20230410104415.00006ad2.zbestahu@gmail.com>
In-Reply-To: <20230407141710.113882-3-jefflexu@linux.alibaba.com>
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
	<20230407141710.113882-3-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri,  7 Apr 2023 22:17:05 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> As commit 8f7acdae2cd4 ("staging: erofs: kill all failure handling in
> fill_super()"), move the initialization of packed inode after root
> inode is assigned, so that the iput() in .put_super() is adequate as
> the failure handling.
> 
> Otherwise, iput() is also needed in .kill_sb(), in case of the mounting
> fails halfway.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/internal.h |  1 +
>  fs/erofs/super.c    | 22 +++++++++++-----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 2bcff3194e4a..caea9dc1cd82 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -157,6 +157,7 @@ struct erofs_sb_info {
>  
>  	/* what we really care is nid, rather than ino.. */
>  	erofs_nid_t root_nid;
> +	erofs_nid_t packed_nid;
>  	/* used for statfs, f_files - f_favail */
>  	u64 inos;
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 58ffbf410bfb..325602820dc8 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -388,17 +388,7 @@ static int erofs_read_superblock(struct super_block *sb)
>  #endif
>  	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
>  	sbi->root_nid = le16_to_cpu(dsb->root_nid);
> -#ifdef CONFIG_EROFS_FS_ZIP
> -	sbi->packed_inode = NULL;
> -	if (erofs_sb_has_fragments(sbi) && dsb->packed_nid) {
> -		sbi->packed_inode =
> -			erofs_iget(sb, le64_to_cpu(dsb->packed_nid));
> -		if (IS_ERR(sbi->packed_inode)) {
> -			ret = PTR_ERR(sbi->packed_inode);
> -			goto out;
> -		}
> -	}
> -#endif
> +	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
>  	sbi->inos = le64_to_cpu(dsb->inos);
>  
>  	sbi->build_time = le64_to_cpu(dsb->build_time);
> @@ -820,6 +810,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	erofs_shrinker_register(sb);
>  	/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
> +#ifdef CONFIG_EROFS_FS_ZIP
> +	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
> +		sbi->packed_inode = erofs_iget(sb, sbi->packed_nid);
> +		if (IS_ERR(sbi->packed_inode)) {
> +			err = PTR_ERR(sbi->packed_inode);
> +			sbi->packed_inode = NULL;
> +			return err;
> +		}
> +	}
> +#endif
>  	err = erofs_init_managed_cache(sb);
>  	if (err)
>  		return err;

