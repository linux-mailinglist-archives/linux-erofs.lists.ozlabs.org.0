Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB569AE798
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Oct 2024 16:08:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZ77M3b23z3bfS
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 01:08:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729778925;
	cv=none; b=PkYUNSzVcozVtJcmJaeTVuSbn2PcZPiV1osWu0RvwMDwPg0v5tPKo5HiOMUsX1KI6KvbX5T+3zaCbz3Mat1M2POR2bxXhsiXvRWLQHa1j2sDef9mxaw4obpd6rJIDqoPHVgfOzNqIdBTYXuCRup1WVxP2pYCVq9uMztjsWC3cIh63CwoNsI5pVFJ43G7G4G0BJNsgfSILB/mjc9cN1wJp0PLvDMO4SCM4nlENsXEjv/JjJtJhs7eq3szRzR8OKBDsWWeZpskfOlNuOC+unZpW4JoBQRIkNIU/qenhz0ZVQLiETy1s1zrlQffPzKc1XO4eJCfzksAXUZc/hXJbaCifg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729778925; c=relaxed/relaxed;
	bh=u3/1sOVuQqHpfo8UyVSOFEz4LX0EnJcfMGVnlE5mJ3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+4EZbgg7bWFD30nG9ClOPndq9a1ALDspTw6YeZFLTxvuob+h3ALCJl2hshH+8HlX7VgkFYvNf8PxN6DI1fvQ2Sku8rbvVpdtDaGj5kyaMNgGLdZQBDRn5FXsAA6F78nVAlWU8mv70cA7Qb+8lQFHx0wlwgLkgN1BSjjQn2VFg44LHsBLyRi+H1WgiEriasAXZnts6nFhaJNxiPSdyAeoz0ThRBsPwpEiMAlsOkiResRam8vib7UY3bEwlMWW4MClikh2u++FUk6D/qefiqO9i2Vpe1dcePdi9tMmxuhslpjaEEh3v5Kp3lqfFjlBARZy4GQ1yksTnNCiLurBLGpvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P6jLtIXB; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P6jLtIXB; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P6jLtIXB;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P6jLtIXB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZ77J47ldz305n
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Oct 2024 01:08:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3/1sOVuQqHpfo8UyVSOFEz4LX0EnJcfMGVnlE5mJ3g=;
	b=P6jLtIXBDEiiSUep4V/dEnf0Bv+N598UTLBYPYReLO0llf007cAnaxjdML0qw7tYZbsfAF
	g6LFXFvXfEU+ufncHo3j8MBA+xh+EfPGKxFfBy552eZXEWdt+u2uQecy7qO6Ppzi2AaoHS
	m6pzzrPy6/+BqRRgihKddeVI4Dw5Gco=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3/1sOVuQqHpfo8UyVSOFEz4LX0EnJcfMGVnlE5mJ3g=;
	b=P6jLtIXBDEiiSUep4V/dEnf0Bv+N598UTLBYPYReLO0llf007cAnaxjdML0qw7tYZbsfAF
	g6LFXFvXfEU+ufncHo3j8MBA+xh+EfPGKxFfBy552eZXEWdt+u2uQecy7qO6Ppzi2AaoHS
	m6pzzrPy6/+BqRRgihKddeVI4Dw5Gco=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-s2xcwJiqNh2AsSay-NhpDA-1; Thu,
 24 Oct 2024 10:08:35 -0400
X-MC-Unique: s2xcwJiqNh2AsSay-NhpDA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 768DE1955BC7;
	Thu, 24 Oct 2024 14:08:32 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2EBB1955F43;
	Thu, 24 Oct 2024 14:08:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 21/27] afs: Make afs_init_request() get a key if not given a file
Date: Thu, 24 Oct 2024 15:05:19 +0100
Message-ID: <20241024140539.3828093-22-dhowells@redhat.com>
In-Reply-To: <20241024140539.3828093-1-dhowells@redhat.com>
References: <20241024140539.3828093-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

In a future patch, AFS directory caching will go through netfslib and this
will involve, at times, running on behalf of ->lookup(), which doesn't
provide us with a file from which we can get an authentication key.

If a file isn't provided, make afs_init_request() get a key from the
process's keyrings instead when setting up a read.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/file.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index f717168da4ab..a9d98d18407c 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -372,10 +372,26 @@ static int afs_symlink_read_folio(struct file *file, struct folio *folio)
 
 static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
+	struct afs_vnode *vnode = AFS_FS_I(rreq->inode);
+
 	if (file)
 		rreq->netfs_priv = key_get(afs_file_key(file));
 	rreq->rsize = 256 * 1024;
 	rreq->wsize = 256 * 1024 * 1024;
+
+	switch (rreq->origin) {
+	case NETFS_READ_SINGLE:
+		if (!file) {
+			struct key *key = afs_request_key(vnode->volume->cell);
+
+			if (IS_ERR(key))
+				return PTR_ERR(key);
+			rreq->netfs_priv = key;
+		}
+		break;
+	default:
+		break;
+	}
 	return 0;
 }
 

