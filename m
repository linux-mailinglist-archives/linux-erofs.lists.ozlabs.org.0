Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7DF4F9FE1
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Apr 2022 01:06:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZv554GbWz3bYF
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Apr 2022 09:06:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VWbnVUUa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TkztPFNF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=VWbnVUUa; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TkztPFNF; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZv4y50vqz3bbB
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Apr 2022 09:06:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649459183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ld+cEivmS2eiw6XDxU0mlxvi/LBjnzd3w1ODGapxQaM=;
 b=VWbnVUUaUMA7IhwjQ3VlnVFFl4m/0auFVjiJdJ8KTxgkvbZuz9yFMRqL5pjUZbiGxPDy7C
 s0nXkrNSydTpxvsso3mKNYQYnOSw8yFVpHn/mKLdISE6P1Ek8oEl2x3VyuQN0e1jp5kx+a
 Tc2wgmqRjX6FVC2RMwiIkz9xUoo/+PI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649459184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ld+cEivmS2eiw6XDxU0mlxvi/LBjnzd3w1ODGapxQaM=;
 b=TkztPFNFOV/VC4xMN+77qZh9vQDNazv+a9RbnSlFwhwv7dNohN9Pi1VliYsmsAXlmgmSbI
 cmwtsUGNioY2k7ggl/aFV1hp+fNlWnovLdo0wlxm8iEsQhrB1dEVhDv7PjNK2zOlKAIGqV
 +2m5sBMU7khKiBpcX+kOxRSQdemCC8c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-4FgHaXraMlmkSqSvQhr4NA-1; Fri, 08 Apr 2022 19:06:20 -0400
X-MC-Unique: 4FgHaXraMlmkSqSvQhr4NA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32E9A8038E3;
 Fri,  8 Apr 2022 23:06:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB0C040317F;
 Fri,  8 Apr 2022 23:06:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/8] cachefiles: Fix KASAN slab-out-of-bounds in
 cachefiles_set_volume_xattr
From: David Howells <dhowells@redhat.com>
To: linux-cachefs@redhat.com
Date: Sat, 09 Apr 2022 00:06:18 +0100
Message-ID: <164945917804.773423.15758074013305901898.stgit@warthog.procyon.org.uk>
In-Reply-To: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
References: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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
Cc: Dave Wysochanski <dwysocha@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, dhowells@redhat.com,
 linux-fsdevel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Dave Wysochanski <dwysocha@redhat.com>

Use the actual length of volume coherency data when setting the
xattr to avoid the following KASAN report.

 BUG: KASAN: slab-out-of-bounds in cachefiles_set_volume_xattr+0xa0/0x350 [cachefiles]
 Write of size 4 at addr ffff888101e02af4 by task kworker/6:0/1347

 CPU: 6 PID: 1347 Comm: kworker/6:0 Kdump: loaded Not tainted 5.18.0-rc1-nfs-fscache-netfs+ #13
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-4.fc34 04/01/2014
 Workqueue: events fscache_create_volume_work [fscache]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x45/0x5a
  print_report.cold+0x5e/0x5db
  ? __lock_text_start+0x8/0x8
  ? cachefiles_set_volume_xattr+0xa0/0x350 [cachefiles]
  kasan_report+0xab/0x120
  ? cachefiles_set_volume_xattr+0xa0/0x350 [cachefiles]
  kasan_check_range+0xf5/0x1d0
  memcpy+0x39/0x60
  cachefiles_set_volume_xattr+0xa0/0x350 [cachefiles]
  cachefiles_acquire_volume+0x2be/0x500 [cachefiles]
  ? __cachefiles_free_volume+0x90/0x90 [cachefiles]
  fscache_create_volume_work+0x68/0x160 [fscache]
  process_one_work+0x3b7/0x6a0
  worker_thread+0x2c4/0x650
  ? process_one_work+0x6a0/0x6a0
  kthread+0x16c/0x1a0
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x22/0x30
  </TASK>

 Allocated by task 1347:
  kasan_save_stack+0x1e/0x40
  __kasan_kmalloc+0x81/0xa0
  cachefiles_set_volume_xattr+0x76/0x350 [cachefiles]
  cachefiles_acquire_volume+0x2be/0x500 [cachefiles]
  fscache_create_volume_work+0x68/0x160 [fscache]
  process_one_work+0x3b7/0x6a0
  worker_thread+0x2c4/0x650
  kthread+0x16c/0x1a0
  ret_from_fork+0x22/0x30

 The buggy address belongs to the object at ffff888101e02af0
 which belongs to the cache kmalloc-8 of size 8
 The buggy address is located 4 bytes inside of
 8-byte region [ffff888101e02af0, ffff888101e02af8)

 The buggy address belongs to the physical page:
 page:00000000a2292d70 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x101e02
 flags: 0x17ffffc0000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
 raw: 0017ffffc0000200 0000000000000000 dead000000000001 ffff888100042280
 raw: 0000000000000000 0000000080660066 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
 ffff888101e02980: fc 00 fc fc fc fc 00 fc fc fc fc 00 fc fc fc fc
 ffff888101e02a00: 00 fc fc fc fc 00 fc fc fc fc 00 fc fc fc fc 00
 >ffff888101e02a80: fc fc fc fc 00 fc fc fc fc 00 fc fc fc fc 04 fc
                                                            ^
 ffff888101e02b00: fc fc fc 00 fc fc fc fc 00 fc fc fc fc 00 fc fc
 ffff888101e02b80: fc fc 00 fc fc fc fc 00 fc fc fc fc 00 fc fc fc
 ==================================================================

Fixes: 413a4a6b0b55 "cachefiles: Fix volume coherency attribute"
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/20220405134649.6579-1-dwysocha@redhat.com/ # v1
Link: https://lore.kernel.org/r/20220405142810.8208-1-dwysocha@redhat.com/ # Incorrect v2
---

 fs/cachefiles/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 35465109d9c4..00b087c14995 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -203,7 +203,7 @@ bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume)
 	if (!buf)
 		return false;
 	buf->reserved = cpu_to_be32(0);
-	memcpy(buf->data, p, len);
+	memcpy(buf->data, p, volume->vcookie->coherency_len);
 
 	ret = cachefiles_inject_write_error();
 	if (ret == 0)


