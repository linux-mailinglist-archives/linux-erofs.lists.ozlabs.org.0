Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 191E870A387
	for <lists+linux-erofs@lfdr.de>; Sat, 20 May 2023 02:01:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QNP5C2QDYz3fFh
	for <lists+linux-erofs@lfdr.de>; Sat, 20 May 2023 10:01:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YAmVD1ES;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YAmVD1ES;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YAmVD1ES;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YAmVD1ES;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QNP543Ygqz3cDk
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 May 2023 10:01:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684540883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbFi31jMxWzghDu9RJeKpwLNk82XZBGuvfsvQFuMAZA=;
	b=YAmVD1ESEiekjfILaBpaFI2UshIVzSH6kMj6ES8zjH2P8KfsiwTPy6IbhO/aW02mxQkoAa
	3mshb7B+V0D2xo5FDMTBKCuEmp9oB+4x9FJbiI0NzFoVuB4T29p4Yqa2J2NF6JEQS7JiY2
	llmJ7OvMIv5KFY0tFxdlIzdRbN+RweI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684540883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbFi31jMxWzghDu9RJeKpwLNk82XZBGuvfsvQFuMAZA=;
	b=YAmVD1ESEiekjfILaBpaFI2UshIVzSH6kMj6ES8zjH2P8KfsiwTPy6IbhO/aW02mxQkoAa
	3mshb7B+V0D2xo5FDMTBKCuEmp9oB+4x9FJbiI0NzFoVuB4T29p4Yqa2J2NF6JEQS7JiY2
	llmJ7OvMIv5KFY0tFxdlIzdRbN+RweI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-boGls4mfOPmRYAKfMNAYJA-1; Fri, 19 May 2023 20:01:18 -0400
X-MC-Unique: boGls4mfOPmRYAKfMNAYJA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A57D3C01DB4;
	Sat, 20 May 2023 00:01:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0BE5F40CFD46;
	Sat, 20 May 2023 00:01:14 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v21 08/30] splice: Make splice from a DAX file use copy_splice_read()
Date: Sat, 20 May 2023 01:00:27 +0100
Message-Id: <20230520000049.2226926-9-dhowells@redhat.com>
In-Reply-To: <20230520000049.2226926-1-dhowells@redhat.com>
References: <20230520000049.2226926-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
Cc: linux-erofs@lists.ozlabs.org, linux-block@vger.kernel.org, Hillf Danton <hdanton@sina.com>, Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org, David Hildenbrand <david@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Jason Gunthorpe <jgg@nvidia.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Make a read splice from a DAX file go directly to copy_splice_read() to do
the reading as filemap_splice_read() is unlikely to find any pagecache to
splice.

I think this affects only erofs, Ext2, Ext4, fuse and XFS.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-erofs@lists.ozlabs.org
cc: linux-ext4@vger.kernel.org
cc: linux-xfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #21)
     - Don't need #ifdef CONFIG_FS_DAX as IS_DAX() is false if !CONFIG_FS_DAX.
     - Needs to be in vfs_splice_read(), not generic_file_splice_read().

 fs/splice.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 76126b1aafcb..8268248df3a9 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -908,10 +908,10 @@ long vfs_splice_read(struct file *in, loff_t *ppos,
 	if (unlikely(!in->f_op->splice_read))
 		return warn_unsupported(in, "read");
 	/*
-	 * O_DIRECT doesn't deal with the pagecache, so we allocate a buffer,
-	 * copy into it and splice that into the pipe.
+	 * O_DIRECT and DAX don't deal with the pagecache, so we allocate a
+	 * buffer, copy into it and splice that into the pipe.
 	 */
-	if ((in->f_flags & O_DIRECT))
+	if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
 		return copy_splice_read(in, ppos, pipe, len, flags);
 	return in->f_op->splice_read(in, ppos, pipe, len, flags);
 }

