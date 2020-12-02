Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 443C92CBAAB
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Dec 2020 11:41:32 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CmFrT3GlXzDr3X
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Dec 2020 21:41:29 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=iiL5YbJh; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iiL5YbJh; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CmFrM70JxzDqkd
 for <linux-erofs@lists.ozlabs.org>; Wed,  2 Dec 2020 21:41:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606905680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KSwBOUDyXPcIBtTerXOppu0M3t5O1iaRxWsFEw9vC5M=;
 b=iiL5YbJhYMppMA0fp3u5/79kOkgY9JqihdfN34Y2Ixvg5RfIhxlkz9hGoMVBP7IoZVQv8F
 R/3exDmhRrm1DjjuMCTZpeo3UQfGC/lSBG065cMFX1D6pbddprLD/oc+bQjDFJHYqbTzy+
 PYfip7oqscFkWx5SXRRjGuy6j6OIUOU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606905680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KSwBOUDyXPcIBtTerXOppu0M3t5O1iaRxWsFEw9vC5M=;
 b=iiL5YbJhYMppMA0fp3u5/79kOkgY9JqihdfN34Y2Ixvg5RfIhxlkz9hGoMVBP7IoZVQv8F
 R/3exDmhRrm1DjjuMCTZpeo3UQfGC/lSBG065cMFX1D6pbddprLD/oc+bQjDFJHYqbTzy+
 PYfip7oqscFkWx5SXRRjGuy6j6OIUOU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-wv_rSSisNR6EmNG5XY-SEQ-1; Wed, 02 Dec 2020 05:41:18 -0500
X-MC-Unique: wv_rSSisNR6EmNG5XY-SEQ-1
Received: by mail-pf1-f198.google.com with SMTP id r8so992932pfh.9
 for <linux-erofs@lists.ozlabs.org>; Wed, 02 Dec 2020 02:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KSwBOUDyXPcIBtTerXOppu0M3t5O1iaRxWsFEw9vC5M=;
 b=Bsc4EuQyR8766mJl9lyrg6lSm6WWThdf+iZuKhAplTOtH5w9INsrwCbBDjhiJz/PK5
 MdWj299wWW9bg0Zv3kh8fMVnUOdQvEKAg4RnLyictflzypL7fARzwwUzWpXpBTQFA9Cs
 HpJDx1uVoonzXQ7DGcshl8AYUDxUCFYDgpbVT9EXv8UdD+QfDhEApi/M6Jf4vO/bl6cH
 iKavZ1uVarPfp1zIuM4qSpjnMuxNzv0IdGvtkYECKvvOP/9thvWqCCznNMH4ccs78L8S
 2EAWgFM1fH5b5f6qWBUlvLsZldNHazvTh7K6eARGTtjfwtLeg/QQMZPiJvip17UKMFDA
 YQlQ==
X-Gm-Message-State: AOAM532nJLqLojrg5VNz+rbXtrAMJ69niMHzWV427AxSz9MpzwYPEyVF
 cpcNONqGCJu+jRcQACQFQo8SXN4WIt5cRsqzjhnU3yoj2qu6+V9q8haO+HIAkz7dfvSEG0e2jGr
 UtbXmb3qvbxHOkyWcKhqmGqFt
X-Received: by 2002:a63:6882:: with SMTP id d124mr2066870pgc.197.1606905677137; 
 Wed, 02 Dec 2020 02:41:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRh6v2UqWcsTIxbX8rSEitLs9ZoK8VZoIzwksWR2LjzoRTqmKNweDKS3PXe9fEfsnDIxnp7A==
X-Received: by 2002:a63:6882:: with SMTP id d124mr2066860pgc.197.1606905676925; 
 Wed, 02 Dec 2020 02:41:16 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id bf3sm1613982pjb.45.2020.12.02.02.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Dec 2020 02:41:16 -0800 (PST)
Date: Wed, 2 Dec 2020 18:41:05 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: About Segmentation fault of mkfs.erofs in AOSP
Message-ID: <20201202104105.GA1505758@xiangao.remote.csb>
References: <20201201192309.00007531.zbestahu@gmail.com>
 <20201201114253.GA1323470@xiangao.remote.csb>
 <20201201194843.000068c5.zbestahu@gmail.com>
 <20201201115158.GA1325175@xiangao.remote.csb>
 <20201202175929.0000666a.zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201202175929.0000666a.zbestahu@gmail.com>
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
Cc: huyue2@yulong.com, linux-erofs <linux-erofs@lists.ozlabs.org>,
 zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Dec 02, 2020 at 05:59:29PM +0800, Yue Hu wrote:
> On Tue, 1 Dec 2020 19:51:58 +0800
> Gao Xiang <hsiangkao@redhat.com> wrote:
> 
> > > Gao Xiang <hsiangkao@redhat.com> wrote:
> > >   

...

> > > > 
> > > > Which lz4 version is used? it would be better to use lz4 1.9.3
> > > > (or 1.9.2 with some unexpected CR issues.)  
> > > 
> > > Hi Xiang,
> > > 
> > > ok, let me check.  
> > 
> > At least, lz4 1.8.3 ~ 1.9.1 are buggy, for more details, see:
> > https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/README?h=dev#n107
> > 
> 
> wow, working fine when i upgrade lz4 version from 1.8.3 to 1.9.3 bypass vndk error.
> 

Thanks for the feedback, I'm now working on add unique testcases to
intercept such broken lz4 versions as well, the WIP branch is
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-test

> And seems canned fs config processing has minor issue. I will double check and submit patch if possible.

Comments, patches, evaluation are always welcome :)
(btw, I'm about to release erofs-utils v1.2 this month...)

Thanks,
Gao Xiang

> 
> Thank you!
> 
> > >   

