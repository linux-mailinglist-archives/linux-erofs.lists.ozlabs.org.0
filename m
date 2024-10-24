Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523A99AE78A
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Oct 2024 16:08:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZ76V2MdSz3bdX
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 01:08:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729778880;
	cv=none; b=eNlbwHQA4yxcXY7mZZyJW1eSkZuahWjVtlWpeCbO80lmocbSsWaL1K+GF890E84g801pDHVuPj+wLl28dvFYu39f/u77+/eGPGT6y7Psqj3LHx2oIPvqqCQ9EM1esbL6FhI/bdhuc5dbEi1zLdhnEBy0ahuHyPttCcDqBJ1cMjx7lTipjou8Ad0ZxF/5dQOtgzB1zHo9z8d2OkJGbNa3fN9fXu5xEI0xqvigmwULCyuqwuWYlzVuQffXxoisVXtjVEJJ2wgsW6y+EtWMlrU6yoaoh8gBTXZr5CCXsNpz6VZ7iCXo9R6vYxYhp5wfufZN+eNgcdEuu6gts2/rkwfwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729778880; c=relaxed/relaxed;
	bh=PpSYjRYWbFXxWDdh6eO8irNXCJzGx0/SlE83d2O2JK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeBBAKrZ4b/8cXF38mILjrVaEFM5mk2nvA6YTi9z4GeV/36VpTEgh341wEiadynu6R10h5OusUtIRwgs5q4di3X6LA+OAr8fLiRVaZukvBlBjgXJdfixzSRR9BviADT7KE/ns6++i7I8q/LX/zdvHRsX9yR39moVT4odPiyfgSrs12g2gHVCchBtoLRy2UdyVFdskN9kd+Wp0PSzwQl/dRDpR+KhZvEz9FelSfBC0oEE9oOWrcqGniaihdVVPDMpwUCUaicj9WNEeJJvfKzfBZ2sSHBNcm2x468lUZKbfNY84GLd/d7H7JK18IOVvRUrvO8A4xTWNoeSUdwbw5lxiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DmnQE/rB; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HgQw4R76; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DmnQE/rB;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HgQw4R76;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZ76R3n2fz2ysv
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Oct 2024 01:07:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpSYjRYWbFXxWDdh6eO8irNXCJzGx0/SlE83d2O2JK0=;
	b=DmnQE/rB0dgw5o8ZixzhnuFUHaCSVDy3qI8/s8JSMIlbuqBkQSjzKPRgF/jZXbtw37jzhu
	LmyDjrAWNPgpe6G+6V69uz6M1h5RKKoKVka6uOiWyMVvMYZ23hlwV8AkcpKaNge+Yimkja
	2QOi0jUnogQXzIJCUKyvTNuyZ3VHTpo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpSYjRYWbFXxWDdh6eO8irNXCJzGx0/SlE83d2O2JK0=;
	b=HgQw4R76byHV4By2iNBdUZwdbzo5Ray+sHSB5PZQLxHHFgsN0WBW63RrypZl9Jkxc9pNk1
	B07JkQWI7+YxEJiH+O0vowJwAIRgO/OONkk3yq9iwYC4X9CtVO2CZZ6fkCrsecKdxFrrQg
	BaM4dj6EH0RL2hKNMk9BhX08vFmpof0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-X2salaQqORGe0htRiH1TeQ-1; Thu,
 24 Oct 2024 10:07:53 -0400
X-MC-Unique: X2salaQqORGe0htRiH1TeQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 831B21955EAA;
	Thu, 24 Oct 2024 14:07:49 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C92C3196BB7D;
	Thu, 24 Oct 2024 14:07:43 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 15/27] netfs: Remove some extraneous directory invalidations
Date: Thu, 24 Oct 2024 15:05:13 +0100
Message-ID: <20241024140539.3828093-16-dhowells@redhat.com>
In-Reply-To: <20241024140539.3828093-1-dhowells@redhat.com>
References: <20241024140539.3828093-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In the directory editing code, we shouldn't re-invalidate the directory
if it is already invalidated.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir_edit.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index fe223fb78111..13fb236a3f50 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -247,7 +247,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 		 */
 		index = b / AFS_DIR_BLOCKS_PER_PAGE;
 		if (nr_blocks >= AFS_DIR_MAX_BLOCKS)
-			goto error;
+			goto error_too_many_blocks;
 		if (index >= folio_nr_pages(folio0)) {
 			folio = afs_dir_get_folio(vnode, index);
 			if (!folio)
@@ -260,7 +260,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
-			goto invalidated;
+			goto already_invalidated;
 
 		_debug("block %u: %2u %3u %u",
 		       b,
@@ -348,9 +348,8 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	_leave("");
 	return;
 
-invalidated:
+already_invalidated:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_create_inval, 0, 0, 0, 0, name->name);
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	kunmap_local(block);
 	if (folio != folio0) {
 		folio_unlock(folio);
@@ -358,9 +357,10 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	}
 	goto out_unmap;
 
+error_too_many_blocks:
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 error:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_create_error, 0, 0, 0, 0, name->name);
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	goto out_unmap;
 }
 
@@ -421,7 +421,7 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
-			goto invalidated;
+			goto already_invalidated;
 
 		if (b > AFS_DIR_BLOCKS_WITH_CTR ||
 		    meta->meta.alloc_ctrs[b] <= AFS_DIR_SLOTS_PER_BLOCK - 1 - need_slots) {
@@ -475,10 +475,9 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	_leave("");
 	return;
 
-invalidated:
+already_invalidated:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete_inval,
 			   0, 0, 0, 0, name->name);
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	kunmap_local(block);
 	if (folio != folio0) {
 		folio_unlock(folio);
@@ -489,7 +488,6 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 error:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete_error,
 			   0, 0, 0, 0, name->name);
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	goto out_unmap;
 }
 
@@ -530,7 +528,7 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
-			goto invalidated;
+			goto already_invalidated;
 
 		slot = afs_dir_scan_block(block, &dotdot_name, b);
 		if (slot >= 0)
@@ -564,18 +562,16 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 	_leave("");
 	return;
 
-invalidated:
+already_invalidated:
 	kunmap_local(block);
 	folio_unlock(folio);
 	folio_put(folio);
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_inval,
 			   0, 0, 0, 0, "..");
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	goto out;
 
 error:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_error,
 			   0, 0, 0, 0, "..");
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	goto out;
 }

