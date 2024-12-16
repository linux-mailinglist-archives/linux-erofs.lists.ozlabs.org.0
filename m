Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDD69F3B25
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:43:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBsMx0tFMz30Gm
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 07:43:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734381787;
	cv=none; b=Ps9Sou7xzY1hY4tsGxRXOTENAu3GkurYAOGlRCVj6PB8zFYw7RPm0gG4nevbczS1MspAyING77/LVfQL4Xey5O50X9zioj88GSVp6sWsqC1CdY3ZUKUsjf19ag8EF6cmpzeHQE15L/uQRBMBRXnxenNT/awT1QoUL44M81BY1qKDpLJXEtNlqOShBi3E2kCSUSyye6Jq3PVaaEW3O/Z5VAykUYD5LcwwYECED+Al8l2oWP2ONQ6e0Oi93As9V0EsAsm3At9EmVOMuMxNJg85yCErbXlb8fSxFOTcnJIjbv7gOGB3kmFbYCAYXRnGP4oCrkFCpZQ9VspO+OzaSAQQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734381787; c=relaxed/relaxed;
	bh=MklTcYfvPOLy1NwZc1kfQfg10kbAaSIvx2D4rHXDyWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdRF3RtUAH7SMoLGnFCqg2slUoXsBN+yARRV4r5heWIPUUgQ0Qa9wsgrUyhUV/WTrKQidkGQ1usDWCFWrClt9f0e/Xy7NOlg1CMlijiVHlSFocQQPS1BlmgUz/seDE21EW0+ky0cg0s25wydBl8xNYsrZYHG4WfS8n80QxOO4UnP5Yb7gqbk3ruCD63P+54Rfpm7eIgfaCojYTJvztNGPX42getRmEWfv2kwZ2JLmtlP5m6+diSzN6xSHeYEyGmECFwBivPI2LWFAecjwTDHNBSk/q5+XXqhkaBLuss8aeDyefV42GFG3c8dDbzr/tvya3BWaVtY24pgRpLUnqZxzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=APwkUQjI; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G4cd6Yx+; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=APwkUQjI;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G4cd6Yx+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBsMt4MxPz2y8V
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Dec 2024 07:43:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MklTcYfvPOLy1NwZc1kfQfg10kbAaSIvx2D4rHXDyWY=;
	b=APwkUQjI+ehxAzyCsdPg6QGfT76ab2/AKndZM8Bpf7+ZTNmzXN+acEjgMs9rfYfVOc22rw
	zzgKeTMMKP+ztrYJdXK88vXzcpW1LqsU7YbmmBHV/Jz+uvv5fTV3IniYpAT8Co9lWpzc+A
	G5GzILyA0XS0A8OpvI39fRo6X/OxxRk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MklTcYfvPOLy1NwZc1kfQfg10kbAaSIvx2D4rHXDyWY=;
	b=G4cd6Yx+VtlMXkfbDIdXXeSWly408yjCi7Y+9AV6R/ZjuLt3PrhepknqohL3NLdJ8fhKCe
	ucCou5/oYaQBKT6N853VwoQz97Ji4PkQGlhqSztcF9+ZExpJZRHfHCSXYkMgDanU7+FyTd
	x+D2MBrkNsZqfDe1QjPL2z6MPTvSjrw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-1s12ay6wOs2Tgrvj1-IX_g-1; Mon,
 16 Dec 2024 15:43:00 -0500
X-MC-Unique: 1s12ay6wOs2Tgrvj1-IX_g-1
X-Mimecast-MFC-AGG-ID: 1s12ay6wOs2Tgrvj1-IX_g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D71951956054;
	Mon, 16 Dec 2024 20:42:57 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA7DE19560B0;
	Mon, 16 Dec 2024 20:42:51 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 11/32] afs: Don't use mutex for I/O operation lock
Date: Mon, 16 Dec 2024 20:41:01 +0000
Message-ID: <20241216204124.3752367-12-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

Don't use the standard mutex for the I/O operation lock, but rather
implement our own as the standard mutex must be released in the same thread
as locked it.  This is a problem when it comes to doing async FetchData
where the lock will be dropped from the workqueue that processed the
incoming data and not from the issuing thread.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_operation.c | 111 +++++++++++++++++++++++++++++++++++++++---
 fs/afs/internal.h     |   3 +-
 fs/afs/super.c        |   2 +-
 3 files changed, 108 insertions(+), 8 deletions(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 428721bbe4f6..0175d7a31332 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -49,6 +49,105 @@ struct afs_operation *afs_alloc_operation(struct key *key, struct afs_volume *vo
 	return op;
 }
 
+struct afs_io_locker {
+	struct list_head	link;
+	struct task_struct	*task;
+	unsigned long		have_lock;
+};
+
+/*
+ * Unlock the I/O lock on a vnode.
+ */
+static void afs_unlock_for_io(struct afs_vnode *vnode)
+{
+	struct afs_io_locker *locker;
+
+	spin_lock(&vnode->lock);
+	locker = list_first_entry_or_null(&vnode->io_lock_waiters,
+					  struct afs_io_locker, link);
+	if (locker) {
+		list_del(&locker->link);
+		smp_store_release(&locker->have_lock, 1); /* The unlock barrier. */
+		smp_mb__after_atomic(); /* Store have_lock before task state */
+		wake_up_process(locker->task);
+	} else {
+		clear_bit(AFS_VNODE_IO_LOCK, &vnode->flags);
+	}
+	spin_unlock(&vnode->lock);
+}
+
+/*
+ * Lock the I/O lock on a vnode uninterruptibly.  We can't use an ordinary
+ * mutex as lockdep will complain if we unlock it in the wrong thread.
+ */
+static void afs_lock_for_io(struct afs_vnode *vnode)
+{
+	struct afs_io_locker myself = { .task = current, };
+
+	spin_lock(&vnode->lock);
+
+	if (!test_and_set_bit(AFS_VNODE_IO_LOCK, &vnode->flags)) {
+		spin_unlock(&vnode->lock);
+		return;
+	}
+
+	list_add_tail(&myself.link, &vnode->io_lock_waiters);
+	spin_unlock(&vnode->lock);
+
+	for (;;) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (smp_load_acquire(&myself.have_lock)) /* The lock barrier */
+			break;
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+}
+
+/*
+ * Lock the I/O lock on a vnode interruptibly.  We can't use an ordinary mutex
+ * as lockdep will complain if we unlock it in the wrong thread.
+ */
+static int afs_lock_for_io_interruptible(struct afs_vnode *vnode)
+{
+	struct afs_io_locker myself = { .task = current, };
+	int ret = 0;
+
+	spin_lock(&vnode->lock);
+
+	if (!test_and_set_bit(AFS_VNODE_IO_LOCK, &vnode->flags)) {
+		spin_unlock(&vnode->lock);
+		return 0;
+	}
+
+	list_add_tail(&myself.link, &vnode->io_lock_waiters);
+	spin_unlock(&vnode->lock);
+
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (smp_load_acquire(&myself.have_lock) || /* The lock barrier */
+		    signal_pending(current))
+			break;
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+
+	/* If we got a signal, try to transfer the lock onto the next
+	 * waiter.
+	 */
+	if (unlikely(signal_pending(current))) {
+		spin_lock(&vnode->lock);
+		if (myself.have_lock) {
+			spin_unlock(&vnode->lock);
+			afs_unlock_for_io(vnode);
+		} else {
+			list_del(&myself.link);
+			spin_unlock(&vnode->lock);
+		}
+		ret = -ERESTARTSYS;
+	}
+	return ret;
+}
+
 /*
  * Lock the vnode(s) being operated upon.
  */
@@ -60,7 +159,7 @@ static bool afs_get_io_locks(struct afs_operation *op)
 	_enter("");
 
 	if (op->flags & AFS_OPERATION_UNINTR) {
-		mutex_lock(&vnode->io_lock);
+		afs_lock_for_io(vnode);
 		op->flags |= AFS_OPERATION_LOCK_0;
 		_leave(" = t [1]");
 		return true;
@@ -72,7 +171,7 @@ static bool afs_get_io_locks(struct afs_operation *op)
 	if (vnode2 > vnode)
 		swap(vnode, vnode2);
 
-	if (mutex_lock_interruptible(&vnode->io_lock) < 0) {
+	if (afs_lock_for_io_interruptible(vnode) < 0) {
 		afs_op_set_error(op, -ERESTARTSYS);
 		op->flags |= AFS_OPERATION_STOP;
 		_leave(" = f [I 0]");
@@ -81,10 +180,10 @@ static bool afs_get_io_locks(struct afs_operation *op)
 	op->flags |= AFS_OPERATION_LOCK_0;
 
 	if (vnode2) {
-		if (mutex_lock_interruptible_nested(&vnode2->io_lock, 1) < 0) {
+		if (afs_lock_for_io_interruptible(vnode2) < 0) {
 			afs_op_set_error(op, -ERESTARTSYS);
 			op->flags |= AFS_OPERATION_STOP;
-			mutex_unlock(&vnode->io_lock);
+			afs_unlock_for_io(vnode);
 			op->flags &= ~AFS_OPERATION_LOCK_0;
 			_leave(" = f [I 1]");
 			return false;
@@ -104,9 +203,9 @@ static void afs_drop_io_locks(struct afs_operation *op)
 	_enter("");
 
 	if (op->flags & AFS_OPERATION_LOCK_1)
-		mutex_unlock(&vnode2->io_lock);
+		afs_unlock_for_io(vnode2);
 	if (op->flags & AFS_OPERATION_LOCK_0)
-		mutex_unlock(&vnode->io_lock);
+		afs_unlock_for_io(vnode);
 }
 
 static void afs_prepare_vnode(struct afs_operation *op, struct afs_vnode_param *vp,
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index c9d620175e80..07b8f7083e73 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -702,13 +702,14 @@ struct afs_vnode {
 	struct afs_file_status	status;		/* AFS status info for this file */
 	afs_dataversion_t	invalid_before;	/* Child dentries are invalid before this */
 	struct afs_permits __rcu *permit_cache;	/* cache of permits so far obtained */
-	struct mutex		io_lock;	/* Lock for serialising I/O on this mutex */
+	struct list_head	io_lock_waiters; /* Threads waiting for the I/O lock */
 	struct rw_semaphore	validate_lock;	/* lock for validating this vnode */
 	struct rw_semaphore	rmdir_lock;	/* Lock for rmdir vs sillyrename */
 	struct key		*silly_key;	/* Silly rename key */
 	spinlock_t		wb_lock;	/* lock for wb_keys */
 	spinlock_t		lock;		/* waitqueue/flags lock */
 	unsigned long		flags;
+#define AFS_VNODE_IO_LOCK	0		/* Set if the I/O serialisation lock is held */
 #define AFS_VNODE_UNSET		1		/* set if vnode attributes not yet set */
 #define AFS_VNODE_DIR_VALID	2		/* Set if dir contents are valid */
 #define AFS_VNODE_ZAP_DATA	3		/* set if vnode's data should be invalidated */
diff --git a/fs/afs/super.c b/fs/afs/super.c
index f3ba1c3e72f5..7631302c1984 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -663,7 +663,7 @@ static void afs_i_init_once(void *_vnode)
 
 	memset(vnode, 0, sizeof(*vnode));
 	inode_init_once(&vnode->netfs.inode);
-	mutex_init(&vnode->io_lock);
+	INIT_LIST_HEAD(&vnode->io_lock_waiters);
 	init_rwsem(&vnode->validate_lock);
 	spin_lock_init(&vnode->wb_lock);
 	spin_lock_init(&vnode->lock);

