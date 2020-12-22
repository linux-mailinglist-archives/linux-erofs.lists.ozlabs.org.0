Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4E62E086F
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 10:59:33 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0Wyp5QyWzDqQX
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 20:59:30 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=I2CrLtA1; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I2CrLtA1; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0Wym3bgNzDqPm
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 20:59:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608631164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8/fXrpoTo2QI8+8ZEVnoYJZJCHnAwkIc6Kn6UkRQuyw=;
 b=I2CrLtA1XakfpUynZY+0FGNKfVlowJVYF1YpJyo1Ck7YNU3UbLINFn20iQLdHf2A2uTe98
 rXJyiIruNpjOiFZHVzd1UsFWL6IOhpTrh/4RKpgAF9+qemVnAEFtiXKvd4P8YahY/jsDIt
 Ut8tcXxR+t1onROZcNHqw+yP1h394qU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608631164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8/fXrpoTo2QI8+8ZEVnoYJZJCHnAwkIc6Kn6UkRQuyw=;
 b=I2CrLtA1XakfpUynZY+0FGNKfVlowJVYF1YpJyo1Ck7YNU3UbLINFn20iQLdHf2A2uTe98
 rXJyiIruNpjOiFZHVzd1UsFWL6IOhpTrh/4RKpgAF9+qemVnAEFtiXKvd4P8YahY/jsDIt
 Ut8tcXxR+t1onROZcNHqw+yP1h394qU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-bH8QHjnoNeKw05xPbxLzcQ-1; Tue, 22 Dec 2020 04:59:18 -0500
X-MC-Unique: bH8QHjnoNeKw05xPbxLzcQ-1
Received: by mail-pj1-f70.google.com with SMTP id o19so1009140pjr.8
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 01:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8/fXrpoTo2QI8+8ZEVnoYJZJCHnAwkIc6Kn6UkRQuyw=;
 b=O1YKXyn8ilc24/l8LKH2u64twIdA8YeTSZtRQW3KCc9OMi99/WMK6p36Ib1tivBtAv
 5hk3ij/3f86j9rfJtCUGwepDTw3mA6e9Vc8CUcv3P4fmaMndKDb4FRg2RQxxQLcdUl+3
 2Ia92glqCvHsLFy1dGYtXmCwmmwj67zRVG0ZQBtvCfMzXd583iDBibm1Pr2TY2QgfodK
 tSFiLwl+OOTYRAlCgcppW30LsEqNBt/sUlfqWdRT2a//+b5SLCL+8gQ/M8TTqZRrT/2s
 mDv+Lu2Nmo3pedhjMgWyn22fOZzqdff9IDuHbh5W/yk6sRNlESqceaqFoOeNV62T4Jhm
 koTw==
X-Gm-Message-State: AOAM530kHVH6VwPTIMjKYGXeyB/QJdVkKjnqFvf4H8mTV6qBEDOqQirA
 wnS3m33WXZ5BKq+NQU85Rx1o+mpry+XrmHvqMjXFRTP4vNWdqigUUcQpUBMnPoDyIxdI8R/Y/w5
 AJiQeJRQZkOU4kUTaGy5TIf1O
X-Received: by 2002:a17:90a:bb8c:: with SMTP id
 v12mr21497725pjr.227.1608631157652; 
 Tue, 22 Dec 2020 01:59:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTYq2Eh4seEfx0zexRVV36G16rm7G8D/BoDLOhXTsMlba+twJ6bOdhAVQikVw2l/5MbdkZ+Q==
X-Received: by 2002:a17:90a:bb8c:: with SMTP id
 v12mr21497710pjr.227.1608631157388; 
 Tue, 22 Dec 2020 01:59:17 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w131sm19718429pfc.46.2020.12.22.01.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Dec 2020 01:59:16 -0800 (PST)
Date: Tue, 22 Dec 2020 17:59:06 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201222095906.GA1826582@xiangao.remote.csb>
References: <20201222020430.12512-1-zbestahu@gmail.com>
 <20201222034455.GA1775594@xiangao.remote.csb>
 <20201222124733.000000fe.zbestahu@gmail.com>
 <20201222063112.GB1775594@xiangao.remote.csb>
 <20201222070458.GA1803221@xiangao.remote.csb>
 <20201222160935.000061c3.zbestahu@gmail.com>
 <20201222091340.GA1819755@xiangao.remote.csb>
 <20201222173014.000055d3.zbestahu@gmail.com>
 <20201222093952.GC1819755@xiangao.remote.csb>
 <20201222174623.00005f9b.zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201222174623.00005f9b.zbestahu@gmail.com>
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

On Tue, Dec 22, 2020 at 05:46:23PM +0800, Yue Hu wrote:
> On Tue, 22 Dec 2020 17:39:52 +0800
> Gao Xiang <hsiangkao@redhat.com> wrote:
> 
> > On Tue, Dec 22, 2020 at 05:30:14PM +0800, Yue Hu wrote:
> > 
> > ...
> > 
> > > > > 
> > > > >     
> > > > > > +	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > > > > > +			  erofs_fspath(path)) <= 0)    
> > > > > 
> > > > > The argument of path will be root directory. And canned fs_config for root directory as
> > > > > below:
> > > > > 
> > > > > 0 0 755 selabel=u:object_r:rootfs:s0 capabilities=0x0
> > > > > 
> > > > > So, cannot add mount point to root directory for canned fs_config. And what about non-canned
> > > > > fs_config?    
> > > > 
> > > > Not quite sure what you mean. For non-canned fs_config, we didn't observed any strange
> > > > before (I ported to cuttlefish and hikey960 with boot success, also as I mentioned before
> > > > some other vendors already use it.)
> > > > 
> > > > I think the following commit is only useful for squashfs since its (non)root inode
> > > > workflows are different, so need to add in two difference place. But mkfs.erofs is not.
> > > > https://android.googlesource.com/platform/external/squashfs-tools/+/85a6bc1e52bb911f195c5dc0890717913938c2d1%5E%21/#F0
> > > > 
> > > > For root inode is erofs, I think erofs_fspath(path) would return "", so that case
> > > > is included as well.... Am I missing something?  
> > > 
> > > Yes, erofs_fspath(path) returns "" for root inode. However, the above patch add the mount
> > > point to fspath when specify it, so the real path is "vendor/" which does not exist in canned
> > > fs_config file. build will report below error:
> > > 
> > > failed to find [/vendor/] in canned fs_config  
> > 
> > Hmmm... such design is quite strange for me....
> 
> :) i checked the squashfs before, seems root directory is handled in some position. Separated
> with sub directory fs_config. so i add the goto code in the 1st patch.

What confuses me a lot is that we didn't get any strange without canned fs_config
if mount point prefix is added. I will look into other implementation about this
later (Another guess is that relates to Android 10 only?).

Yeah, the opensource fs_config implementation might be different from HUAWEI
internal fs_config version since such part was not originally written by me and
I didn't pay more attention about this part when I was in my previous company.
But anyway, this cleanup opensource version is already used for some vendors
as well and I don't get such report... And any formal description about this
would be helpful for me to understand how fs_config really works..

Thanks,
Gao Xiang

> 
> > Could you try the following diff?
> 
> Let's me verify.
> 

