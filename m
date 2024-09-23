Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A42FF97EDA3
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 17:08:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XC5wz4l1bz2yYK
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 01:08:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727104129;
	cv=none; b=hHoDDK4AkW5Gux3hdwfgwwd4qL0ZE+TQmhflInoP6IAN+whTNbNZcz4zhzaubWfMH877aCuJ5vJhmA9RPiXDxgIuQcIcgDTBf2lbnaxgYFyLxYiJYqZyvLslb+vcX5K7IbsO3dcKC+UZ9jEyOBkKDePSTZJ56p8DMlV9uQWqcvXRI5KAacsJIUaPKEyBSqB4TNUyOKnZybdd5dl5Vx5+6M7OQp2NnS1A94TfTcLW88U62x3gkKqa7QvGiO8GdFuJQIijplE4cAjfeZ3rb5v8mcQX7TK3iFqtk4fpp+EB/HEk/Y5pPJK2T03rQS887YJnv37fzY5HfFnMiHA3dScnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727104129; c=relaxed/relaxed;
	bh=3lKiHWTaBx3zx8IjGF1i+IbwHetAMo/Hx9i4LC4nBI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1kCh6FQaZzLoCV+rIavtU0vJVd3ttCatlHMK8R5+TLyuUnPZyp8olTy+d6T/9uqW74B2CiD7JdJfNwOx8j7ymyVTE1wrcwGgmMGbDjlgUjB6gOS534F+j7CX1xpug7qaZmwTX5rUFus1XJThWY045zkOS9PVnadMMWQsECoRcdmagbPXl5XySLzxvUuZadShtKIzRzHSuk6ZsCeVs/pDRc+rcxpterPer0RZUlxZpuxgYFfzpMHhBvOg6EUz/ltvW7Bvl8/AkspFUXvb7Lm0OC1himPB56L+WyYkihqw7E3C9bGY1INHWCrIhemj/deCFb2ARne9x2ypNEJpR0Wog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fsf5hCz+; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fsf5hCz+; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fsf5hCz+;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fsf5hCz+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XC5ww5TYcz2yPq
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 01:08:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lKiHWTaBx3zx8IjGF1i+IbwHetAMo/Hx9i4LC4nBI4=;
	b=fsf5hCz+3BHRr1WVXiOxEM6jVTMKARH7mxTfClSdyAQHMWwLkd/rpJTd9RBISWfqaWeRVU
	qyiiMhWyz7BI/er1iinIZMH9o/g48qnv5crucZK2EutdTzNgNcMazHwdUXsOCKKtzZ6gDI
	9xqYXwSDK1jeMU/ZF1ulKuO4WJeEVWQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lKiHWTaBx3zx8IjGF1i+IbwHetAMo/Hx9i4LC4nBI4=;
	b=fsf5hCz+3BHRr1WVXiOxEM6jVTMKARH7mxTfClSdyAQHMWwLkd/rpJTd9RBISWfqaWeRVU
	qyiiMhWyz7BI/er1iinIZMH9o/g48qnv5crucZK2EutdTzNgNcMazHwdUXsOCKKtzZ6gDI
	9xqYXwSDK1jeMU/ZF1ulKuO4WJeEVWQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-Odl9lH7FPeeRz2-0q0JfvA-1; Mon,
 23 Sep 2024 11:08:42 -0400
X-MC-Unique: Odl9lH7FPeeRz2-0q0JfvA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 059CD18BC605;
	Mon, 23 Sep 2024 15:08:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51FD51977026;
	Mon, 23 Sep 2024 15:08:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 5/8] afs: Fix possible infinite loop with unresponsive servers
Date: Mon, 23 Sep 2024 16:07:49 +0100
Message-ID: <20240923150756.902363-6-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-1-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com>
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Markus Suvanto <markus.suvanto@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Marc Dionne <marc.dionne@auristor.com>

A return code of 0 from afs_wait_for_one_fs_probe is an indication
that the endpoint state attached to the operation is stale and has
been superseded.  In that case the iteration needs to be restarted
so that the newer probe result state gets used.

Failure to do so can result in an tight infinite loop around the
iterate_address label, where all addresses are thought to be responsive
and have been tried, with nothing to refresh the endpoint state.

Fixes: 495f2ae9e355 ("afs: Fix fileserver rotation")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: https://lists.infradead.org/pipermail/linux-afs/2024-July/008628.html
cc: linux-afs@lists.infradead.org
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240906134019.131553-1-marc.dionne@auristor.com/
---
 fs/afs/fs_probe.c |  4 ++--
 fs/afs/rotate.c   | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 580de4adaaf6..b516d05b0fef 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -506,10 +506,10 @@ int afs_wait_for_one_fs_probe(struct afs_server *server, struct afs_endpoint_sta
 	finish_wait(&server->probe_wq, &wait);
 
 dont_wait:
-	if (estate->responsive_set & ~exclude)
-		return 1;
 	if (test_bit(AFS_ESTATE_SUPERSEDED, &estate->flags))
 		return 0;
+	if (estate->responsive_set & ~exclude)
+		return 1;
 	if (is_intr && signal_pending(current))
 		return -ERESTARTSYS;
 	if (timo == 0)
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index ed09d4d4c211..d612983d6f38 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -632,8 +632,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 wait_for_more_probe_results:
 	error = afs_wait_for_one_fs_probe(op->server, op->estate, op->addr_tried,
 					  !(op->flags & AFS_OPERATION_UNINTR));
-	if (!error)
+	if (error == 1)
 		goto iterate_address;
+	if (!error)
+		goto restart_from_beginning;
 
 	/* We've now had a failure to respond on all of a server's addresses -
 	 * immediately probe them again and consider retrying the server.
@@ -644,10 +646,13 @@ bool afs_select_fileserver(struct afs_operation *op)
 		error = afs_wait_for_one_fs_probe(op->server, op->estate, op->addr_tried,
 						  !(op->flags & AFS_OPERATION_UNINTR));
 		switch (error) {
-		case 0:
+		case 1:
 			op->flags &= ~AFS_OPERATION_RETRY_SERVER;
-			trace_afs_rotate(op, afs_rotate_trace_retry_server, 0);
+			trace_afs_rotate(op, afs_rotate_trace_retry_server, 1);
 			goto retry_server;
+		case 0:
+			trace_afs_rotate(op, afs_rotate_trace_retry_server, 0);
+			goto restart_from_beginning;
 		case -ERESTARTSYS:
 			afs_op_set_error(op, error);
 			goto failed;

