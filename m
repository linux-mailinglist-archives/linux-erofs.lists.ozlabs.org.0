Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00720840218
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jan 2024 10:50:04 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RisgDQk/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RisgDQk/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TNk6y6XjRz3bqx
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jan 2024 20:50:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RisgDQk/;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RisgDQk/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TNk6d4Cdkz2yN8
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jan 2024 20:49:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706521782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ty0Sx4Ua+2bn5g9HXUfTFpOpeFYCT/PUmNHnpETf4uo=;
	b=RisgDQk/Kuhb52G294FYLA9YgLqnUrQgXUyduXMW2f8B3XEGCID1CgGgXS5YSNbPAMjXas
	TPe1B0OP0q/mlZxDsiO2gegWoIOgncTanrWPwXVLYkbvNjvUpVcWApuvso+2ggpfFfQYSF
	GBMZjpWAj6v9Dj+016oCGtXvhDbuXaM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706521782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ty0Sx4Ua+2bn5g9HXUfTFpOpeFYCT/PUmNHnpETf4uo=;
	b=RisgDQk/Kuhb52G294FYLA9YgLqnUrQgXUyduXMW2f8B3XEGCID1CgGgXS5YSNbPAMjXas
	TPe1B0OP0q/mlZxDsiO2gegWoIOgncTanrWPwXVLYkbvNjvUpVcWApuvso+2ggpfFfQYSF
	GBMZjpWAj6v9Dj+016oCGtXvhDbuXaM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-X_1LCiW7OoeQwPj1VhB6fQ-1; Mon, 29 Jan 2024 04:49:35 -0500
X-MC-Unique: X_1LCiW7OoeQwPj1VhB6fQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8808688B7A3;
	Mon, 29 Jan 2024 09:49:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79BAB492BE2;
	Mon, 29 Jan 2024 09:49:32 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 2/2] netfs: Fix missing zero-length check in unbuffered write
Date: Mon, 29 Jan 2024 09:49:19 +0000
Message-ID: <20240129094924.1221977-3-dhowells@redhat.com>
In-Reply-To: <20240129094924.1221977-1-dhowells@redhat.com>
References: <20240129094924.1221977-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Dominique Martinet <asmadeus@codewreck.org>, linux_oss@crudebyte.com, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix netfs_unbuffered_write_iter() to return immediately if
generic_write_checks() returns 0, indicating there's nothing to write.
Note that netfs_file_write_iter() already does this.

Also, whilst we're at it, put in checks for the size being zero before we
even take the locks.  Note that generic_write_checks() can still reduce the
size to zero, so we still need that check.

Without this, a warning similar to the following is logged to dmesg:

	netfs: Zero-sized write [R=1b6da]

and the syscall fails with EIO, e.g.:

	/sbin/ldconfig.real: Writing of cache extension data failed: Input/output error

This can be reproduced on 9p by:

	xfs_io -f -c 'pwrite 0 0' /xfstest.test/foo

Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
Reported-by: Eric Van Hensbergen <ericvh@kernel.org>
Link: https://lore.kernel.org/r/ZbQUU6QKmIftKsmo@FV7GG9FTHL/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: v9fs@lists.linux.dev
cc: linux_oss@crudebyte.com
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c | 3 +++
 fs/netfs/direct_write.c   | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index a3059b3168fd..9a0d32e4b422 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -477,6 +477,9 @@ ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
 
+	if (!iov_iter_count(from))
+		return 0;
+
 	if ((iocb->ki_flags & IOCB_DIRECT) ||
 	    test_bit(NETFS_ICTX_UNBUFFERED, &ictx->flags))
 		return netfs_unbuffered_write_iter(iocb, from);
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 60a40d293c87..bee047e20f5d 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -139,6 +139,9 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
 
+	if (!iov_iter_count(from))
+		return 0;
+
 	trace_netfs_write_iter(iocb, from);
 	netfs_stat(&netfs_n_rh_dio_write);
 
@@ -146,7 +149,7 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret < 0)
 		return ret;
 	ret = generic_write_checks(iocb, from);
-	if (ret < 0)
+	if (ret <= 0)
 		goto out;
 	ret = file_remove_privs(file);
 	if (ret < 0)

