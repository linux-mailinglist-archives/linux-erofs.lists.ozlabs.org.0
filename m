Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B202FFA27
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 02:49:28 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMMd15zk2zDrYX
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 12:49:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=MoUQe+B2; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MoUQe+B2; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMMcw0kwpzDrSN
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 12:49:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611280155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTRpbK0Xaoh6wR01XL/uZWSYlZHPDc50JqiblCFNLZs=;
 b=MoUQe+B23KLI0XI7p6903UxII2zO3J1BJtCrXx/t/UmeaC6bVIs9e9Q5vpuy8sWiOrHiHH
 q07pe4f1/uFv5F3TLdHym32Y8DuvlrEOUaAH+TCQHJBupV+Nf7IyOuAwKljQHAwduwQNcl
 3d7W8d4HCSscbJeCBG49/UyhOxnkOp4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611280155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTRpbK0Xaoh6wR01XL/uZWSYlZHPDc50JqiblCFNLZs=;
 b=MoUQe+B23KLI0XI7p6903UxII2zO3J1BJtCrXx/t/UmeaC6bVIs9e9Q5vpuy8sWiOrHiHH
 q07pe4f1/uFv5F3TLdHym32Y8DuvlrEOUaAH+TCQHJBupV+Nf7IyOuAwKljQHAwduwQNcl
 3d7W8d4HCSscbJeCBG49/UyhOxnkOp4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-DHfPDDp2P6uDt7fuB4RUnw-1; Thu, 21 Jan 2021 20:49:13 -0500
X-MC-Unique: DHfPDDp2P6uDt7fuB4RUnw-1
Received: by mail-pj1-f70.google.com with SMTP id hg20so2650111pjb.3
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 17:49:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=aTRpbK0Xaoh6wR01XL/uZWSYlZHPDc50JqiblCFNLZs=;
 b=XrRD01698iWVlMaMDDEyhkFiX7mCI7hsitWoAMTAsO4dS6vKa9m+Xws4lkYjnxnsG6
 hUZsijGUCko9hYiZP2oAb9tf+PZk2aPrK90w1ydOUxyEAF1DwBGtIpoynIQnwvRvI8s8
 9pvXLeyOkee8hNOGniLLaGHk6uoilW10gE+y15AIKac+52j6MgPXPRDiWhdMtHcUDeyY
 vBHTE4Ya4UlOegG6u1Ug5dTRMLe8aOcKuA/eWUmYuo2LDBI7QLP/xvUqix64jgpFxeAK
 2NOPJ9CX1Bj7LOxKlHTGQVx64EQtg9lt+GSVn0v6nyb3WQqONg64iKytGKcL2fGubc9U
 iD+g==
X-Gm-Message-State: AOAM5331UxEQFfOGAY2SuVu59vgEJoS2THc/ymztodv3fziUgucKoFdv
 NMhoCbllMCUYu6OWOeUmncP1If/yWNeqiibm+aZ/EfGClDpLit/PoxOlDCByFlIiZ65/vsw6Y7J
 iHWfOD3zPdkjwMYUokJD6mXCc
X-Received: by 2002:a17:90b:1483:: with SMTP id
 js3mr2567170pjb.121.1611280152605; 
 Thu, 21 Jan 2021 17:49:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyeaWLTgVk/fzcPop/TY/c8VNlPWb+g3u2yH2Jj7b+RbvSgh5CKLSwvABVWdxUaceQg2W7aGQ==
X-Received: by 2002:a17:90b:1483:: with SMTP id
 js3mr2567143pjb.121.1611280152338; 
 Thu, 21 Jan 2021 17:49:12 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a21sm6688681pgd.57.2021.01.21.17.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 17:49:11 -0800 (PST)
Date: Fri, 22 Jan 2021 09:49:01 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: fuse: fix random readlink error
Message-ID: <20210122014901.GB2918836@xiangao.remote.csb>
References: <20210122003416.GF2996701@xiangao.remote.csb>
 <86D0E0EF-4F13-4410-80C1-19B829A4D61D@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <86D0E0EF-4F13-4410-80C1-19B829A4D61D@mail.scut.edu.cn>
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

Hi Weiwen,

On Fri, Jan 22, 2021 at 09:00:44AM +0800, 胡玮文 wrote:
> Hi Xiang,
> 
> > 在 2021年1月22日，08:34，Gao Xiang <hsiangkao@redhat.com> 写道：
> > 
> > ﻿Hi Weiwen,
> > 
> >> On Fri, Jan 22, 2021 at 12:31:43AM +0800, Hu Weiwen wrote:
> >> readlink should fill a **null terminated** string in buffer.
> >> 
> >> Also, read should return number of bytes remaining on EOF.
> >> 
> >> Link: https://lore.kernel.org/linux-erofs/20210121101233.GC6680@DESKTOP-N4CECTO.huww98.cn/
> >> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> > 
> > Thanks for catching this!
> > 
> >> ---
> >> fuse/main.c | 14 +++++++++++++-
> >> 1 file changed, 13 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/fuse/main.c b/fuse/main.c
> >> index c162912..bc1e496 100644
> >> --- a/fuse/main.c
> >> +++ b/fuse/main.c
> >> @@ -71,6 +71,12 @@ static int erofsfuse_read(const char *path, char *buffer,
> >>    if (ret)
> >>        return ret;
> >> 
> >> +    if (offset >= vi.i_size)
> >> +        return 0;
> >> +
> >> +    if (offset + size > vi.i_size)
> >> +        size = vi.i_size - offset;
> >> +
> > 
> > It would be better to call erofs_pread() with the original offset
> > and size (also I think there is some missing memset(0) for
> > !EROFS_MAP_MAPPED), and fix up the return value to the needed value.
> 
> Yes, that is what I have initially tried. But this way is harder than I thought. 
> EROFS_MAP_MAPPED flag seems to be designed to handle sparse file, and is reused to
> represent EOF. So maybe we need a new flag to represent EOF? 

Nope, I think we just need to handle return value of read, I mean

erofs_ilookup()

ret = erofs_pread()
if (ret)
	return ret;

if (offset + size > vi.i_size)
	return vi.i_size - offset;

return size;

Is that enough? Am I missing something?

> So that we can distinguish EOF and hole in the middle, and return the bytes read.
> Or we just abandon the sparse file support, and use EROFS_MAP_MAPPED to indicate
> EOF exclusively. Since erofs current does not actually support this, right?

Actually, Pratik was working on it months ago, if you have some interest
of uncompressed sparse files (since for compressed files, 0-ed data would
be highly compressed by fixed-sized output compression.), could you pick
his feature up if possible? That would be of great help to EROFS as long
as you have some interest and extra time... :)

https://lore.kernel.org/r/20200102094732.31567-1-pratikshinde320@gmail.com/

Thanks,
Gao Xiang

> 
> > Thanks,
> > Gao Xiang
> > 
> >>    ret = erofs_pread(&vi, buffer, size, offset);
> >>    if (ret)
> >>        return ret;
> >> @@ -79,10 +85,16 @@ static int erofsfuse_read(const char *path, char *buffer,
> >> 
> >> static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
> >> {
> >> -    int ret = erofsfuse_read(path, buffer, size, 0, NULL);
> >> +    int ret;
> >> +    size_t path_len;
> >> +
> >> +    erofs_dbg("path:%s size=%zd", path, size);
> >> +    ret = erofsfuse_read(path, buffer, size, 0, NULL);
> >> 
> >>    if (ret < 0)
> >>        return ret;
> >> +    path_len = min(size - 1, (size_t)ret);
> >> +    buffer[path_len] = '\0';
> >>    return 0;
> >> }
> >> 
> >> -- 
> >> 2.30.0
> >> 
> 

