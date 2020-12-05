Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BBB2CFAB2
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 09:54:46 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cp3Kv72J9zDqkG
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 19:54:43 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=GxxKj/Gx; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K4z5fvN/; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cp3Kq0Zk1zDqc8
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 19:54:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607158474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8SGAnxeUT9O+kwxWqPy3ZarCop9vx3+4Q8GbTneG62U=;
 b=GxxKj/Gx+oGo8Ip/AjJrYv1Di+Ygx/dvbNsEN3fAFRlX6c4oOjBhvkViPP7cQpw8UcszJP
 JX+RbJV9ts2KDzsGeaT1+9A6xrr3R7Z8nKNfUuITad8XCJKrZ5eb9SOPVZwI8x/jcOmSIq
 iE4iVQHd14YwTCG4n/VcAc++jm66HGs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607158475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8SGAnxeUT9O+kwxWqPy3ZarCop9vx3+4Q8GbTneG62U=;
 b=K4z5fvN/I/6YS9W46UCal0Zx4t8bJ/Ifb3raOLvXdypTvoYGzk3ZB4VHWsSNibO0u67We0
 tFDMQLralJuzMFzXW1TwGzbpoIqBLKPZ9yfI9n9GArmoeysEWsccAhOI30jmxUxY8V+7iQ
 nyxo3fFsXqjCYe3LpaW+j4VMxfExpSk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-CqGbbW3bMTyPUuhy45e0zA-1; Sat, 05 Dec 2020 03:54:30 -0500
X-MC-Unique: CqGbbW3bMTyPUuhy45e0zA-1
Received: by mail-pf1-f197.google.com with SMTP id n8so4847368pfa.8
 for <linux-erofs@lists.ozlabs.org>; Sat, 05 Dec 2020 00:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8SGAnxeUT9O+kwxWqPy3ZarCop9vx3+4Q8GbTneG62U=;
 b=g4Gt+KA7Q0LYA1P3t6tVrpsdNIdiSRyT/3kXZAhmqX4faZAL3e+Fyc0Rgbx5pKawmF
 3PaZL83YzBhIzG2sV+hgFfVggy30fvOSOKBY/PIiRUsAVVhp7AsG3I4So17Za4IaFbyc
 k67TwRGakVOIov8eCn/YdnjFWjQpg1l9obrMXnhfmtpXfpfbLAuxzEZYBy6EJ+yx2dQ2
 NPXqblmKTSnW74n4Opl0Rb902m6r3H2FIQ1tz+SKD9jqlCPQrLcGrRc9IRdaOWUyQiEX
 JeI1LB0ZIAmiGUIVbNYSiPzmjPq1E5qijdDopeYwWQwW5KvxnGCOee2Rl0/hPBCzp+j3
 E2nA==
X-Gm-Message-State: AOAM530vXKt+oZI/GwUZXB2dO5LAfZcIbFHfJghGetXxLXsElR6Jes6T
 emYvmwut3KV0hAFbH+7FMZF0wExoteVvS65egXquWVy8MwHz+bJJzzHSCY+kABmSkKJD1SKLSsf
 ZQKC7sPGTDQIHZRrUwFtYNYpq
X-Received: by 2002:a17:90a:4b8d:: with SMTP id
 i13mr8084991pjh.86.1607158469801; 
 Sat, 05 Dec 2020 00:54:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2XjSBvFY5qr2EuabB0kOKgbOplqPyNrReVAkAsPv8+ukH7QsXBWi4N0OjvYdwC//98lyl5g==
X-Received: by 2002:a17:90a:4b8d:: with SMTP id
 i13mr8084975pjh.86.1607158469481; 
 Sat, 05 Dec 2020 00:54:29 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id i10sm7515063pfk.206.2020.12.05.00.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Dec 2020 00:54:28 -0800 (PST)
Date: Sat, 5 Dec 2020 16:54:19 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Li GuiFu <bluce.lee@aliyun.com>
Subject: Re: [PATCH v3 2/3] erofs-utils: fuse: support symlink & special inode
Message-ID: <20201205085419.GC2333547@xiangao.remote.csb>
References: <20201127114617.13055-1-hsiangkao@aol.com>
 <20201127114617.13055-3-hsiangkao@aol.com>
 <5367c0d3-b303-6430-3e4b-99e2af4bdcbd@aliyun.com>
MIME-Version: 1.0
In-Reply-To: <5367c0d3-b303-6430-3e4b-99e2af4bdcbd@aliyun.com>
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
Cc: linux-erofs@lists.ozlabs.org, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Sat, Dec 05, 2020 at 04:42:04PM +0800, Li GuiFu via Linux-erofs wrote:
> 
> 
> On 2020/11/27 19:46, Gao Xiang via Linux-erofs wrote:
> > From: Huang Jianan <huangjianan@oppo.com>
> > 
> > This patch adds symlink and special inode (e.g. block dev, char,
> > socket, pipe inode) support.
> > 
> > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> > Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> > ---
> >  fuse/main.c | 10 ++++++++++
> >  lib/namei.c | 22 ++++++++++++++++++----
> >  2 files changed, 28 insertions(+), 4 deletions(-)
> > 
> 
> It looks good
> Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
> Tested-by: Li Guifu <bluce.lee@aliyun.com>

My tendency is that once a patch is merged to dev branch from
experimental. There is no chance to apply more tags since we need to
stablize the commit ID for dev/master branch (git commit --amend will
modify the original commit ID). So I have to ignore these RVB tags
for the reason above.

And the merging route is "experimental" (can rebase) -> "dev" (cannot
rebase) -> "master".

Also, it's actually hard to carefully review erofsfuse code here with
limited time if your bandwidth is limited as well, so I applied directly
as what I said in
https://lore.kernel.org/r/20201127131630.GA654423@xiangao.remote.csb/

But yeah, more testing is always welcome, and thanks for the testing :)

Finally, my suggestion is that it's better to use erofsfuse rather than
customized ".ko" for older linux x86 versions at HUAWEI as well, since
the old internal ".ko" versions are quite hacky and messy (at least due
to many kernel API changes).

Thanks,
Gao Xiang

