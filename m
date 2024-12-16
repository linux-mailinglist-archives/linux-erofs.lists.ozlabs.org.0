Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E199F3B3E
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:44:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBsPT15QJz30T0
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 07:44:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734381866;
	cv=none; b=GjjX9YzHi7DEeWAsqtk4Ek8KRB1Dv5SD/au6IWYaJR0pRQ0HeR++JBinji+sS+k6mCoOIWczcovf671RSAtnp1gtyGQcPWMF0F7QFNuvDvqKzUOlpPmmsxE3fVNkeHDXjjKoqfB6NV7LUYTPft1MBE9m1kWET5sqZdgDll+ZhN0TGFcHqCbNPjc6DCVKD6lcI43xKm1//EJeRN2gf1ut6Z6mr4MUpRShCCv0hSlR4LaTaOM9NACXukn01az0PTTZiSWcmjzxKrf0GUdSukd6fUr/4AlqXIZpDLlBCb9+WvA2+7Mimk4Fc5wCQ9EB1SgIVtKvBGIdrHKWGoNIdW97dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734381866; c=relaxed/relaxed;
	bh=4RLYbte7mYyt1QaQ0KqP8VYAxxJSLvvB/K4TT0z4kIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViiTqVqrAblzB8h8iRe8y1DiZY6jtEIiKHKazyvpzQ1WvKd6ZpnYmo8s2wNcLXYC/SqtDWBlapJzVhNPbFPW6ERC/8F2a8YzosoRYlTjaKPMeVr43iAjibpWgrBd/oiJirF33VaFnpG7FjpE0lNpcnAvIZ5cVQkQBnew5MCjm6SnNGHW11H5HgwF5uG2MQqvBHk1yFLiOVErWOD9S/lABNGr+Jl28CQkk5vvG4PJzhV0jHhu0jlpFJQhBCxVacfAjg62wXhMiMf+uydVM3kOieeCtdXPmxUOSYOc2IDTMOXTrPMJRpnuW8Nb1cG2tH+/sTUui3qfAiHPkfwJrygCbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/g3ZOui; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/g3ZOui; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/g3ZOui;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/g3ZOui;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBsPP6D9Wz302W
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Dec 2024 07:44:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RLYbte7mYyt1QaQ0KqP8VYAxxJSLvvB/K4TT0z4kIU=;
	b=Z/g3ZOui2bSWhZ74rEiDDKCtgOyei6WKqjKMlSBTZ5iBC3aipl5aNvMEfshBgOiLkeKIiZ
	sZT0m1ZJjSB94FtfmEH+oJCqiTG4oYQKZTKl/8u1/ds/FoJItKM7JdlaRBODcpKqezGzNa
	Ud1OsceBtQ8Od73OzD9i0MNiFJyiVGY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RLYbte7mYyt1QaQ0KqP8VYAxxJSLvvB/K4TT0z4kIU=;
	b=Z/g3ZOui2bSWhZ74rEiDDKCtgOyei6WKqjKMlSBTZ5iBC3aipl5aNvMEfshBgOiLkeKIiZ
	sZT0m1ZJjSB94FtfmEH+oJCqiTG4oYQKZTKl/8u1/ds/FoJItKM7JdlaRBODcpKqezGzNa
	Ud1OsceBtQ8Od73OzD9i0MNiFJyiVGY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-nnpLUb3eM36tDcvvMQ1joA-1; Mon,
 16 Dec 2024 15:44:20 -0500
X-MC-Unique: nnpLUb3eM36tDcvvMQ1joA-1
X-Mimecast-MFC-AGG-ID: nnpLUb3eM36tDcvvMQ1joA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8377F19560B8;
	Mon, 16 Dec 2024 20:44:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F394519560AD;
	Mon, 16 Dec 2024 20:44:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 22/32] afs: Use netfslib for symlinks, allowing them to be cached
Date: Mon, 16 Dec 2024 20:41:12 +0000
Message-ID: <20241216204124.3752367-23-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

Use netfslib to read symlinks, thereby allowing them to be cached by
fscache and cachefiles.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/file.c              | 32 -------------------
 fs/afs/inode.c             | 64 +++++++++++++++++++++++++++++++++++---
 fs/afs/internal.h          |  4 ++-
 fs/afs/mntpt.c             | 22 ++++++-------
 include/trace/events/afs.h |  1 +
 5 files changed, 74 insertions(+), 49 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 5bc36bfaa173..48695a50d2f9 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -20,7 +20,6 @@
 #include "internal.h"
 
 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
-static int afs_symlink_read_folio(struct file *file, struct folio *folio);
 
 static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
@@ -61,13 +60,6 @@ const struct address_space_operations afs_file_aops = {
 	.writepages	= afs_writepages,
 };
 
-const struct address_space_operations afs_symlink_aops = {
-	.read_folio	= afs_symlink_read_folio,
-	.release_folio	= netfs_release_folio,
-	.invalidate_folio = netfs_invalidate_folio,
-	.migrate_folio	= filemap_migrate_folio,
-};
-
 static const struct vm_operations_struct afs_vm_ops = {
 	.open		= afs_vm_open,
 	.close		= afs_vm_close,
@@ -346,30 +338,6 @@ static void afs_issue_read(struct netfs_io_subrequest *subreq)
 	queue_work(system_long_wq, &subreq->work);
 }
 
-static int afs_symlink_read_folio(struct file *file, struct folio *folio)
-{
-	struct afs_vnode *vnode = AFS_FS_I(folio->mapping->host);
-	struct afs_read *fsreq;
-	int ret;
-
-	fsreq = afs_alloc_read(GFP_NOFS);
-	if (!fsreq)
-		return -ENOMEM;
-
-	fsreq->pos	= folio_pos(folio);
-	fsreq->len	= folio_size(folio);
-	fsreq->vnode	= vnode;
-	fsreq->iter	= &fsreq->def_iter;
-	iov_iter_xarray(&fsreq->def_iter, ITER_DEST, &folio->mapping->i_pages,
-			fsreq->pos, fsreq->len);
-
-	ret = afs_fetch_data(fsreq->vnode, fsreq);
-	if (ret == 0)
-		folio_mark_uptodate(folio);
-	folio_unlock(folio);
-	return ret;
-}
-
 static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct afs_vnode *vnode = AFS_FS_I(rreq->inode);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 0ed1e5c35fef..6934cc30a4ca 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -25,8 +25,60 @@
 #include "internal.h"
 #include "afs_fs.h"
 
+static void afs_put_link(void *arg)
+{
+	struct folio *folio = virt_to_folio(arg);
+
+	kunmap_local(arg);
+	folio_put(folio);
+}
+
+const char *afs_get_link(struct dentry *dentry, struct inode *inode,
+			 struct delayed_call *callback)
+{
+	struct afs_vnode *vnode = AFS_FS_I(inode);
+	struct folio *folio;
+	char *content;
+	ssize_t ret;
+
+	if (atomic64_read(&vnode->cb_expires_at) == AFS_NO_CB_PROMISE ||
+	    !test_bit(AFS_VNODE_DIR_READ, &vnode->flags)) {
+		if (!dentry)
+			return ERR_PTR(-ECHILD);
+		ret = afs_read_single(vnode, NULL);
+		if (ret < 0)
+			return ERR_PTR(ret);
+	}
+
+	folio = folioq_folio(vnode->directory, 0);
+	folio_get(folio);
+	content = kmap_local_folio(folio, 0);
+	set_delayed_call(callback, afs_put_link, content);
+	return content;
+}
+
+int afs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
+{
+	DEFINE_DELAYED_CALL(done);
+	const char *content;
+	int len;
+
+	content = afs_get_link(dentry, d_inode(dentry), &done);
+	if (IS_ERR(content)) {
+		do_delayed_call(&done);
+		return PTR_ERR(content);
+	}
+
+	len = umin(strlen(content), buflen);
+	if (copy_to_user(buffer, content, len))
+		len = -EFAULT;
+	do_delayed_call(&done);
+	return len;
+}
+
 static const struct inode_operations afs_symlink_inode_operations = {
-	.get_link	= page_get_link,
+	.get_link	= afs_get_link,
+	.readlink	= afs_readlink,
 };
 
 static noinline void dump_vnode(struct afs_vnode *vnode, struct afs_vnode *parent_vnode)
@@ -124,13 +176,13 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 			inode->i_mode	= S_IFDIR | 0555;
 			inode->i_op	= &afs_mntpt_inode_operations;
 			inode->i_fop	= &afs_mntpt_file_operations;
-			inode->i_mapping->a_ops	= &afs_symlink_aops;
 		} else {
 			inode->i_mode	= S_IFLNK | status->mode;
 			inode->i_op	= &afs_symlink_inode_operations;
-			inode->i_mapping->a_ops	= &afs_symlink_aops;
 		}
+		inode->i_mapping->a_ops	= &afs_dir_aops;
 		inode_nohighmem(inode);
+		mapping_set_release_always(inode->i_mapping);
 		break;
 	default:
 		dump_vnode(vnode, op->file[0].vnode != vnode ? op->file[0].vnode : NULL);
@@ -443,7 +495,8 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 	struct afs_vnode_cache_aux aux;
 
 	if (vnode->status.type != AFS_FTYPE_FILE &&
-	    vnode->status.type != AFS_FTYPE_DIR) {
+	    vnode->status.type != AFS_FTYPE_DIR &&
+	    vnode->status.type != AFS_FTYPE_SYMLINK) {
 		vnode->netfs.cache = NULL;
 		return;
 	}
@@ -657,7 +710,8 @@ void afs_evict_inode(struct inode *inode)
 
 	ASSERTCMP(inode->i_ino, ==, vnode->fid.vnode);
 
-	if ((S_ISDIR(inode->i_mode)) &&
+	if ((S_ISDIR(inode->i_mode) ||
+	     S_ISLNK(inode->i_mode)) &&
 	    (inode->i_state & I_DIRTY) &&
 	    !sbi->dyn_root) {
 		struct writeback_control wbc = {
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 1744a93aae27..7f170455cf25 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1116,7 +1116,6 @@ extern void afs_dynroot_depopulate(struct super_block *);
  * file.c
  */
 extern const struct address_space_operations afs_file_aops;
-extern const struct address_space_operations afs_symlink_aops;
 extern const struct inode_operations afs_file_inode_operations;
 extern const struct file_operations afs_file_operations;
 extern const struct netfs_request_ops afs_req_ops;
@@ -1222,6 +1221,9 @@ extern void afs_fs_probe_cleanup(struct afs_net *);
  */
 extern const struct afs_operation_ops afs_fetch_status_operation;
 
+const char *afs_get_link(struct dentry *dentry, struct inode *inode,
+			 struct delayed_call *callback);
+int afs_readlink(struct dentry *dentry, char __user *buffer, int buflen);
 extern void afs_vnode_commit_status(struct afs_operation *, struct afs_vnode_param *);
 extern int afs_fetch_status(struct afs_vnode *, struct key *, bool, afs_access_t *);
 extern int afs_ilookup5_test_by_fid(struct inode *, void *);
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 297487ee8323..507c25a5b2cb 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -30,7 +30,7 @@ const struct file_operations afs_mntpt_file_operations = {
 
 const struct inode_operations afs_mntpt_inode_operations = {
 	.lookup		= afs_mntpt_lookup,
-	.readlink	= page_readlink,
+	.readlink	= afs_readlink,
 	.getattr	= afs_getattr,
 };
 
@@ -118,9 +118,9 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 		ctx->volnamesz = sizeof(afs_root_volume) - 1;
 	} else {
 		/* read the contents of the AFS special symlink */
-		struct page *page;
+		DEFINE_DELAYED_CALL(cleanup);
+		const char *content;
 		loff_t size = i_size_read(d_inode(mntpt));
-		char *buf;
 
 		if (src_as->cell)
 			ctx->cell = afs_use_cell(src_as->cell, afs_cell_trace_use_mntpt);
@@ -128,16 +128,16 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 		if (size < 2 || size > PAGE_SIZE - 1)
 			return -EINVAL;
 
-		page = read_mapping_page(d_inode(mntpt)->i_mapping, 0, NULL);
-		if (IS_ERR(page))
-			return PTR_ERR(page);
+		content = afs_get_link(mntpt, d_inode(mntpt), &cleanup);
+		if (IS_ERR(content)) {
+			do_delayed_call(&cleanup);
+			return PTR_ERR(content);
+		}
 
-		buf = kmap(page);
 		ret = -EINVAL;
-		if (buf[size - 1] == '.')
-			ret = vfs_parse_fs_string(fc, "source", buf, size - 1);
-		kunmap(page);
-		put_page(page);
+		if (content[size - 1] == '.')
+			ret = vfs_parse_fs_string(fc, "source", content, size - 1);
+		do_delayed_call(&cleanup);
 		if (ret < 0)
 			return ret;
 
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index d05f2c09efe3..49a749672e38 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -422,6 +422,7 @@ enum yfs_cm_operation {
 	EM(afs_file_error_dir_over_end,		"DIR_ENT_OVER_END")	\
 	EM(afs_file_error_dir_small,		"DIR_SMALL")		\
 	EM(afs_file_error_dir_unmarked_ext,	"DIR_UNMARKED_EXT")	\
+	EM(afs_file_error_symlink_big,		"SYM_BIG")		\
 	EM(afs_file_error_mntpt,		"MNTPT_READ_FAILED")	\
 	E_(afs_file_error_writeback_fail,	"WRITEBACK_FAILED")
 

