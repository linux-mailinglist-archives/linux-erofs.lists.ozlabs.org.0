Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C11A6D70F0
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 01:56:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Prl6P1SlBz3cjL
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 09:56:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1680652605;
	bh=CiwVxtHqh7PtMKcIrbTly4vzLJ3BWefIHUj9tJBpUIs=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DR7cee9bHYMgnKX8X/kSCaoE+SqGjhzYzio/eFC1bMzKsX9WNH1sobV55VOwGGHio
	 AAeDd9ZMqag1rmvGl6bQLJg3J/Q1sxW5FtXxihQUepZBcOCEUm2fDVUIthe9VOW8n8
	 fatS+GqU0KZ5M+4pMxdfyNX9BcQRBLu5uBaL5/rDusjVfgE8TFvJkWfxtgnykHyEkL
	 YTNoyIyPhpVh5QE8Yjx7o78G+n0M9377dmGmd9XaLJfnzANTXTrZGmmrzaHZObYve1
	 /kHplPpV2y2DF3gZOexY4QrFCRsxtKk0Gjfa6RCkY4MdFnPJr4ujwmQp2k4dI+yhJS
	 qST7txGRJNi+A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=david@fromorbit.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20210112.gappssmtp.com header.i=@fromorbit-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=vimaQLlp;
	dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Prl6K5rdbz3cfj
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 09:56:39 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id l14so22539047pfc.11
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Apr 2023 16:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680652597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiwVxtHqh7PtMKcIrbTly4vzLJ3BWefIHUj9tJBpUIs=;
        b=QnZokHeJGXc406TAocI/xMIvxAPQaA/pUT5BwAuBCGwocKs95n6T/LaCtmGbqhzt93
         do+DVzsgXhVxjyzo1xjXWmVbBp1R2u4GstYScLDuVmiQkcAg8x/ZZzKsV7drwg5wIJX3
         DpE8J1lKdKGG8ukmR3SGLbNDBTkI3uSa1ZKdZ6/UQ5D7N+4vbWSYEsHWA6Eq/2oBWozo
         vhtTPhODI748wEgiue9HaQdJYiEHqg24Gjual7sgbYtllDsrfY4w9IX2I1wdQYwh20l0
         8+fYbrCdFz6KoIGpfikm+LTXAjDmmfxj873h1At64kT037J3zxGAupx6WIFWs/MDa7IO
         kKzA==
X-Gm-Message-State: AAQBX9c6xDkXKZ/WMq1og0LcBuoQh0tK8CwzBsjF2yN9XMDhJZBRnMeO
	LPHIhLnlJ0XupCjRUFouUZ3tUw==
X-Google-Smtp-Source: AKy350boc1NJttMEXbPWdN9rfQR7KWvZb/0IvD3DuAJJ+io4CZz0OVS7AP+iey99+szOCn0Wgij/bQ==
X-Received: by 2002:a62:6454:0:b0:626:7c43:7cb8 with SMTP id y81-20020a626454000000b006267c437cb8mr3631280pfb.20.1680652596758;
        Tue, 04 Apr 2023 16:56:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id a18-20020a656412000000b005136b93f8e9sm8146027pgv.14.2023.04.04.16.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 16:56:36 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1pjqVt-00H7ij-6l; Wed, 05 Apr 2023 09:56:33 +1000
Date: Wed, 5 Apr 2023 09:56:33 +1000
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 16/23] xfs: add inode on-disk VERITY flag
Message-ID: <20230404235633.GN3223426@dread.disaster.area>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-17-aalbersh@redhat.com>
 <20230404224123.GD1893@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404224123.GD1893@sol.localdomain>
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
From: Dave Chinner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, djwong@kernel.org, Andrey Albershteyn <aalbersh@redhat.com>, linux-f2fs-devel@lists.sourceforge.net, hch@infradead.org, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, damien.lemoal@opensource.wdc.com, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Apr 04, 2023 at 03:41:23PM -0700, Eric Biggers wrote:
> Hi Andrey,
> 
> On Tue, Apr 04, 2023 at 04:53:12PM +0200, Andrey Albershteyn wrote:
> > Add flag to mark inodes which have fs-verity enabled on them (i.e.
> > descriptor exist and tree is built).
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> >  fs/ioctl.c                 | 4 ++++
> >  fs/xfs/libxfs/xfs_format.h | 4 +++-
> >  fs/xfs/xfs_inode.c         | 2 ++
> >  fs/xfs/xfs_iops.c          | 2 ++
> >  include/uapi/linux/fs.h    | 1 +
> >  5 files changed, 12 insertions(+), 1 deletion(-)
> [...]
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index b7b56871029c..5172a2eb902c 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -140,6 +140,7 @@ struct fsxattr {
> >  #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
> >  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
> >  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
> > +#define FS_XFLAG_VERITY		0x00020000	/* fs-verity sealed inode */
> >  #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
> >  
> 
> I don't think "xfs: add inode on-disk VERITY flag" is an accurate description of
> a patch that involves adding something to the UAPI.

Well it does that, but it also adds the UAPI for querying the
on-disk flag via the FS_IOC_FSGETXATTR interface as well.  It
probably should be split up into two patches.

> Should the other filesystems support this new flag too?

I think they should get it automatically now that it has been
defined for FS_IOC_FSGETXATTR and added to the generic fileattr flag
fill functions in fs/ioctl.c.

> I'd also like all ways of getting the verity flag to continue to be mentioned in
> Documentation/filesystems/fsverity.rst.  The existing methods (FS_IOC_GETFLAGS
> and statx) are already mentioned there.

*nod*

-Dave.
-- 
Dave Chinner
david@fromorbit.com
