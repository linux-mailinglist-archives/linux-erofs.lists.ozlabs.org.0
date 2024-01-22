Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8CD837631
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 23:33:45 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q7hyQnCV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q7hyQnCV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJlPM15hXz3bsQ
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jan 2024 09:33:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q7hyQnCV;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q7hyQnCV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJlNj6qrnz3bfS
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jan 2024 09:33:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EbxtrFCFvcK5IiuVsAPW/KUPjjRaC8uqKzNdD5mRDM=;
	b=Q7hyQnCV4h6RGdy/5oB7d8KenQtE61HiCRbCdiua7LHAJsnLzwPaUuB100A+0Nel3ikHuM
	oODTrnU6CZJlixkVslN9hH/jG7HS4yc/AdCVjcO97tACsfBJpFJxg2ixs108NkAnxN/9I2
	Tyfcco+zYG0NgKjRsKkD7wdLkeJJTX8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EbxtrFCFvcK5IiuVsAPW/KUPjjRaC8uqKzNdD5mRDM=;
	b=Q7hyQnCV4h6RGdy/5oB7d8KenQtE61HiCRbCdiua7LHAJsnLzwPaUuB100A+0Nel3ikHuM
	oODTrnU6CZJlixkVslN9hH/jG7HS4yc/AdCVjcO97tACsfBJpFJxg2ixs108NkAnxN/9I2
	Tyfcco+zYG0NgKjRsKkD7wdLkeJJTX8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-7Wyv8Y6KNviaO9h4wF-rXg-1; Mon, 22 Jan 2024 17:33:03 -0500
X-MC-Unique: 7Wyv8Y6KNviaO9h4wF-rXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FF28863062;
	Mon, 22 Jan 2024 22:33:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DC8335012;
	Mon, 22 Jan 2024 22:33:00 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 10/10] afs: Fix missing/incorrect unlocking of RCU read lock
Date: Mon, 22 Jan 2024 22:32:23 +0000
Message-ID: <20240122223230.4000595-11-dhowells@redhat.com>
In-Reply-To: <20240122223230.4000595-1-dhowells@redhat.com>
References: <20240122223230.4000595-1-dhowells@redhat.com>
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, kernel test robot <oliver.sang@intel.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In afs_proc_addr_prefs_show(), we need to unlock the RCU read lock in both
places before returning (and not lock it again).

Fixes: f94f70d39cc2 ("afs: Provide a way to configure address priorities")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401172243.cd53d5f6-oliver.sang@intel.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 3bd02571f30d..15eab053af6d 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -166,7 +166,7 @@ static int afs_proc_addr_prefs_show(struct seq_file *m, void *v)
 
 	if (!preflist) {
 		seq_puts(m, "NO PREFS\n");
-		return 0;
+		goto out;
 	}
 
 	seq_printf(m, "PROT SUBNET                                      PRIOR (v=%u n=%u/%u/%u)\n",
@@ -191,7 +191,8 @@ static int afs_proc_addr_prefs_show(struct seq_file *m, void *v)
 		}
 	}
 
-	rcu_read_lock();
+out:
+	rcu_read_unlock();
 	return 0;
 }
 

