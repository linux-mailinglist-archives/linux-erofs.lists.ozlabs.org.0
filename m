Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320AA96336D
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 23:03:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WvH2h1lV8z2yqB
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 07:03:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724879034;
	cv=none; b=f7EMAYXMO1swjYjJ5ya6MHOwkR7TtYUlG7hinZRqJd9tPPtEcSwZgqaWXg5baoOLZ1Tb8TpvyOyd4NXeyxtCw674uzWX/acDEVTORy2/NGKv9r/JuVMPmHVGMnZZdrzgaOqZzo0Bz3FPN629ttvOSfnVsBo9K90In9m5zGL0HpbnMIVbhOOIw8i/uY53Lz8+/EMOu5HYOH1rCxy16/DwmXoKRr1tb9mDmYp3eD6YK6dvf+btXgaIHx28WcB5l5PTZ0j/SwxnDuxkX6Jm0+FRGO7UItb3vt/lPBNyRuhYd1fLVHK7xVVSYmEI3F8zueqiyGb/A9gEwfbe7xebGrMzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724879034; c=relaxed/relaxed;
	bh=HnRbucMY226i4IUYHJiuv+7kBNxjZEs05bItUy7sjXs=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=nB0RJQz+v7zT10TIaBbIY12tDhjQTOgsseGRNsIdFXkKhbfAVCzjmFxeeXpZ1W+DA2vb9RFUCQFZ6bAjjIO7Ff3aER4J/Az2j3yds7i9MUcrWECwE8Zt+mXZ8TwXs0aiyor74yL5MCzCOirjwT2gf4eKoXycnE6VfextxHhWKRJiB2gvagLu7l5fUu75CDE8LDgI3sjeIKprVREyeizNn0j5IbmOJji2tsS582IsCo27KGPdxzrY0Bi4EwNIhh7CjU2Rj9PXVxNWLwAanVDzQmYhwWMUXzUsni6AFAQ/KSVzpwBJQnpP0KH83qIuU8r4qR6XBu5DvinK1bYw71gFLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=REgv7IQR; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FdFsD6mk; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=REgv7IQR;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FdFsD6mk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WvH2d6mDFz2y8X
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 07:03:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724879030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HnRbucMY226i4IUYHJiuv+7kBNxjZEs05bItUy7sjXs=;
	b=REgv7IQR0dZOkBay5uqUMA+aoN7jimvi7JXLWm6KZVqRHEu628UwOXFM3xQaHFaWux4Hx5
	SOdGGpqAeYpzq77PsVe2MW6OxFR+zjrQPFOkocPPln2RmxbIM6Mzw7Qo0HaOXqJGy/5I12
	ekiGzf8xSPc77/tecm2rikHEdkbKbSY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724879031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HnRbucMY226i4IUYHJiuv+7kBNxjZEs05bItUy7sjXs=;
	b=FdFsD6mkDlI5bNwRuuHD9c8KrPQY6bsbj40L58YPSnHc72Uey/H22OifjX1iy1s4k1JTZD
	3pGE+xnHW7M4x9grBi4gi7OvcI97J0YAdPkHTkI5WNiKWjHmKnqXBH88AyoLVMdcVShbLg
	DQioft5FYuin9RCqxJMoBDXS9mmO3EI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-iAIpNcUkPheyG0CeJjFQ_w-1; Wed,
 28 Aug 2024 17:03:45 -0400
X-MC-Unique: iAIpNcUkPheyG0CeJjFQ_w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 010F11955BF1;
	Wed, 28 Aug 2024 21:03:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B35C1955BF2;
	Wed, 28 Aug 2024 21:03:38 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 6/6] netfs, cifs: Improve some debugging bits
Date: Wed, 28 Aug 2024 22:02:47 +0100
Message-ID: <20240828210249.1078637-7-dhowells@redhat.com>
In-Reply-To: <20240828210249.1078637-1-dhowells@redhat.com>
References: <20240828210249.1078637-1-dhowells@redhat.com>
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-cifs@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
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
index 4df84ebe8dbe..e6540072ffb0 100644
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
 

