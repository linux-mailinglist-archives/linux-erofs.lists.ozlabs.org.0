Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 218DB699854
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Feb 2023 16:07:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PHdbF5RkLz3cCn
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Feb 2023 02:07:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BRtSDGXR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a7rYj9i9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BRtSDGXR;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a7rYj9i9;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PHdbB2VzTz3cGH
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Feb 2023 02:07:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676560033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Zm5Dn7i1p/5BiDzjYElohEtJkvunM7mT3Q22YOMQp4=;
	b=BRtSDGXRr6OgpRJ6bYIr26yfVXPEBqRTZc31RYcD2kGiEOt+QvKc+3W/uvXS8KMOgCUsAA
	od3pDTDa+IZS9yqP3+6r+06OStb9tZTNWzp/3n+NmDWspY1dM/w4T84rpL++/ahf+ip5J3
	zoijKIVqiL1i7GfdYe8Q6ma2F1IiWfo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676560034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Zm5Dn7i1p/5BiDzjYElohEtJkvunM7mT3Q22YOMQp4=;
	b=a7rYj9i9xct8sIRKgr6ilFD6C6WmyqX+ShTq08cIBZ/CVAeJl6TZuTNA7NdIssyFk8Y0PQ
	xATJmAd/tv/R7ZmNrwqjT/R+bBSxCrCR2KSRTN+R+NglvpVVpo63qvpghgiqTHOCAeKcPv
	SV9Dxz5Y0p3bNQdgPbX2RLzViHCVToo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-iIVyHqFbOUyMy5heOHW_ZQ-1; Thu, 16 Feb 2023 10:07:09 -0500
X-MC-Unique: iIVyHqFbOUyMy5heOHW_ZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CAE93C14862;
	Thu, 16 Feb 2023 15:07:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E53A4010E85;
	Thu, 16 Feb 2023 15:07:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v6 0/2] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache
Date: Thu, 16 Feb 2023 15:06:59 +0000
Message-Id: <20230216150701.3654894-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-erofs@lists.ozlabs.org, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Willy,

Is this okay by you?  You said you wanted to look at the remaining uses of
page_has_private(), of which there are then three after these patches, not
counting folio_has_private():

	arch/s390/kernel/uv.c:          if (page_has_private(page))
	mm/khugepaged.c:                    1 + page_mapcount(page) + page_has_private(page)) {
	mm/migrate_device.c:            extra += 1 + page_has_private(page);

--
I've split the folio_has_private()/filemap_release_folio() call pair
merging into its own patch, separate from the actual bugfix and pulled out
the folio_needs_release() function into mm/internal.h and made
filemap_release_folio() use it.  I've also got rid of the bit clearances
from the network filesystem evict_inode functions as they doesn't seem to
be necessary.

Note that the last vestiges of try_to_release_page() got swept away, so I
rebased and dealt with that.  One comment remained, which is removed by the
first patch.

David

Changes:
========
ver #6)
 - Drop the third patch which removes a duplicate check in vmscan().

ver #5)
 - Rebased on linus/master.  try_to_release_page() has now been entirely
   replaced by filemap_release_folio(), barring one comment.
 - Cleaned up some pairs in ext4.

ver #4)
 - Split has_private/release call pairs into own patch.
 - Moved folio_needs_release() to mm/internal.h and removed open-coded
   version from filemap_release_folio().
 - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
 - Added experimental patch to reduce shrink_folio_list().

ver #3)
 - Fixed mapping_clear_release_always() to use clear_bit() not set_bit().
 - Moved a '&&' to the correct line.

ver #2)
 - Rewrote entirely according to Willy's suggestion[1].

Link: https://lore.kernel.org/r/Yk9V/03wgdYi65Lb@casper.infradead.org/ [1]
Link: https://lore.kernel.org/r/164928630577.457102.8519251179327601178.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/166844174069.1124521.10890506360974169994.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/166869495238.3720468.4878151409085146764.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/1459152.1669208550@warthog.procyon.org.uk/ # v3 also
Link: https://lore.kernel.org/r/166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/167172131368.2334525.8569808925687731937.stgit@warthog.procyon.org.uk/ # v5
---
%(shortlog)s
%(diffstat)s

David Howells (2):
  mm: Merge folio_has_private()/filemap_release_folio() call pairs
  mm, netfs, fscache: Stop read optimisation when folio removed from
    pagecache

 fs/9p/cache.c           |  2 ++
 fs/afs/internal.h       |  2 ++
 fs/cachefiles/namei.c   |  2 ++
 fs/ceph/cache.c         |  2 ++
 fs/cifs/fscache.c       |  2 ++
 fs/ext4/move_extent.c   | 12 ++++--------
 fs/splice.c             |  3 +--
 include/linux/pagemap.h | 16 ++++++++++++++++
 mm/filemap.c            |  2 ++
 mm/huge_memory.c        |  3 +--
 mm/internal.h           | 11 +++++++++++
 mm/khugepaged.c         |  3 +--
 mm/memory-failure.c     |  8 +++-----
 mm/migrate.c            |  3 +--
 mm/truncate.c           |  6 ++----
 mm/vmscan.c             |  8 ++++----
 16 files changed, 56 insertions(+), 29 deletions(-)

