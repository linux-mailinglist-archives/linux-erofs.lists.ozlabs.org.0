Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC111301667
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jan 2021 16:37:05 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DNKxV5qqGzDrP0
	for <lists+linux-erofs@lfdr.de>; Sun, 24 Jan 2021 02:37:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Rv/cL4B8; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LMC09dYe; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DNKxL221DzDqgw
 for <linux-erofs@lists.ozlabs.org>; Sun, 24 Jan 2021 02:36:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611416209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+1Pu8RMQn/CCMcU+Mpn3Vadz4JB3UfD5RvGMi08LGhs=;
 b=Rv/cL4B8qs2i8rA5t6LZMmv97RJniMT0DNm847HPOwVxsHUgmsLxI3S1Nl2dgNmUUwF6gN
 s5aAHpLa94Gkhb7bOBvIJdr/SomB4xGJGyOXsxchGmitJlbnUUqim5xRLd+P4441WanFli
 yJVFmNWMARS9E8gfGqktL3nouIlzE+I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611416210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+1Pu8RMQn/CCMcU+Mpn3Vadz4JB3UfD5RvGMi08LGhs=;
 b=LMC09dYe/GtTUYntZWNlsB5/URbeMSCfuDV05Mt21o9rFyQkdRaDAgMlNCx1ptyEM0n71O
 DI3XIIzQ9b8kF5c5ThOJ62zrgSzoVoOV11BuSJfy1RfbCFC+DED2lVxOIlHSdVpFvTv4ik
 WMDJDWs6gP4IzpXmZokfecIaueEBS0U=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-FXgStbgBMcuSHgPHi1DddA-1; Sat, 23 Jan 2021 10:36:48 -0500
X-MC-Unique: FXgStbgBMcuSHgPHi1DddA-1
Received: by mail-pg1-f200.google.com with SMTP id l15so4610954pgr.6
 for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jan 2021 07:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=+1Pu8RMQn/CCMcU+Mpn3Vadz4JB3UfD5RvGMi08LGhs=;
 b=J8NjNmIc3rtOyPnVXXzSzEpgVW9SCh0bsGlVllIwibeS7SqCGymGjk/SjdWGUyb/0a
 M4cZmQ3i3RhAgKz+eWXAS3zYg6AU/fRkJ24wy6cvcgXSMixY3negLQVokbf6fj9bpha4
 nDSuVmqltcx01c4v5C48vqnZos16Yi7ipXsOSXPFP0KnnLBMGGUHgQahtAaeEW3qlaiq
 oSHaYP/HvuOIHlBeC+922tVtCmV1JUu+wf04zkvTlBmDN58Cz5aZNWj+BxYg/Iio+rKw
 XZyS1RtOACGtD8YMaE1xvo0K2MOnYTWw5FiMe0PxENJ9oyWh+K8oXwxre5ywz8R0tcZi
 WDiA==
X-Gm-Message-State: AOAM5301Icf2DWEyqkhjQxHr58b37vfdvjMZG0C0GcxPdihTdVvGIgrZ
 y9pGvyjpXJxLMH4OnKXWaI7yuDLJLqbOdft7X/uOiNEPkeyLgiF7MO/exFqLIgiDrpyEshYafju
 OrT4Jdm0s/C7pXKsh6C00TkFE
X-Received: by 2002:a63:fc56:: with SMTP id r22mr5538900pgk.203.1611416206839; 
 Sat, 23 Jan 2021 07:36:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNfOPK5+szBfF6lOZlQlW7j6f+2QxVfxqlMmwXYEbtebcK8ElTaBd+52Ci9DN04XCXxSaTbA==
X-Received: by 2002:a63:fc56:: with SMTP id r22mr5538883pgk.203.1611416206598; 
 Sat, 23 Jan 2021 07:36:46 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id gv22sm12444392pjb.56.2021.01.23.07.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Jan 2021 07:36:45 -0800 (PST)
Date: Sat, 23 Jan 2021 23:36:36 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: fuse: fix random readlink error
Message-ID: <20210123153636.GC3167351@xiangao.remote.csb>
References: <20210122003416.GF2996701@xiangao.remote.csb>
 <86D0E0EF-4F13-4410-80C1-19B829A4D61D@mail.scut.edu.cn>
 <20210122014901.GB2918836@xiangao.remote.csb>
 <20210123131830.GA16490@DESKTOP-N4CECTO.huww98.cn>
 <20210123152213.GB3167351@xiangao.remote.csb>
MIME-Version: 1.0
In-Reply-To: <20210123152213.GB3167351@xiangao.remote.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jan 23, 2021 at 11:22:13PM +0800, Gao Xiang wrote:
> On Sat, Jan 23, 2021 at 09:18:30PM +0800, 胡玮文 wrote:
> > On Fri, Jan 22, 2021 at 09:49:01AM +0800, Gao Xiang wrote:
> > > Hi Weiwen,
> > > 
> > > On Fri, Jan 22, 2021 at 09:00:44AM +0800, 胡玮文 wrote:
> > > > Hi Xiang,
> > > > 
> > > > > 在 2021年1月22日，08:34，Gao Xiang <hsiangkao@redhat.com> 写道：
> > > > > 
> > > > > ﻿Hi Weiwen,
> > > > > 
> > > > >> On Fri, Jan 22, 2021 at 12:31:43AM +0800, Hu Weiwen wrote:
> > > > >> readlink should fill a **null terminated** string in buffer.
> > > > >> 
> > > > >> Also, read should return number of bytes remaining on EOF.
> > > > >> 
> > > > >> Link: https://lore.kernel.org/linux-erofs/20210121101233.GC6680@DESKTOP-N4CECTO.huww98.cn/
> > > > >> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> > > > > 
> > > > > Thanks for catching this!
> > > > > 
> > > > >> ---
> > > > >> fuse/main.c | 14 +++++++++++++-
> > > > >> 1 file changed, 13 insertions(+), 1 deletion(-)
> > > > >> 
> > > > >> diff --git a/fuse/main.c b/fuse/main.c
> > > > >> index c162912..bc1e496 100644
> > > > >> --- a/fuse/main.c
> > > > >> +++ b/fuse/main.c
> > > > >> @@ -71,6 +71,12 @@ static int erofsfuse_read(const char *path, char *buffer,
> > > > >>    if (ret)
> > > > >>        return ret;
> > > > >> 
> > > > >> +    if (offset >= vi.i_size)
> > > > >> +        return 0;
> > > > >> +
> > > > >> +    if (offset + size > vi.i_size)
> > > > >> +        size = vi.i_size - offset;
> > > > >> +
> > > > > 
> > > > > It would be better to call erofs_pread() with the original offset
> > > > > and size (also I think there is some missing memset(0) for
> > > > > !EROFS_MAP_MAPPED), and fix up the return value to the needed value.
> > > > 
> > > > Yes, that is what I have initially tried. But this way is harder than I thought. 
> > > > EROFS_MAP_MAPPED flag seems to be designed to handle sparse file, and is reused to
> > > > represent EOF. So maybe we need a new flag to represent EOF? 
> > > 
> > > Nope, I think we just need to handle return value of read, I mean
> > > 
> > > erofs_ilookup()
> > > 
> > > ret = erofs_pread()
> > > if (ret)
> > > 	return ret;
> > > 
> > > if (offset + size > vi.i_size)
> > > 	return vi.i_size - offset;
> > > 
> > > return size;
> > > 
> > > Is that enough? Am I missing something?
> > 
> > This should work, except we should also add this branch
> > 
> > if (offset >= vi.i_size)
> > 	return 0;
> 
> yeah, agreed. It'd also be added after erofs_pread().
> 
> >
> > But how this is better than my original patch? I would say my patch should be
> > more efficient.
> > 
> > By saying "what I have initially tried" in my last mail, I mean changing
> > erofs_pread() to return the number of bytes read (just like pread system call,
> > instead of always 0). I think this is easier to understand for others, but
> > seems harder to implement. Do you think this is worthful?
> > 
> 
> There are 2 reasons for me to do it at least:
> 1) need to memset(0) for these unmapped buffers;
> 2) introduce a hook to fs to read data regardless of i_size,
>    just as linux kernel page cache approach.
> 
> Don't be confused with ->i_size (this is only a EOF-marker) and
> the real inode data, that are two different concepts for me, I'd
> like to handle all data processing in erofs_pread() (even for
> post-EOF case), but only deal with i_size in erofsfuse_read().
> 

Also, no need to follow erofs_pread() as the pread() system call.
It just used a similiar name. The core concept of this is to handle
file data itself. There is nothing to do with eof-marker (but much
related to inode extent/block mapping instead, although currently
EROFS extent mapping format internally relies on i_size.)

Thanks,
Gao Xiang

> Thanks,
> Gao Xiang
> 

