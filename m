Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DAA2E0711
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 09:11:28 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0TZ52mzlzDqQh
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 19:11:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a;
 helo=mail-pl1-x62a.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=HfMWoHG0; dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0TYx0ltqzDqQS
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 19:11:14 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id r4so7019602pls.11
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 00:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FIZr8REIKcdh25/ig1dxr/9jUdUT51ksELvWPS3GJVg=;
 b=HfMWoHG0WZz2wO7W6mu+DtqZAAItpOf4o3KjTV8KEL9iRWjjKM5UmRdkU1Glf2Xx+I
 nhiEfNxtbi9i/h5R/upiqglBVBi0Hi97Pyd/onFadn9/9CyrJMzAFHpMDrOX8sIyA51N
 kR3jvNbQRNYT839E6R7Ch2oINiJhDWL1/ddn3+m1B39l/wJG5J1LheTR9TJuK66CUwoj
 esg3YYpJoR/i5/ojqRtyLIDJB+9TToayY9km/ckjsPEugVPcxtc9sDO7uELQIqXQhIC4
 9duxA08hhI8SE13RxE/Og2PQcsBio0zHC8SzGtUQ5o8klIgdvn44oRb2vQRlsiVNb8Kj
 glsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FIZr8REIKcdh25/ig1dxr/9jUdUT51ksELvWPS3GJVg=;
 b=hjTTBU3w8bJUBCJ1IPcQ2qJMIed434QU0j4HzUZCL2oZmqiqIn9GOmjrbKZFDSspEU
 NORd9CHNicdApqFree4d/JCAyQ6xnuFV9vscwHEL6JyUTUFWvPIAG4f7V2LN2s77JyJp
 LAicG/PDba+sbYhMFeBTcMQgSWwCM5ES4pb76FgHkp0ukmXhJF57lNLZNx/tqJE0XQ4e
 92mVURJX3QbyiPzjZvYGUmXZpV+qMSRZNEtqcxselCwjmRMMaoT5sDK5WhyNfKbDp+d3
 j5UBn0t3yXBq0Dn4H9BT1CnO5RtOU9ME40fjUpF5wzn1j77EzarN6MAahoNHDyVw/Dqw
 QGyA==
X-Gm-Message-State: AOAM532aTsIZqVNe6kJoe3FxZsBt6OAO/DjKJ4dNEb5noehEyIhr2tAD
 nxcFcspCo7j9SQ3S7oJRjpY=
X-Google-Smtp-Source: ABdhPJwADFOhSud0vLmvpIYKKcUPlWU5iTNSIQzvjS5VBgyDArE69VK8OjMmTJKRyLQOXVK3NwV+5A==
X-Received: by 2002:a17:902:521:b029:dc:2836:ec17 with SMTP id
 30-20020a1709020521b02900dc2836ec17mr19970981plf.47.1608624670754; 
 Tue, 22 Dec 2020 00:11:10 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id 5sm18888559pff.125.2020.12.22.00.11.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Dec 2020 00:11:10 -0800 (PST)
Date: Tue, 22 Dec 2020 16:10:58 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222160935.000061c3.zbestahu@gmail.com>
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@yulong.com
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

lib/inode.c:688:10: error: assigning to 'char *' from 'const char *' discards...
                fspath = erofs_fspath(path);
                       ^ ~~~~~~~~~~~~~~~~~~

-           fspath = erofs_fspath(path);
+         fspath = (char *)erofs_fspath(path);


> +	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> +			  erofs_fspath(path)) <= 0)

The argument of path will be root directory. And canned fs_config for root directory as
below:

0 0 755 selabel=u:object_r:rootfs:s0 capabilities=0x0

So, cannot add mount point to root directory for canned fs_config. And what about non-canned
fs_config?

Thx.


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

