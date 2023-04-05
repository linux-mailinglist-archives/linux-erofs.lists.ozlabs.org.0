Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCCB6D83A8
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 18:27:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ps95r3C2Tz3cj8
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 02:27:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IofOlEqA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IofOlEqA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IofOlEqA;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IofOlEqA;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ps95j2GJzz3bj0
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 02:27:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680712053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpkEDS6jt39qufg3GMcbXZKRt5qOSbn/1OJhbiuzI9E=;
	b=IofOlEqACMOcCzuQ8zDo5dyqBOLvXdb0QvuYAKZrtfen6rJemfyHcn0NzhYfrMe90AlLgw
	sCXlDbXL5AfxkB8L5tN7WQZjNBjcTD4zvgK1uGeauIk2xCLMzXyltZzqAigdMU2MFWboC3
	kBA0yYlZD3JoeCQK1YgJw9KbBIxHoOc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680712053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpkEDS6jt39qufg3GMcbXZKRt5qOSbn/1OJhbiuzI9E=;
	b=IofOlEqACMOcCzuQ8zDo5dyqBOLvXdb0QvuYAKZrtfen6rJemfyHcn0NzhYfrMe90AlLgw
	sCXlDbXL5AfxkB8L5tN7WQZjNBjcTD4zvgK1uGeauIk2xCLMzXyltZzqAigdMU2MFWboC3
	kBA0yYlZD3JoeCQK1YgJw9KbBIxHoOc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-HGRhOr_VNvSNoQxRxMNSfA-1; Wed, 05 Apr 2023 12:27:32 -0400
X-MC-Unique: HGRhOr_VNvSNoQxRxMNSfA-1
Received: by mail-qt1-f198.google.com with SMTP id t15-20020a05622a180f00b003e37dd114e3so24656003qtc.10
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Apr 2023 09:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680712051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpkEDS6jt39qufg3GMcbXZKRt5qOSbn/1OJhbiuzI9E=;
        b=DYaPOJaWNmBsmNPC5hcMzapwxuz3jTWe8KRSwArlvbWxFO98CNqpaCGvFwGENos795
         Z35Z6oVRgViNlh6rdJiI6iwS9xzPPbZjZM206OJEX6bOW9fQ/Q/vALYQ8YOmic6icejp
         8C2X1dj/3PVTKKkYNVy01NYMgHHQ7pMBG8OWFSCNQYMMLiUDDcp2SEya9wIbt4T3eOuw
         tOPVdlkgYWaqFEYtoANUFxfcrwXTEZNIWj4SP23eNQC072mrbmNSgATsQ/IhAo/BFkH4
         Z5W7nUqFRqrROySsu+H4V1m5yrYKpFo+5pJT5TAPLYfBNbdaB3DpdWI+6p13v/zwZO16
         g0FA==
X-Gm-Message-State: AAQBX9fYki8XiVhXhlYxVjcqaxp6EgkVgYbBzzUqMtSoJiCBvgckaiFY
	UrDc+bLMISi4YLy8jtPuqFcH/HwWSof7+gfXOHGmXk9JpKBH7vV5OyK9s3hdGjdDnYjcQM4Pl8y
	TsPeVD4no4JMwkvniBXIk1Z4vjwyRy8Wuig==
X-Received: by 2002:a05:6214:1c8d:b0:5bb:eefc:1624 with SMTP id ib13-20020a0562141c8d00b005bbeefc1624mr9853048qvb.27.1680712051485;
        Wed, 05 Apr 2023 09:27:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZZl4q26mcUoNHuCokraSI3hi88peqAYHPpgY7Wvk0Gvn/BxgeqpN4NaYegoUGQwHkcsJ0yow==
X-Received: by 2002:a05:6214:1c8d:b0:5bb:eefc:1624 with SMTP id ib13-20020a0562141c8d00b005bbeefc1624mr9853021qvb.27.1680712051206;
        Wed, 05 Apr 2023 09:27:31 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id r206-20020a3744d7000000b0074a0051fcd4sm4559684qka.88.2023.04.05.09.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:27:30 -0700 (PDT)
Date: Wed, 5 Apr 2023 18:27:26 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <20230405162726.4d7bu3uz63w4cdkz@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404163942.GD109974@frogsfrogsfrogs>
MIME-Version: 1.0
In-Reply-To: <20230404163942.GD109974@frogsfrogsfrogs>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: fsverity@lists.linux.dev, hch@infradead.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Darrick,

On Tue, Apr 04, 2023 at 09:39:42AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 04, 2023 at 04:52:56PM +0200, Andrey Albershteyn wrote:
> > Hi all,
> > 
> > This is V2 of fs-verity support in XFS. In this series I did
> > numerous changes from V1 which are described below.
> > 
> > This patchset introduces fs-verity [5] support for XFS. This
> > implementation utilizes extended attributes to store fs-verity
> > metadata. The Merkle tree blocks are stored in the remote extended
> > attributes.
> > 
> > A few key points:
> > - fs-verity metadata is stored in extended attributes
> > - Direct path and DAX are disabled for inodes with fs-verity
> > - Pages are verified in iomap's read IO path (offloaded to
> >   workqueue)
> > - New workqueue for verification processing
> > - New ro-compat flag
> > - Inodes with fs-verity have new on-disk diflag
> > - xfs_attr_get() can return buffer with the attribute
> > 
> > The patchset is tested with xfstests -g auto on xfs_1k, xfs_4k,
> > xfs_1k_quota, and xfs_4k_quota. Haven't found any major failures.
> > 
> > Patches [6/23] and [7/23] touch ext4, f2fs, btrfs, and patch [8/23]
> > touches erofs, gfs2, and zonefs.
> > 
> > The patchset consist of four parts:
> > - [1..4]: Patches from Parent Pointer patchset which add binary
> >           xattr names with a few deps
> > - [5..7]: Improvements to core fs-verity
> > - [8..9]: Add read path verification to iomap
> > - [10..23]: Integration of fs-verity to xfs
> > 
> > Changes from V1:
> > - Added parent pointer patches for easier testing
> > - Many issues and refactoring points fixed from the V1 review
> > - Adjusted for recent changes in fs-verity core (folios, non-4k)
> > - Dropped disabling of large folios
> > - Completely new fsverity patches (fix, callout, log_blocksize)
> > - Change approach to verification in iomap to the same one as in
> >   write path. Callouts to fs instead of direct fs-verity use.
> > - New XFS workqueue for post read folio verification
> > - xfs_attr_get() can return underlying xfs_buf
> > - xfs_bufs are marked with XBF_VERITY_CHECKED to track verified
> >   blocks
> > 
> > kernel:
> > [1]: https://github.com/alberand/linux/tree/xfs-verity-v2
> > 
> > xfsprogs:
> > [2]: https://github.com/alberand/xfsprogs/tree/fsverity-v2
> 
> Will there any means for xfs_repair to check the merkle tree contents?
> Should it clear the ondisk inode flag if it decides to trash the xattr
> structure, or is it ok to let the kernel deal with flag set and no
> verity data?

The fsverity-util can calculate merkle tree offline, so, it's
possible for xfs_repair to do the same and compare, also it can
check that all merkle tree blocks are there. The flag without tree
is probably bad as all reading ops will fail and it won't be
possible to regenerate the tree (enable also checks for flag).

-- 
- Andrey

