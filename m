Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 599F85F63A
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jul 2019 12:02:37 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45fYSB4KGmzDqS6
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jul 2019 20:02:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q2p98X98"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45fYS048dvzDqCk
 for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jul 2019 20:02:23 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id b7so2837717pls.6
 for <linux-erofs@lists.ozlabs.org>; Thu, 04 Jul 2019 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AHAOh7FBxYQUboNiiix/lSgcCWAvw4RHDpwodpRKdNs=;
 b=Q2p98X98irjXvs/iO/RhgVHs6Fge85Y5iF373sUnY3qNCrHybAjkpOg2173g30ukn9
 HceW3sPP1hcjiOirEYf1+2mbxehzwjbOdybYng+r5jcyFlXNsHvgeNL89Q3S+MFrxv12
 Rg/JCjywQszl4f7Mb90cJMn6Y5sCGTNGVuW0A1qsFWjYht58BcSwfcWaKbWKdYpJhTK+
 2OL5lza0T8EGCgP+/sjaYM9zJ6O96cbpqVgRV/sFu5KLA9MJEl767XFzWRKGIARGVIGN
 YVM8rxsGOi8DS9TO2jE10VLDKy3iWLNFkeOLvvZKL7EKKDLLU4bDYr0Aklq71Uabo+FM
 V/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AHAOh7FBxYQUboNiiix/lSgcCWAvw4RHDpwodpRKdNs=;
 b=a52VNx0zEDT2H6Q8PSgVxji1P1p5UvxuWSa1rduZZQ+M2c99jnpklkK/bncblE2KWU
 cxH8NcFZKiJuky39CTmuX7zkggHuE5gDkorf6PxY0Y5k3G1nX395OTn2nbMFqDGamOOs
 W2YmzBCCS/J23w/9G4aBMwJiy9KIYXTQfDMIbZs9rXU3THFGf9AQwGqnl0BxcfamWWZG
 v6gnd7nB2wVuPJyCjiBBpTmyJz8ClTA9biNWAJsBoJIA6YIlWdpwiKeg0v2o+Mr5fmEN
 U9KKPCdY6kl0/yWHDcEXbRwTQb16IpO8qUl3lt6RqtnS5OT9P4YWvxu6xDrp4PmkVNyA
 VMlA==
X-Gm-Message-State: APjAAAV1A37w13/bHjt3b428G7NMPIqeryX4Hhg7XFgUl/nwddr6uwa5
 DNGKs4OMVA6ClgpFPrYvlbs/DgN1
X-Google-Smtp-Source: APXvYqyUpSz5kViPDgxvt9wrV2Cyk1yHzTLql9qU6i3mRjiEnK1Vbw4O//g0ryQX4vvxf+WtJC1zCQ==
X-Received: by 2002:a17:902:2aa8:: with SMTP id
 j37mr46217419plb.316.1562234541812; 
 Thu, 04 Jul 2019 03:02:21 -0700 (PDT)
Received: from localhost ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id w187sm5189791pfb.4.2019.07.04.03.02.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 04 Jul 2019 03:02:21 -0700 (PDT)
Date: Thu, 4 Jul 2019 18:02:07 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND v3] staging: erofs: remove unsupported ->datamode
 check in fill_inline_data()
Message-ID: <20190704180207.0000374e.zbestahu@gmail.com>
In-Reply-To: <20190704052649.GA7454@kroah.com>
References: <20190702025601.7976-1-zbestahu@gmail.com>
 <20190703162038.GA31307@kroah.com>
 <20190704095903.0000565e.zbestahu@gmail.com>
 <20190704052649.GA7454@kroah.com>
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
Cc: devel@driverdev.osuosl.org, huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 4 Jul 2019 07:26:49 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 04, 2019 at 09:59:03AM +0800, Yue Hu wrote:
> > On Wed, 3 Jul 2019 18:20:38 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >   
> > > On Tue, Jul 02, 2019 at 10:56:01AM +0800, Yue Hu wrote:  
> > > > From: Yue Hu <huyue2@yulong.com>
> > > > 
> > > > Already check if ->datamode is supported in read_inode(), no need to check
> > > > again in the next fill_inline_data() only called by fill_inode().
> > > > 
> > > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > > Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> > > > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > > > ---
> > > > no change
> > > > 
> > > >  drivers/staging/erofs/inode.c | 2 --
> > > >  1 file changed, 2 deletions(-)    
> > > 
> > > This is already in my tree, right?  
> > 
> > Seems not, i have received notes about other 2 patches below mergerd:
> > 
> > ```note1
> > This is a note to let you know that I've just added the patch titled
> > 
> >     staging: erofs: don't check special inode layout
> > 
> > to my staging git tree which can be found at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> > in the staging-next branch.
> > ```
> > 
> > ```note2
> > This is a note to let you know that I've just added the patch titled
> > 
> >     staging: erofs: return the error value if fill_inline_data() fails
> > 
> > to my staging git tree which can be found at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> > in the staging-next branch.
> > ```
> > 
> > No this patch in below link checked:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/log/drivers/staging/erofs?h=staging-testing  
> 
> Then if it is not present, it needs to be rebased as it does not apply.
> 
> Please do so and resend it.

Hm, no need to resend since it's included in another patch below.

ec8c244 staging: erofs: add compacted ondisk compression indexes.

Thanks.

> 
> thanks,
> 
> greg k-h

