Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3272E814C
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Dec 2020 17:50:57 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D6DgL36sTzDqKN
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Jan 2021 03:50:54 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=GBhmu0K9; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GBhmu0K9; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D6Dg650DczDqGP
 for <linux-erofs@lists.ozlabs.org>; Fri,  1 Jan 2021 03:50:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609433436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7ekweP/RbcKIJKtOEFaH7R7hSYlTN2BXTV0OkRK4+0=;
 b=GBhmu0K90m3IroSrithMVd94/Z8abWc95/5+5qH6vSv2pI31eGy5K9xMpTUA2izk6f/7K7
 XzaN3N2KcgZVcbzNkrsDUusen4MHfdxp2w5J8nmYBwsdm7MnXVSKEPy8cHuMbT0m/G5XYC
 u0JLrpEymVhUJ7pBbjAzFfgpQ38rRyM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609433436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7ekweP/RbcKIJKtOEFaH7R7hSYlTN2BXTV0OkRK4+0=;
 b=GBhmu0K90m3IroSrithMVd94/Z8abWc95/5+5qH6vSv2pI31eGy5K9xMpTUA2izk6f/7K7
 XzaN3N2KcgZVcbzNkrsDUusen4MHfdxp2w5J8nmYBwsdm7MnXVSKEPy8cHuMbT0m/G5XYC
 u0JLrpEymVhUJ7pBbjAzFfgpQ38rRyM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-_u9yf7agOI-RrRBitCzGuw-1; Thu, 31 Dec 2020 11:50:34 -0500
X-MC-Unique: _u9yf7agOI-RrRBitCzGuw-1
Received: by mail-pj1-f70.google.com with SMTP id q10so6445551pjg.1
 for <linux-erofs@lists.ozlabs.org>; Thu, 31 Dec 2020 08:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Q7ekweP/RbcKIJKtOEFaH7R7hSYlTN2BXTV0OkRK4+0=;
 b=XfQd5jisBK6G893fq8e5khEg4yBdjmCmq5lsJf7iZM6oave1Miu7iIOtm1RpkUFRhO
 nQ3TxI94XqVzvdYbeUy3HC99P2hkJe6ocL1Sf6g17uoGcyK7KhWb/HA/VTKky5lpS859
 6iLjyKTQcnhuprnejq4A4lX/8wfrQZQ+Z5L0hzt8Xyre8al5PYpis89T1IZTFsTi94xb
 4xeiiAIYJXE3OXVELytc5AACGWQuhgPZ7b23gvTKuPiSwO+glzGhRUbBXdB/Of39H+CF
 r34267DlaFq3rNBwyIKD3I180A246p9I0UNFKLKUYLYBdBWlG/dXG6Rr4HEwyRJusBWA
 a30w==
X-Gm-Message-State: AOAM531tGSCj7D4/Ln3c3bYetYvNH1zZbT1PNPOrzDP3ArP0bOD0uoHd
 sz8PqUQIZcGdL7Fxq/emntd/8U1cBqeiqxoJ3vajsyR/lQgvaTeQCU/NI11Kj2cIclQ3L8vcsnc
 cTnO7Cv2R7joa8u4+btmFSAtI
X-Received: by 2002:a63:597:: with SMTP id 145mr56966982pgf.252.1609433433466; 
 Thu, 31 Dec 2020 08:50:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8YxyIyjyEi5vmi3CHdkagRuT3Vce/o5ESx9BiNlzf2DEWuSa2nkpUbaYeojp6qTvNT95IIw==
X-Received: by 2002:a63:597:: with SMTP id 145mr56966970pgf.252.1609433433169; 
 Thu, 31 Dec 2020 08:50:33 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 5sm46197016pff.125.2020.12.31.08.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Dec 2020 08:50:32 -0800 (PST)
Date: Fri, 1 Jan 2021 00:50:22 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Li GuiFu <bluce.lee@aliyun.com>
Subject: Re: [PATCH v2] AOSP: erofs-utils: fix sub-directory prefix for
 canned fs_config
Message-ID: <20201231165022.GA3493580@xiangao.remote.csb>
References: <20201226062736.29920-1-hsiangkao@aol.com>
 <20201228105146.2939914-1-hsiangkao@redhat.com>
 <bbfb6dba-7db1-a0ab-e766-e6f3c4d10976@aliyun.com>
MIME-Version: 1.0
In-Reply-To: <bbfb6dba-7db1-a0ab-e766-e6f3c4d10976@aliyun.com>
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
Cc: Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 Yue Hu <zbestahu@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Fri, Jan 01, 2021 at 12:31:22AM +0800, Li GuiFu wrote:
> Thank for your works, Yue Hu, Jianan, Gao Xiang
> 
> On 2020/12/28 18:51, Gao Xiang wrote:

...

> > diff --git a/lib/inode.c b/lib/inode.c
> > index 0c4839d..e6159c9 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -696,32 +696,43 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
> >  	/* filesystem_config does not preserve file type bits */
> >  	mode_t stat_file_type_mask = st->st_mode & S_IFMT;
> >  	unsigned int uid = 0, gid = 0, mode = 0;
> > -	char *fspath;
> > +	const char *fspath;
> > +	char *decorated = NULL;
> >  
> >  	inode->capabilities = 0;
> > +	if (!cfg.fs_config_file && !cfg.mount_point)
> > +		return 0;
> > +
> > +	if (!cfg.mount_point ||
> > +	/* have to drop the mountpoint for rootdir of canned fsconfig */
> > +	    (cfg.fs_config_file && erofs_fspath(path)[0] == '\0')) {
> > +		fspath = erofs_fspath(path);
> > +	} else {
> > +		if (asprintf(&decorated, "%s/%s", cfg.mount_point,
> > +			     erofs_fspath(path)) <= 0)
> > +			return -ENOMEM;
> > +		fspath = decorated;
> > +	}
> > +
> erofs_fspath has been written for three times, and called always.
> What do you think refact it ? Do it with
> fspath = erofs_fspath(path);
> if need decorated:
>    fspath = decorated

Yeah, it sounds reasonable. Let's refine this as a improvement of
an individual patch (if needed) since I have to rebuild AOSP again
(that is a bit complex for me now to open my PC...)

Thanks,
Gao Xiang

> 

