Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E28E740F2F
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 12:49:11 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WYn/AnRw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WYn/AnRw;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QrdcP2NB6z30Nt
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 20:49:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WYn/AnRw;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WYn/AnRw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QrdcK3NT2z305R
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jun 2023 20:49:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687949341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+QydiwIjN9aTPx/xjudDhfoGuS6UX8G9SMmj+YNOpRA=;
	b=WYn/AnRwPgELAz6A5BSOTcRS951r/Gjx3TtjzKBK6fTFzgQZTpzkK3O0I58sUIIvmbXdtb
	ZdRfAlRNIui8SWmBVk+hibAvOTW04v/LBARNHgz8ZYQx95ppKFDwU6E38qZEcAZtrZ8UrV
	MNE+YfkttTEb875En4E/4dhD20MmXhg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687949341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+QydiwIjN9aTPx/xjudDhfoGuS6UX8G9SMmj+YNOpRA=;
	b=WYn/AnRwPgELAz6A5BSOTcRS951r/Gjx3TtjzKBK6fTFzgQZTpzkK3O0I58sUIIvmbXdtb
	ZdRfAlRNIui8SWmBVk+hibAvOTW04v/LBARNHgz8ZYQx95ppKFDwU6E38qZEcAZtrZ8UrV
	MNE+YfkttTEb875En4E/4dhD20MmXhg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-vLNGNocHNsqPW492eEhOXw-1; Wed, 28 Jun 2023 06:48:57 -0400
X-MC-Unique: vLNGNocHNsqPW492eEhOXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C298E3810D42;
	Wed, 28 Jun 2023 10:48:56 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 25EC6200B677;
	Wed, 28 Jun 2023 10:48:55 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 0/2] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache
Date: Wed, 28 Jun 2023 11:48:50 +0100
Message-ID: <20230628104852.3391651-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-erofs@lists.ozlabs.org, Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Andrew,

Should this go through the mm tree?

This fixes an optimisation in fscache whereby we don't read from the cache
for a particular file until we know that there's data there that we don't
have in the pagecache.  The problem is that I'm no longer using PG_fscache
(aka PG_private_2) to indicate that the page is cached and so I don't get a
notification when a cached page is dropped from the pagecache.

The first patch merges some folio_has_private() and filemap_release_folio()
pairs and introduces a helper, folio_needs_release(), to indicate if a
release is required.

The second patch is the actual fix.  Following Willy's suggestions[1], it
adds an AS_RELEASE_ALWAYS flag to an address_space that will make
filemap_release_folio() always call ->release_folio(), even if
PG_private/PG_private_2 aren't set.  folio_needs_release() is altered to
add a check for this.

David

Changes:
========
ver #7)
 - Make NFS set AS_RELEASE_ALWAYS.

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
Link: https://lore.kernel.org/r/20230216150701.3654894-1-dhowells@redhat.com/ # v6

David Howells (2):
  mm: Merge folio_has_private()/filemap_release_folio() call pairs
  mm, netfs, fscache: Stop read optimisation when folio removed from
    pagecache

 fs/9p/cache.c           |  2 ++
 fs/afs/internal.h       |  2 ++
 fs/cachefiles/namei.c   |  2 ++
 fs/ceph/cache.c         |  2 ++
 fs/ext4/move_extent.c   | 12 ++++--------
 fs/nfs/fscache.c        |  3 +++
 fs/smb/client/fscache.c |  2 ++
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
 17 files changed, 59 insertions(+), 29 deletions(-)

