Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E23301640
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jan 2021 16:22:46 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DNKcz08gNzDrgT
	for <lists+linux-erofs@lfdr.de>; Sun, 24 Jan 2021 02:22:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=dolRX9+t; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hX9l6RPW; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DNKcn35xLzDrgG
 for <linux-erofs@lists.ozlabs.org>; Sun, 24 Jan 2021 02:22:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611415347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2YYFjXJGRO17MhxZ91EQD0JniTDP8+4fGvsb+Yd6IU=;
 b=dolRX9+txQaHP3RZt8Gp0dX80dp9pl9ZzxYYGTfybdjplyiGmuyr83G6xvTPxOouOliGTl
 wG9CQejpO0c2jrEnrzlL19HmkAPkun0HA5H8YiyTv89ZbxUV16Q47OGik4CCdFXu9Ndq8w
 V//37LctEFLoVhiTLszY7+ZnbDP9erQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611415348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2YYFjXJGRO17MhxZ91EQD0JniTDP8+4fGvsb+Yd6IU=;
 b=hX9l6RPWSQszRYdks9bjRBH2SUkYq192vo6STChndiQ56WUxNh5hD6QbEInBRyocpwIUV5
 3gCKMLZ5ldQsd7T7acw4TAqIjThfzTKi6wZfAw7E9rG7Jo21lxiQ/JfMQZLbQNBqNnrIOU
 4ADDmXwGkIgrWepyLzpPr670XkZx1pA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-oMYUYOpRNRiW4T3y0OMuAA-1; Sat, 23 Jan 2021 10:22:25 -0500
X-MC-Unique: oMYUYOpRNRiW4T3y0OMuAA-1
Received: by mail-pj1-f71.google.com with SMTP id w9so5750142pjh.7
 for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jan 2021 07:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=O2YYFjXJGRO17MhxZ91EQD0JniTDP8+4fGvsb+Yd6IU=;
 b=Dq1nTDbFFPvzH28tc6P99QrikKcGx/XtR+lccqE4Zo1wvOtWh4cOJFiD8gVI0WEhmr
 Zi6R06sxYM8arDTKxvM5Tq8+qV/W+eVFcO4GitO/qtST2ANTF+GPvJUSeFjzxUAvjJeG
 DTZH9WTXBXQxnwMbf49ege3jve6wcGv9zWj/sRWs8Nsw1gMzBwddicTg950vneBrGF9g
 PK+g7wIxoVXg7ZtgJ3rtUXPt1IssyabryYoPGB65Z0XUyEJgjY+FzNpM6xyEtHqqobyi
 I7X8X/VqTwrW/UcHRkvKknSvqptmDtMh3UEWakrEBXH5u8RQzWHqLNDg6hLK5M0itQ2G
 g3dA==
X-Gm-Message-State: AOAM532lOymL8/OomYyNRPT1zDBzj0Tap0qhEP///T901eT2xGh5tNLP
 xAP/JHW5hPuaVrtxep2IIr1+wpC/fDCN6F37ydpjuWwtdfPCzPTfuTyDXlE2B1iK+AQLZ40xRqg
 8utLfdAH9Z+hW35SkLPy+/CJm
X-Received: by 2002:a62:e30e:0:b029:1b9:3823:4b3a with SMTP id
 g14-20020a62e30e0000b02901b938234b3amr446905pfh.15.1611415344271; 
 Sat, 23 Jan 2021 07:22:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMM7bEcYcbJOrGOgh+Vn560IXqtThqK9FKwfbygDQSxrzM7rfeeB927aOcvOrPHEx1faElkQ==
X-Received: by 2002:a62:e30e:0:b029:1b9:3823:4b3a with SMTP id
 g14-20020a62e30e0000b02901b938234b3amr446886pfh.15.1611415343981; 
 Sat, 23 Jan 2021 07:22:23 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v1sm12413789pga.63.2021.01.23.07.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Jan 2021 07:22:23 -0800 (PST)
Date: Sat, 23 Jan 2021 23:22:13 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: fuse: fix random readlink error
Message-ID: <20210123152213.GB3167351@xiangao.remote.csb>
References: <20210122003416.GF2996701@xiangao.remote.csb>
 <86D0E0EF-4F13-4410-80C1-19B829A4D61D@mail.scut.edu.cn>
 <20210122014901.GB2918836@xiangao.remote.csb>
 <20210123131830.GA16490@DESKTOP-N4CECTO.huww98.cn>
MIME-Version: 1.0
In-Reply-To: <20210123131830.GA16490@DESKTOP-N4CECTO.huww98.cn>
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

On Sat, Jan 23, 2021 at 09:18:30PM +0800, 胡玮文 wrote:
> On Fri, Jan 22, 2021 at 09:49:01AM +0800, Gao Xiang wrote:
> > Hi Weiwen,
> > 
> > On Fri, Jan 22, 2021 at 09:00:44AM +0800, 胡玮文 wrote:
> > > Hi Xiang,
> > > 
> > > > 在 2021年1月22日，08:34，Gao Xiang <hsiangkao@redhat.com> 写道：
> > > > 
> > > > ﻿Hi Weiwen,
> > > > 
> > > >> On Fri, Jan 22, 2021 at 12:31:43AM +0800, Hu Weiwen wrote:
> > > >> readlink should fill a **null terminated** string in buffer.
> > > >> 
> > > >> Also, read should return number of bytes remaining on EOF.
> > > >> 
> > > >> Link: https://lore.kernel.org/linux-erofs/20210121101233.GC6680@DESKTOP-N4CECTO.huww98.cn/
> > > >> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> > > > 
> > > > Thanks for catching this!
> > > > 
> > > >> ---
> > > >> fuse/main.c | 14 +++++++++++++-
> > > >> 1 file changed, 13 insertions(+), 1 deletion(-)
> > > >> 
> > > >> diff --git a/fuse/main.c b/fuse/main.c
> > > >> index c162912..bc1e496 100644
> > > >> --- a/fuse/main.c
> > > >> +++ b/fuse/main.c
> > > >> @@ -71,6 +71,12 @@ static int erofsfuse_read(const char *path, char *buffer,
> > > >>    if (ret)
> > > >>        return ret;
> > > >> 
> > > >> +    if (offset >= vi.i_size)
> > > >> +        return 0;
> > > >> +
> > > >> +    if (offset + size > vi.i_size)
> > > >> +        size = vi.i_size - offset;
> > > >> +
> > > > 
> > > > It would be better to call erofs_pread() with the original offset
> > > > and size (also I think there is some missing memset(0) for
> > > > !EROFS_MAP_MAPPED), and fix up the return value to the needed value.
> > > 
> > > Yes, that is what I have initially tried. But this way is harder than I thought. 
> > > EROFS_MAP_MAPPED flag seems to be designed to handle sparse file, and is reused to
> > > represent EOF. So maybe we need a new flag to represent EOF? 
> > 
> > Nope, I think we just need to handle return value of read, I mean
> > 
> > erofs_ilookup()
> > 
> > ret = erofs_pread()
> > if (ret)
> > 	return ret;
> > 
> > if (offset + size > vi.i_size)
> > 	return vi.i_size - offset;
> > 
> > return size;
> > 
> > Is that enough? Am I missing something?
> 
> This should work, except we should also add this branch
> 
> if (offset >= vi.i_size)
> 	return 0;

yeah, agreed. It'd also be added after erofs_pread().

>
> But how this is better than my original patch? I would say my patch should be
> more efficient.
> 
> By saying "what I have initially tried" in my last mail, I mean changing
> erofs_pread() to return the number of bytes read (just like pread system call,
> instead of always 0). I think this is easier to understand for others, but
> seems harder to implement. Do you think this is worthful?
> 

There are 2 reasons for me to do it at least:
1) need to memset(0) for these unmapped buffers;
2) introduce a hook to fs to read data regardless of i_size,
   just as linux kernel page cache approach.

Don't be confused with ->i_size (this is only a EOF-marker) and
the real inode data, that are two different concepts for me, I'd
like to handle all data processing in erofs_pread() (even for
post-EOF case), but only deal with i_size in erofsfuse_read().

Thanks,
Gao Xiang

