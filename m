Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D849C22D4
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Nov 2024 18:23:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XlQlD10B2z3c1C
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Nov 2024 04:23:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731086614;
	cv=none; b=CvtqhuvIWBnP7i23J7zkcVtpo48y2vvUGR9ZxHdoNzEF+uELod6dOjmsRSM/OMFV7Kr4vCnydQr8VRLNsHjIPrCwlo7PM3XMseROyCCX33gDqLbzL4zwETg+dzdi7BJshfL2mnIbu3xPBQZWOE/6n2padqaGc6oYvfNGws6tnebEfCLwp7b7cLxMdTA1vlD+lBEwzRBlw75QcOQEm/dfgbZofJ6f/dX9WgjvFaCFas0zMSqgI/78Xof/ahyLPMx9fUB6bHzFnaCsO5d6cA8biyGt2QaX89WkdeQ9+CcYvigww5ORdoSRaBXEJtJfmme1QEsMei+jP9Ba26W42HZPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731086614; c=relaxed/relaxed;
	bh=XwJwM3+z7apLKFV/fpUBCprrM/E8Cp6F04ODxbzFqfw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=G8O7Quib5U4eBMT2WBx8jKDI6xoWREi/dGLkrMe0RdWgjR8rlh7rHkRh3DHc7Q2aOH47BxNjE/chWxRCSMnegQ70of1WnNtAx7nPMyToxn78XXwCdEKmoIJJn0bfbBPmOKxXLQ+cMHWaa3hLW0w+l2cRpUmH7MDyeFBa9t/c/heQM5I7gBhzd7ANVfwE21OdK2hedYkVe/4RFkEbb8NXeHF7GmkaNzqwu0eZacN53GvPkNwJJMj3akRXpuFRvn7i5tPLoJnEpzWFYWyzqL8egbyUZW2KMRMvApZrl/H+c/EW3cuENEfN3xcrrgk6eROnqX4Cx5pNO8UBggaRt6WrGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N2FRIWSa; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N2FRIWSa; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N2FRIWSa;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N2FRIWSa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XlQl92GGTz3btt
	for <linux-erofs@lists.ozlabs.org>; Sat,  9 Nov 2024 04:23:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731086606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwJwM3+z7apLKFV/fpUBCprrM/E8Cp6F04ODxbzFqfw=;
	b=N2FRIWSaQi+G3HvR0bVpVPUkOKSiM9onStV18UwrGGlCiHhZ+HC1QpygZyDwlZfkB9Bft2
	uF8vg0gqyJV8rCmgF6Kv8rNSTSviB+iAQ4c2HKQxv7dmj/j1rO9zHFqyPwH/hRgPy6pJHH
	KZENtEk7N4U7p7VQbSTGOBhLQA/aBLw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731086606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwJwM3+z7apLKFV/fpUBCprrM/E8Cp6F04ODxbzFqfw=;
	b=N2FRIWSaQi+G3HvR0bVpVPUkOKSiM9onStV18UwrGGlCiHhZ+HC1QpygZyDwlZfkB9Bft2
	uF8vg0gqyJV8rCmgF6Kv8rNSTSviB+iAQ4c2HKQxv7dmj/j1rO9zHFqyPwH/hRgPy6pJHH
	KZENtEk7N4U7p7VQbSTGOBhLQA/aBLw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-jwRKCGCpNXimF2m3kjGVAg-1; Fri,
 08 Nov 2024 12:23:21 -0500
X-MC-Unique: jwRKCGCpNXimF2m3kjGVAg-1
X-Mimecast-MFC-AGG-ID: jwRKCGCpNXimF2m3kjGVAg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E948D195F198;
	Fri,  8 Nov 2024 17:23:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64CE21953882;
	Fri,  8 Nov 2024 17:23:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-24-dhowells@redhat.com>
References: <20241106123559.724888-24-dhowells@redhat.com> <20241106123559.724888-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 23/33] afs: Use netfslib for directories
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1360666.1731086590.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Nov 2024 17:23:10 +0000
Message-ID: <1360667.1731086590@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The attached fix needs folding in across this patch (23), patch 24, patch
29 and patch 31.

David
---
commit 9d4429bc7bb3f2b518d6decd1ca0e99e4d80d58e
Author: David Howells <dhowells@redhat.com>
Date:   Thu Nov 7 23:46:48 2024 +0000

    afs: Fix handling of signals during readdir
    =

    When a directory is being read, whether or not the dvnode->directory b=
uffer
    pointer is NULL is used to track whether we've checked fscache yet.
    However, if a signal occurs after the buffer being allocated but whils=
t
    we're doing the read, we may end up in an invalid state with ->directo=
ry
    set but no data in the buffer.
    =

    In this state, afs_readdir(), afs_lookup() and afs_d_revalidate() see
    corrupt directory contents leading to a variety of malfunctions.
    =

    Fix this by providing a specific flag to record whether or not we've
    performed a read yet - and, incidentally, sampled fscache - rather tha=
n
    using the value in ->directory instead.
    =

    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Marc Dionne <marc.dionne@auristor.com>
    cc: linux-afs@lists.infradead.org

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 663a212964d8..b6a202fd9926 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -323,7 +323,7 @@ ssize_t afs_read_dir(struct afs_vnode *dvnode, struct =
file *file)
 	 * haven't read it yet.
 	 */
 	if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) &&
-	    dvnode->directory) {
+	    test_bit(AFS_VNODE_DIR_READ, &dvnode->flags)) {
 		ret =3D i_size;
 		goto valid;
 	}
@@ -336,7 +336,7 @@ ssize_t afs_read_dir(struct afs_vnode *dvnode, struct =
file *file)
 		afs_invalidate_cache(dvnode, 0);
 =

 	if (!test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) ||
-	    !dvnode->directory) {
+	    !test_bit(AFS_VNODE_DIR_READ, &dvnode->flags)) {
 		trace_afs_reload_dir(dvnode);
 		ret =3D afs_read_single(dvnode, file);
 		if (ret < 0)
@@ -345,6 +345,7 @@ ssize_t afs_read_dir(struct afs_vnode *dvnode, struct =
file *file)
 		// TODO: Trim excess pages
 =

 		set_bit(AFS_VNODE_DIR_VALID, &dvnode->flags);
+		set_bit(AFS_VNODE_DIR_READ, &dvnode->flags);
 	} else {
 		ret =3D i_size;
 	}
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index f6f4b1adc8dc..60a549f1d9c5 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -644,4 +644,5 @@ void afs_mkdir_init_dir(struct afs_vnode *dvnode, stru=
ct afs_vnode *parent_dvnod
 =

 	netfs_single_mark_inode_dirty(&dvnode->netfs.inode);
 	set_bit(AFS_VNODE_DIR_VALID, &dvnode->flags);
+	set_bit(AFS_VNODE_DIR_READ, &dvnode->flags);
 }
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index f5618564b3fc..e9538e91f848 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -39,6 +39,7 @@ void afs_init_new_symlink(struct afs_vnode *vnode, struc=
t afs_operation *op)
 	p =3D kmap_local_folio(folioq_folio(vnode->directory, 0), 0);
 	memcpy(p, op->create.symlink, size);
 	kunmap_local(p);
+	set_bit(AFS_VNODE_DIR_READ, &vnode->flags);
 	netfs_single_mark_inode_dirty(&vnode->netfs.inode);
 }
 =

@@ -60,12 +61,12 @@ const char *afs_get_link(struct dentry *dentry, struct=
 inode *inode,
 =

 	if (!dentry) {
 		/* RCU pathwalk. */
-		if (!vnode->directory || !afs_check_validity(vnode))
+		if (!test_bit(AFS_VNODE_DIR_READ, &vnode->flags) || !afs_check_validity=
(vnode))
 			return ERR_PTR(-ECHILD);
 		goto good;
 	}
 =

-	if (!vnode->directory)
+	if (test_bit(AFS_VNODE_DIR_READ, &vnode->flags))
 		goto fetch;
 =

 	ret =3D afs_validate(vnode, NULL);
@@ -73,13 +74,14 @@ const char *afs_get_link(struct dentry *dentry, struct=
 inode *inode,
 		return ERR_PTR(ret);
 =

 	if (!test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags) &&
-	    vnode->directory)
+	    test_bit(AFS_VNODE_DIR_READ, &vnode->flags))
 		goto good;
 =

 fetch:
 	ret =3D afs_read_single(vnode, NULL);
 	if (ret < 0)
 		return ERR_PTR(ret);
+	set_bit(AFS_VNODE_DIR_READ, &vnode->flags);
 =

 good:
 	folio =3D folioq_folio(vnode->directory, 0);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a5da0dd8e9cc..90f407774a9a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -705,6 +705,7 @@ struct afs_vnode {
 #define AFS_VNODE_NEW_CONTENT	8		/* Set if file has new content (create/t=
runc-0) */
 #define AFS_VNODE_SILLY_DELETED	9		/* Set if file has been silly-deleted =
*/
 #define AFS_VNODE_MODIFYING	10		/* Set if we're performing a modification=
 op */
+#define AFS_VNODE_DIR_READ	11		/* Set if we've read a dir's contents */
 =

 	struct folio_queue	*directory;	/* Directory contents */
 	struct list_head	wb_keys;	/* List of keys available for writeback */

