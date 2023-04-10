Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586286DC2CB
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Apr 2023 04:38:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvtSq17gxz3chj
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Apr 2023 12:38:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=HO0JdJmI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=HO0JdJmI;
	dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PvtSm0zkfz3cL8
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Apr 2023 12:38:31 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id v9so8278712pjk.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 09 Apr 2023 19:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681094309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCtGUQFe5Dbm6hG4sTfRdcAn7odOh+gle3cljKvZY1A=;
        b=HO0JdJmIvIlkeoqzcxm4OquQFOW5UQPR8tciBqzwYuMnvnaNbD0TvRUyoG7T8ZbODD
         Jr3O3ucLkb4EYdU/pC37Xh3ZrYEuRYbIcx3fZarqPgNGpyhtp7VoxQzOy2paGNzWqE/r
         A13dC4fKnhWNSdbiZGLXk+fquwXoIPMDdTUNZCDHqFH1LQNdEJPcazrbm0iS1plSOrnE
         rMEzQPRVYRlbDGisPNI2KOUQZe8JdmvNbm5Gjy4tXxNQS/IuLcdpNjMDe0z/JACV4fGx
         KmcwS6oFO+6w2ju6O+kiNhmKhWfxsS6j3vBPZMiuS67WQ84ZQwa0fxSZM6qMBxuDhcwN
         ac1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681094309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCtGUQFe5Dbm6hG4sTfRdcAn7odOh+gle3cljKvZY1A=;
        b=1i7hpBT1b4bi3I3r4wzslVteG442uWc5pXzQQGpEgjwwOTH8UMIUn6MVTJh1sBE6p3
         CWxowN9cHJ6KZhPXidpcaABKvOQFe85Z+Yhf8CnbEw4x8t2ClvDDAIgRwKn2kFGRbh1j
         XoGYF7UNs+9Yt56fRemXYFHEUKWI1zobbAUeLQr/kdIVZC9xbx0eNYVY6vGUyxkObflP
         ShlxqbCIpPhFN74LopsutFodTteZNFvUBEeyc9mwklPGcj2wuk/L6bDcQMa0y7tcCnWD
         PTgne9txGATtptJNe/w0AO34NrykPjyQyC0tJbgY/7qng0A2Ve3wMoWTzDIke623yRPW
         YG/g==
X-Gm-Message-State: AAQBX9fiJH5JBxeAgcTkvT228HE4rhQEkMowI4orOqfsbOM2xBebCsBA
	D01XWKkGa1UOI8AQmSFe+wk=
X-Google-Smtp-Source: AKy350YmT/B2xIHq1k5QPFp0mwZibS3LCgetSwB+W8Tvl5wdry74Po3rJy4g1mvxEqMICzO9iU2AVA==
X-Received: by 2002:a05:6a20:3b28:b0:de:6e42:e0e5 with SMTP id c40-20020a056a203b2800b000de6e42e0e5mr9400995pzh.13.1681094308667;
        Sun, 09 Apr 2023 19:38:28 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id j11-20020aa78dcb000000b005e4c3e2022fsm6740568pfr.72.2023.04.09.19.38.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Apr 2023 19:38:28 -0700 (PDT)
Date: Mon, 10 Apr 2023 10:45:32 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 3/7] erofs: move packed inode out of the compression
 part
Message-ID: <20230410104532.000034fa.zbestahu@gmail.com>
In-Reply-To: <20230407141710.113882-4-jefflexu@linux.alibaba.com>
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
	<20230407141710.113882-4-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri,  7 Apr 2023 22:17:06 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> packed inode could be used in more scenarios which are independent of
> compression in the future.
> 
> For example, packed inode could be used to keep extra long xattr
> prefixes with the help of following patches.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/internal.h | 2 +-
>  fs/erofs/super.c    | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index caea9dc1cd82..8b5168f94dd2 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -134,8 +134,8 @@ struct erofs_sb_info {
>  	struct inode *managed_cache;
>  
>  	struct erofs_sb_lz4_info lz4;
> -	struct inode *packed_inode;
>  #endif	/* CONFIG_EROFS_FS_ZIP */
> +	struct inode *packed_inode;
>  	struct erofs_dev_context *devs;
>  	struct dax_device *dax_dev;
>  	u64 dax_part_off;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 325602820dc8..8f2f8433db61 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -810,7 +810,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	erofs_shrinker_register(sb);
>  	/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
> -#ifdef CONFIG_EROFS_FS_ZIP
>  	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
>  		sbi->packed_inode = erofs_iget(sb, sbi->packed_nid);
>  		if (IS_ERR(sbi->packed_inode)) {
> @@ -819,7 +818,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  			return err;
>  		}
>  	}
> -#endif
>  	err = erofs_init_managed_cache(sb);
>  	if (err)
>  		return err;
> @@ -986,9 +984,9 @@ static void erofs_put_super(struct super_block *sb)
>  #ifdef CONFIG_EROFS_FS_ZIP
>  	iput(sbi->managed_cache);
>  	sbi->managed_cache = NULL;
> +#endif
>  	iput(sbi->packed_inode);
>  	sbi->packed_inode = NULL;
> -#endif
>  	erofs_free_dev_context(sbi->devs);
>  	sbi->devs = NULL;
>  	erofs_fscache_unregister_fs(sb);

