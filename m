Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BDC82300A
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 16:00:26 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PKcc3oFd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BTYeivIt;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4tF35lT2z3bnL
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 02:00:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PKcc3oFd;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BTYeivIt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T4tDt0fKzz3btj
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jan 2024 02:00:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704294011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/klC/ghutWIOc1+EVzXLrxXcGHqt0/sieVr6S5RVKE=;
	b=PKcc3oFdjtuJktPx/Q9JV6aDZd72LiH+YYZzgii44amt9wGCPsNJJ77T6z8PSIOEUf5KUQ
	g/Zos1dJKtCGWRrOsutw5Y/KcoVXKRbk6nzZ0pkT2VShd+HMypjiVg+Pl8tNZeecGdDxh1
	ab2GRXfpeeaNlhRKUvwn+3TGFVXeSiw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704294012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/klC/ghutWIOc1+EVzXLrxXcGHqt0/sieVr6S5RVKE=;
	b=BTYeivItSsmZwP7mfN3CAwkPP7F6hA+ulZAHP2EVFLOtCfO5XYGkPL2Tij0eyBiyGDV6Ku
	LIAELf+2xRVXHnPkf5P88aAKTWBhWQ1GeY0phJE1DZUONoa7z/6Hx3WXv16OIqTUs0bPPX
	P/CuGyTgAx5A/ZQfNrkyUgwygwk68tw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-L2AWb4usNJ6xafig_4JuOw-1; Wed, 03 Jan 2024 10:00:08 -0500
X-MC-Unique: L2AWb4usNJ6xafig_4JuOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C7D38F4126;
	Wed,  3 Jan 2024 15:00:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2DFEE2026D66;
	Wed,  3 Jan 2024 15:00:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 4/5] 9p: Always update remote_i_size in stat2inode
Date: Wed,  3 Jan 2024 14:59:28 +0000
Message-ID: <20240103145935.384404-5-dhowells@redhat.com>
In-Reply-To: <20240103145935.384404-1-dhowells@redhat.com>
References: <20240103145935.384404-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Always update remote_i_size in v9fs_stat2inode*() if the size is available,
even if we are asked not to update i_isize

Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Link: https://lore.kernel.org/r/ZZVctju5TEjS218p@codewreck.org/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_inode_dotl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 3505227e1704..aa3a77bb5e86 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -684,10 +684,10 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
 			mode |= inode->i_mode & ~S_IALLUGO;
 			inode->i_mode = mode;
 		}
-		if (!(flags & V9FS_STAT2INODE_KEEP_ISIZE) &&
-		    stat->st_result_mask & P9_STATS_SIZE) {
+		if (stat->st_result_mask & P9_STATS_SIZE) {
 			v9inode->netfs.remote_i_size = stat->st_size;
-			v9fs_i_size_write(inode, stat->st_size);
+			if (!(flags & V9FS_STAT2INODE_KEEP_ISIZE))
+				v9fs_i_size_write(inode, stat->st_size);
 		}
 		if (stat->st_result_mask & P9_STATS_BLOCKS)
 			inode->i_blocks = stat->st_blocks;

