Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEA8836361
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 13:39:09 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q8kPdbND;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M044jC0p;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJVCH4X0Zz3bt2
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 23:39:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q8kPdbND;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M044jC0p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJVC92r6qz3bqx
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jan 2024 23:39:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705927138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRDq2jwLFhb5pXOHdUvfqCYrkV16pIgDVznzrFSoQl0=;
	b=Q8kPdbNDZyo+AMJzZifaqYsBgLEeDHNX7y3n6zo/pCSRpCeJ1MFmvehvy4m+Pq7xwnUGce
	YRC7Z1GgkOTjY4RZoiEOcTOxyhaHFjzaQSrPQk9BMJF87w6j29Qjjo9gcPlUzj9MtpJXS0
	mM/LMsXzPai/HLc77uai2oxMiC0X5jg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705927139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRDq2jwLFhb5pXOHdUvfqCYrkV16pIgDVznzrFSoQl0=;
	b=M044jC0pjDyp8SkWky4RXeJSraOFeaRvbIWw/DSrTGpJTMKxQcNoNB0AeUTyXUW6+aCd/5
	dn6DWrKl910HQ3HH3Jt/ZQVmvP6XnTFEYWqq4Ez+fAS/lUw3hJJEqBtTRLEzkKU+hHUz2j
	ymbkazhgGcQkyHyLt+fcDWr3RKy0yzY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-UOC2OtDLMeOsQR0hPiJYIA-1; Mon, 22 Jan 2024 07:38:57 -0500
X-MC-Unique: UOC2OtDLMeOsQR0hPiJYIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 840ED83106D;
	Mon, 22 Jan 2024 12:38:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A0F1C2166B31;
	Mon, 22 Jan 2024 12:38:54 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 02/10] afs: Don't use certain internal folio_*() functions
Date: Mon, 22 Jan 2024 12:38:35 +0000
Message-ID: <20240122123845.3822570-3-dhowells@redhat.com>
In-Reply-To: <20240122123845.3822570-1-dhowells@redhat.com>
References: <20240122123845.3822570-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Filesystems should not be using folio->index not folio_index(folio) and
folio->mapping, not folio_mapping() or folio_file_mapping() in filesystem
code.

Change this automagically with:

perl -p -i -e 's/folio_mapping[(]([^)]*)[)]/\1->mapping/g' fs/afs/*.c
perl -p -i -e 's/folio_file_mapping[(]([^)]*)[)]/\1->mapping/g' fs/afs/*.c
perl -p -i -e 's/folio_index[(]([^)]*)[)]/\1->index/g' fs/afs/*.c

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/dir.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index c14533ef108f..3f73d61f7c8a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -124,7 +124,7 @@ static void afs_dir_read_cleanup(struct afs_read *req)
 		if (xas_retry(&xas, folio))
 			continue;
 		BUG_ON(xa_is_value(folio));
-		ASSERTCMP(folio_file_mapping(folio), ==, mapping);
+		ASSERTCMP(folio->mapping, ==, mapping);
 
 		folio_put(folio);
 	}
@@ -202,12 +202,12 @@ static void afs_dir_dump(struct afs_vnode *dvnode, struct afs_read *req)
 		if (xas_retry(&xas, folio))
 			continue;
 
-		BUG_ON(folio_file_mapping(folio) != mapping);
+		BUG_ON(folio->mapping != mapping);
 
 		size = min_t(loff_t, folio_size(folio), req->actual_len - folio_pos(folio));
 		for (offset = 0; offset < size; offset += sizeof(*block)) {
 			block = kmap_local_folio(folio, offset);
-			pr_warn("[%02lx] %32phN\n", folio_index(folio) + offset, block);
+			pr_warn("[%02lx] %32phN\n", folio->index + offset, block);
 			kunmap_local(block);
 		}
 	}
@@ -233,7 +233,7 @@ static int afs_dir_check(struct afs_vnode *dvnode, struct afs_read *req)
 		if (xas_retry(&xas, folio))
 			continue;
 
-		BUG_ON(folio_file_mapping(folio) != mapping);
+		BUG_ON(folio->mapping != mapping);
 
 		if (!afs_dir_check_folio(dvnode, folio, req->actual_len)) {
 			afs_dir_dump(dvnode, req);
@@ -2022,7 +2022,7 @@ static bool afs_dir_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
 	struct afs_vnode *dvnode = AFS_FS_I(folio_inode(folio));
 
-	_enter("{{%llx:%llu}[%lu]}", dvnode->fid.vid, dvnode->fid.vnode, folio_index(folio));
+	_enter("{{%llx:%llu}[%lu]}", dvnode->fid.vid, dvnode->fid.vnode, folio->index);
 
 	folio_detach_private(folio);
 

