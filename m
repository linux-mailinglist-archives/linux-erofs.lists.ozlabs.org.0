Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E604FFA56
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Apr 2022 17:35:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kdmr343yJz2ypZ
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Apr 2022 01:35:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PVPqatHF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PVPqatHF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=PVPqatHF; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PVPqatHF; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kdmqz5Lfvz2yLg
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Apr 2022 01:35:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649864104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sk1v32UTIyZH37LdAUzNEF5obtPm583SsWSiAI9jtSE=;
 b=PVPqatHF3EO/5sZ9UHKmI0Lh28J2LKI9qS+t9zB33oYywz1Exd4TeclCe9cDAfLPRbpyRD
 a+NMGsT8HmFaGw5cEV6BKqct3vlDrRX4TLPOh1Dy5hrwBgSs2OcEJHAmv8GgI3iQqL+kxE
 9uwooZf532fnfuPdkzL35YsNBD2hVwU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649864104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sk1v32UTIyZH37LdAUzNEF5obtPm583SsWSiAI9jtSE=;
 b=PVPqatHF3EO/5sZ9UHKmI0Lh28J2LKI9qS+t9zB33oYywz1Exd4TeclCe9cDAfLPRbpyRD
 a+NMGsT8HmFaGw5cEV6BKqct3vlDrRX4TLPOh1Dy5hrwBgSs2OcEJHAmv8GgI3iQqL+kxE
 9uwooZf532fnfuPdkzL35YsNBD2hVwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-LhXBCQdeMm2JQunRUBAsEg-1; Wed, 13 Apr 2022 11:35:00 -0400
X-MC-Unique: LhXBCQdeMm2JQunRUBAsEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5040585A5BC;
 Wed, 13 Apr 2022 15:35:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8ED7AC27E9D;
 Wed, 13 Apr 2022 15:34:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] fscache: Miscellaneous fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2266867.1649864097.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Apr 2022 16:34:57 +0100
Message-ID: <2266868.1649864097@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
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
Cc: linux-cachefs@redhat.com, Dave Wysochanski <dwysocha@redhat.com>,
 Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
 Yue Hu <huyue2@coolpad.com>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Here's a collection of fscache and cachefiles fixes and misc small
cleanups.  The two main fixes are:

 (1) Add a missing unmark of the inode in-use mark in an error path.

 (2) Fix a KASAN slab-out-of-bounds error when setting the xattr on a
     cachefiles volume due to the wrong length being given to memcpy().

In addition, there's the removal of an unused parameter, removal of an
unused Kconfig option, conditionalising a bit of procfs-related stuff and
some doc fixes.

David

Link: https://lore.kernel.org/r/164945915630.773423.14655306154231712324.s=
tgit@warthog.procyon.org.uk/

---
The following changes since commit 42e7a03d3badebd4e70aea5362d6914dfc7c220=
b:

  Merge tag 'hyperv-fixes-signed-20220407' of git://git.kernel.org/pub/scm=
/linux/kernel/git/hyperv/linux (2022-04-07 06:35:34 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fscache-fixes-20220413

for you to fetch changes up to 61132ceeda723d2c48cbc2610ca3213a7fcb083b:

  fscache: remove FSCACHE_OLD_API Kconfig option (2022-04-08 23:54:37 +010=
0)

----------------------------------------------------------------
fscache fixes

----------------------------------------------------------------
Dave Wysochanski (1):
      cachefiles: Fix KASAN slab-out-of-bounds in cachefiles_set_volume_xa=
ttr

Jeffle Xu (1):
      cachefiles: unmark inode in use in error path

Yue Hu (6):
      docs: filesystems: caching/backend-api.rst: correct two relinquish A=
PIs use
      docs: filesystems: caching/backend-api.rst: fix an object withdrawn =
API
      fscache: Remove the cookie parameter from fscache_clear_page_bits()
      fscache: Move fscache_cookies_seq_ops specific code under CONFIG_PRO=
C_FS
      fscache: Use wrapper fscache_set_cache_state() directly when relinqu=
ishing
      fscache: remove FSCACHE_OLD_API Kconfig option

 Documentation/filesystems/caching/backend-api.rst |  8 +++---
 Documentation/filesystems/caching/netfs-api.rst   | 25 +++++++++--------
 fs/afs/write.c                                    |  3 +--
 fs/cachefiles/namei.c                             | 33 ++++++++++++++++--=
-----
 fs/cachefiles/xattr.c                             |  2 +-
 fs/fscache/Kconfig                                |  3 ---
 fs/fscache/cache.c                                |  2 +-
 fs/fscache/cookie.c                               |  4 ++-
 fs/fscache/internal.h                             |  4 +++
 fs/fscache/io.c                                   |  5 ++--
 include/linux/fscache.h                           |  4 +--
 11 files changed, 53 insertions(+), 40 deletions(-)

