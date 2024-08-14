Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D322952372
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 22:39:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QKjbJFxE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QKjbJFxE;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wkg9215sBz2yWr
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 06:39:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QKjbJFxE;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QKjbJFxE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wkg8n6g0Sz2yMX
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 06:39:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723667959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSm2exThzk/ONkPYsLo5wk2mtv0Gd6Av4xPNxsPfqsw=;
	b=QKjbJFxE3vPI+1J2QCsJnOyn/TXR2lXM6WlG5Y2O3neheWwQ09i2im4qpcuNHeQanyt5kd
	o1u6W5r9IleYgJNUcanFDVRvabL4Vxxr8lqO7dW2Qk9zgcKvQV9A0Ic+e+/PPmlwz9eQTt
	9BIeuhOiyGUJE3lLAxgfoszX3f9XCSM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723667959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSm2exThzk/ONkPYsLo5wk2mtv0Gd6Av4xPNxsPfqsw=;
	b=QKjbJFxE3vPI+1J2QCsJnOyn/TXR2lXM6WlG5Y2O3neheWwQ09i2im4qpcuNHeQanyt5kd
	o1u6W5r9IleYgJNUcanFDVRvabL4Vxxr8lqO7dW2Qk9zgcKvQV9A0Ic+e+/PPmlwz9eQTt
	9BIeuhOiyGUJE3lLAxgfoszX3f9XCSM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-9yDs-KHPO0qhfQhsIZ1yWQ-1; Wed,
 14 Aug 2024 16:39:15 -0400
X-MC-Unique: 9yDs-KHPO0qhfQhsIZ1yWQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C2591956095;
	Wed, 14 Aug 2024 20:39:10 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9959E3001FE1;
	Wed, 14 Aug 2024 20:39:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 01/25] netfs, ceph: Partially revert "netfs: Replace PG_fscache by setting folio->private and marking dirty"
Date: Wed, 14 Aug 2024 21:38:21 +0100
Message-ID: <20240814203850.2240469-2-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, Xiubo Li <xiubli@redhat.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This partially reverts commit 2ff1e97587f4d398686f52c07afde3faf3da4e5c.

In addition to reverting the removal of PG_private_2 wrangling from the
buffered read code[1][2], the removal of the waits for PG_private_2 from
netfs_release_folio() and netfs_invalidate_folio() need reverting too.

It also adds a wait into ceph_evict_inode() to wait for netfs read and
copy-to-cache ops to complete.

Fixes: 2ff1e97587f4 ("netfs: Replace PG_fscache by setting folio->private and marking dirty")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Max Kellermann <max.kellermann@ionos.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: ceph-devel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/3575457.1722355300@warthog.procyon.org.uk [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e5ced7804cb9184c4a23f8054551240562a8eda [2]
---
 fs/ceph/inode.c | 1 +
 fs/netfs/misc.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 71cd70514efa..4a8eec46254b 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -695,6 +695,7 @@ void ceph_evict_inode(struct inode *inode)
 
 	percpu_counter_dec(&mdsc->metric.total_inodes);
 
+	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	if (inode->i_state & I_PINNING_NETFS_WB)
 		ceph_fscache_unuse_cookie(inode, true);
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 83e644bd518f..554a1a4615ad 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -101,6 +101,8 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 
 	_enter("{%lx},%zx,%zx", folio->index, offset, length);
 
+	folio_wait_private_2(folio); /* [DEPRECATED] */
+
 	if (!folio_test_private(folio))
 		return;
 
@@ -165,6 +167,11 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 
 	if (folio_test_private(folio))
 		return false;
+	if (unlikely(folio_test_private_2(folio))) { /* [DEPRECATED] */
+		if (current_is_kswapd() || !(gfp & __GFP_FS))
+			return false;
+		folio_wait_private_2(folio);
+	}
 	fscache_note_page_release(netfs_i_cookie(ctx));
 	return true;
 }

