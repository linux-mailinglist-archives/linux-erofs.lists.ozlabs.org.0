Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E14792E060B
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 07:31:41 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0RLy6SqqzDqQW
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 17:31:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ZiEAFLqX; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZiEAFLqX; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0RLw1VVWzDqP2
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 17:31:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608618690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nqO5ZoPn4Bi3DzYV+QKVJbVyz8y/e8OfYcv3fLLrpIU=;
 b=ZiEAFLqXoCllniPcjgbUrcBK+QU6tWAZ9totVks4RXPHx03krEg7Yc03czj+IHOOYXdIie
 aqcf9qaWsCRzA7cIkZzA+T3n0MZWrxmtNcwXCCaQvfp/s5lKxgFD/A70TvsFhAuXHQ2bPF
 ikz0KdTT6g5FXEzV8jJzj5uwbhACpog=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608618690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nqO5ZoPn4Bi3DzYV+QKVJbVyz8y/e8OfYcv3fLLrpIU=;
 b=ZiEAFLqXoCllniPcjgbUrcBK+QU6tWAZ9totVks4RXPHx03krEg7Yc03czj+IHOOYXdIie
 aqcf9qaWsCRzA7cIkZzA+T3n0MZWrxmtNcwXCCaQvfp/s5lKxgFD/A70TvsFhAuXHQ2bPF
 ikz0KdTT6g5FXEzV8jJzj5uwbhACpog=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-hiFQIV_XNKSC9bj4FLLsrw-1; Tue, 22 Dec 2020 01:31:26 -0500
X-MC-Unique: hiFQIV_XNKSC9bj4FLLsrw-1
Received: by mail-pg1-f200.google.com with SMTP id z20so7973089pgh.18
 for <linux-erofs@lists.ozlabs.org>; Mon, 21 Dec 2020 22:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nqO5ZoPn4Bi3DzYV+QKVJbVyz8y/e8OfYcv3fLLrpIU=;
 b=q2D24+e9LdhQZLYlcrxJ/wYvYTMogUO/szPmFuk/ZmULW0X2LlPL+gOWH4pKY2Tamu
 +hlm/v2IsDxkhoKSTHw2WYgMTO3boL/cQYH8djOljok2r/6obVjteh1UwHgg+5eFKyuf
 ICVoWPiN6pD9MZt/H1EjC6ahur9rK5s1cKp/0H17TeG240KxTfV0mJmPJpxAwh3yrzLY
 KzArqX7bf2jkI2Wlat92Ue0xNLkLvUcZ8yFn4RS7T5toyuIFEbaYm5fYNif0RHSzY5g0
 ShvW5fK7UY4NzCrk2ojNV66JmWVKoBEWM3IxJ5Z3NyZb2F8bfh8XyZT06ZuyswqQmpq4
 Cfzw==
X-Gm-Message-State: AOAM530oZ1vPhJHNw6nZoA3ZqiYrrfXEVpnSi+SJD+eibAH4wK795UeP
 G2XVKrdy7NU0lJ3so+1z6tgXmybk1M+AT3GVen9I0/Qb9gp2BJ/P+soiHcRB5CClexfKERbvkbT
 8sYDWAc4BUH44IB3oS0sVDkae
X-Received: by 2002:a17:902:599d:b029:da:fcfd:7088 with SMTP id
 p29-20020a170902599db02900dafcfd7088mr19651298pli.68.1608618685345; 
 Mon, 21 Dec 2020 22:31:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNXLP+GA5BIMiwvQAu3NUdivc3Ky86dDRDrHuWO2RWCKce/VK6lFDp0fuy+4y9Lmj0Bwcpww==
X-Received: by 2002:a17:902:599d:b029:da:fcfd:7088 with SMTP id
 p29-20020a170902599db02900dafcfd7088mr19651289pli.68.1608618685104; 
 Mon, 21 Dec 2020 22:31:25 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d10sm18760566pfn.218.2020.12.21.22.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Dec 2020 22:31:24 -0800 (PST)
Date: Tue, 22 Dec 2020 14:31:12 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222063112.GB1775594@xiangao.remote.csb>
References: <20201222020430.12512-1-zbestahu@gmail.com>
 <20201222034455.GA1775594@xiangao.remote.csb>
 <20201222124733.000000fe.zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201222124733.000000fe.zbestahu@gmail.com>
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

On Tue, Dec 22, 2020 at 12:47:33PM +0800, Yue Hu wrote:
> On Tue, 22 Dec 2020 11:44:55 +0800
> Gao Xiang <hsiangkao@redhat.com> wrote:
> 
> > Hi Yue,
> > 
> > On Tue, Dec 22, 2020 at 10:04:30AM +0800, Yue Hu wrote:
> > > From: Yue Hu <huyue2@yulong.com>
> > > 
> > > We observe that creating image failed to find [%s] in canned fs_config
> > > using --fs-config-file option under Android 10.
> > > 
> > > Notice that canned fs_config has a prefix to sub directory if mount_point
> > > presents. However, erofs_fspath() does not contain the prefix.
> > >   
> > 
> > Thanks for your patch. Let me play with it a bit this weekend (I'm not
> > quite familiar with canned fs_config, it would be of great help to add
> > some hints/steps for me to confirm this issue.... since some other vendors
> > already use it without report (maybe they don't use canned fs_config.)
> 
> Hi Xiang,
> 
> It's been observed under QC/QSSI platform with dynamic partition.
> 
> such as product.img/product_filesystem_config.txt:
> 
> ```txt
>  0 0 755 selabel=u:object_r:rootfs:s0 capabilities=0x0
> product/app 0 0 755 selabel=u:object_r:system_file:s0 capabilities=0x0
> product/app/CalculatorGoogle 0 0 755 selabel=u:object_r:system_file:s0 capabilities=0x0
> ```
> 
> product_filesystem_config.txt should be from below build:
> 
> $(call fs_config,$(zip_root)/PRODUCT,product/) > $(zip_root)/META/product_filesystem_config.txt
> 
> Do not observe this issue in squashfs, so i check related code of squashfs, squashfs have
> considered the mount point, also ext4 does. So, erofs should be same as one long used before.
> 
> After this patch, build & boot are working fine by test.
> 
> Here's a change from mksqushfs: Allow passing fs_config file for generating mksquashfs

Ok, I will try to find some clue to verify later.

> 
> > 
> > > Moreover, we should not add the mount point to fspath on root inode for
> > > fs_config() branch.  
> > 
> > Is there some descriptive words or reference for this? To be honest,
> > I'm quite unsure about this kind of Android-specific things... :(
> 
> Refer to change: mksquashfs: Run android_fs_config() on the root inode
> 
> I think erofs of AOSP has this issue also. Am i right?

Not quite sure if it effects non-canned fs_config after
reading the commit message...
https://android.googlesource.com/platform/external/squashfs-tools/+/85a6bc1e52bb911f195c5dc0890717913938c2d1%5E%21/#F0

And no permission to access Bug 72745016, so...
maybe we need to limit this to non-canned fs_config only?
(at least confirming the original case would be better)

BTW, Also, from its testcase command line in the commit message:
"mksquashfs path system.raw.img -fs-config-file fs_config -android-fs-config"

I'm not sure if "--mount-point" is passed in so I think for
such case no need to use such "goto" as well? 

Thanks,
Gao Xiang

