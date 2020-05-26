Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 656D31E1FCA
	for <lists+linux-erofs@lfdr.de>; Tue, 26 May 2020 12:35:55 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49WVjg6sBXzDqPc
	for <lists+linux-erofs@lfdr.de>; Tue, 26 May 2020 20:35:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.120;
 helo=us-smtp-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=KRViZfcw; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QAm5nB4V; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49WVjX37wMzDqLY
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 May 2020 20:35:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590489339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xcFnRMsNHU9w0WLfQZWbCJdA0m+d2hsrGanpZ277EL8=;
 b=KRViZfcw2LBgIr0oHCLiGDlAI+y5lg0qFcBqMdsU+N4fqY7BogMGZEJLOYMkmhJ/axIFYD
 c7WAct9da02jmsJtF1PpucY59ed7BYXXStVBQOhktY/JG+Lz4KbbBEG2O70d1eBhEhnJuz
 XsSq1ZrDExADvJvUzJ89tPp/Qx5HCjY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590489340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xcFnRMsNHU9w0WLfQZWbCJdA0m+d2hsrGanpZ277EL8=;
 b=QAm5nB4VaOlSm5LnhbWiieqXDgqylJDRUgtq/l4rgssSP0ABFPHYZ31hlJp3wOuhz+/maN
 n8FjfVEEFP+Gpx7Ls1UTaKb/XjH0M53qMdcsHImXE1UNC17iUBja2PuskM51Feos6Bni3F
 OWyxNeOY5ifW9QKJrENCjzVQyoLw844=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-vtwu2_jTOZGpcKJLuSlUcQ-1; Tue, 26 May 2020 06:35:35 -0400
X-MC-Unique: vtwu2_jTOZGpcKJLuSlUcQ-1
Received: by mail-pj1-f71.google.com with SMTP id a13so2250264pjd.9
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 May 2020 03:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xcFnRMsNHU9w0WLfQZWbCJdA0m+d2hsrGanpZ277EL8=;
 b=gzVghrRi1zNIL2IBTCja8PCTIgjM+nqbmmwhI6dz3fo5ZD10uMivwcI1bl8eSGVT/T
 FLTlyzkmS+pbcHC4qIgNw4ZK9cdnw6mXv7VxjEvLQ2mm8hvXXQr7HjPBPLbG4l4E5TMf
 jSwGNgOM1AntqYcgnB15gFukivCrDqUR6lsTfSAzEFzmWcABtAt6FTuBTwNYzabSUYAF
 t3IagYztZtrkigs12HrLH/PwXU01CmyLzoGA/bqe8tc3E/iKI4+4PUnsBXXE5T/Hb8rk
 s5+gqxQq/dtlHrW93Ns73lvdfjCVGBH6h8A1IWj47W8R4R0Gqk93W/M+6qX/p/M6oTo6
 ViDQ==
X-Gm-Message-State: AOAM532LhrYVRmTWxeYuJgO+yj4zqIquDNfHuaIdDUOMBhrTLRAqHAhp
 2Mz1vqxO59F1A/7rMGMtqov6A9O0oEDPvckbTbx3zVuuTooN4RE3fSRYtOlMvhV3cMlx3jBeVBu
 ExHBxlw/V/aMU9nMLCiPYGlSb
X-Received: by 2002:a17:902:8b82:: with SMTP id
 ay2mr456564plb.142.1590489334068; 
 Tue, 26 May 2020 03:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfb9Lo+5uEDhkRdHfcUpiEtiZLHYLwhDbs9NE7dcN4oO6o7uoB6r64b1mRpT1q76wYjZQ6JA==
X-Received: by 2002:a17:902:8b82:: with SMTP id
 ay2mr456537plb.142.1590489333659; 
 Tue, 26 May 2020 03:35:33 -0700 (PDT)
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 84sm14903952pfv.157.2020.05.26.03.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 03:35:33 -0700 (PDT)
Date: Tue, 26 May 2020 18:35:23 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: cgxu <cgxu519@mykernel.net>
Subject: Re: [PATCH] erofs: code cleanup by removing ifdef macro surrounding
Message-ID: <20200526103522.GC8107@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200526090343.22794-1-cgxu519@mykernel.net>
 <20200526094939.GB8107@hsiangkao-HP-ZHAN-66-Pro-G1>
 <4c4a7f7d-c3b7-9093-ae76-32ad258e29a6@mykernel.net>
MIME-Version: 1.0
In-Reply-To: <4c4a7f7d-c3b7-9093-ae76-32ad258e29a6@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, May 26, 2020 at 06:29:00PM +0800, cgxu wrote:
> On 5/26/20 5:49 PM, Gao Xiang wrote:
> > Hi Chengguang,
> > 
> > On Tue, May 26, 2020 at 05:03:43PM +0800, Chengguang Xu wrote:
> > > Define erofs_listxattr and erofs_xattr_handlers to NULL when
> > > CONFIG_EROFS_FS_XATTR is not enabled, then we can remove many
> > > ugly ifdef macros in the code.
> > > 
> > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> > > ---
> > > Only compile tested.
> > > 
> > >   fs/erofs/inode.c | 6 ------
> > >   fs/erofs/namei.c | 2 --
> > >   fs/erofs/super.c | 4 +---
> > >   fs/erofs/xattr.h | 7 ++-----
> > >   4 files changed, 3 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> > > index 3350ab65d892..7dd4bbe9674f 100644
> > > --- a/fs/erofs/inode.c
> > > +++ b/fs/erofs/inode.c
> > > @@ -311,27 +311,21 @@ int erofs_getattr(const struct path *path, struct kstat *stat,
> > >   const struct inode_operations erofs_generic_iops = {
> > >   	.getattr = erofs_getattr,
> > > -#ifdef CONFIG_EROFS_FS_XATTR
> > >   	.listxattr = erofs_listxattr,
> > > -#endif
> > 
> > It seems equivalent. And it seems ext2 and f2fs behave in the same way...
> 
> I posted similar patch for ext2 and Jack merged to
> his tree the other day, though that series also
> included a real bugfix. I also posted similar patch
> to f2fs, so if erofs and f2fs merge these patches
> then all three will behave in the same way, ;-)
> 
> You may refer below link for the detail.
> 
> https://lore.kernel.org/linux-ext4/20200522044035.24190-2-cgxu519@mykernel.net/

Thanks for your link...

> 
> 
> > But I'm not sure whether we'd return 0 (if I didn't see fs/xattr.c by mistake)
> > or -EOPNOTSUPP here... Some thoughts about this? >
> > Anyway, I'm fine with that if return 0 is okay here, but I'd like to know your
> > and Chao's thoughts about this... I will play with it later as well.
> 
> Originally, we set erofs_listxattr to ->listxattr only
> when the config macro CONFIG_EROFS_FS_XATTR is enabled,
> it means that erofs_listxattr() never returns -EOPNOTSUPP
> in any case, so actually there is no logic change here,
> right?

Yeah, I agree there is no logic change, so I'm fine with the patch.
But I'm little worry about if return 0 is actually wrong here...

see the return value at:
http://man7.org/linux/man-pages/man2/listxattr.2.html

Thanks,
Gao Xiang

> 
> 
> Thanks,
> cgxu
> 

