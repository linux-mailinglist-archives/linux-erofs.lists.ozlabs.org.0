Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 11120546DBC
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Jun 2022 21:57:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKWvY3g9wz3c8k
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 05:57:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D9if958G;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D9if958G;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D9if958G;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D9if958G;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKWvN2w2tz3btb
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 05:57:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654891014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=irp9I7bg5aP2EcRerJx9k5cqapFEVHVDaAOauS4ZbRQ=;
	b=D9if958GWPyjFB1vd456EiDHu9kqHu9ZoaghN/VsptJlkT+h9Txfpk0ij9Ow+7EaC2MYd+
	wepQKcW66fuEjlVfi+INuthIS6PRpw8STEnRA1W3hkFKKPe8p4wQTCCVB5ID8oeIQ1QHNz
	+JWn68ZatbN4q4XVf29ZWOYQS8m7ltY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654891014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=irp9I7bg5aP2EcRerJx9k5cqapFEVHVDaAOauS4ZbRQ=;
	b=D9if958GWPyjFB1vd456EiDHu9kqHu9ZoaghN/VsptJlkT+h9Txfpk0ij9Ow+7EaC2MYd+
	wepQKcW66fuEjlVfi+INuthIS6PRpw8STEnRA1W3hkFKKPe8p4wQTCCVB5ID8oeIQ1QHNz
	+JWn68ZatbN4q4XVf29ZWOYQS8m7ltY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121----5JlC7Nga4prmah_EWXw-1; Fri, 10 Jun 2022 15:56:49 -0400
X-MC-Unique: ---5JlC7Nga4prmah_EWXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B090801756;
	Fri, 10 Jun 2022 19:56:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B1B6F40CF8EF;
	Fri, 10 Jun 2022 19:56:46 +0000 (UTC)
Subject: [RFC][PATCH 0/3] netfs, afs: Cleanups
From: David Howells <dhowells@redhat.com>
Date: Fri, 10 Jun 2022 20:56:45 +0100
Message-ID:  <165489100590.703883.11054313979289027590.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


Hi Linus,

Here are some cleanups, one for afs and a couple for netfs:

 (1) The afs patch cleans up a checker complaint.

 (2) The first netfs patch is your netfs_inode changes plus the requisite
     documentation changes.

 (3) The second netfs patch replaces the ->cleanup op with a ->free_request
     op.  This is possible as the I/O request is now always available at
     the cleanup point as the stuff to be cleaned up is no longer passed
     into the API functions, but rather obtained by ->init_request.

I've run the patches through xfstests with -g quick on afs.

The patches are on a branch here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-fixes

David

---
David Howells (2):
      afs: Fix some checker issues
      netfs: Rename the netfs_io_request cleanup op and give it an op pointer

Linus Torvalds (1):
      netfs: Further cleanups after struct netfs_inode wrapper introduced


 Documentation/filesystems/netfs_library.rst | 33 +++++++++++----------
 fs/9p/v9fs.h                                |  2 +-
 fs/9p/vfs_addr.c                            | 13 ++++----
 fs/9p/vfs_inode.c                           |  3 +-
 fs/afs/dynroot.c                            |  2 +-
 fs/afs/file.c                               |  6 ++--
 fs/afs/inode.c                              |  2 +-
 fs/afs/internal.h                           |  2 +-
 fs/afs/volume.c                             |  3 +-
 fs/afs/write.c                              |  2 +-
 fs/ceph/addr.c                              | 12 ++++----
 fs/ceph/cache.h                             |  2 +-
 fs/ceph/inode.c                             |  2 +-
 fs/cifs/fscache.h                           |  2 +-
 fs/netfs/buffered_read.c                    |  5 ++--
 fs/netfs/objects.c                          |  6 ++--
 include/linux/netfs.h                       | 25 +++++++---------
 17 files changed, 60 insertions(+), 62 deletions(-)


