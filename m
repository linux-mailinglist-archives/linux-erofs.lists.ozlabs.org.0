Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DCD538E98
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 12:15:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LC7TB6rfvz3bkv
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 20:15:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ih7jTC/o;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ih7jTC/o;
	dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LC7T43f9Lz30Bl
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 May 2022 20:15:35 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id 15so1401533pfy.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 31 May 2022 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLdvb8C7605Al0vAEdjULangjvUcLhv4bkAYsWaTk3c=;
        b=ih7jTC/o9DEWuw1O/BJCKaaJLd9EPuzYWrzOL3dkvSY21vOfnhRy4+ZKQAQvJjaZMz
         i5VSXRQSTmYKdHk/cPieTz4VzEOZvqRUYop14b0vbSiUm5ZAmy6ML3lsYfRezBVWQeLf
         Nm77NsF4xoCEFK9sWU1IKTT8HL9kkw+hSyNRlU/Iwik4vfW7MNTFcTywEmABLwNjZsYw
         YDwgZ8IcKhnGeGzazNIp34dohQJpG8/QsTbilAW3EAxq3Alt/l6EwZ6IFHgQlYaJhvsg
         E7OQZSjsWc1wSjJJDKNq1MAGRIUD8ocgF2O9m+lFnTSNYJ3GWo0iHq0vwgcQmEUsXLJZ
         NeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLdvb8C7605Al0vAEdjULangjvUcLhv4bkAYsWaTk3c=;
        b=ujrMnozkHmuaq6OJN1bgwZMm7uoHG694qwj/OO5+Up950q43JCiJDKGhbCOswOcDyH
         tMRm6a8I3CIECtImz11gSoD3/5h5daUXO7HiDN60nIYfr/iVP/+uDwUQ5XJ5gaDLWtlw
         5eQTc0f4eu5heX8e8KaFsfhOR0DUAlHjI8K0KRNlKm9mgek5un39W+JyJTeapweXl3fh
         DJKpWchXvF2OTy4qsPRILNmqvZY4z314lN2Txy/jGtmDundLvbKzDzs/iCt20BABrJkN
         sdqOPQWJb2EdjMWUFrHSApWyyKiXRA3Bzdpzszon0dPQsmeLHA7RYKMLifVtnXUwwpA3
         jg+g==
X-Gm-Message-State: AOAM533uCA8Ue2OfUw4GFxMuaKZMojbF3uM/YJWFhRzz95ptwq/pHxu8
	Eq50sSEf2no/ug6Y+Ttwu6Y=
X-Google-Smtp-Source: ABdhPJwQ8jskHDnA3htdQMDwR0aYeYe4PGCpvNGtti07W846EVVv5R3dl7i0VzyleJZp+xZKQZFHEA==
X-Received: by 2002:a05:6a00:be1:b0:518:86d3:4f93 with SMTP id x33-20020a056a000be100b0051886d34f93mr48327867pfu.35.1653992132480;
        Tue, 31 May 2022 03:15:32 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id y129-20020a626487000000b0050dc76281b5sm10664360pfb.143.2022.05.31.03.15.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 May 2022 03:15:31 -0700 (PDT)
Date: Tue, 31 May 2022 18:16:00 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: Worse performance than SquashFS for small filesystems
Message-ID: <20220531181421.00000757.zbestahu@gmail.com>
In-Reply-To: <YpXnhI8gBlSgHEBW@B-P7TQMD6M-0146.local>
References: <B908083A-D162-4EC1-9E2C-23D49190BAA1@aparcar.org>
	<YpVao8WX3B6HPWt7@debian>
	<14612283-0BA7-490B-A89C-D4CF82565178@aparcar.org>
	<YpXnhI8gBlSgHEBW@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, Paul Spooren <mail@aparcar.org>, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 31 May 2022 18:01:40 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Paul,
> 
> On Tue, May 31, 2022 at 10:58:01AM +0200, Paul Spooren wrote:
> > Hi,
> > 
> > Thank you for the quick response!
> >   
> > > On 31. May 2022, at 02:00, Gao Xiang <xiang@kernel.org> wrote:
> > > 
> > > On Mon, May 30, 2022 at 08:41:34PM +0200, Paul Spooren wrote:  
> > >> Hi,
> > >> 
> > >> I¡¯m an OpenWrt developer and we work on an operation system for routers and overall network facing embedded devices. Since storage is often limited on our targeted devices we use SquashFS to compress everything, total image sizes are less than 10 MegaBytes.
> > >> 
> > >> Reading about erofs I¡¯m very keen to adopt it for our case, however giving it a first try the storage performance seems to be significantly _worse_ than the default SquashFS implementation. Since you ran benchmarks in the past, could you give me advise if I¡¯m missing anything?  
> > > 
> > > What the meaning of `performance'? I don't think the size of images
> > > mean runtime performance anyway.  
> > 
> > Performance as in looking at how well it performs on minimizing the space requirement.  
> 
> Originally, EROFS had a goal to have a better runtime performance with
> minimal memory overhead (with some inplace techniques).
> 
> Strictly speaking, if you'd like to minimize the storage space, there
> are many FUSE fses which can do this, but such fses doesn't consider
> more about memory footprints or runtime I/O amplification and that's
> what EROFS addresses exactly.
> 
> But yeah, we tend to perform a generic in-kernel fses, I think we can
> do in this way (saving more space without impact runtime performance)
> with our best effort.
> 
> >   
> > >   
> > >> 
> > >> For the test I used erofs-utils as of a134ce7c39a5427343029e97a62665157bef9bc3 (2022-05-17) and compressed the x86/64 root filesystem of a standard OpenWrt image[1]. I¡¯m seeing a difference of one MegaByte which is about 30% worse in this context.
> > >> 
> > >> My test:
> > >> 
> > >> $ ./staging_dir/host/bin/mkfs.erofs -zlzma erofs.root ./build_dir/target-x86_64_musl/root-x86  
> > > 
> > > Have you try with
> > > 
> > > -zlzma -C 65536 -Eztailpacking
> > > 
> > > by default, EROFS uses 4k compression rather than Squashfs 128k.  
> > 
> > That indeed improves the total size, I¡¯m now down to 3.6MB (vs 3.3MB for squashfs).  
> 
> Good to hear that.
> 
> >   
> > >   
> > >> mkfs.erofs 1.4
> > >> <W> erofs: EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!
> > >> <W> erofs: Note that it may take more time since the compressor is still single-threaded for now.
> > >> Build completed.
> > >> 
> > >> $ mksquashfs -comp xz ./build_dir/target-x86_64_musl/root-x86 squashfs.root
> > >> 
> > >> $ ls -lh *.root
> > >> -rw-r--r-- 1 ubuntu ubuntu 4.3M May 30 20:27 erofs.root
> > >> -rw-r--r-- 1 ubuntu ubuntu 3.3M May 30 20:28 squashfs.root  
> > > 
> > > Even EROFS now supports big pcluster and ztailpacking features,
> > > Squashfs supports a feature called fragments which compresses
> > > several tails of files in a fragment. It's obviously beneficial
> > > to the final size of images but it can read unrelated data of
> > > other files even such files are very small.
> > > 
> > > You can try a big file with EROFS and Squashfs, and you can
> > > see the difference.
> > > 
> > > Btw, MicroLZMA is still an experimental feature for now, due to 
> > > three reasons:
> > > - XZ utils hasn't release a stable version for now, which I think
> > >   Lasse will release a stable version this year;
> > > 
> > > - EROFS has a finalized on-disk MircoLZMA support since Linux 5.16,
> > >   so users can mount MicroLZMA since 5.16.  Yet currently EROFS is
> > >   not quite optimized for such slow algorithm, since it needs a
> > >   completely different strategy from LZ4.  I'm working on that
> > >   together with folio work;
> > > 
> > > - We need a similiar `fragment' feature to catch squashfs under a
> > >   lot of files.  
> > 
> > Is that feature likely to be implemented for EROFS or is that out of scope?  
> 
> As far as I know, Yue Hu has some interest working on this. But that is

Yeah, I'm trying to implement this feature, hope to have a good result.

> not a promise anyway, I can seek time working on this as well.
> 
> >   
> > >   
> > >> 
> > >> Is erofs just not meant for such small storages?  
> > > 
> > > If you care more about the size of images, I personally prefer to
> > > squashfs for now until we handle all the things above.  
> > 
> > Sure, I didn¡¯t plan to migrate things over to EROFS just like that but it looks like a good candidate in the future!  
> 
> Yeah, I think anyway openwrt can support it as an alternative fs, but
> anyway, if you pursue extreme storage saving, the solution may vary
> endlessly and could be much complicated (and definitely impact runtime
> performance.)
> 
> But we can do in this way further if it seems simply like fragments.
> 
> > 
> > Thank you and everyone involved for working on EROFS!
> >   
> 
> Thanks,
> Gao Xing
> 
> > Best,
> > Paul Spooren
> >   
> > > 
> > > Thanks,
> > > Gao Xiang
> > >   
> > >> 
> > >> Thanks for all further comments!
> > >> 
> > >> Best,
> > >> Paul
> > >> 
> > >> [1]: https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-x86-64-rootfs.tar.gz  

Thanks,
Yue Hu
