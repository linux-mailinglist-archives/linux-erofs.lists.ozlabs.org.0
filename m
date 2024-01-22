Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01075836360
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 13:39:04 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RKgKdcHr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RKgKdcHr;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJVC95hyKz3br3
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 23:39:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RKgKdcHr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RKgKdcHr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJVC724jjz2ygX
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jan 2024 23:38:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705927135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ca8cxTevNKQzpblzOoDFxpwIIAtXLPpPEjrN9AhhcL4=;
	b=RKgKdcHrFyu019r76hlVwfa3nS8Efh+Iu9Hno3MYGhbCAAA5llbSV9qIJ/Z+pjH9vDAVkf
	vgjFAz8xYHwMs8fqoGPwqzVbtxjrPBUUYjsSqGQqGHMyV1gq5jPw7LPr3MqcB7aH670rqA
	jjfwobX9tc4HmBsolSaf28kjsAt5gXs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705927135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ca8cxTevNKQzpblzOoDFxpwIIAtXLPpPEjrN9AhhcL4=;
	b=RKgKdcHrFyu019r76hlVwfa3nS8Efh+Iu9Hno3MYGhbCAAA5llbSV9qIJ/Z+pjH9vDAVkf
	vgjFAz8xYHwMs8fqoGPwqzVbtxjrPBUUYjsSqGQqGHMyV1gq5jPw7LPr3MqcB7aH670rqA
	jjfwobX9tc4HmBsolSaf28kjsAt5gXs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-RK-uI1WhPqCXplc0tNwNjw-1; Mon, 22 Jan 2024 07:38:52 -0500
X-MC-Unique: RK-uI1WhPqCXplc0tNwNjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 555BC85A58A;
	Mon, 22 Jan 2024 12:38:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8060F111E408;
	Mon, 22 Jan 2024 12:38:49 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 00/10] netfs, afs, cifs, cachefiles, erofs: Miscellaneous fixes
Date: Mon, 22 Jan 2024 12:38:33 +0000
Message-ID: <20240122123845.3822570-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

Dan Carpenter (2):
  netfs, fscache: Prevent Oops in fscache_put_cache()
  netfs: Fix a NULL vs IS_ERR() check in netfs_perform_write()

David Howells (8):
  netfs: Don't use certain internal folio_*() functions
  afs: Don't use certain internal folio_*() functions
  cifs: Don't use certain internal folio_*() functions
  cachefiles, erofs: Fix NULL deref in when cachefiles is not doing
    ondemand-mode
  afs: Hide silly-rename files from userspace
  afs: Fix error handling with lookup via FS.InlineBulkStatus
  afs: Remove afs_dynroot_d_revalidate() as it is redundant
  afs: Fix missing/incorrect unlocking of RCU read lock

 fs/afs/dir.c               | 30 ++++++++++++++++++++++--------
 fs/afs/dynroot.c           |  9 ---------
 fs/afs/proc.c              |  5 +++--
 fs/cachefiles/namei.c      | 16 ++++++++++------
 fs/netfs/buffered_read.c   | 12 ++++++------
 fs/netfs/buffered_write.c  | 15 ++++++++-------
 fs/netfs/fscache_cache.c   |  3 ++-
 fs/netfs/io.c              |  2 +-
 fs/netfs/misc.c            |  2 +-
 fs/smb/client/file.c       | 10 +++++-----
 include/trace/events/afs.h | 25 +++++++++++++++++++++++++
 11 files changed, 83 insertions(+), 46 deletions(-)

