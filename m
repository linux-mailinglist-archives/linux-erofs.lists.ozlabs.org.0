Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B429B100A
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 22:42:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZvpk03Lbz3bqM
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Oct 2024 07:42:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729888924;
	cv=none; b=I7BYdimywfZCnwv8g1QkN03q3csmhmDYV/twRbfBM7zRphCp5PcXROhlVvW5cFexGPezl/Lg8Ja0n2s+y96JEmX8daZ/fCBL4TxnKT9bF2fvWg+wR+5R1q9tQJNV66aH0XLhr9nOHO4cOkOgGxR2zqN20ilHOglRubtTqL89/0dBS75wnG8QzFQem5pHWtMkHc3Ls+Gg/kZFgRBz9PfSNhGf2zitaraU1OiGTn8CLyDxEwqaTLpO9tWqT5SqNdPrU7kUeByIB6vQEDwbWg9FWnTC6DDMIT0kNOKwF3t3+hBD0UNShjXxOi1NdbQl1EtMEMffvTaKmy7lx0lGzxO9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729888924; c=relaxed/relaxed;
	bh=HO1trrAUxh6ged928OSrE9rZIbGVfYli8k1F5yQtGbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPNp++F6+IHJ2BgWlXpn1tDHeZcL9FFmpEr6WOv0h3jhl2WZ6IwgyqBTCqnYochfv08sAt3XJZMOirrbcuytWm2fohyy9nWT0RBU6KPuC/QxaAr/HOVo5xWWuH3U3Gv5dKFbprJYYQBOREiPi0XnJ/WRt2VuUnfPNl9y4qla7BQNM2J8w+xwqU/f/MgxKc0ue4Hj1uQGaO+loBf3rfxKS8xjd2s9u3+bKGXyA4UZTR4fgVKXYAODFvszOORWq/mhxMco2mD5nrY67fqDkVtM7FO8fYB9+F2wyMyNgBf1he55aZWoMBqcjxj/OP+p568fQZUpFaDxKrJQmb905xwGQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fz8mU1wq; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MgbL4f+B; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fz8mU1wq;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MgbL4f+B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZvpg4Vrvz3bjk
	for <linux-erofs@lists.ozlabs.org>; Sat, 26 Oct 2024 07:42:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729888920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HO1trrAUxh6ged928OSrE9rZIbGVfYli8k1F5yQtGbY=;
	b=fz8mU1wq3QeLpYt48ouIjIYe4df88E/hwAloSzcF7oSWSbDsLBDukwqLK/95ynDI4rVrAE
	6hdgVpp46hvIEaOajUFwVHHk0PWTePJ+UHa7Pq2kCIZm72E9Mr7cBnYXIU0v4WPykZYb2X
	+VPIzTuWxlgeMRMot5WWRoBURwdvrus=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729888921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HO1trrAUxh6ged928OSrE9rZIbGVfYli8k1F5yQtGbY=;
	b=MgbL4f+BXpK9ieWJJI6KDgnEhsKt/xAJAjYluZ9//K0ZLbM62BDxHKuodxICMjv7fyc9hS
	fIQxicM6HkpQSKtEFC5J47I5dgzUmuBx0/EJKIneVfuJVXdayUfm9VS4RLmwWn2OFkLkco
	S6yfmsL+bwBLnZww2rYEFsNuhHUNxtc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-2-4fzlHMNnKbyI7I-IjOzQ-1; Fri,
 25 Oct 2024 16:41:57 -0400
X-MC-Unique: 2-4fzlHMNnKbyI7I-IjOzQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AF4E1955F3F;
	Fri, 25 Oct 2024 20:41:54 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65AA219560A2;
	Fri, 25 Oct 2024 20:41:49 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 14/31] afs: Fix directory format encoding struct
Date: Fri, 25 Oct 2024 21:39:41 +0100
Message-ID: <20241025204008.4076565-15-dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-1-dhowells@redhat.com>
References: <20241025204008.4076565-1-dhowells@redhat.com>
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
 

