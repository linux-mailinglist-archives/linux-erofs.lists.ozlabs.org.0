Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7629AE789
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Oct 2024 16:07:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZ76M5sTkz3bdW
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 01:07:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729778874;
	cv=none; b=UcIm0yEeTeUnYA7c+cD1lSOlbHziI21CNQ+VcYLUfFaU6HecPJLkkFc2WLJ7ebwXvU0RZLYSBDjFS1tA3ZdptLphP8bxhuNvznKSskxcvasGamjzKfp2Ceju5BjmTrkHzQvPEd2FJF8qaIcA1zXFhXQ4XNoFj9YHbeyREmcWJdjkpAuNGVSnZxe6DU7JiwxcbZrdYPZYZ6mURRRHcD5Mfi0bxOoFA9tgjILFACZZH4ul02t1WjAodMnmqeS8OZ5H88vip+eHvqy0e1Z4qtBUWIZC2NpxhAktMm5JwbPP9qYXOKss/0SiPZcnjrGWOikACLKTKo0reFoEUIqu3h5ePA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729778874; c=relaxed/relaxed;
	bh=HO1trrAUxh6ged928OSrE9rZIbGVfYli8k1F5yQtGbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjBkiFzz3NK3Ii4K8rJuS6Dx7KgWl4FoIuAHOMkZaimdFWEkpWT/g7h6tEVyf2Sl7WeQrZf9uRFplgYjabi27Rzqyk9LTrA0E+5qUJg9L59MWZMEDjU7/sdWt+2ag2DADBeIj6WhbQWyPnun/RGBTYwvfuwUKSAdzI3a27erjXoaSX4Oj1IzT5COa+RMYxae5SeoAzeq8cH5Eo5iN8f3zZ6kfuhPnTQyUQ5Ozi6KMNPyoJfK57JYIoaWKKTfU7gm2wTv0kYK5pYjACMUMxVhCKbWtr/DuFH+2H3VvwSxzg/4R1soxNlm/q0BtynDDVfgKpc9aiGOUsm6hEpNQG062A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZmGfUiGE; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZmGfUiGE; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZmGfUiGE;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZmGfUiGE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZ76K0Bwrz2ysv
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Oct 2024 01:07:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HO1trrAUxh6ged928OSrE9rZIbGVfYli8k1F5yQtGbY=;
	b=ZmGfUiGE3osQRFxnP4aD3akb2ZoZzWJlvY0t36uuaRPEwNvYlzzljRYGsrvU8WTYw1HIlK
	+YAF7y2fUUa9q6n/7hlhqrgo2Nzvk1tXQNhPn6dVGg2i4zIeqoFefEhgQjhTqzaq86QQb+
	XJGJg1jMGI6vSYHIHdx2mB3AixnVd6Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HO1trrAUxh6ged928OSrE9rZIbGVfYli8k1F5yQtGbY=;
	b=ZmGfUiGE3osQRFxnP4aD3akb2ZoZzWJlvY0t36uuaRPEwNvYlzzljRYGsrvU8WTYw1HIlK
	+YAF7y2fUUa9q6n/7hlhqrgo2Nzvk1tXQNhPn6dVGg2i4zIeqoFefEhgQjhTqzaq86QQb+
	XJGJg1jMGI6vSYHIHdx2mB3AixnVd6Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-aBdfNAsnOIKNO2ip9a3iKg-1; Thu,
 24 Oct 2024 10:07:46 -0400
X-MC-Unique: aBdfNAsnOIKNO2ip9a3iKg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53E881955F3B;
	Thu, 24 Oct 2024 14:07:42 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C784219560A2;
	Thu, 24 Oct 2024 14:07:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 14/27] afs: Fix directory format encoding struct
Date: Thu, 24 Oct 2024 15:05:12 +0100
Message-ID: <20241024140539.3828093-15-dhowells@redhat.com>
In-Reply-To: <20241024140539.3828093-1-dhowells@redhat.com>
References: <20241024140539.3828093-1-dhowells@redhat.com>
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

The AFS directory format structure, union afs_xdr_dir_block::meta, has too
many alloc counter slots declared and so pushes the hash table along and
over the data.  This doesn't cause a problem at the moment because I'm
currently ignoring the hash table and only using the correct number of
alloc_ctrs in the code anyway.  In future, however, I should start using
the hash table to try and speed up afs_lookup().

Fix this by using the correct constant to declare the counter array.

Fixes: 4ea219a839bf ("afs: Split the directory content defs into a header")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/xdr_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/xdr_fs.h b/fs/afs/xdr_fs.h
index 8ca868164507..cc5f143d21a3 100644
--- a/fs/afs/xdr_fs.h
+++ b/fs/afs/xdr_fs.h
@@ -88,7 +88,7 @@ union afs_xdr_dir_block {
 
 	struct {
 		struct afs_xdr_dir_hdr	hdr;
-		u8			alloc_ctrs[AFS_DIR_MAX_BLOCKS];
+		u8			alloc_ctrs[AFS_DIR_BLOCKS_WITH_CTR];
 		__be16			hashtable[AFS_DIR_HASHTBL_SIZE];
 	} meta;
 

