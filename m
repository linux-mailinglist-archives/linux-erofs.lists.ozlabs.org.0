Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CEABD2E081E
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 10:30:37 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0WKR17thzDqQd
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 20:30:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c;
 helo=mail-pf1-x42c.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=t2R0ej3P; dkim-atps=neutral
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0WKN5VXlzDqPm
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 20:30:30 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id x126so8128399pfc.7
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 01:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=muqVJc+8qUWW94T4XJRuB2BzSDTLBbaDOkHska+SPWw=;
 b=t2R0ej3PT7lDW8oH9mHnSyNojvWK/teSTANJnWyaOc+BUR7mWDAzWxS/JWT1N9k1oy
 Hcqe9J8SrkIBPO3JZ1gJu0tp/tjnVDC0gs1THydk6zxbm2wFpnAQXTO36kkdY1okPNUb
 EF4FcDAttPpF2mQBGXr/9xX2V6Zg/e4f/wO57FNbs/C9HOpIzt/uJzFn5VZv32nxkVOV
 AqVR4oLu5PAcqdZIz66Bj4zfKfg/NjvFbGIMeX/hii2pkz5aGlAkKQEQpZmGQHP5I5hU
 14ekY9+6szlkfCFyTZ8+mnF7WwdaMePatDQ2X7zfN6cCLGJ3mQ1VvEGj+aLzWy0XW9FJ
 DHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=muqVJc+8qUWW94T4XJRuB2BzSDTLBbaDOkHska+SPWw=;
 b=QJP7MFqaavY03gKMkgOU7/df43shDkykJNUWNw02bRfaBEE8U1hS3MwM+jgwEcxwDT
 AmzrKcPAhpcA1akcpcpiPf61MQeeoyTKLgiHQduUtBQ4Pl1VeUtJ2gF+jbSPd++dUBUx
 nDlPZ7nx3rdewbNs43O3GBPHQPXAWgB3wwsb1Gn+kJejK/DYu8PSxuaR9nXjFFsaVK7b
 9b3o5JPqTB6jvy5U3CoMboaQPEUWU3vYQkmVtEzNcEFHPika4nHYlZDdpe9Hkmy7ThfX
 miH6aMXj9uNzdRsEalHhz4+RhAWKFGcYHB0Oy5uBDMljqm1m7otWjnqpwdqarbYliy4I
 OkFA==
X-Gm-Message-State: AOAM531rhj7dIPGa23wZM0O5c049Dc56LgnzYye6feRfRpc+viR7djKJ
 bOE4w9eNpPu57dV0Q48gZacVz5tw15OgqA==
X-Google-Smtp-Source: ABdhPJwSSIXnFMGFi1gD7bxCI1OPlU+UddJh4jqOXaJ6TD7JW1T+6dBGT0gzBoPb4u4pXiwTZtkdXQ==
X-Received: by 2002:a65:6782:: with SMTP id e2mr18801289pgr.424.1608629426712; 
 Tue, 22 Dec 2020 01:30:26 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id s1sm19711958pjk.1.2020.12.22.01.30.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Dec 2020 01:30:26 -0800 (PST)
Date: Tue, 22 Dec 2020 17:30:14 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222173014.000055d3.zbestahu@gmail.com>
In-Reply-To: <20201222091340.GA1819755@xiangao.remote.csb>
References: <20201222020430.12512-1-zbestahu@gmail.com>
 <20201222034455.GA1775594@xiangao.remote.csb>
 <20201222124733.000000fe.zbestahu@gmail.com>
 <20201222063112.GB1775594@xiangao.remote.csb>
 <20201222070458.GA1803221@xiangao.remote.csb>
 <20201222160935.000061c3.zbestahu@gmail.com>
 <20201222091340.GA1819755@xiangao.remote.csb>
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

On Tue, 22 Dec 2020 17:13:40 +0800
Gao Xiang <hsiangkao@redhat.com> wrote:

> On Tue, Dec 22, 2020 at 04:10:58PM +0800, Yue Hu wrote:
> > On Tue, 22 Dec 2020 15:04:58 +0800
> > Gao Xiang <hsiangkao@redhat.com> wrote:
> >   
> > > Hi Yue,
> > > 
> > > On Tue, Dec 22, 2020 at 02:31:12PM +0800, Gao Xiang wrote:
> > > 
> > > ...
> > >   
> > > > 
> > > > Ok, I will try to find some clue to verify later.
> > > >     
> > > > >     
> > > > > >     
> > > > > > > Moreover, we should not add the mount point to fspath on root inode for
> > > > > > > fs_config() branch.      
> > > > > > 
> > > > > > Is there some descriptive words or reference for this? To be honest,
> > > > > > I'm quite unsure about this kind of Android-specific things... :(    
> > > > > 
> > > > > Refer to change: mksquashfs: Run android_fs_config() on the root inode
> > > > > 
> > > > > I think erofs of AOSP has this issue also. Am i right?    
> > > > 
> > > > Not quite sure if it effects non-canned fs_config after
> > > > reading the commit message...
> > > > https://android.googlesource.com/platform/external/squashfs-tools/+/85a6bc1e52bb911f195c5dc0890717913938c2d1%5E%21/#F0
> > > > 
> > > > And no permission to access Bug 72745016, so...
> > > > maybe we need to limit this to non-canned fs_config only?
> > > > (at least confirming the original case would be better)
> > > > 
> > > > BTW, Also, from its testcase command line in the commit message:
> > > > "mksquashfs path system.raw.img -fs-config-file fs_config -android-fs-config"
> > > > 
> > > > I'm not sure if "--mount-point" is passed in so I think for
> > > > such case no need to use such "goto" as well? 
> > > > 
> > > > Thanks,
> > > > Gao Xiang    
> > > 
> > > Could you verify the following patch if possible? (without compilation,
> > > I don't have test environment now since AOSP code is on my PC)
> > > 
> > > From: Yue Hu <huyue2@yulong.com>
> > > Date: Tue, 22 Dec 2020 14:52:22 +0800
> > > Subject: [PATCH] AOSP: erofs-utils: fix sub-directory prefix for canned
> > >  fs_config
> > > 
> > > "failed to find [%s] in canned fs_config" is observed by using
> > > "--fs-config-file" option under Android 10.
> > > 
> > > Notice that canned fs_config has a prefix to sub-directory if
> > > "--mount-point" presents. However, such prefix cannot be added by
> > > just using erofs_fspath().
> > > 
> > > Fixes: 8a9e8046f170 ("AOSP: erofs-utils: add fs_config support")
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> > > ---
> > >  lib/inode.c | 18 +++++++++++-------
> > >  1 file changed, 11 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/lib/inode.c b/lib/inode.c
> > > index 3d634fc..9469074 100644
> > > --- a/lib/inode.c
> > > +++ b/lib/inode.c
> > > @@ -701,21 +701,25 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
> > >  	char *fspath;
> > >  
> > >  	inode->capabilities = 0;
> > > +	if (!cfg.mount_point)
> > > +		fspath = erofs_fspath(path);  
> > 
> > lib/inode.c:688:10: error: assigning to 'char *' from 'const char *' discards...
> >                 fspath = erofs_fspath(path);
> >                        ^ ~~~~~~~~~~~~~~~~~~
> > 
> > -           fspath = erofs_fspath(path);
> > +         fspath = (char *)erofs_fspath(path);  
> 
> oops, I think it can be modified as a temporary workaround, will submit a formal
> patch after verification.
> 
> > 
> >   
> > > +	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > > +			  erofs_fspath(path)) <= 0)  
> > 
> > The argument of path will be root directory. And canned fs_config for root directory as
> > below:
> > 
> > 0 0 755 selabel=u:object_r:rootfs:s0 capabilities=0x0
> > 
> > So, cannot add mount point to root directory for canned fs_config. And what about non-canned
> > fs_config?  
> 
> Not quite sure what you mean. For non-canned fs_config, we didn't observed any strange
> before (I ported to cuttlefish and hikey960 with boot success, also as I mentioned before
> some other vendors already use it.)
> 
> I think the following commit is only useful for squashfs since its (non)root inode
> workflows are different, so need to add in two difference place. But mkfs.erofs is not.
> https://android.googlesource.com/platform/external/squashfs-tools/+/85a6bc1e52bb911f195c5dc0890717913938c2d1%5E%21/#F0
> 
> For root inode is erofs, I think erofs_fspath(path) would return "", so that case
> is included as well.... Am I missing something?

Yes, erofs_fspath(path) returns "" for root inode. However, the above patch add the mount
point to fspath when specify it, so the real path is "vendor/" which does not exist in canned
fs_config file. build will report below error:

failed to find [/vendor/] in canned fs_config

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thx.
> > 
> >   
> > > +		return -ENOMEM;
> > > +
> > > +
> > >  	if (cfg.fs_config_file)
> > > -		canned_fs_config(erofs_fspath(path),
> > > +		canned_fs_config(fspath,
> > >  				 S_ISDIR(st->st_mode),
> > >  				 cfg.target_out_path,
> > >  				 &uid, &gid, &mode, &inode->capabilities);
> > > -	else if (cfg.mount_point) {
> > > -		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > > -			     erofs_fspath(path)) <= 0)
> > > -			return -ENOMEM;
> > > -
> > > +	else
> > >  		fs_config(fspath, S_ISDIR(st->st_mode),
> > >  			  cfg.target_out_path,
> > >  			  &uid, &gid, &mode, &inode->capabilities);
> > > +
> > > +	if (cfg.mount_point)
> > >  		free(fspath);
> > > -	}
> > >  	st->st_uid = uid;
> > >  	st->st_gid = gid;
> > >  	st->st_mode = mode | stat_file_type_mask;  
> >   
> 

