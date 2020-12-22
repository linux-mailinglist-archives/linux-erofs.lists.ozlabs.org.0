Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEB2E08DD
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 11:34:33 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0XlB6R3XzDqQS
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 21:34:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533;
 helo=mail-pg1-x533.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Zjme9bqp; dkim-atps=neutral
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0Xl85FJHzDqPF
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 21:34:28 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id f17so8105199pge.6
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 02:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1mZTeWHyH/oBLljdi98lEPG/b0r0aBjTvVQ8Ad8s0rE=;
 b=Zjme9bqpYNP5MHiQmEXmylUxjYTeRiFYFy8h/bhxvbGtSqk1jG0ATKgmk+EWbWB5J5
 5lxKVqZZ7Za1rmARcu8srhoBgJdjTjYX14iusQPUAyACQevq8PyBAQru/tNZQfOPpgo2
 sPJmN5LJa8JzWTINe/+ajxwnZQoZnNeGkrEHp29ZF4EqJrpsp5D2qyBeX+0L6tdAVtDT
 nMx2tsMWHoJBMC6ctO8SkaTOfHFUeAabQo0ZCvmYHXi3DsxfjmnyMn9XtR5VSu3NNtMX
 aLyIhh/fD1FAc71Pk8IGDLiPDpE4Ls0ZGcZ3hJOESawDLk+1VBrwHdzfnszvNgCZkb4E
 aHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1mZTeWHyH/oBLljdi98lEPG/b0r0aBjTvVQ8Ad8s0rE=;
 b=iDVtyIgZMUDQg+Ah5uEmgPEEug+oxNpgtGtmpiBDwgaVh9LgvEhMPg5yOebKKdrOso
 vclpqMNDiQdep8lSeQyKKa3wK+4bRF9J0IxLZLIQEVt+UDjg6YYU6ZE22aoXoheONg/y
 FqZHuSmA6erbSbZaz54QqfehnYpd4pQUxsiv26ny3b63ien0OlO4SenwJb9n0G2JTf6g
 lR3GJoYlcm4PU+GCSyJF8ZqqZRpX0e0q3Wo8TIXBrs2mSVkHNwzpKoS8AziJXyzwqseb
 8wUvnX1xZdHoE3pYLAOw2MoGpL9ILkk+/1ZkUk9yWIsECMFKua6g+AQiio+1WRYPKiCW
 pg2A==
X-Gm-Message-State: AOAM5314oHjnIpPht+3sw7vCd76JNGEz8mkWdcH/mqXjf+eWKS2OdN6+
 H7Y9E+I9oJhf1OPiw6+12rM=
X-Google-Smtp-Source: ABdhPJwuEwlPf1duMq6Mz4S5fcFMv3EXSIl3xNhlQBMZDvOPiJsmqs+bituRAdlmCZhlbPv8cCsOeQ==
X-Received: by 2002:a63:b1e:: with SMTP id 30mr19129338pgl.203.1608633264170; 
 Tue, 22 Dec 2020 02:34:24 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id p22sm21252465pgk.21.2020.12.22.02.34.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Dec 2020 02:34:23 -0800 (PST)
Date: Tue, 22 Dec 2020 18:34:11 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222183411.00004854.zbestahu@gmail.com>
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
> Could you try the following diff?
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

Works for me for canned fs_config.

Thx.

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

