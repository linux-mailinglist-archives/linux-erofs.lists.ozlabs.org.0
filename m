Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A429B1029
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 22:43:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZvrN72Bvz3bjq
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Oct 2024 07:43:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729889011;
	cv=none; b=M6eyCLkavOuDscCv0/lpEKSxtZQy5fY2hlTvYutKLW9ccKs/yLMNV98fKY01xjLOga10S/5hU5+qFtoskGuUcWk9BZrHu1mH3UPoUy/IRdjJ+syFvIPlJl3c7H0/bIZA23PmcI7gy5DUa8FEvRHkk6KBuPTA1UZWdFI6dtqCS0++AbxAW9O1z4OfqkWZcWpAyZenBFYqSdlTDY8L9zwdrpcFARjXSL9tT8b3S17UjtaukZRjRAbMQzc7gGBLPQ3Gb17b9yU9syDHhnS3LeGFU6Te220lWvuqUIVqeVdFyAUCoc8PXsEVzp6lI2B0X3t/Uol+C3hqFfmbheQsPXlYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729889011; c=relaxed/relaxed;
	bh=DNBmYsisi11F4a9GdaB4+2hzkwarlQJLH0bImPjM4eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leOPCpRqneiIXr4Fh5dS3A0d7TRuFWTIyRHPNG3dIo5m89WxjRf+1N6JPA8DJ3O6tPCLEt2pFDiTu/iCAp8zUMY7wxj2TFUDCVA+WLHWs748AyDgMaqb7gIE/09WlIYTdgKOb4X9biKb8Rlm9Cc2MFxMb4//pJh0ELA7VqpWcXK5eAymoAxNrls1uVSzc7Fkfxg8Eee6RqnsA38U3oYqHmtpxOrGnedqsQK2KjSpjfpyNUET/hF+DSd9HRfuRGi20yOs2r2FUBoxaQaK4FFEPtB4RkSmxUkpc2Eil1f6WUXLbiGnfSvKfe1SuQ7sRpZwelapYcm1FP7bW6dQrWq7Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RChp7dg8; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RChp7dg8; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RChp7dg8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RChp7dg8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZvrL0dr2z2yn4
	for <linux-erofs@lists.ozlabs.org>; Sat, 26 Oct 2024 07:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729889007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNBmYsisi11F4a9GdaB4+2hzkwarlQJLH0bImPjM4eE=;
	b=RChp7dg8pZEWkFaQV6EaI3SKJpfc883obXxNBof14tCNhY2QSKQM5irKs3+HaZCf6twDyB
	ks5bVnWwZhMO0oYrQtgXDTLIGPwqiwE/e5cJL6YQbBIYdxlxxnEpmuYpNojOJlL1eBEsol
	AtkNXQ290jUHxMCLA2EcZwi9mcBBFd0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729889007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNBmYsisi11F4a9GdaB4+2hzkwarlQJLH0bImPjM4eE=;
	b=RChp7dg8pZEWkFaQV6EaI3SKJpfc883obXxNBof14tCNhY2QSKQM5irKs3+HaZCf6twDyB
	ks5bVnWwZhMO0oYrQtgXDTLIGPwqiwE/e5cJL6YQbBIYdxlxxnEpmuYpNojOJlL1eBEsol
	AtkNXQ290jUHxMCLA2EcZwi9mcBBFd0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-LBc8O0OjOoyLZPAMboBZnQ-1; Fri,
 25 Oct 2024 16:43:21 -0400
X-MC-Unique: LBc8O0OjOoyLZPAMboBZnQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3FE11955F3E;
	Fri, 25 Oct 2024 20:43:16 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 206F6300018D;
	Fri, 25 Oct 2024 20:43:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 27/31] afs: Make afs_mkdir() locally initialise a new directory's content
Date: Fri, 25 Oct 2024 21:39:54 +0100
Message-ID: <20241025204008.4076565-28-dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-1-dhowells@redhat.com>
References: <20241025204008.4076565-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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

Initialise a new directory's content when it is created by mkdir locally
rather than downloading the content from the server as we can predict what
it's going to look like.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c               |  3 +++
 fs/afs/dir_edit.c          | 48 ++++++++++++++++++++++++++++++++++++++
 fs/afs/internal.h          |  1 +
 include/trace/events/afs.h |  2 ++
 4 files changed, 54 insertions(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 4b1b25015573..aa589f0d55bf 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1258,6 +1258,7 @@ void afs_check_for_remote_deletion(struct afs_operation *op)
  */
 static void afs_vnode_new_inode(struct afs_operation *op)
 {
+	struct afs_vnode_param *dvp = &op->file[0];
 	struct afs_vnode_param *vp = &op->file[1];
 	struct afs_vnode *vnode;
 	struct inode *inode;
@@ -1277,6 +1278,8 @@ static void afs_vnode_new_inode(struct afs_operation *op)
 
 	vnode = AFS_FS_I(inode);
 	set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
+	if (S_ISDIR(inode->i_mode))
+		afs_mkdir_init_dir(vnode, dvp->vnode);
 	if (!afs_op_error(op))
 		afs_cache_permit(vnode, op->key, vnode->cb_break, &vp->scb);
 	d_instantiate(op->dentry, inode);
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 71cce884e434..f4037973416e 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -556,3 +556,51 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 			   0, 0, 0, 0, "..");
 	goto out;
 }
+
+/*
+ * Initialise a new directory.  We need to fill in the "." and ".." entries.
+ */
+void afs_mkdir_init_dir(struct afs_vnode *dvnode, struct afs_vnode *parent_dvnode)
+{
+	union afs_xdr_dir_block *meta;
+	struct afs_dir_iter iter = { .dvnode = dvnode };
+	union afs_xdr_dirent *de;
+	unsigned int slot = AFS_DIR_RESV_BLOCKS0;
+	loff_t i_size;
+
+	i_size = i_size_read(&dvnode->netfs.inode);
+	if (i_size != AFS_DIR_BLOCK_SIZE) {
+		afs_invalidate_dir(dvnode, afs_dir_invalid_edit_add_bad_size);
+		return;
+	}
+
+	meta = afs_dir_get_block(&iter, 0);
+	if (!meta)
+		return;
+
+	afs_edit_init_block(meta, meta, 0);
+
+	de = &meta->dirents[slot];
+	de->u.valid  = 1;
+	de->u.vnode  = htonl(dvnode->fid.vnode);
+	de->u.unique = htonl(dvnode->fid.unique);
+	memcpy(de->u.name, ".", 2);
+	trace_afs_edit_dir(dvnode, afs_edit_dir_for_mkdir, afs_edit_dir_mkdir, 0, slot,
+			   dvnode->fid.vnode, dvnode->fid.unique, ".");
+	slot++;
+
+	de = &meta->dirents[slot];
+	de->u.valid  = 1;
+	de->u.vnode  = htonl(parent_dvnode->fid.vnode);
+	de->u.unique = htonl(parent_dvnode->fid.unique);
+	memcpy(de->u.name, "..", 3);
+	trace_afs_edit_dir(dvnode, afs_edit_dir_for_mkdir, afs_edit_dir_mkdir, 0, slot,
+			   parent_dvnode->fid.vnode, parent_dvnode->fid.unique, "..");
+
+	afs_set_contig_bits(meta, AFS_DIR_RESV_BLOCKS0, 2);
+	meta->meta.alloc_ctrs[0] -= 2;
+	kunmap_local(meta);
+
+	netfs_single_mark_inode_dirty(&dvnode->netfs.inode);
+	set_bit(AFS_VNODE_DIR_VALID, &dvnode->flags);
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index c7f0d75eab7f..3acf1445e444 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1074,6 +1074,7 @@ extern void afs_edit_dir_add(struct afs_vnode *, struct qstr *, struct afs_fid *
 extern void afs_edit_dir_remove(struct afs_vnode *, struct qstr *, enum afs_edit_dir_reason);
 void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_dvnode,
 				enum afs_edit_dir_reason why);
+void afs_mkdir_init_dir(struct afs_vnode *dvnode, struct afs_vnode *parent_vnode);
 
 /*
  * dir_silly.c
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 49a749672e38..020ab7302a6b 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -348,6 +348,7 @@ enum yfs_cm_operation {
 	EM(afs_dir_invalid_edit_add_no_slots,	"edit-add-no-slots") \
 	EM(afs_dir_invalid_edit_add_too_many_blocks, "edit-add-too-many-blocks") \
 	EM(afs_dir_invalid_edit_get_block,	"edit-get-block") \
+	EM(afs_dir_invalid_edit_mkdir,		"edit-mkdir") \
 	EM(afs_dir_invalid_edit_rem_bad_size,	"edit-rem-bad-size") \
 	EM(afs_dir_invalid_edit_rem_wrong_name,	"edit-rem-wrong_name") \
 	EM(afs_dir_invalid_edit_upd_bad_size,	"edit-upd-bad-size") \
@@ -369,6 +370,7 @@ enum yfs_cm_operation {
 	EM(afs_edit_dir_delete_error,		"d_err ") \
 	EM(afs_edit_dir_delete_inval,		"d_invl") \
 	EM(afs_edit_dir_delete_noent,		"d_nent") \
+	EM(afs_edit_dir_mkdir,			"mk_ent") \
 	EM(afs_edit_dir_update_dd,		"u_ddot") \
 	EM(afs_edit_dir_update_error,		"u_fail") \
 	EM(afs_edit_dir_update_inval,		"u_invl") \

