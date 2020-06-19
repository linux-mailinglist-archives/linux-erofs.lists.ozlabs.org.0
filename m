Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C117200564
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2020 11:39:45 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49pDKp4vGlzDrP3
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2020 19:39:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.120;
 helo=us-smtp-1.mimecast.com; envelope-from=agruenba@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=A+rmE91/; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mge/SA+x; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49pDKj0LNpzDrNW
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2020 19:39:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592559571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=owa0qFAPsKpu74jXgvEbAGd5tDvX5jYwWR6WKxTC83E=;
 b=A+rmE91/XWvIGwVPztfC2xSH+Ljqj2gdGCPvurUNuIf1FSfXAj4KCIXJ3Ee1JtDTM09IUC
 mTTq43RoAbxwk1/NtUXhCqWUFJLaVGEO6xNd5bKuXG3UYEmqoCJbnn1CIwNfJEMAC2HfSC
 EfbCDG8uiuULWZHi/visat4U2UOSSlM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592559572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=owa0qFAPsKpu74jXgvEbAGd5tDvX5jYwWR6WKxTC83E=;
 b=Mge/SA+x8UMo7p4rN8N02BoR5Iwx8EZOsWwN3yPp+TDis79S5eUzV+o2gXweticWg3S8CB
 iogAZ3cuDX/JALcPMYcs8LRMnxHW7Q+vN+OW/CG0xDWl/Yar/zKY1KFTvjmBpED26NtY1I
 198TH8sshfFMGHsadnEQm25fwSkvBUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-E2DQ6Q59N3WWMbSJVCOn4A-1; Fri, 19 Jun 2020 05:39:29 -0400
X-MC-Unique: E2DQ6Q59N3WWMbSJVCOn4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE7B8107B265;
 Fri, 19 Jun 2020 09:39:26 +0000 (UTC)
Received: from max.home.com (unknown [10.40.195.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E9A15D9E8;
 Fri, 19 Jun 2020 09:39:18 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH 0/2] gfs2 readahead regression in v5.8-rc1
Date: Fri, 19 Jun 2020 11:39:14 +0200
Message-Id: <20200619093916.1081129-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, Junxiao Bi <junxiao.bi@oracle.com>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-erofs@lists.ozlabs.org,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello,

can the two patches in this set still be considered for v5.8?

Commit d4388340ae0b ("fs: convert mpage_readpages to mpage_readahead")
which converts gfs2 and other filesystems to use the new ->readahead
address space operation is leading to deadlocks between the inode glocks
and page locks: ->readahead is called with the pages to readahead
already locked.  When gfs2_readahead then tries to lock the associated
inode glock, another process already holding the inode glock may be
trying to lock the same pages.

We could work around this in gfs by using a LM_FLAG_TRY lock in
->readahead for now.  The real reason for this deadlock is that gfs2
shouldn't be taking the inode glock in ->readahead in the first place
though, so I'd prefer to fix this "properly" instead.  Unfortunately,
this depends on a new IOCB_CACHED flag for generic_file_read_iter.

A previous version was posted in November:

https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruenba@redhat.com/

Thanks,
Andreas

Andreas Gruenbacher (2):
  fs: Add IOCB_CACHED flag for generic_file_read_iter
  gfs2: Rework read and page fault locking

 fs/gfs2/aops.c     | 27 ++------------------
 fs/gfs2/file.c     | 61 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h |  1 +
 mm/filemap.c       | 16 ++++++++++--
 4 files changed, 76 insertions(+), 29 deletions(-)


base-commit: af42d3466bdc8f39806b26f593604fdc54140bcb
-- 
2.26.2

