Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C07DC83761E
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 23:32:47 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eKU3HnG/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eKU3HnG/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJlNF4lGvz3bnL
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jan 2024 09:32:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eKU3HnG/;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eKU3HnG/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJlNB1tMYz2ygX
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jan 2024 09:32:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6rMqtCN9Nns9gicLLQn3euoOj3eY7rsKvUOdFV5pAfA=;
	b=eKU3HnG/G3v6dgfryRu4P2BOhEutBoNu/++OwmyqXzbMrhbrXNyx8TZdxmIcf1Qz+qRGy8
	2kC7ALMtFjdLTguOKr05Dt+FYDnq0ffFU93fwYwuLdO2R/2k9Lz89H7fIK2M8lhixm5/dK
	s+CCt+neT6d6LJZW5VnaRKHmt2KG0/Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6rMqtCN9Nns9gicLLQn3euoOj3eY7rsKvUOdFV5pAfA=;
	b=eKU3HnG/G3v6dgfryRu4P2BOhEutBoNu/++OwmyqXzbMrhbrXNyx8TZdxmIcf1Qz+qRGy8
	2kC7ALMtFjdLTguOKr05Dt+FYDnq0ffFU93fwYwuLdO2R/2k9Lz89H7fIK2M8lhixm5/dK
	s+CCt+neT6d6LJZW5VnaRKHmt2KG0/Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-xVA4GeBNMjm4A_25AiODpA-1; Mon, 22 Jan 2024 17:32:35 -0500
X-MC-Unique: xVA4GeBNMjm4A_25AiODpA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03AE785A589;
	Mon, 22 Jan 2024 22:32:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 48FAB5012;
	Mon, 22 Jan 2024 22:32:32 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 00/10] netfs, afs, cifs, cachefiles, erofs: Miscellaneous fixes
Date: Mon, 22 Jan 2024 22:32:13 +0000
Message-ID: <20240122223230.4000595-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian,

Here are some miscellaneous fixes for netfslib and a number of filesystems:

 (1) Replace folio_index() with folio->index in netfs, afs and cifs.

 (2) Fix an oops in fscache_put_cache().

 (3) Fix error handling in netfs_perform_write().

 (4) Fix an oops in cachefiles when not using erofs ondemand mode.

 (5) In afs, hide silly-rename files from getdents() to avoid problems with
     tar and suchlike.

 (6) In afs, fix error handling in lookup with a bulk status fetch.

 (7) In afs, afs_dynroot_d_revalidate() is redundant, so remove it.

 (8) In afs, fix the RCU unlocking in afs_proc_addr_prefs_show().

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

Changes
=======
ver #2)
 - Update the commit messages of the don't-use-folio_index patches.
 - Move check of object->ondemand into cachefiles_ondemand_init_object().


Link: https://lore.kernel.org/r/20240122123845.3822570-1-dhowells@redhat.com/ # v1

Dan Carpenter (2):
  netfs, fscache: Prevent Oops in fscache_put_cache()
  netfs: Fix a NULL vs IS_ERR() check in netfs_perform_write()

David Howells (8):
  netfs: Don't use certain unnecessary folio_*() functions
  afs: Don't use certain unnecessary folio_*() functions
  cifs: Don't use certain unnecessary folio_*() functions
  cachefiles, erofs: Fix NULL deref in when cachefiles is not doing
    ondemand-mode
  afs: Hide silly-rename files from userspace
  afs: Fix error handling with lookup via FS.InlineBulkStatus
  afs: Remove afs_dynroot_d_revalidate() as it is redundant
  afs: Fix missing/incorrect unlocking of RCU read lock

 fs/afs/dir.c               | 30 ++++++++++++++++++++++--------
 fs/afs/dynroot.c           |  9 ---------
 fs/afs/proc.c              |  5 +++--
 fs/cachefiles/ondemand.c   |  3 +++
 fs/netfs/buffered_read.c   | 12 ++++++------
 fs/netfs/buffered_write.c  | 15 ++++++++-------
 fs/netfs/fscache_cache.c   |  3 ++-
 fs/netfs/io.c              |  2 +-
 fs/netfs/misc.c            |  2 +-
 fs/smb/client/file.c       | 10 +++++-----
 include/trace/events/afs.h | 25 +++++++++++++++++++++++++
 11 files changed, 76 insertions(+), 40 deletions(-)

