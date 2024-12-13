Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0493F9F0DB0
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 14:50:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8rMP4CdBz3bW5
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 00:50:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734097839;
	cv=none; b=a6GjxIS7UZO+1l3qJcUOsnqi+d4LIcWlZeEME+hVugb0FYMDgmTTdWoxOhQaFwNkR+vHSOwtFA8zVwFB25HBha3AnDHTyv9BBP+/V70BOx79MJz6NcNm132N+GaiNJMv2Vt3Vf6cEA0No+oI7d8NhaKFEXgPyPuWLa4/afUxO3y6Un+udYu3RylmZXUgr16AhX2LnVmBxjwfDweZnX1vK6Ec8kbvtES4X7YU/nGuoakfowzMARhjJqkikIq0FTlTaJJQu6bgAdtblfO63VoIdze1EZG4MTk9TuCCW4NmaclWWCzpyEYhF48Fdti6FRvtsKt7WCtEuUu8Ci5h79/W3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734097839; c=relaxed/relaxed;
	bh=zlbVdG3EuDS4xv5qOG5kSQTp/vih38GtqzMbAmIdEqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XjOprSER3fhdFY1PFDTT1WGPWiAHlGPDf/ZyMux1/575VUAGd4gQeIct+AwKjAzQORpadfWzOQoQK56g9q6lAlbqWQcwKBMXRdpM7uV4rRfESaw/pdUnLobapavz2PGLI2YlRXm0W/WxPLLF2oRGHGOig85fWEW1BKGYxwqRvlIdudl5hoqljelMW4NDee2FGdohElInb5qnZB/6WLVbd/CTeIfjSqYfYOExp98RAVT/2OnJWlltIsn5aLJDKQAJ+jASUi4rfTaLi1/tQRvydeSHC1ykmqYfouLy76CiijDmf+2rpf8Ja3GenTKKWH+8wK8Je8GgZGgo2dM+gagsWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AuhBKtGR; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K8syPZoM; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AuhBKtGR;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K8syPZoM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8rMK2SX2z3bTJ
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Dec 2024 00:50:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zlbVdG3EuDS4xv5qOG5kSQTp/vih38GtqzMbAmIdEqA=;
	b=AuhBKtGRx8vXJJtAKxnyC927Q8QGh+0ofbaF6Epkd8t1h+944nggTsIPSiRxYr/O9fOk1Q
	bTqovgXKEkzP3boom6J3cOYwiL1JvIc74B42xxDhDGh+8yXzxckFJXLSUzTXma3u4k1BXN
	aQr3Gx+8njVJCjB5XiLmfNYOZ13lEEw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zlbVdG3EuDS4xv5qOG5kSQTp/vih38GtqzMbAmIdEqA=;
	b=K8syPZoM0m/GSylGswnzAI+vWx/dj9V1MxKfTlA5/ZOlA/LNLvhY1GuHfNm0wsTGYOtfhR
	Q2lxtEIzv2s15oAWoGNGZ4b/MJBtBtWsTAzqpzjogg81oNlNAQ0gBaGimOIDjaqWXZyoI+
	MZ7C4Im/WotL7awiJy9Ymoxcs1QSByw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-woItBugOMb6D8BiRItruoA-1; Fri,
 13 Dec 2024 08:50:26 -0500
X-MC-Unique: woItBugOMb6D8BiRItruoA-1
X-Mimecast-MFC-AGG-ID: woItBugOMb6D8BiRItruoA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23A451955D4B;
	Fri, 13 Dec 2024 13:50:22 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8520330044C1;
	Fri, 13 Dec 2024 13:50:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 00/10] netfs, ceph, nfs, cachefiles: Miscellaneous fixes/changes
Date: Fri, 13 Dec 2024 13:50:00 +0000
Message-ID: <20241213135013.2964079-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian,

Here are some miscellaneous fixes and changes for netfslib and the ceph and
nfs filesystems:

 (1) Ignore silly-rename files from afs and nfs when building the header
     archive in a kernel build.

 (2) netfs: Fix the way read result collection applies results to folios
     when each folio is being read by multiple subrequests and the results
     come out of order.

 (3) netfs: Fix ENOMEM handling in buffered reads.

 (4) nfs: Fix an oops in nfs_netfs_init_request() when copying to the cache.

 (5) cachefiles: Parse the "secctx" command immediately to get the correct
     error rather than leaving it to the "bind" command.

 (6) netfs: Remove a redundant smp_rmb().  This isn't a bug per se and
     could be deferred.

 (7) netfs: Fix missing barriers by using clear_and_wake_up_bit().

 (8) netfs: Work around recursion in read retry by failing and abandoning
     the retried subrequest if no I/O is performed.

     [!] NOTE: This only works around the recursion problem if the
     	 recursion keeps returning no data.  If the server manages, say, to
     	 repeatedly return a single byte of data faster than the retry
     	 algorithm can complete, it will still recurse and the stack
     	 overrun may still occur.  Actually fixing this requires quite an
     	 intrusive change which will hopefully make the next merge window.

 (9) netfs: Fix the clearance of a folio_queue when unlocking the page if
     we're going to want to subsequently send the queue for copying to the
     cache (if, for example, we're using ceph).

(10) netfs: Fix the lack of cancellation of copy-to-cache when the cache
     for a file is temporarily disabled (for example when a DIO write is
     done to the file).  This patch and (9) fix hangs with ceph.

With these patches, I can run xfstest -g quick to completion on ceph with a
local cache.

The patches can also be found here with a bonus cifs patch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (8):
  kheaders: Ignore silly-rename files
  netfs: Fix non-contiguous donation between completed reads
  netfs: Fix enomem handling in buffered reads
  nfs: Fix oops in nfs_netfs_init_request() when copying to cache
  netfs: Fix missing barriers by using clear_and_wake_up_bit()
  netfs: Work around recursion by abandoning retry if nothing read
  netfs: Fix ceph copy to cache on write-begin
  netfs: Fix the (non-)cancellation of copy when cache is temporarily
    disabled

Max Kellermann (1):
  cachefiles: Parse the "secctx" immediately

Zilin Guan (1):
  netfs: Remove redundant use of smp_rmb()

 fs/9p/vfs_addr.c         |  6 +++++-
 fs/afs/write.c           |  5 ++++-
 fs/cachefiles/daemon.c   | 14 +++++++-------
 fs/cachefiles/internal.h |  3 ++-
 fs/cachefiles/security.c |  6 +++---
 fs/netfs/buffered_read.c | 28 ++++++++++++++++------------
 fs/netfs/direct_write.c  |  1 -
 fs/netfs/read_collect.c  | 33 +++++++++++++++++++--------------
 fs/netfs/read_pgpriv2.c  |  4 ++++
 fs/netfs/read_retry.c    |  6 ++++--
 fs/netfs/write_collect.c | 14 +++++---------
 fs/netfs/write_issue.c   |  2 ++
 fs/nfs/fscache.c         |  9 ++++++++-
 fs/smb/client/cifssmb.c  | 13 +++++++++----
 fs/smb/client/smb2pdu.c  |  9 ++++++---
 include/linux/netfs.h    |  6 +++---
 kernel/gen_kheaders.sh   |  1 +
 17 files changed, 98 insertions(+), 62 deletions(-)

