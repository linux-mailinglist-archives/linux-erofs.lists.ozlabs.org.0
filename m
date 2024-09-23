Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2946297ED9D
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 17:08:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XC5wZ1CZ8z2yYf
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 01:08:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727104108;
	cv=none; b=Cx2o1CM0xPuCxasbM3YBo0AJyWGbKdbgJoo6Z2q7E3MQCAC14XabHuuo/APltY8HVi7X8PSHcGWYcQZKTgrKQgCsk478SeS/3VbhvPfui+OwEAMM2xlwTUfRFTsSRZBWWL2G2OeSEvUwLlqsTaMM03s/Q5V3jnpxWpeDU88WlMbHaaANk1yW8sdSo4KCznaTHz2/ID126y3iO3toHJRJBMViwJTBfpMHhPZ8gPBggOV/X78ngA8UP8yB8oqpBYvhPbPZND4YXzWewbotGDVSxO/vhHpR9eop1odUmYpjiaFpO08weApZiHRzKBZGmay1HYGHbCYGQFGeR0dv29KQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727104108; c=relaxed/relaxed;
	bh=UHKFm+zddtgJAu8raP8xj5T/wroKl8vpea/DCvZ5VL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7OixdxAQq77x316/BKLW4+iWDObN3Z8t6nNEe1IYUZKWorlQCi8DzaxV2pqTpi9TC7+KqhxnhXihplb3t5tZ5jUzl20Mkws1cTfupO9KQTH0nkRhEa1bKohn4egEkA9oHxfIrmghA7vlqFjNhPXJqe4nRnvLepJscYbRKF+Pn8Jy6K8cvu93UR0+lGaHKOGS+4jJMIor8JjcIZVf2mK5Hyy5Fk1wd+HjAlezf6BuStUxKwyJZjYn6PqQtqp0VZkEScnnGwJvpKbivD1UqcC3lo6LoS2bZDesq6CjbhygR9OXhv8nugecAJTKHShXRJxWC+AZRsTkHmFDnfidmk9Ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cy5T7kp4; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cy5T7kp4; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cy5T7kp4;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cy5T7kp4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XC5wX1hPZz2xb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 01:08:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHKFm+zddtgJAu8raP8xj5T/wroKl8vpea/DCvZ5VL0=;
	b=Cy5T7kp43j6ZIX0rZTJf/xV3Y4iWo8mFqNR30ZEODUTXef1k+g0I2P6Sio3g6U0LEpZY15
	vC91V/1O52xoupf4nkNJVIb1QsOo0bdp0WvpOlEsfCNt+GNx9aLXMKm7tz00MTvvgyvWqW
	OT1U1EairVBLsGPIu1bUT/Jep08j+J4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHKFm+zddtgJAu8raP8xj5T/wroKl8vpea/DCvZ5VL0=;
	b=Cy5T7kp43j6ZIX0rZTJf/xV3Y4iWo8mFqNR30ZEODUTXef1k+g0I2P6Sio3g6U0LEpZY15
	vC91V/1O52xoupf4nkNJVIb1QsOo0bdp0WvpOlEsfCNt+GNx9aLXMKm7tz00MTvvgyvWqW
	OT1U1EairVBLsGPIu1bUT/Jep08j+J4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-YwYfIXcXPKSEJj725uT1xQ-1; Mon,
 23 Sep 2024 11:08:20 -0400
X-MC-Unique: YwYfIXcXPKSEJj725uT1xQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59BFD18E6A7E;
	Mon, 23 Sep 2024 15:08:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9EE911954190;
	Mon, 23 Sep 2024 15:08:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 1/8] netfs: Fix mtime/ctime update for mmapped writes
Date: Mon, 23 Sep 2024 16:07:45 +0100
Message-ID: <20240923150756.902363-2-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-1-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, kernel test robot <oliver.sang@intel.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The cifs flag CIFS_INO_MODIFIED_ATTR, which indicates that the mtime and
ctime need to be written back on close, got taken over by netfs as
NETFS_ICTX_MODIFIED_ATTR to avoid the need to call a function pointer to
set it.

The flag gets set correctly on buffered writes, but doesn't get set by
netfs_page_mkwrite(), leading to occasional failures in generic/080 and
generic/215.

Fix this by setting the flag in netfs_page_mkwrite().

Fixes: 73425800ac94 ("netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_inode")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409161629.98887b2-oliver.sang@intel.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index d7eae597e54d..b3910dfcb56d 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -552,6 +552,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 		trace_netfs_folio(folio, netfs_folio_trace_mkwrite);
 	netfs_set_group(folio, netfs_group);
 	file_update_time(file);
+	set_bit(NETFS_ICTX_MODIFIED_ATTR, &ictx->flags);
 	if (ictx->ops->post_modify)
 		ictx->ops->post_modify(inode);
 	ret = VM_FAULT_LOCKED;

