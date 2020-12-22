Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2F42E0956
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 12:08:03 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0YTq74kqzDqQQ
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 22:07:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d;
 helo=mail-pg1-x52d.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=mDdBOSif; dkim-atps=neutral
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0YTj4tYVzDqPl
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 22:07:50 +1100 (AEDT)
Received: by mail-pg1-x52d.google.com with SMTP id c22so8132676pgg.13
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 03:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qTOIP66YdHTT+9HQIguVtksTWzxQ33ng+Fhv3YU2tE4=;
 b=mDdBOSifrv+VFQIvGEs8ERMORXUF329m8Ea617N4qII4ggOmTUFJG7XVopolPFpIF8
 XbIf/mXquLJW6dUvZMmeBxekEHK33pCErIX65+gSBZxuaU6KSUG0DYUdBIr7ZDFY5FCG
 AaaybI8E2x5zYPDnEHw2SDH6JM3U9JPc2cgsYLhbj+zJLLf73b3Fcb/hBTt7NwaqGVx0
 bdru6FMb5DZmBiBXeM3Q7DulVqgODu0TSoZ5AbwuCmRqUVAC0DSDeqrnDPIiw06j7aaU
 PokkHKAT4GSjV+TI1C5txcpXkOxb8jj4FcwudHAZEUa2oIVrkgBSjGDC6zI6MnvLHYsc
 PzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qTOIP66YdHTT+9HQIguVtksTWzxQ33ng+Fhv3YU2tE4=;
 b=miVMEOwl7fl/4z1m1yqyXtnEq0N35kOhusQkO51K1nPflnHR4yZo04vwFAwySbRm2C
 uPy+ymtDx3y74Gqh8xKNv+MRxIQqI+sxMm9+yvqzUcHH+/88g3nGst0FnqiGEQ4+5soK
 fheykyWsFiXC8r+5vveiFWmuCeUje6jexKrXudcfNa436C9XBzkDlilbihnpmyB4FnNO
 K/DOI9etrVJWuzaH20aBcWLPm4FZ9PTUACzcANINg/gUBHflcr09VecKci2pbD0gnOzt
 6jacAJGjxuMxk+TgmOqpsK58zgBcHbovJpgvqC7hSFb6MYuz2vmpG6FBDRFF9cNOA4lu
 kyOQ==
X-Gm-Message-State: AOAM5314WDPm2KVfPBTbhj01tLdt1GS7g6XvM7d/AKCTZ4EdLoaIs260
 nRBVRcpQ9qxlVFdG6+dBZ7Q=
X-Google-Smtp-Source: ABdhPJwTopFXXXV5zoRlJxabRMmv6XSqRJVFUung02KAJiY3cR6c/ORV62REA/pyxLFUXoxekc2UOA==
X-Received: by 2002:a63:591f:: with SMTP id n31mr8119394pgb.244.1608635263842; 
 Tue, 22 Dec 2020 03:07:43 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id a18sm19689044pfg.107.2020.12.22.03.07.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Dec 2020 03:07:43 -0800 (PST)
Date: Tue, 22 Dec 2020 19:07:35 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222190546.00003142.zbestahu@gmail.com>
In-Reply-To: <20201222103320.GA1831635@xiangao.remote.csb>
References: <20201222124733.000000fe.zbestahu@gmail.com>
 <20201222063112.GB1775594@xiangao.remote.csb>
 <20201222070458.GA1803221@xiangao.remote.csb>
 <20201222160935.000061c3.zbestahu@gmail.com>
 <20201222091340.GA1819755@xiangao.remote.csb>
 <20201222173014.000055d3.zbestahu@gmail.com>
 <20201222093952.GC1819755@xiangao.remote.csb>
 <20201222174623.00005f9b.zbestahu@gmail.com>
 <20201222095906.GA1826582@xiangao.remote.csb>
 <20201222181751.00004a42.zbestahu@gmail.com>
 <20201222103320.GA1831635@xiangao.remote.csb>
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
Cc: huyue2@yulong.com, xiang@kernel.org, linux-erofs@lists.ozlabs.org,
 zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 22 Dec 2020 18:33:20 +0800
Gao Xiang <hsiangkao@redhat.com> wrote:

> On Tue, Dec 22, 2020 at 06:17:51PM +0800, Yue Hu wrote:
> > On Tue, 22 Dec 2020 17:59:06 +0800
> > Gao Xiang <hsiangkao@redhat.com> wrote:
> >   
> > > On Tue, Dec 22, 2020 at 05:46:23PM +0800, Yue Hu wrote:  
> > > > On Tue, 22 Dec 2020 17:39:52 +0800
> > > > Gao Xiang <hsiangkao@redhat.com> wrote:
> > > >     
> > > > > On Tue, Dec 22, 2020 at 05:30:14PM +0800, Yue Hu wrote:
> > > > > 
> > > > > ...
> > > > >     
> > > > > > > > 
> > > > > > > >         
> > > > > > > > > +	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > > > > > > > > +			  erofs_fspath(path)) <= 0)        
> > > > > > > > 
> > > > > > > > The argument of path will be root directory. And canned fs_config for root directory as
> > > > > > > > below:
> > > > > > > > 
> > > > > > > > 0 0 755 selabel=u:object_r:rootfs:s0 capabilities=0x0
> > > > > > > > 
> > > > > > > > So, cannot add mount point to root directory for canned fs_config. And what about non-canned
> > > > > > > > fs_config?        
> > > > > > > 
> > > > > > > Not quite sure what you mean. For non-canned fs_config, we didn't observed any strange
> > > > > > > before (I ported to cuttlefish and hikey960 with boot success, also as I mentioned before
> > > > > > > some other vendors already use it.)
> > > > > > > 
> > > > > > > I think the following commit is only useful for squashfs since its (non)root inode
> > > > > > > workflows are different, so need to add in two difference place. But mkfs.erofs is not.
> > > > > > > https://android.googlesource.com/platform/external/squashfs-tools/+/85a6bc1e52bb911f195c5dc0890717913938c2d1%5E%21/#F0
> > > > > > > 
> > > > > > > For root inode is erofs, I think erofs_fspath(path) would return "", so that case
> > > > > > > is included as well.... Am I missing something?      
> > > > > > 
> > > > > > Yes, erofs_fspath(path) returns "" for root inode. However, the above patch add the mount
> > > > > > point to fspath when specify it, so the real path is "vendor/" which does not exist in canned
> > > > > > fs_config file. build will report below error:
> > > > > > 
> > > > > > failed to find [/vendor/] in canned fs_config      
> > > > > 
> > > > > Hmmm... such design is quite strange for me....    
> > > > 
> > > > :) i checked the squashfs before, seems root directory is handled in some position. Separated
> > > > with sub directory fs_config. so i add the goto code in the 1st patch.    
> > > 
> > > What confuses me a lot is that we didn't get any strange without canned fs_config
> > > if mount point prefix is added. I will look into other implementation about this
> > > later (Another guess is that relates to Android 10 only?).  
> > 
> > maybe relates to dynamic partition(intro from Android 10) which not be enabled by some vendors.  
> 
> I think some of them use dynamic partition AFAIK, but might not be with QSSI
> enabled (I'm not sure, anyway, that is minor...)
> 
> >   
> > > 
> > > Yeah, the opensource fs_config implementation might be different from HUAWEI
> > > internal fs_config version since such part was not originally written by me and
> > > I didn't pay more attention about this part when I was in my previous company.
> > > But anyway, this cleanup opensource version is already used for some vendors
> > > as well and I don't get such report... And any formal description about this
> > > would be helpful for me to understand how fs_config really works..  
> > 
> > Now i'm not familar with fs_config also :) I will continue to check when i have
> > enough time.
> > 
> > Anyway, i observed the issue in canned fs_config since i'm using it. so i decide
> > to report it and patch it to upstream to verify if it's a real one.  
> 
> Yeah, that is somewhat bad and needs fixing if canned fs_config doesn't work
> as expected...
> My confusion for now is that how to deal with root dir properly (it seems
> make_ext4fs doesn't even care about rootdir fs_config at all if my understanding
> is correct.)
> 
> Also,
> https://android.googlesource.com/platform/system/core/+/master/libcutils/fs_config.cpp
> https://android.googlesource.com/platform/system/core/+/master/libcutils/canned_fs_config.cpp
> 
> are implemented quite different. So look forward to your test result (I tend
> to add prefix for fs_config, but drop prefix for canned_fs_config instead.)

It works for canned fs_config i'm using. We can simplify the test enviroment.
canned fs_config file content/format (e.g. mount point is vendor) as below: 

 0 2000 755 selabel=u:object_r:rootfs:s0 capabilities=0x0
vendor/app 0 2000 755 selabel=u:object_r:vendor_app_file:s0 capabilities=0x0
vendor/app/CACertService 0 2000 755 selabel=u:object_r:vendor_app_file:s0 capabilities=0x0
vendor/app/CACertService/CACertService.apk 0 0 644 selabel=u:object_r:vendor_app_file:s0 capabilities=0x0
vendor/app/CACertService/oat 0 2000 755 selabel=u:object_r:vendor_app_file:s0 capabilities=0x0
vendor/app/CACertService/oat/arm64 0 2000 755 selabel=u:object_r:vendor_app_file:s0 capabilities=0x0

The 1st line is for root inode search and the others are for sub inode like search.

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thx.
> >   
> > > 
> > > Thanks,
> > > Gao Xiang
> > >   
> > > >     
> > > > > Could you try the following diff?    
> > > > 
> > > > Let's me verify.
> > > >     
> > >   
> >   
> 

