Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDB69C234D
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Nov 2024 18:36:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XlR2B686Zz3c2L
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Nov 2024 04:36:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731087392;
	cv=none; b=Ng56KYyk3m/N8Z+3dKjYWzDa8MNd4aqGXhFPrJVOl3ZMyHAZ0RycxYwT98W2oZ7iufux3j6Luma3komqbHIPboJ+QwdLyaA/A0mJH8ImKsEPgKWycrIRwtapoliM6iDzmwEX1EXdddXnDUL0TJLR0PWkAPuPHmD9ejXmwF94NM43TeWgAjlByRkTOWhH7bNiPupBtdAudQ6+ZJNok8FvfzFFhHwYmEdDu6pXBO+/DTyyseiRbGFrzpxU24cRyNZrLFHINVUc5yvtvktnFHfcVLcYRtcCS+4B8os9CjVlgAAPCpDwFFn4eXthkm/LN9t77rJ83jDrHpYCvEFf/Yk5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731087392; c=relaxed/relaxed;
	bh=N84/tyZ1Zqmc+8460SgM1W5oZOUi9H5EDjBhi/Hz3hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+Ng2qhk2mbcYsBm28mHZ5Z1WpSelJip4OrRZy/ogbi8/rx9DefUm2RMT871eXZ+I/b6XvSzXbB4iplUdlvhuqvwLWbNBZcX3eLAQ/0vQCeVYfzLrz1in9Hv4h3Xop3eELFh3o7Vk+MpLPpnddHjDpPiCmr5slaKoD/1v2kCEKh9nWCzDZu1eqE/5FQvSTPGzcNgX8jz6ic8YokNbseRmRVuSUcgDCS4hbdl6PQBkW9PzaEsiqiYBUgl0w1upVzV6ARBW4FpXrramIUymGcLOVugRTVSd/482VamRfRsZoGTcTceIQ3Ia8Xzt3UIFqwlPxoBOf4CZXhKegE5FxW0IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KcHxUaW8; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e4pY4uM5; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KcHxUaW8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e4pY4uM5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XlR273FLJz3bxl
	for <linux-erofs@lists.ozlabs.org>; Sat,  9 Nov 2024 04:36:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N84/tyZ1Zqmc+8460SgM1W5oZOUi9H5EDjBhi/Hz3hg=;
	b=KcHxUaW8SJAxn29rSGxc20flKKIClPcFEfPqx53s28Y4PZNtWbVbbS/jen5kiT1o5r3QpD
	Jzn3eYQWc5M49WGhjcemzvVS7hDd4NUra20iYB3vP0Jd/r8oY1jaT8jpxwwp9UVVYmDFYn
	1+xIxymnkSMn3YYAttr0suUG0mPWKe0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N84/tyZ1Zqmc+8460SgM1W5oZOUi9H5EDjBhi/Hz3hg=;
	b=e4pY4uM5Ni2719UJMbdA7nsvAx2BwuoHxHbBzZSBIDM8ult+bwejcJyexEWvJy6M++9YO/
	g1k9FGOpQLvsOF3NcSO1slMK23iGA5cEsMkIUIoSNOl3Y2t8LqLpS6+FNC59lnwoz5s0oy
	3Uth0tPKPbx+bd7u0lymNsmp8D2s0vw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-hk3-d5_yOlavS-880BzBGQ-1; Fri,
 08 Nov 2024 12:36:25 -0500
X-MC-Unique: hk3-d5_yOlavS-880BzBGQ-1
X-Mimecast-MFC-AGG-ID: hk3-d5_yOlavS-880BzBGQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E984195395A;
	Fri,  8 Nov 2024 17:36:22 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D3B8300019E;
	Fri,  8 Nov 2024 17:36:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 30/33] afs: Use the contained hashtable to search a directory
Date: Fri,  8 Nov 2024 17:32:31 +0000
Message-ID: <20241108173236.1382366-31-dhowells@redhat.com>
In-Reply-To: <20241108173236.1382366-1-dhowells@redhat.com>
References: <20241108173236.1382366-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
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

Each directory image contains a hashtable with 128 buckets to speed up
searching.  Currently, kafs does not use this, but rather iterates over all
the occupied slots in the image as it can share this with readdir.

Switch kafs to use the hashtable for lookups to reduce the latency.  Care
must be taken that the hash chains are acyclic.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/Makefile     |   1 +
 fs/afs/dir.c        |  42 ++++----
 fs/afs/dir_edit.c   | 135 +++++++++++++++++---------
 fs/afs/dir_search.c | 227 ++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/internal.h   |  18 ++++
 5 files changed, 350 insertions(+), 73 deletions(-)
 create mode 100644 fs/afs/dir_search.c

diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index dcdc0f1bb76f..5efd7e13b304 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -11,6 +11,7 @@ kafs-y := \
 	cmservice.o \
 	dir.o \
 	dir_edit.o \
+	dir_search.o \
 	dir_silly.o \
 	dynroot.o \
 	file.o \
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 8c4c1029ea2f..d195a42cea1d 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -88,8 +88,6 @@ struct afs_lookup_one_cookie {
 struct afs_lookup_cookie {
 	struct dir_context	ctx;
 	struct qstr		name;
-	bool			found;
-	bool			one_only;
 	unsigned short		nr_fids;
 	struct afs_fid		fids[50];
 };
@@ -309,7 +307,7 @@ ssize_t afs_read_single(struct afs_vnode *dvnode, struct file *file)
  * Read the directory into a folio_queue buffer in one go, scrubbing the
  * previous contents.  We return -ESTALE if the caller needs to call us again.
  */
-static ssize_t afs_read_dir(struct afs_vnode *dvnode, struct file *file)
+ssize_t afs_read_dir(struct afs_vnode *dvnode, struct file *file)
 	__acquires(&dvnode->validate_lock)
 {
 	ssize_t ret;
@@ -644,19 +642,10 @@ static bool afs_lookup_filldir(struct dir_context *ctx, const char *name,
 	BUILD_BUG_ON(sizeof(union afs_xdr_dir_block) != 2048);
 	BUILD_BUG_ON(sizeof(union afs_xdr_dirent) != 32);
 
-	if (cookie->found) {
-		if (cookie->nr_fids < 50) {
-			cookie->fids[cookie->nr_fids].vnode	= ino;
-			cookie->fids[cookie->nr_fids].unique	= dtype;
-			cookie->nr_fids++;
-		}
-	} else if (cookie->name.len == nlen &&
-		   memcmp(cookie->name.name, name, nlen) == 0) {
-		cookie->fids[1].vnode	= ino;
-		cookie->fids[1].unique	= dtype;
-		cookie->found = 1;
-		if (cookie->one_only)
-			return false;
+	if (cookie->nr_fids < 50) {
+		cookie->fids[cookie->nr_fids].vnode	= ino;
+		cookie->fids[cookie->nr_fids].unique	= dtype;
+		cookie->nr_fids++;
 	}
 
 	return cookie->nr_fids < 50;
@@ -784,6 +773,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 	struct afs_vnode *dvnode = AFS_FS_I(dir), *vnode;
 	struct inode *inode = NULL, *ti;
 	afs_dataversion_t data_version = READ_ONCE(dvnode->status.data_version);
+	bool supports_ibulk;
 	long ret;
 	int i;
 
@@ -800,19 +790,19 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 	cookie->nr_fids = 2; /* slot 1 is saved for the fid we actually want
 			      * and slot 0 for the directory */
 
-	if (!afs_server_supports_ibulk(dvnode))
-		cookie->one_only = true;
-
-	/* search the directory */
-	ret = afs_dir_iterate(dir, &cookie->ctx, NULL, &data_version);
+	/* Search the directory for the named entry using the hash table... */
+	ret = afs_dir_search(dvnode, &dentry->d_name, &cookie->fids[1], &data_version);
 	if (ret < 0)
 		goto out;
 
-	dentry->d_fsdata = (void *)(unsigned long)data_version;
+	supports_ibulk = afs_server_supports_ibulk(dvnode);
+	if (supports_ibulk) {
+		/* ...then scan linearly from that point for entries to lookup-ahead. */
+		cookie->ctx.pos = (ret + 1) * AFS_DIR_DIRENT_SIZE;
+		afs_dir_iterate(dir, &cookie->ctx, NULL, &data_version);
+	}
 
-	ret = -ENOENT;
-	if (!cookie->found)
-		goto out;
+	dentry->d_fsdata = (void *)(unsigned long)data_version;
 
 	/* Check to see if we already have an inode for the primary fid. */
 	inode = ilookup5(dir->i_sb, cookie->fids[1].vnode,
@@ -871,7 +861,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 	 * the whole operation.
 	 */
 	afs_op_set_error(op, -ENOTSUPP);
-	if (!cookie->one_only) {
+	if (supports_ibulk) {
 		op->ops = &afs_inline_bulk_status_operation;
 		afs_begin_vnode_operation(op);
 		afs_wait_for_operation(op);
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 53178bb2d1a6..60a549f1d9c5 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -245,7 +245,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	union afs_xdr_dir_block *meta, *block;
 	union afs_xdr_dirent *de;
 	struct afs_dir_iter iter = { .dvnode = vnode };
-	unsigned int need_slots, nr_blocks, b;
+	unsigned int nr_blocks, b, entry;
 	loff_t i_size;
 	int slot;
 
@@ -263,7 +263,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 		return;
 
 	/* Work out how many slots we're going to need. */
-	need_slots = afs_dir_calc_slots(name->len);
+	iter.nr_slots = afs_dir_calc_slots(name->len);
 
 	if (i_size == 0)
 		goto new_directory;
@@ -281,7 +281,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 
 		/* Lower dir blocks have a counter in the header we can check. */
 		if (b < AFS_DIR_BLOCKS_WITH_CTR &&
-		    meta->meta.alloc_ctrs[b] < need_slots)
+		    meta->meta.alloc_ctrs[b] < iter.nr_slots)
 			continue;
 
 		block = afs_dir_get_block(&iter, b);
@@ -308,7 +308,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 		/* We need to try and find one or more consecutive slots to
 		 * hold the entry.
 		 */
-		slot = afs_find_contig_bits(block, need_slots);
+		slot = afs_find_contig_bits(block, iter.nr_slots);
 		if (slot >= 0) {
 			_debug("slot %u", slot);
 			goto found_space;
@@ -347,12 +347,18 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	de->u.name[name->len] = 0;
 
 	/* Adjust the bitmap. */
-	afs_set_contig_bits(block, slot, need_slots);
-	kunmap_local(block);
+	afs_set_contig_bits(block, slot, iter.nr_slots);
 
 	/* Adjust the allocation counter. */
 	if (b < AFS_DIR_BLOCKS_WITH_CTR)
-		meta->meta.alloc_ctrs[b] -= need_slots;
+		meta->meta.alloc_ctrs[b] -= iter.nr_slots;
+
+	/* Adjust the hash chain. */
+	entry = b * AFS_DIR_SLOTS_PER_BLOCK + slot;
+	iter.bucket = afs_dir_hash_name(name);
+	de->u.hash_next = meta->meta.hashtable[iter.bucket];
+	meta->meta.hashtable[iter.bucket] = htons(entry);
+	kunmap_local(block);
 
 	inode_inc_iversion_raw(&vnode->netfs.inode);
 	afs_stat_v(vnode, n_dir_cr);
@@ -387,12 +393,14 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 void afs_edit_dir_remove(struct afs_vnode *vnode,
 			 struct qstr *name, enum afs_edit_dir_reason why)
 {
-	union afs_xdr_dir_block *meta, *block;
-	union afs_xdr_dirent *de;
+	union afs_xdr_dir_block *meta, *block, *pblock;
+	union afs_xdr_dirent *de, *pde;
 	struct afs_dir_iter iter = { .dvnode = vnode };
-	unsigned int need_slots, nr_blocks, b;
+	struct afs_fid fid;
+	unsigned int b, slot, entry;
 	loff_t i_size;
-	int slot;
+	__be16 next;
+	int found;
 
 	_enter(",,{%d,%s},", name->len, name->name);
 
@@ -403,59 +411,90 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 		afs_invalidate_dir(vnode, afs_dir_invalid_edit_rem_bad_size);
 		return;
 	}
-	nr_blocks = i_size / AFS_DIR_BLOCK_SIZE;
 
-	meta = afs_dir_get_block(&iter, 0);
-	if (!meta)
+	if (!afs_dir_init_iter(&iter, name))
 		return;
 
-	/* Work out how many slots we're going to discard. */
-	need_slots = afs_dir_calc_slots(name->len);
-
-	/* Find a block that has sufficient slots available.  Each folio
-	 * contains two or more directory blocks.
-	 */
-	for (b = 0; b < nr_blocks; b++) {
-		block = afs_dir_get_block(&iter, b);
-		if (!block)
-			goto error;
-
-		/* Abandon the edit if we got a callback break. */
-		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
-			goto already_invalidated;
-
-		if (b > AFS_DIR_BLOCKS_WITH_CTR ||
-		    meta->meta.alloc_ctrs[b] <= AFS_DIR_SLOTS_PER_BLOCK - 1 - need_slots) {
-			slot = afs_dir_scan_block(block, name, b);
-			if (slot >= 0)
-				goto found_dirent;
-		}
+	meta = afs_dir_find_block(&iter, 0);
+	if (!meta)
+		return;
 
-		kunmap_local(block);
+	/* Find the entry in the blob. */
+	found = afs_dir_search_bucket(&iter, name, &fid);
+	if (found < 0) {
+		/* Didn't find the dirent to clobber.  Re-download. */
+		trace_afs_edit_dir(vnode, why, afs_edit_dir_delete_noent,
+				   0, 0, 0, 0, name->name);
+		afs_invalidate_dir(vnode, afs_dir_invalid_edit_rem_wrong_name);
+		goto out_unmap;
 	}
 
-	/* Didn't find the dirent to clobber.  Download the directory again. */
-	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete_noent,
-			   0, 0, 0, 0, name->name);
-	afs_invalidate_dir(vnode, afs_dir_invalid_edit_rem_wrong_name);
-	goto out_unmap;
+	entry = found;
+	b    = entry / AFS_DIR_SLOTS_PER_BLOCK;
+	slot = entry % AFS_DIR_SLOTS_PER_BLOCK;
 
-found_dirent:
+	block = afs_dir_find_block(&iter, b);
+	if (!block)
+		goto error;
+	if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
+		goto already_invalidated;
+
+	/* Check and clear the entry. */
 	de = &block->dirents[slot];
+	if (de->u.valid != 1)
+		goto error_unmap;
 
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete, b, slot,
 			   ntohl(de->u.vnode), ntohl(de->u.unique),
 			   name->name);
 
-	memset(de, 0, sizeof(*de) * need_slots);
-
 	/* Adjust the bitmap. */
-	afs_clear_contig_bits(block, slot, need_slots);
-	kunmap_local(block);
+	afs_clear_contig_bits(block, slot, iter.nr_slots);
 
 	/* Adjust the allocation counter. */
 	if (b < AFS_DIR_BLOCKS_WITH_CTR)
-		meta->meta.alloc_ctrs[b] += need_slots;
+		meta->meta.alloc_ctrs[b] += iter.nr_slots;
+
+	/* Clear the constituent entries. */
+	next = de->u.hash_next;
+	memset(de, 0, sizeof(*de) * iter.nr_slots);
+	kunmap_local(block);
+
+	/* Adjust the hash chain: if iter->prev_entry is 0, the hashtable head
+	 * index is previous; otherwise it's slot number of the previous entry.
+	 */
+	if (!iter.prev_entry) {
+		__be16 prev_next = meta->meta.hashtable[iter.bucket];
+
+		if (unlikely(prev_next != htons(entry))) {
+			pr_warn("%llx:%llx:%x: not head of chain b=%x p=%x,%x e=%x %*s",
+				vnode->fid.vid, vnode->fid.vnode, vnode->fid.unique,
+				iter.bucket, iter.prev_entry, prev_next, entry,
+				name->len, name->name);
+			goto error;
+		}
+		meta->meta.hashtable[iter.bucket] = next;
+	} else {
+		unsigned int pb = iter.prev_entry / AFS_DIR_SLOTS_PER_BLOCK;
+		unsigned int ps = iter.prev_entry % AFS_DIR_SLOTS_PER_BLOCK;
+		__be16 prev_next;
+
+		pblock = afs_dir_find_block(&iter, pb);
+		if (!pblock)
+			goto error;
+		pde = &pblock->dirents[ps];
+		prev_next = pde->u.hash_next;
+		if (prev_next != htons(entry)) {
+			kunmap_local(pblock);
+			pr_warn("%llx:%llx:%x: not prev in chain b=%x p=%x,%x e=%x %*s",
+				vnode->fid.vid, vnode->fid.vnode, vnode->fid.unique,
+				iter.bucket, iter.prev_entry, prev_next, entry,
+				name->len, name->name);
+			goto error;
+		}
+		pde->u.hash_next = next;
+		kunmap_local(pblock);
+	}
 
 	netfs_single_mark_inode_dirty(&vnode->netfs.inode);
 
@@ -474,6 +513,8 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 			   0, 0, 0, 0, name->name);
 	goto out_unmap;
 
+error_unmap:
+	kunmap_local(block);
 error:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete_error,
 			   0, 0, 0, 0, name->name);
diff --git a/fs/afs/dir_search.c b/fs/afs/dir_search.c
new file mode 100644
index 000000000000..b25bd892db4d
--- /dev/null
+++ b/fs/afs/dir_search.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Search a directory's hash table.
+ *
+ * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * https://tools.ietf.org/html/draft-keiser-afs3-directory-object-00
+ */
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/iversion.h>
+#include "internal.h"
+#include "afs_fs.h"
+#include "xdr_fs.h"
+
+/*
+ * Calculate the name hash.
+ */
+unsigned int afs_dir_hash_name(const struct qstr *name)
+{
+	const unsigned char *p = name->name;
+	unsigned int hash = 0, i;
+	int bucket;
+
+	for (i = 0; i < name->len; i++)
+		hash = (hash * 173) + p[i];
+	bucket = hash & (AFS_DIR_HASHTBL_SIZE - 1);
+	if (hash > INT_MAX) {
+		bucket = AFS_DIR_HASHTBL_SIZE - bucket;
+		bucket &= (AFS_DIR_HASHTBL_SIZE - 1);
+	}
+	return bucket;
+}
+
+/*
+ * Reset a directory iterator.
+ */
+static bool afs_dir_reset_iter(struct afs_dir_iter *iter)
+{
+	unsigned long long i_size = i_size_read(&iter->dvnode->netfs.inode);
+	unsigned int nblocks;
+
+	/* Work out the maximum number of steps we can take. */
+	nblocks = umin(i_size / AFS_DIR_BLOCK_SIZE, AFS_DIR_MAX_BLOCKS);
+	if (!nblocks)
+		return false;
+	iter->loop_check = nblocks * (AFS_DIR_SLOTS_PER_BLOCK - AFS_DIR_RESV_BLOCKS);
+	iter->prev_entry = 0; /* Hash head is previous */
+	return true;
+}
+
+/*
+ * Initialise a directory iterator for looking up a name.
+ */
+bool afs_dir_init_iter(struct afs_dir_iter *iter, const struct qstr *name)
+{
+	iter->nr_slots = afs_dir_calc_slots(name->len);
+	iter->bucket = afs_dir_hash_name(name);
+	return afs_dir_reset_iter(iter);
+}
+
+/*
+ * Get a specific block.
+ */
+union afs_xdr_dir_block *afs_dir_find_block(struct afs_dir_iter *iter, size_t block)
+{
+	struct folio_queue *fq = iter->fq;
+	struct afs_vnode *dvnode = iter->dvnode;
+	struct folio *folio;
+	size_t blpos = block * AFS_DIR_BLOCK_SIZE;
+	size_t blend = (block + 1) * AFS_DIR_BLOCK_SIZE, fpos = iter->fpos;
+	int slot = iter->fq_slot;
+
+	_enter("%zx,%d", block, slot);
+
+	if (iter->block) {
+		kunmap_local(iter->block);
+		iter->block = NULL;
+	}
+
+	if (dvnode->directory_size < blend)
+		goto fail;
+
+	if (!fq || blpos < fpos) {
+		fq = dvnode->directory;
+		slot = 0;
+		fpos = 0;
+	}
+
+	/* Search the folio queue for the folio containing the block... */
+	for (; fq; fq = fq->next) {
+		for (; slot < folioq_count(fq); slot++) {
+			size_t fsize = folioq_folio_size(fq, slot);
+
+			if (blend <= fpos + fsize) {
+				/* ... and then return the mapped block. */
+				folio = folioq_folio(fq, slot);
+				if (WARN_ON_ONCE(folio_pos(folio) != fpos))
+					goto fail;
+				iter->fq = fq;
+				iter->fq_slot = slot;
+				iter->fpos = fpos;
+				iter->block = kmap_local_folio(folio, blpos - fpos);
+				return iter->block;
+			}
+			fpos += fsize;
+		}
+		slot = 0;
+	}
+
+fail:
+	iter->fq = NULL;
+	iter->fq_slot = 0;
+	afs_invalidate_dir(dvnode, afs_dir_invalid_edit_get_block);
+	return NULL;
+}
+
+/*
+ * Search through a directory bucket.
+ */
+int afs_dir_search_bucket(struct afs_dir_iter *iter, const struct qstr *name,
+			  struct afs_fid *_fid)
+{
+	const union afs_xdr_dir_block *meta;
+	unsigned int entry;
+	int ret = -ESTALE;
+
+	meta = afs_dir_find_block(iter, 0);
+	if (!meta)
+		return -ESTALE;
+
+	entry = ntohs(meta->meta.hashtable[iter->bucket & (AFS_DIR_HASHTBL_SIZE - 1)]);
+	_enter("%x,%x", iter->bucket, entry);
+
+	while (entry) {
+		const union afs_xdr_dir_block *block;
+		const union afs_xdr_dirent *dire;
+		unsigned int blnum = entry / AFS_DIR_SLOTS_PER_BLOCK;
+		unsigned int slot = entry % AFS_DIR_SLOTS_PER_BLOCK;
+		unsigned int resv = (blnum == 0 ? AFS_DIR_RESV_BLOCKS0 : AFS_DIR_RESV_BLOCKS);
+
+		_debug("search %x", entry);
+
+		if (slot < resv) {
+			kdebug("slot out of range h=%x rs=%2x sl=%2x-%2x",
+			       iter->bucket, resv, slot, slot + iter->nr_slots - 1);
+			goto bad;
+		}
+
+		block = afs_dir_find_block(iter, blnum);
+		if (!block)
+			goto bad;
+		dire = &block->dirents[slot];
+
+		if (slot + iter->nr_slots <= AFS_DIR_SLOTS_PER_BLOCK &&
+		    memcmp(dire->u.name, name->name, name->len) == 0 &&
+		    dire->u.name[name->len] == '\0') {
+			_fid->vnode  = ntohl(dire->u.vnode);
+			_fid->unique = ntohl(dire->u.unique);
+			ret = entry;
+			goto found;
+		}
+
+		iter->prev_entry = entry;
+		entry = ntohs(dire->u.hash_next);
+		if (!--iter->loop_check) {
+			kdebug("dir chain loop h=%x", iter->bucket);
+			goto bad;
+		}
+	}
+
+	ret = -ENOENT;
+found:
+	if (iter->block) {
+		kunmap_local(iter->block);
+		iter->block = NULL;
+	}
+
+bad:
+	if (ret == -ESTALE)
+		afs_invalidate_dir(iter->dvnode, afs_dir_invalid_iter_stale);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Search the appropriate hash chain in the contents of an AFS directory.
+ */
+int afs_dir_search(struct afs_vnode *dvnode, struct qstr *name,
+		   struct afs_fid *_fid, afs_dataversion_t *_dir_version)
+{
+	struct afs_dir_iter iter = { .dvnode = dvnode, };
+	int ret, retry_limit = 3;
+
+	_enter("{%lu},,,", dvnode->netfs.inode.i_ino);
+
+	if (!afs_dir_init_iter(&iter, name))
+		return -ENOENT;
+	do {
+		if (--retry_limit < 0) {
+			pr_warn("afs_read_dir(): Too many retries\n");
+			ret = -ESTALE;
+			break;
+		}
+		ret = afs_read_dir(dvnode, NULL);
+		if (ret < 0) {
+			if (ret != -ESTALE)
+				break;
+			if (test_bit(AFS_VNODE_DELETED, &dvnode->flags)) {
+				ret = -ESTALE;
+				break;
+			}
+			continue;
+		}
+		*_dir_version = inode_peek_iversion_raw(&dvnode->netfs.inode);
+
+		ret = afs_dir_search_bucket(&iter, name, _fid);
+		up_read(&dvnode->validate_lock);
+		if (ret == -ESTALE)
+			afs_dir_reset_iter(&iter);
+	} while (ret == -ESTALE);
+
+	_leave(" = %d", ret);
+	return ret;
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index acae1b5bfc63..b7d02c105340 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -978,9 +978,14 @@ static inline void afs_invalidate_cache(struct afs_vnode *vnode, unsigned int fl
  */
 struct afs_dir_iter {
 	struct afs_vnode	*dvnode;
+	union afs_xdr_dir_block *block;
 	struct folio_queue	*fq;
 	unsigned int		fpos;
 	int			fq_slot;
+	unsigned int		loop_check;
+	u8			nr_slots;
+	u8			bucket;
+	unsigned int		prev_entry;
 };
 
 #include <trace/events/afs.h>
@@ -1065,6 +1070,8 @@ extern const struct address_space_operations afs_dir_aops;
 extern const struct dentry_operations afs_fs_dentry_operations;
 
 ssize_t afs_read_single(struct afs_vnode *dvnode, struct file *file);
+ssize_t afs_read_dir(struct afs_vnode *dvnode, struct file *file)
+	__acquires(&dvnode->validate_lock);
 extern void afs_d_release(struct dentry *);
 extern void afs_check_for_remote_deletion(struct afs_operation *);
 int afs_single_writepages(struct address_space *mapping,
@@ -1080,6 +1087,17 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 				enum afs_edit_dir_reason why);
 void afs_mkdir_init_dir(struct afs_vnode *dvnode, struct afs_vnode *parent_vnode);
 
+/*
+ * dir_search.c
+ */
+unsigned int afs_dir_hash_name(const struct qstr *name);
+bool afs_dir_init_iter(struct afs_dir_iter *iter, const struct qstr *name);
+union afs_xdr_dir_block *afs_dir_find_block(struct afs_dir_iter *iter, size_t block);
+int afs_dir_search_bucket(struct afs_dir_iter *iter, const struct qstr *name,
+			  struct afs_fid *_fid);
+int afs_dir_search(struct afs_vnode *dvnode, struct qstr *name,
+		   struct afs_fid *_fid, afs_dataversion_t *_dir_version);
+
 /*
  * dir_silly.c
  */

