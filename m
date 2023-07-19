Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239A5758AEB
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jul 2023 03:35:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1689730552;
	bh=xZssYNKocP7SJAjxckC3wBJ507CzulE9IvrMWjf3P+k=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=h/K40Hh652hGvZs3aNshtPKaD3+a+XKjCfy7dqH9E7FW8AvZgdGcj+FcjF8ydmQqM
	 FWFQL9B2zf9Vq6XMGhOG9XyAbJf3yPfClr+MLu1mwXqBYbh6pKexUW56g6T26YC0N4
	 QM6W1wqvcVvGIg1cEgnZuqk/WfzUsOvrIFizqS/BV14vN8f6v4vJXvnXsjgBjldRJ4
	 crjTSK2HButQxL4MNrw4LYpOpYtOadIthnl7I/F9zcEWgBsboDZDROleCRxwNdG0pv
	 34AS5dpKl9T7sd/dSts+fk6d4a3+Uw2wACNYIh2LiW+AOy99Si21Sg7WMFcTEP3wTg
	 1SU9zxvFMFlLA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R5JLJ5DXzz3bWW
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jul 2023 11:35:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20221208.gappssmtp.com header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=UyEHrifu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R5JLB1mPHz2ykT
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jul 2023 11:35:44 +1000 (AEST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1bac0e25891so754525fac.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jul 2023 18:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689730542; x=1692322542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZssYNKocP7SJAjxckC3wBJ507CzulE9IvrMWjf3P+k=;
        b=Vb7NYZnf2Q5Mo3JKrURnhLP8vKPDk5k24Yi09v9xFl40UMg4ppnz/jJ4MHIPJH+PXj
         h4HfA8ultad98Y+u9oNE8LHRpJeIYAJHojTClJPnT+H1fw6Ow1b2q1ES0VPneHr/GF+X
         RySvc2mpp4tJ8qKgMth4/otEJ947vimYiEFAt498b4G56kVMfOXaFWdOxr+1+DxuQbhn
         Nj4ibhXs8wsWa6n5Q9kjInprDXSP+x1jMVMKAlg+9h72Lw/2DqYEnf+vOGXlEMtcB+cJ
         DjGCfKyIRZUEv5hgCBi6x7gKyBHQjc3hJ+7i8tVq2uELSabm7dMQzXleLAQVTl0jwbUv
         ViZQ==
X-Gm-Message-State: ABy/qLbhK/cCRNAUOKgpHK5N6HtsFzqStDzmgy7dTn1HtwyNBO2E/Xhv
	3jPuxipNf1whV9clQmzS2WpHpg==
X-Google-Smtp-Source: APBJJlHb4gEwJfD+TL2icCrXL1rPSO1/If2sqk52+FC1gSV2ztjdma15fYoDbEqUpP5c7bsoFPcHEw==
X-Received: by 2002:a05:6870:96a6:b0:1b3:8d35:c85f with SMTP id o38-20020a05687096a600b001b38d35c85fmr1011777oaq.1.1689730541592;
        Tue, 18 Jul 2023 18:35:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au. [49.186.119.116])
        by smtp.gmail.com with ESMTPSA id 201-20020a6301d2000000b005633311c70dsm2343100pgb.32.2023.07.18.18.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 18:35:40 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qLw6L-007mcz-1V;
	Wed, 19 Jul 2023 11:35:37 +1000
Date: Wed, 19 Jul 2023 11:35:37 +1000
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v5 6/8] xfs: switch to multigrain timestamps
Message-ID: <ZLc96V2Yo72sthsi@dread.disaster.area>
References: <20230713-mgctime-v5-0-9eb795d2ae37@kernel.org>
 <20230713-mgctime-v5-6-9eb795d2ae37@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713-mgctime-v5-6-9eb795d2ae37@kernel.org>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, linux-f2fs-devel@lists.sourceforge.
 net, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, ecryptfs@vger.kernel.org, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-mtd@lists.infradead.org, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, Ronnie S
 ahlberg <lsahlber@redhat.com>, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jul 13, 2023 at 07:00:55PM -0400, Jeff Layton wrote:
> Enable multigrain timestamps, which should ensure that there is an
> apparent change to the timestamp whenever it has been written after
> being actively observed via getattr.
> 
> Also, anytime the mtime changes, the ctime must also change, and those
> are now the only two options for xfs_trans_ichgtime. Have that function
> unconditionally bump the ctime, and warn if XFS_ICHGTIME_CHG is ever not
> set.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_trans_inode.c | 6 +++---
>  fs/xfs/xfs_iops.c               | 4 ++--
>  fs/xfs/xfs_super.c              | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> index 0c9df8df6d4a..86f5ffce2d89 100644
> --- a/fs/xfs/libxfs/xfs_trans_inode.c
> +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> @@ -62,12 +62,12 @@ xfs_trans_ichgtime(
>  	ASSERT(tp);
>  	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
>  
> -	tv = current_time(inode);
> +	/* If the mtime changes, then ctime must also change */
> +	WARN_ON_ONCE(!(flags & XFS_ICHGTIME_CHG));

Make that an ASSERT(flags & XFS_ICHGTIME_CHG), please. There's no
need to verify this at runtime on production kernels.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
