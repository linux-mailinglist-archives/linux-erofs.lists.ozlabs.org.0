Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3702A300369
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 13:44:20 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMf8d4BNTzDrRc
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 23:44:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ZyRT6udZ; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aF7a32Dj; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMf8V0zFrzDqNW
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 23:44:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611319446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cC9/ct5iMZo1UcSRMXNc61jAMmh7Jff3VgaV7tsP5lc=;
 b=ZyRT6udZiFmDFoWzUjnbNPtKmtWOTgG4wzi+1kxGJm+p81h4KspNG5YhDyAQyRFnbXMhBw
 GOZ+sVs7ajRBvm6IV+QkysQfXbWPK23h0bHbT2kcf1YW2jxyba/Tj0v4HDfyR1ecbQwbtC
 fKKLsamo2kbR3DLvceethxFJZysm99s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611319447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cC9/ct5iMZo1UcSRMXNc61jAMmh7Jff3VgaV7tsP5lc=;
 b=aF7a32Djx+AYlwbSQzFC4jgq9Ch7fH0VD1ojb1U4bsHitf95EROUF0ZxMTsWBi/DYjAgIM
 qj5JxByEKw1F+WQa7dZfymZj8l4sTjXNGUORzSPUzoZI8msKULhG/z7ezTk1mQ//CsZlFi
 KO8nPkhE/Y65Ej+L91U4QmfIUBsvdF0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-Po3G8l5RMYWKJ9nnjJk4sg-1; Fri, 22 Jan 2021 07:44:04 -0500
X-MC-Unique: Po3G8l5RMYWKJ9nnjJk4sg-1
Received: by mail-pj1-f72.google.com with SMTP id e10so3537791pjj.8
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 04:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cC9/ct5iMZo1UcSRMXNc61jAMmh7Jff3VgaV7tsP5lc=;
 b=OOcYDcnj+qpvdKiI2Koj8JShjbp0laWm1xAJX97LMPX0TuIjLxYmTebUBH4aHvDeJE
 4k7Uh+G23p30GnN4ReZRaEA4ht9zoO3nPf59ALTuaGWt1iaLiuKhVMsu4E6AkVjF+y+O
 Q76QM9dyNhIJyDlhq0/bR9hCVaSKxUPL8iZia3iL4zjwiR3Ps7zDWQiZSexnEPGBR9sF
 jHZ8CXrIvyu5zoNJ6r0ZddK8kak+M84fPUS71Y161MmIW8z8RTs6j6jOLwV6St5kAkR8
 lRMFCAMoJZbkfHIhMpnRBodeXRTxQ/k1vNRQ4gvaQRo/29YdKo7xT9L7qSd0LJUdZmXh
 +pOg==
X-Gm-Message-State: AOAM533k5TmsYrOTX8CfJbGJS+EqX/RZCtOqVz8LGBErdDI9w8Arsk0c
 NMHZj/kTvIH2Lqx78+1y1CMq23QPy1Kue0SuPBFysK7yKD19sG8eCutKkdhKMV+jTkWls9TQH24
 LuWIrcHqZrDMo5gEORzk+33Wx
X-Received: by 2002:a17:90a:5889:: with SMTP id
 j9mr5114192pji.195.1611319443705; 
 Fri, 22 Jan 2021 04:44:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy62+PmjHsfg8ehBa7rURaGZhT5w634Mh2HKS2hQp/PHbPjEQS3rVmyUmJmyu/hboFEqgKCzg==
X-Received: by 2002:a17:90a:5889:: with SMTP id
 j9mr5114179pji.195.1611319443498; 
 Fri, 22 Jan 2021 04:44:03 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c23sm9225903pgc.72.2021.01.22.04.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 04:44:02 -0800 (PST)
Date: Fri, 22 Jan 2021 20:43:52 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH v2] erofs-utils: fix battach on full buffer block
Message-ID: <20210122124352.GA3105292@xiangao.remote.csb>
References: <20210120051216.GA2688693@xiangao.remote.csb>
 <20210121162606.8168-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210121162606.8168-1-sehuww@mail.scut.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Weiwen,

On Fri, Jan 22, 2021 at 12:26:06AM +0800, Hu Weiwen wrote:
> When __erofs_battach() is called on an buffer block of which
> (bb->buffers.off % EROFS_BLKSIZ == 0), `tail_blkaddr' will not be
> updated correctly. This bug can be reproduced by:
> 
> mkdir bug-repo
> head -c 4032 /dev/urandom > bug-repo/1
> head -c 4095 /dev/urandom > bug-repo/2
> head -c 12345 /dev/urandom > bug-repo/3  # arbitrary size
> mkfs.erofs -Eforce-inode-compact bug-repo.erofs.img bug-repo
> 
> Then mount this image and see that file `3' in the image is different
> from `bug-repo/3'.
> 
> This patch fix this by:
> 
> * Don't inline tail-end data in this case, since the tail-end data will
> be in a different block from inode.
> * Correctly handle `battach' in this case.
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> ---
> Hi Xiang,
> 
> I still think send this as a seperate patch would be better. In previous v6
> patch, I have fixed the erofs_mapbh() behaviour so that there should be no
> user-visible bug introduced in that patch. And this patch is almost unrelated
> to that optimization.
> 
> Compared with v1, this version fixes an error when compression is enabled.
> 

I have to say I still don't get the point of the whole description
above and the patch itself honestly. even if (bb->buffers.off %
EROFS_BLKSIZ == 0), the whole block can be used for tail-packing
inline + inode. Assume that you testcase above is the case you
addressed, could you elaborate them in detail?

If the original behavior is no user-visiable, I'm not sure what
issue you'd like to resolve...

Thanks,
Gao Xiang

> Thanks,
> Hu Weiwen

