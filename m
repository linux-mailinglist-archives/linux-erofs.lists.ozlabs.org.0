Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F7F93FA76
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2024 18:20:46 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MCA8xd2n;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MCA8xd2n;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WXk9k6t2sz3cds
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jul 2024 02:20:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MCA8xd2n;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MCA8xd2n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WXk9Y1NQ1z3cW3
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jul 2024 02:20:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPjOG63ucqIecfQUcEvOk2uVbkRV7p0tyL6NVisM1C4=;
	b=MCA8xd2nhBo/pB1lmaxFN5ng1AlXwf0mJpF0+PiVeNUxo1lxFmL6VvIABDqF5BSrSeX5UE
	yzNWcofD/qjcKOPbs2A12f/T0+eJOR0+i0NkiVW3et+4eZZyytAZfZPV+qG2Fu1OxmcYOL
	wbDsnlKdA79apO1/MbqIUN848nAnhQI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPjOG63ucqIecfQUcEvOk2uVbkRV7p0tyL6NVisM1C4=;
	b=MCA8xd2nhBo/pB1lmaxFN5ng1AlXwf0mJpF0+PiVeNUxo1lxFmL6VvIABDqF5BSrSeX5UE
	yzNWcofD/qjcKOPbs2A12f/T0+eJOR0+i0NkiVW3et+4eZZyytAZfZPV+qG2Fu1OxmcYOL
	wbDsnlKdA79apO1/MbqIUN848nAnhQI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-pbazTEYXMY-3m3K78NsRKg-1; Mon,
 29 Jul 2024 12:20:26 -0400
X-MC-Unique: pbazTEYXMY-3m3K78NsRKg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 407551955D4C;
	Mon, 29 Jul 2024 16:20:22 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A2B5195605F;
	Mon, 29 Jul 2024 16:20:14 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 01/24] fs/netfs/fscache_cookie: add missing "n_accesses" check
Date: Mon, 29 Jul 2024 17:19:30 +0100
Message-ID: <20240729162002.3436763-2-dhowells@redhat.com>
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Max Kellermann <max.kellermann@ionos.com>

This fixes a NULL pointer dereference bug due to a data race which
looks like this:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP PTI
  CPU: 33 PID: 16573 Comm: kworker/u97:799 Not tainted 6.8.7-cm4all1-hp+ #43
  Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/17/2018
  Workqueue: events_unbound netfs_rreq_write_to_cache_work
  RIP: 0010:cachefiles_prepare_write+0x30/0xa0
  Code: 57 41 56 45 89 ce 41 55 49 89 cd 41 54 49 89 d4 55 53 48 89 fb 48 83 ec 08 48 8b 47 08 48 83 7f 10 00 48 89 34 24 48 8b 68 20 <48> 8b 45 08 4c 8b 38 74 45 49 8b 7f 50 e8 4e a9 b0 ff 48 8b 73 10
  RSP: 0018:ffffb4e78113bde0 EFLAGS: 00010286
  RAX: ffff976126be6d10 RBX: ffff97615cdb8438 RCX: 0000000000020000
  RDX: ffff97605e6c4c68 RSI: ffff97605e6c4c60 RDI: ffff97615cdb8438
  RBP: 0000000000000000 R08: 0000000000278333 R09: 0000000000000001
  R10: ffff97605e6c4600 R11: 0000000000000001 R12: ffff97605e6c4c68
  R13: 0000000000020000 R14: 0000000000000001 R15: ffff976064fe2c00
  FS:  0000000000000000(0000) GS:ffff9776dfd40000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000008 CR3: 000000005942c002 CR4: 00000000001706f0
  Call Trace:
   <TASK>
   ? __die+0x1f/0x70
   ? page_fault_oops+0x15d/0x440
   ? search_module_extables+0xe/0x40
   ? fixup_exception+0x22/0x2f0
   ? exc_page_fault+0x5f/0x100
   ? asm_exc_page_fault+0x22/0x30
   ? cachefiles_prepare_write+0x30/0xa0
   netfs_rreq_write_to_cache_work+0x135/0x2e0
   process_one_work+0x137/0x2c0
   worker_thread+0x2e9/0x400
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xcc/0x100
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x30/0x50
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1b/0x30
   </TASK>
  Modules linked in:
  CR2: 0000000000000008
  ---[ end trace 0000000000000000 ]---

This happened because fscache_cookie_state_machine() was slow and was
still running while another process invoked fscache_unuse_cookie();
this led to a fscache_cookie_lru_do_one() call, setting the
FSCACHE_COOKIE_DO_LRU_DISCARD flag, which was picked up by
fscache_cookie_state_machine(), withdrawing the cookie via
cachefiles_withdraw_cookie(), clearing cookie->cache_priv.

At the same time, yet another process invoked
cachefiles_prepare_write(), which found a NULL pointer in this code
line:

  struct cachefiles_object *object = cachefiles_cres_object(cres);

The next line crashes, obviously:

  struct cachefiles_cache *cache = object->volume->cache;

During cachefiles_prepare_write(), the "n_accesses" counter is
non-zero (via fscache_begin_operation()).  The cookie must not be
withdrawn until it drops to zero.

The counter is checked by fscache_cookie_state_machine() before
switching to FSCACHE_COOKIE_STATE_RELINQUISHING and
FSCACHE_COOKIE_STATE_WITHDRAWING (in "case
FSCACHE_COOKIE_STATE_FAILED"), but not for
FSCACHE_COOKIE_STATE_LRU_DISCARDING ("case
FSCACHE_COOKIE_STATE_ACTIVE").

This patch adds the missing check.  With a non-zero access counter,
the function returns and the next fscache_end_cookie_access() call
will queue another fscache_cookie_state_machine() call to handle the
still-pending FSCACHE_COOKIE_DO_LRU_DISCARD.

Fixes: 12bb21a29c19 ("fscache: Implement cookie user counting and resource pinning")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/netfs/fscache_cookie.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index bce2492186d0..d4d4b3a8b106 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -741,6 +741,10 @@ static void fscache_cookie_state_machine(struct fscache_cookie *cookie)
 			spin_lock(&cookie->lock);
 		}
 		if (test_bit(FSCACHE_COOKIE_DO_LRU_DISCARD, &cookie->flags)) {
+			if (atomic_read(&cookie->n_accesses) != 0)
+				/* still being accessed: postpone it */
+				break;
+
 			__fscache_set_cookie_state(cookie,
 						   FSCACHE_COOKIE_STATE_LRU_DISCARDING);
 			wake = true;

