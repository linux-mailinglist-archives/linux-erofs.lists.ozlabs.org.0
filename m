Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 886998284B2
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 12:21:01 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xnl6G9gD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xnl6G9gD;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T8T535BX8z30gn
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 22:20:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xnl6G9gD;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xnl6G9gD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T8T4v3gMyz307K
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jan 2024 22:20:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704799243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q1rVQCIFdSKutS/VkuEkTryFHcPbkDTWRo3T0LrhEQg=;
	b=Xnl6G9gDwqI1x7XRutQrHuKn6YfoCC1S5xW9g1BGYSlaOKpOCCkJaXD9NOPCPXPE4eB7hi
	86XnHIwLMLB+BNuMm+CQTvWB3X0EkUfecn3BNC9GIwf4YlexfVNmz6ohneH39nxoWR+m5r
	G6k+aNMH0XD0Z+v/UHdUf7fVO/QbV2I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704799243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q1rVQCIFdSKutS/VkuEkTryFHcPbkDTWRo3T0LrhEQg=;
	b=Xnl6G9gDwqI1x7XRutQrHuKn6YfoCC1S5xW9g1BGYSlaOKpOCCkJaXD9NOPCPXPE4eB7hi
	86XnHIwLMLB+BNuMm+CQTvWB3X0EkUfecn3BNC9GIwf4YlexfVNmz6ohneH39nxoWR+m5r
	G6k+aNMH0XD0Z+v/UHdUf7fVO/QbV2I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-nW2fwlmkMRCP2_d0nfEeHQ-1; Tue, 09 Jan 2024 06:20:39 -0500
X-MC-Unique: nW2fwlmkMRCP2_d0nfEeHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF8F085A588;
	Tue,  9 Jan 2024 11:20:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C6A5A51E3;
	Tue,  9 Jan 2024 11:20:35 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 0/6] netfs, cachefiles: More additional patches
Date: Tue,  9 Jan 2024 11:20:17 +0000
Message-ID: <20240109112029.1572463-1-dhowells@redhat.com>
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian, Jeff, Gao,

Here are some additional patches for my netfs-lib tree:

 (1) Mark netfs_unbuffered_write_iter_locked() static as it's only used in
     the file in which it is defined.

 (2) Display a counter for DIO writes in /proc/fs/netfs/stats.

 (3) Fix the interaction between write-streaming (dirty data in
     non-uptodate pages) and the culling of a cache file trying to write
     that to the cache.

 (4) Fix the loop that unmarks folios after writing to the cache.  The
     xarray iterator only advances the index by 1, so if we unmarked a
     multipage folio and that got split before we advance to the next
     folio, we see a repeat of a fragment of the folio.

 (5) Fix a mixup with signed/unsigned offsets when prepping for writing to
     the cache that leads to missing error detection.

 (6) Fix a wrong ifdef hiding a wait.

David

The netfslib postings:
Link: https://lore.kernel.org/r/20231013160423.2218093-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20231117211544.1740466-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20231207212206.1379128-1-dhowells@redhat.com/ # v3
Link: https://lore.kernel.org/r/20231213152350.431591-1-dhowells@redhat.com/ # v4
Link: https://lore.kernel.org/r/20231221132400.1601991-1-dhowells@redhat.com/ # v5
Link: https://lore.kernel.org/r/20240103145935.384404-1-dhowells@redhat.com/ # added patches

David Howells (6):
  netfs: Mark netfs_unbuffered_write_iter_locked() static
  netfs: Count DIO writes
  netfs: Fix interaction between write-streaming and cachefiles culling
  netfs: Fix the loop that unmarks folios after writing to the cache
  cachefiles: Fix signed/unsigned mixup
  netfs: Fix wrong #ifdef hiding wait

 fs/cachefiles/io.c            | 18 +++++++++---------
 fs/netfs/buffered_write.c     | 27 ++++++++++++++++++++++-----
 fs/netfs/direct_write.c       |  5 +++--
 fs/netfs/fscache_stats.c      |  9 ++++++---
 fs/netfs/internal.h           |  8 ++------
 fs/netfs/io.c                 |  2 +-
 fs/netfs/stats.c              | 13 +++++++++----
 include/linux/fscache-cache.h |  3 +++
 include/linux/netfs.h         |  1 +
 9 files changed, 56 insertions(+), 30 deletions(-)

