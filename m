Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C45642E083F
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 10:46:48 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0Wh572B6zDqQX
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 20:46:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436;
 helo=mail-pf1-x436.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=eLCuWvcG; dkim-atps=neutral
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0Wh34dVwzDqCp
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 20:46:38 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id t8so8156183pfg.8
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 01:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dq7BAd4htKw3yt+EAcZf5ADVeT0CGb01UXCAGGlIXh8=;
 b=eLCuWvcGkmqkuUo+eyvRHimUa943hpIbBz4gkRwpwB6m12i7jR22NfC8Ls68i65Gvc
 eCJzHCDVyOynI4RwrPjUOtIYe8NEdfbUIo4Ts8BjiqPk9+ktU2ti/zaixh5FYYaWg/qn
 qRdZ1E0Qujv6RgNqveRN/OOS3M09y/w5BmaxxwnyzLz18DJu1j3qSq9bgW1cqZnHJxOO
 pjnZM4IDQ3bqMaRRue4RLVS0sAqzE4GFDFfpNvAC5qUqXL7a0vkgyNasoc6XCdhl2hS8
 6SYvCteifsKV4Qx18Di+OBS3VEupVkqE2G+ozE3dLHG3Vn7MmAnTBKHw5nvSrBxd//TT
 nnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dq7BAd4htKw3yt+EAcZf5ADVeT0CGb01UXCAGGlIXh8=;
 b=L3JQAhnswZ7VT+FY3Js/4khLZ+h28g6S73vwpuYxceW4HHdMKnxkIvV/tnoLfPPB/C
 k9vUvHaAAwpxBihBAU5dw1RSXIDn24XCk4MUGF0ZB7AzqGyEHw7SsVqKB+24lTDOHhlW
 X/dC663USJ0rCCU9W2sJWsIrngVfvbHbUmPkPU4XAUSW+8bTiFVt+rNSEGeGIQYWPfj1
 oCwQAk8GlH6aZM6cJ/ZjLfTg3EMd5fmaqKmvT71DF/eArijH6nBxf/kdOqq+JGfQJc+d
 fWW/GTH1gJHZQFgl4LGl9CU8kvSdDHReS0MLTLa0LhY/BB8Kjbu+J5DL8gr9iqgjQ/ss
 DiZw==
X-Gm-Message-State: AOAM532Cp+q4rJNM5vnNyB/Tqz5CD6uRJLZBJqp1Kmc9bT/0WCfk4q8B
 WDzC40YnDSadlz4mPJV/GRo=
X-Google-Smtp-Source: ABdhPJxIwhe6qs9hUlEGYMQz0oJfWbc9lPQiyrT10m+dhXyKKdkJcXpxPj6YKDsTbSg2TNeeTpefqQ==
X-Received: by 2002:aa7:9ac9:0:b029:19e:19b6:6e09 with SMTP id
 x9-20020aa79ac90000b029019e19b66e09mr18985396pfp.49.1608630395097; 
 Tue, 22 Dec 2020 01:46:35 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id q15sm8079690pgk.11.2020.12.22.01.46.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Dec 2020 01:46:34 -0800 (PST)
Date: Tue, 22 Dec 2020 17:46:23 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222174623.00005f9b.zbestahu@gmail.com>
In-Reply-To: <20201222093952.GC1819755@xiangao.remote.csb>
References: <20201222020430.12512-1-zbestahu@gmail.com>
 <20201222034455.GA1775594@xiangao.remote.csb>
 <20201222124733.000000fe.zbestahu@gmail.com>
 <20201222063112.GB1775594@xiangao.remote.csb>
 <20201222070458.GA1803221@xiangao.remote.csb>
 <20201222160935.000061c3.zbestahu@gmail.com>
 <20201222091340.GA1819755@xiangao.remote.csb>
 <20201222173014.000055d3.zbestahu@gmail.com>
 <20201222093952.GC1819755@xiangao.remote.csb>
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

On Tue, 22 Dec 2020 17:39:52 +0800
Gao Xiang <hsiangkao@redhat.com> wrote:

> On Tue, Dec 22, 2020 at 05:30:14PM +0800, Yue Hu wrote:
> 
> ...
> 
> > > > 
> > > >     
> > > > > +	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > > > > +			  erofs_fspath(path)) <= 0)    
> > > > 
> > > > The argument of path will be root directory. And canned fs_config for root directory as
> > > > below:
> > > > 
> > > > 0 0 755 selabel=u:object_r:rootfs:s0 capabilities=0x0
> > > > 
> > > > So, cannot add mount point to root directory for canned fs_config. And what about non-canned
> > > > fs_config?    
> > > 
> > > Not quite sure what you mean. For non-canned fs_config, we didn't observed any strange
> > > before (I ported to cuttlefish and hikey960 with boot success, also as I mentioned before
> > > some other vendors already use it.)
> > > 
> > > I think the following commit is only useful for squashfs since its (non)root inode
> > > workflows are different, so need to add in two difference place. But mkfs.erofs is not.
> > > https://android.googlesource.com/platform/external/squashfs-tools/+/85a6bc1e52bb911f195c5dc0890717913938c2d1%5E%21/#F0
> > > 
> > > For root inode is erofs, I think erofs_fspath(path) would return "", so that case
> > > is included as well.... Am I missing something?  
> > 
> > Yes, erofs_fspath(path) returns "" for root inode. However, the above patch add the mount
> > point to fspath when specify it, so the real path is "vendor/" which does not exist in canned
> > fs_config file. build will report below error:
> > 
> > failed to find [/vendor/] in canned fs_config  
> 
> Hmmm... such design is quite strange for me....

:) i checked the squashfs before, seems root directory is handled in some position. Separated
with sub directory fs_config. so i add the goto code in the 1st patch.

> Could you try the following diff?

Let's me verify.

> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 9469074..9af6179 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -698,11 +698,14 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
>  	/* filesystem_config does not preserve file type bits */
>  	mode_t stat_file_type_mask = st->st_mode & S_IFMT;
>  	unsigned int uid = 0, gid = 0, mode = 0;
> +	bool alloced;
>  	char *fspath;
>  
>  	inode->capabilities = 0;
> -	if (!cfg.mount_point)
> -		fspath = erofs_fspath(path);
> +
> +	alloced = (cfg.mount_point && erofs_fspath(path)[0] != '\0');
> +	if (!alloced)
> +		fspath = (char *)erofs_fspath(path);
>  	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
>  			  erofs_fspath(path)) <= 0)
>  		return -ENOMEM;
> @@ -718,7 +721,7 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
>  			  cfg.target_out_path,
>  			  &uid, &gid, &mode, &inode->capabilities);
>  
> -	if (cfg.mount_point)
> +	if (alloced)
>  		free(fspath);
>  	st->st_uid = uid;
>  	st->st_gid = gid;
> 
> if it works, will redo a formal patch then....
> 
> Thanks,
> Gao Xiang
> 
> >   
> > > 
> > > Thanks,
> > > Gao Xiang
> > >   
> > > > 
> > > > Thx.
> > > > 
> > > >     
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +
> > > > >  	if (cfg.fs_config_file)
> > > > > -		canned_fs_config(erofs_fspath(path),
> > > > > +		canned_fs_config(fspath,
> > > > >  				 S_ISDIR(st->st_mode),
> > > > >  				 cfg.target_out_path,
> > > > >  				 &uid, &gid, &mode, &inode->capabilities);
> > > > > -	else if (cfg.mount_point) {
> > > > > -		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > > > > -			     erofs_fspath(path)) <= 0)
> > > > > -			return -ENOMEM;
> > > > > -
> > > > > +	else
> > > > >  		fs_config(fspath, S_ISDIR(st->st_mode),
> > > > >  			  cfg.target_out_path,
> > > > >  			  &uid, &gid, &mode, &inode->capabilities);
> > > > > +
> > > > > +	if (cfg.mount_point)
> > > > >  		free(fspath);
> > > > > -	}
> > > > >  	st->st_uid = uid;
> > > > >  	st->st_gid = gid;
> > > > >  	st->st_mode = mode | stat_file_type_mask;    
> > > >     
> > >   
> >   
> 

