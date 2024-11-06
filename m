Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC719BE9F4
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 13:39:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xk4Wy4pt7z3bdV
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 23:39:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730896749;
	cv=none; b=gm2UI0he5afB4ph/jounI6dr5w3+MtU5tjT9l3MdzjKGERcfBe418j+jPVk3IzHb28Og3DLXvG03S2lp/eVY3IX5tpXlYaHX/ZGXD34m86pOvW/xhFc4Z7dnR7La9yeVKj4Y0hB20GFxO1PDg+lPnv8hjGvRw9y7msbxoKvwTAxr4MJg5YBonlqPfvloXNKqiykn/MNQ0p0ioohKELlFlDwrfBK3mW5uW7EDOeimgnnVisNqXfgjN2NsYTphkWyV+iRwWy+bDEsBCjHJJGkNBDy1rp/n4Wu5FoUdYV59XF5ZrbvBmvP+4b0Pk2zBkq9Yh75wdB/9XKZ+umvz/yZKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730896749; c=relaxed/relaxed;
	bh=u3/1sOVuQqHpfo8UyVSOFEz4LX0EnJcfMGVnlE5mJ3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iouvLuUcG/fTx96iewo4aWmU4WBWYx3o7hWK21N4jv9XEbwcgjfS83hzpHHCfW7Hh1Cdu3J4kmWBERYZXzBnzqE9vYtzG/te7U/Z/A/40blH5fGocJi6Aqwcdv92c/JXJBSqNyziDHkWGDtsyOZb8WoAq+GU5rZ8LBIYbyuhzrCrNd7DLnL5ZW+OIvaPdwFNoKPZq2yQLAP1+XDZs7KoEfNx99t9nbNRe/UpY8HI6MwfmU2Be2vfrgZJe0svf4ssRulJPZVUELHMiR1zzlu+vFC+S2jNMv3WAn9EdksFOhojIiEesYrB3zV9RVFhaB4wrZqF1wk6AvKVNaIBwfBjtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UhRLgZpb; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eq8SZeeE; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UhRLgZpb;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eq8SZeeE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xk4Ww0wGwz301w
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Nov 2024 23:39:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3/1sOVuQqHpfo8UyVSOFEz4LX0EnJcfMGVnlE5mJ3g=;
	b=UhRLgZpbGKNfQjSkcgOPa93WaauMq4tg8AoR39m75SfznzAxiyvhYaF4RJ9pIF1pMoEaYV
	dba+ZegntTD/5OIy3UOULHnGUqlzqKMcM9WEcSMnq8hwyeHm8o9aau1RTXQEgJF85g4CPS
	1n9Q0sN3HCx2RjrViSccM20DxGjrmjo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3/1sOVuQqHpfo8UyVSOFEz4LX0EnJcfMGVnlE5mJ3g=;
	b=eq8SZeeE4ZK6U+qmQyR/c10e94eYxpbt5dHdz9a4CmrssCoe3ZExy8zqKOyypCWuJVsff9
	5GSzha9dW/5OVR13wO27MxvvFJKJS7mIFOkZ1B/Y1TPr4Eo6NnY6HpDy815ZqDJhqgj9xM
	/hdl7FCxUvkEN4UtHzse2ToJXXZwRfc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-zIalLRNpOfSaC24x3As0zw-1; Wed,
 06 Nov 2024 07:38:58 -0500
X-MC-Unique: zIalLRNpOfSaC24x3As0zw-1
X-Mimecast-MFC-AGG-ID: zIalLRNpOfSaC24x3As0zw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26C951955D50;
	Wed,  6 Nov 2024 12:38:54 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9BB6119541A5;
	Wed,  6 Nov 2024 12:38:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 22/33] afs: Make afs_init_request() get a key if not given a file
Date: Wed,  6 Nov 2024 12:35:46 +0000
Message-ID: <20241106123559.724888-23-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
 

