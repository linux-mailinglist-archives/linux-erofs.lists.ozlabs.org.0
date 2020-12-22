Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C102E07C5
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 10:14:05 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0VyL0kDrzDqQg
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 20:14:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=H63EQ2GY; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=H63EQ2GY; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0VyG2DrQzDqP2
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 20:13:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608628435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yc2sUVyvSooLKoUI5gehB2N0+wPQWgeq3PmT72HKe8s=;
 b=H63EQ2GYs0v6DMqsGUryYcEpUxy0F3oMEy32edcDg7z/dzKvP1ucQeLEMAFi08y1Yfxkym
 B34+hMipPW45cg1NnXoQAGQAdpxBCKd1UHUudkXiGWemXIUl2BE8wwe69BXh5glz/FdyuP
 F/9TKkMCvRY6ycUqpG3EoHCyZ5suTeY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608628435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yc2sUVyvSooLKoUI5gehB2N0+wPQWgeq3PmT72HKe8s=;
 b=H63EQ2GYs0v6DMqsGUryYcEpUxy0F3oMEy32edcDg7z/dzKvP1ucQeLEMAFi08y1Yfxkym
 B34+hMipPW45cg1NnXoQAGQAdpxBCKd1UHUudkXiGWemXIUl2BE8wwe69BXh5glz/FdyuP
 F/9TKkMCvRY6ycUqpG3EoHCyZ5suTeY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-QBFSMPbuMDigWGYNyIt9uQ-1; Tue, 22 Dec 2020 04:13:52 -0500
X-MC-Unique: QBFSMPbuMDigWGYNyIt9uQ-1
Received: by mail-pg1-f199.google.com with SMTP id v5so5307680pgq.15
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 01:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yc2sUVyvSooLKoUI5gehB2N0+wPQWgeq3PmT72HKe8s=;
 b=J9Aqq3gSTSXf6nx2KPL2GzXS6RQ0RI0zbKzFb2Lkc9KGlwT1AaJk8Lwpywd8Vw3cRu
 ondjYXPxod1esAPchBT4oKRo/3tz6+BSNNaXq1bgiw3BM7oeJj7xxuHEGzHvcLv6cR9U
 vIkl0dffsX19PNcpTaFXkTpAFRlf9xlvHtQvU43U0dH8QLMLQDH2T0AHi0weSBlQYZQK
 +5Bc53EOJ5yTEKxqSj/3Z5pHzjLj4qwn4OoICZNlnKW3WjInwMLCo/3DKfMhJYTKdzoP
 X5nmRBzMKS+yR12fW3in4sRMJy3+2ysVfYLSNwF8/2aaG5yAxUCKZJtF+BSpAiCnZF1Z
 CZVQ==
X-Gm-Message-State: AOAM533aHtL2JRHAzrmOr3AawGaki+Jzbsw5wOgIuz8Sr+MYQYqIbS/j
 tQs3IbARDPm0E4PyM1q47GjT/ZfAofigCV5i8J+Upr7uexCKKysVoEufHS7JNdP7laxsoDZM9QE
 JahotFYSEEJfYhgW5D5dQN/+t
X-Received: by 2002:a63:5f12:: with SMTP id t18mr19095016pgb.308.1608628431593; 
 Tue, 22 Dec 2020 01:13:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwysTc2r6F8XnihEWbUW8VcmSxo9MaweCh+wEIPXk2Jhd274DSKAxkijnfHuJn2MSPRECmYzw==
X-Received: by 2002:a63:5f12:: with SMTP id t18mr19095003pgb.308.1608628431284; 
 Tue, 22 Dec 2020 01:13:51 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h8sm22159817pjc.2.2020.12.22.01.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Dec 2020 01:13:50 -0800 (PST)
Date: Tue, 22 Dec 2020 17:13:40 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222091340.GA1819755@xiangao.remote.csb>
References: <20201222020430.12512-1-zbestahu@gmail.com>
 <20201222034455.GA1775594@xiangao.remote.csb>
 <20201222124733.000000fe.zbestahu@gmail.com>
 <20201222063112.GB1775594@xiangao.remote.csb>
 <20201222070458.GA1803221@xiangao.remote.csb>
 <20201222160935.000061c3.zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201222160935.000061c3.zbestahu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

On Tue, Dec 22, 2020 at 04:10:58PM +0800, Yue Hu wrote:
> On Tue, 22 Dec 2020 15:04:58 +0800
> Gao Xiang <hsiangkao@redhat.com> wrote:
> 
> > Hi Yue,
> > 
> > On Tue, Dec 22, 2020 at 02:31:12PM +0800, Gao Xiang wrote:
> > 
> > ...
> > 
> > > 
> > > Ok, I will try to find some clue to verify later.
> > >   
> > > >   
> > > > >   
> > > > > > Moreover, we should not add the mount point to fspath on root inode for
> > > > > > fs_config() branch.    
> > > > > 
> > > > > Is there some descriptive words or reference for this? To be honest,
> > > > > I'm quite unsure about this kind of Android-specific things... :(  
> > > > 
> > > > Refer to change: mksquashfs: Run android_fs_config() on the root inode
> > > > 
> > > > I think erofs of AOSP has this issue also. Am i right?  
> > > 
> > > Not quite sure if it effects non-canned fs_config after
> > > reading the commit message...
> > > https://android.googlesource.com/platform/external/squashfs-tools/+/85a6bc1e52bb911f195c5dc0890717913938c2d1%5E%21/#F0
> > > 
> > > And no permission to access Bug 72745016, so...
> > > maybe we need to limit this to non-canned fs_config only?
> > > (at least confirming the original case would be better)
> > > 
> > > BTW, Also, from its testcase command line in the commit message:
> > > "mksquashfs path system.raw.img -fs-config-file fs_config -android-fs-config"
> > > 
> > > I'm not sure if "--mount-point" is passed in so I think for
> > > such case no need to use such "goto" as well? 
> > > 
> > > Thanks,
> > > Gao Xiang  
> > 
> > Could you verify the following patch if possible? (without compilation,
> > I don't have test environment now since AOSP code is on my PC)
> > 
> > From: Yue Hu <huyue2@yulong.com>
> > Date: Tue, 22 Dec 2020 14:52:22 +0800
> > Subject: [PATCH] AOSP: erofs-utils: fix sub-directory prefix for canned
> >  fs_config
> > 
> > "failed to find [%s] in canned fs_config" is observed by using
> > "--fs-config-file" option under Android 10.
> > 
> > Notice that canned fs_config has a prefix to sub-directory if
> > "--mount-point" presents. However, such prefix cannot be added by
> > just using erofs_fspath().
> > 
> > Fixes: 8a9e8046f170 ("AOSP: erofs-utils: add fs_config support")
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> > ---
> >  lib/inode.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 3d634fc..9469074 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -701,21 +701,25 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
> >  	char *fspath;
> >  
> >  	inode->capabilities = 0;
> > +	if (!cfg.mount_point)
> > +		fspath = erofs_fspath(path);
> 
> lib/inode.c:688:10: error: assigning to 'char *' from 'const char *' discards...
>                 fspath = erofs_fspath(path);
>                        ^ ~~~~~~~~~~~~~~~~~~
> 
> -           fspath = erofs_fspath(path);
> +         fspath = (char *)erofs_fspath(path);

oops, I think it can be modified as a temporary workaround, will submit a formal
patch after verification.

> 
> 
> > +	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > +			  erofs_fspath(path)) <= 0)
> 
> The argument of path will be root directory. And canned fs_config for root directory as
> below:
> 
> 0 0 755 selabel=u:object_r:rootfs:s0 capabilities=0x0
> 
> So, cannot add mount point to root directory for canned fs_config. And what about non-canned
> fs_config?

Not quite sure what you mean. For non-canned fs_config, we didn't observed any strange
before (I ported to cuttlefish and hikey960 with boot success, also as I mentioned before
some other vendors already use it.)

I think the following commit is only useful for squashfs since its (non)root inode
workflows are different, so need to add in two difference place. But mkfs.erofs is not.
https://android.googlesource.com/platform/external/squashfs-tools/+/85a6bc1e52bb911f195c5dc0890717913938c2d1%5E%21/#F0

For root inode is erofs, I think erofs_fspath(path) would return "", so that case
is included as well.... Am I missing something?

Thanks,
Gao Xiang

> 
> Thx.
> 
> 
> > +		return -ENOMEM;
> > +
> > +
> >  	if (cfg.fs_config_file)
> > -		canned_fs_config(erofs_fspath(path),
> > +		canned_fs_config(fspath,
> >  				 S_ISDIR(st->st_mode),
> >  				 cfg.target_out_path,
> >  				 &uid, &gid, &mode, &inode->capabilities);
> > -	else if (cfg.mount_point) {
> > -		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > -			     erofs_fspath(path)) <= 0)
> > -			return -ENOMEM;
> > -
> > +	else
> >  		fs_config(fspath, S_ISDIR(st->st_mode),
> >  			  cfg.target_out_path,
> >  			  &uid, &gid, &mode, &inode->capabilities);
> > +
> > +	if (cfg.mount_point)
> >  		free(fspath);
> > -	}
> >  	st->st_uid = uid;
> >  	st->st_gid = gid;
> >  	st->st_mode = mode | stat_file_type_mask;
> 

