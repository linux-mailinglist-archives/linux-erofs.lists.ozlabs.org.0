Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FED95D71F
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 22:09:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WrB4L3pyxz303B
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 06:09:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724443777;
	cv=none; b=Sv1VIgkxJtcVgcrlExp9Dxbkkq8+REW4I3ro3sdRr1pZ8qHcjiEohucIa63Zm/C4ymwtm0PsEp85nTKI4oaYvxEfm1Q3Zr6g5hTmfb9W8MsSMzUr+7qNAJX/+gbAyWAsiz4VwlM0bYgfOggzaWV9NMMEPggi/nKPIsYl4HqE2BoemjuXeJr6nzWmtQnLaXlxUK8Uc9rJJRFtWQiOTGHZT4b5MPtHioR20RZEs9f87eKU3JNmXHQkgXmKPYXnXAuuDIrCB1hkUwx54ZdEaXDv8gfpc9qI7ctrUlysyhgPFqiM5Wkna/N/3Cc7YiEZnurVtVQeg+i29tfKE7sbcmAmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724443777; c=relaxed/relaxed;
	bh=FAmCIU0bJDpl8o1iuVK4ffMXJRGL1l5OGSxq2KqoTWQ=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=kBnEUbFe7VXlq90yTUFUFxI1OAQjOYLra/zKjNpWsxCERKa2Y8cxtVq0kVFYz4sYKGVcvlf3WqLjZUmf2q+Fdbf1EP61FiQEgUbME0Gw+I0quRYn1nK9U1wbi25omLr/Hq2G4/6isTVHwHflnYJcRAO/MPLO4n0I9eYJDHi/Zh3GGq4brHzaueysBhzE/aX+lxsYUCw9U7MdAG+m4yuqAZq0tqbqQ/WU4xKHooMhitmniDnv7h9t0zFC6lkE5Ck1olaRly+FZJc8Nc/+SEgf2k8cBzuzihnADnmxYA2tSsP1Lx/yPX96MTA+lg5xQ0lVLnJge8ES8ppBC5BE/e0IoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YuQdKWKG; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YuQdKWKG; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YuQdKWKG;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YuQdKWKG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WrB4J50MKz2xFq
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 06:09:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAmCIU0bJDpl8o1iuVK4ffMXJRGL1l5OGSxq2KqoTWQ=;
	b=YuQdKWKG0k8hMnRWQTFN3ba/R3SxPfVySpNNlpJa//rf4U16Sk2XCvh4Yq5svJF8e0ealG
	5LlLyYEO1DsvJmKLrsJEsCwmGStGySmlM97X5wlMlhgB6t8BVv4/SOxzWskWC9pkVXU9Fs
	+OxgbBulX3xNXeZsd4UssiZVkczLe1w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAmCIU0bJDpl8o1iuVK4ffMXJRGL1l5OGSxq2KqoTWQ=;
	b=YuQdKWKG0k8hMnRWQTFN3ba/R3SxPfVySpNNlpJa//rf4U16Sk2XCvh4Yq5svJF8e0ealG
	5LlLyYEO1DsvJmKLrsJEsCwmGStGySmlM97X5wlMlhgB6t8BVv4/SOxzWskWC9pkVXU9Fs
	+OxgbBulX3xNXeZsd4UssiZVkczLe1w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-Dvwmp2x-PPyrCItiYsUPfQ-1; Fri,
 23 Aug 2024 16:09:29 -0400
X-MC-Unique: Dvwmp2x-PPyrCItiYsUPfQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AD3B19560B7;
	Fri, 23 Aug 2024 20:09:27 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDBE11956053;
	Fri, 23 Aug 2024 20:09:17 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 9/9] netfs, cifs: Improve some debugging bits
Date: Fri, 23 Aug 2024 21:08:17 +0100
Message-ID: <20240823200819.532106-10-dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, Paulo Alcantara <pc@manguebit.com>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Improve some debugging bits:

 (1) The netfslib _debug() macro doesn't need a newline in its format
     string.

 (2) Display the request debug ID and subrequest index in messages emitted
     in smb2_adjust_credits() to make it easier to reference in traces.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/io.c           | 2 +-
 fs/smb/client/smb2ops.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 943128507af5..d6ada4eba744 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -270,7 +270,7 @@ static void netfs_reset_subreq_iter(struct netfs_io_request *rreq,
 	if (count == remaining)
 		return;
 
-	_debug("R=%08x[%u] ITER RESUB-MISMATCH %zx != %zx-%zx-%llx %x\n",
+	_debug("R=%08x[%u] ITER RESUB-MISMATCH %zx != %zx-%zx-%llx %x",
 	       rreq->debug_id, subreq->debug_index,
 	       iov_iter_count(&subreq->io_iter), subreq->transferred,
 	       subreq->len, rreq->i_size,
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 8fb68c47c218..2741f7d63fe7 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -316,7 +316,8 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 				      cifs_trace_rw_credits_no_adjust_up);
 		trace_smb3_too_many_credits(server->CurrentMid,
 				server->conn_id, server->hostname, 0, credits->value - new_val, 0);
-		cifs_server_dbg(VFS, "request has less credits (%d) than required (%d)",
+		cifs_server_dbg(VFS, "R=%x[%x] request has less credits (%d) than required (%d)",
+				subreq->rreq->debug_id, subreq->subreq.debug_index,
 				credits->value, new_val);
 
 		return -EOPNOTSUPP;
@@ -338,8 +339,9 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 		trace_smb3_reconnect_detected(server->CurrentMid,
 			server->conn_id, server->hostname, scredits,
 			credits->value - new_val, in_flight);
-		cifs_server_dbg(VFS, "trying to return %d credits to old session\n",
-			 credits->value - new_val);
+		cifs_server_dbg(VFS, "R=%x[%x] trying to return %d credits to old session\n",
+				subreq->rreq->debug_id, subreq->subreq.debug_index,
+				credits->value - new_val);
 		return -EAGAIN;
 	}
 

