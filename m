Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8C92E06A2
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 08:13:10 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0SGr1HFwzDqRW
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 18:13:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=RBuCFu6G; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0SFn05cHzDqRR
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 18:12:12 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id v1so838697pjr.2
 for <linux-erofs@lists.ozlabs.org>; Mon, 21 Dec 2020 23:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rAs5nMuYIVMaOibAF4a21d1Ti/Y7wkqpyAPZ/4TpM44=;
 b=RBuCFu6G/+M0qSx/bncWInA73cbbKTJkYMTw+wJaM9g39YNHAR+136URfLH4mNiHo3
 GnM5glWpWXCiKcmGijsEAsk40OomWbgcfoMJ9rwSnKO90glMPD0qMF1qcslJaLjrEZ7I
 qG7ba3Z5QHcJNu/gN0X5BHx2fiJI5CJViv/cMnnm9l1KUmPsntCwb3CD9qhOCJMfRbRZ
 xWwBfGEvG+itE4vGa/LPzJA8/A5mz57zbKnAfHf0sZnWMYFZpyn9tz16aZt8WlkNmazy
 AoqJrEpVHVZutCR7IqJyCNIVB+nPje8524PvKMSuE0n2Zhc33+PGlaW3httOMUhk9AxF
 jkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rAs5nMuYIVMaOibAF4a21d1Ti/Y7wkqpyAPZ/4TpM44=;
 b=E47oFrPBjw9ae1mjZXjk9oHW2KBWgFZR0291fA9av7JdYz7mu83X3KHDBHShaPwajx
 AZZvQ9uFCORgV+nty2GGAslQdh/bf7fH9eHqTkIFhUbYRD9Usdc45Y7dpXt22/+jhXMe
 kNKqWC/oeSbeuiYnJs0M76x8FJ1o3VgnUPd4a67QuSu9ZxjgrvZq9VLF9e0uV9BGb+S2
 0j33eOjFOvBKTt4/yov5+DvDyaGTnYo0aZyjtgDQuYPemPVfwndUbhCu/gGPbc2FL7aC
 7f5zLMO27l2ol+TdBaMgToFBctUyN5QCRmb0dGlOvj01DGddZlmWD/AQaXybmwo6VRMa
 lOKA==
X-Gm-Message-State: AOAM530ggJkxkDW92NmbBYOWIftDGhY0Z7ameM5bYbitvWA0QB/HSMtt
 bg7mgyJrMbsboxww4U3FVq4=
X-Google-Smtp-Source: ABdhPJwRvRNt0UGiCztcL5pCXqxECW/W2mtXj5QZlDVE1iz/i/NiF2KXzT+nNUybgbbYDD+N7ipWfg==
X-Received: by 2002:a17:90a:c20d:: with SMTP id
 e13mr19962642pjt.185.1608621129443; 
 Mon, 21 Dec 2020 23:12:09 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id x143sm20224153pgx.66.2020.12.21.23.12.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Dec 2020 23:12:09 -0800 (PST)
Date: Tue, 22 Dec 2020 15:12:00 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222151118.00005b4a.zbestahu@gmail.com>
In-Reply-To: <20201222070458.GA1803221@xiangao.remote.csb>
References: <20201222020430.12512-1-zbestahu@gmail.com>
 <20201222034455.GA1775594@xiangao.remote.csb>
 <20201222124733.000000fe.zbestahu@gmail.com>
 <20201222063112.GB1775594@xiangao.remote.csb>
 <20201222070458.GA1803221@xiangao.remote.csb>
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
Cc: zbestahu@gmail.com, huyue2@yulong.com, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 22 Dec 2020 15:04:58 +0800
Gao Xiang <hsiangkao@redhat.com> wrote:

> Hi Yue,
> 
> On Tue, Dec 22, 2020 at 02:31:12PM +0800, Gao Xiang wrote:
> 
> ...
> 
> > 
> > Ok, I will try to find some clue to verify later.
> >   
> > >   
> > > >   
> > > > > Moreover, we should not add the mount point to fspath on root inode for
> > > > > fs_config() branch.    
> > > > 
> > > > Is there some descriptive words or reference for this? To be honest,
> > > > I'm quite unsure about this kind of Android-specific things... :(  
> > > 
> > > Refer to change: mksquashfs: Run android_fs_config() on the root inode
> > > 
> > > I think erofs of AOSP has this issue also. Am i right?  
> > 
> > Not quite sure if it effects non-canned fs_config after
> > reading the commit message...
> > https://android.googlesource.com/platform/external/squashfs-tools/+/85a6bc1e52bb911f195c5dc0890717913938c2d1%5E%21/#F0
> > 
> > And no permission to access Bug 72745016, so...
> > maybe we need to limit this to non-canned fs_config only?
> > (at least confirming the original case would be better)
> > 
> > BTW, Also, from its testcase command line in the commit message:
> > "mksquashfs path system.raw.img -fs-config-file fs_config -android-fs-config"
> > 
> > I'm not sure if "--mount-point" is passed in so I think for
> > such case no need to use such "goto" as well? 
> > 
> > Thanks,
> > Gao Xiang  
> 
> Could you verify the following patch if possible? (without compilation,
> I don't have test environment now since AOSP code is on my PC)


Ok, i will verify today.

Thx.

> 
> From: Yue Hu <huyue2@yulong.com>
> Date: Tue, 22 Dec 2020 14:52:22 +0800
> Subject: [PATCH] AOSP: erofs-utils: fix sub-directory prefix for canned
>  fs_config
> 
> "failed to find [%s] in canned fs_config" is observed by using
> "--fs-config-file" option under Android 10.
> 
> Notice that canned fs_config has a prefix to sub-directory if
> "--mount-point" presents. However, such prefix cannot be added by
> just using erofs_fspath().
> 
> Fixes: 8a9e8046f170 ("AOSP: erofs-utils: add fs_config support")
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
>  lib/inode.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 3d634fc..9469074 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -701,21 +701,25 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
>  	char *fspath;
>  
>  	inode->capabilities = 0;
> +	if (!cfg.mount_point)
> +		fspath = erofs_fspath(path);
> +	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> +			  erofs_fspath(path)) <= 0)
> +		return -ENOMEM;
> +
> +
>  	if (cfg.fs_config_file)
> -		canned_fs_config(erofs_fspath(path),
> +		canned_fs_config(fspath,
>  				 S_ISDIR(st->st_mode),
>  				 cfg.target_out_path,
>  				 &uid, &gid, &mode, &inode->capabilities);
> -	else if (cfg.mount_point) {
> -		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> -			     erofs_fspath(path)) <= 0)
> -			return -ENOMEM;
> -
> +	else
>  		fs_config(fspath, S_ISDIR(st->st_mode),
>  			  cfg.target_out_path,
>  			  &uid, &gid, &mode, &inode->capabilities);
> +
> +	if (cfg.mount_point)
>  		free(fspath);
> -	}
>  	st->st_uid = uid;
>  	st->st_gid = gid;
>  	st->st_mode = mode | stat_file_type_mask;

