Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D9B9F0DC1
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 14:51:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8rN73GdSz3bZf
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 00:51:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734097877;
	cv=none; b=ObFPU4cGZK2X9fJZukoMqyi7IJpeTOHTqdMx6/zuBSfuNjaqIVqt9mdasPfG47xhF2yJen3DhEH9ThmaDYeZWxbaI547eE4Ftfx5rOAGUdEkxE+6rXqiJ5TkAP4I9KVGpTZh1lD/k6jvivLeJlUkHj6kN1FpHTj9Xt7sPe3aeo+zxKCRjZKhcOKwtBxA1rtB8fyP3NztiSbUJTSqD9gQac2bBnAuw9QuOCKG1JEzkPNwJ7rhxM8IGUlDI2eipiPVgkbaccJjJS+y1qNkgxiN+w1XcfZeZsqV3/jN8TERgQcAXVj8fowq9yOuASqvXk00riuAat/u6T8cqRdOyMCCog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734097877; c=relaxed/relaxed;
	bh=Iv9WM7D/h/d7OTq2M7QoeqOwEbcTnPmdrMlMHFXuPOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwmbVGrMfpjKFoF6gZTfEuCHAgR8aG+hbMoyHnmsRPKWv0pFL1HnNCKGkAXXABiS/q/ZQUSy6dNkSTc+EIuMati9ZYM8+TOiU29/6tqIBTYtWj4gN+9Fm3LmHOyaCnPGl+gyeDzR+rxWDJzLcDmob8oke9rwz65hkoMNfCvi58E6su28TGyymHeF8Hhwlli/8yCy/dPiLnMN3UZ+cVu+XzfE8Q641s4epssmCzotTkdtQhyZI7wXfWj0H0Tjuda9IDLHMoB+iuC/sRDZCors3SbmmWCxJaIIP3Q15bFb6o8r6FpQez9cgDTYDFE9sXqlFwd469Znm16C20Q143JSUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ua5JPQVZ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ua5JPQVZ; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ua5JPQVZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ua5JPQVZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8rN42qKZz3bTN
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Dec 2024 00:51:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iv9WM7D/h/d7OTq2M7QoeqOwEbcTnPmdrMlMHFXuPOU=;
	b=Ua5JPQVZ31HIxUGetiUzlknSomTKT7tJ3/3VaolcdGPQc/qi4yks9qfta8XyprOUDj+KRT
	Wci7TYMv8UX289imu3eaeiSyYd1kDJ7EOdzJ+dJCCut/Y39Y+OWHhMH9IBAx71k+w6+xQy
	hy9qvaggxNYnBZdi0gZxrAgmYEr2XXk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iv9WM7D/h/d7OTq2M7QoeqOwEbcTnPmdrMlMHFXuPOU=;
	b=Ua5JPQVZ31HIxUGetiUzlknSomTKT7tJ3/3VaolcdGPQc/qi4yks9qfta8XyprOUDj+KRT
	Wci7TYMv8UX289imu3eaeiSyYd1kDJ7EOdzJ+dJCCut/Y39Y+OWHhMH9IBAx71k+w6+xQy
	hy9qvaggxNYnBZdi0gZxrAgmYEr2XXk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-Z0u6tnJ2N66YU4thKkuufg-1; Fri,
 13 Dec 2024 08:51:11 -0500
X-MC-Unique: Z0u6tnJ2N66YU4thKkuufg-1
X-Mimecast-MFC-AGG-ID: Z0u6tnJ2N66YU4thKkuufg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4184F1956089;
	Fri, 13 Dec 2024 13:51:08 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E5001956086;
	Fri, 13 Dec 2024 13:51:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 07/10] netfs: Fix missing barriers by using clear_and_wake_up_bit()
Date: Fri, 13 Dec 2024 13:50:07 +0000
Message-ID: <20241213135013.2964079-8-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
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
Cc: linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, Akira Yokosawa <akiyks@gmail.com>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, ceph-devel@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use clear_and_wake_up_bit() rather than something like:

	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);

as there needs to be a barrier inserted between which is present in
clear_and_wake_up_bit().

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Zilin Guan <zilin@seu.edu.cn>
cc: Akira Yokosawa <akiyks@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c  | 3 +--
 fs/netfs/write_collect.c | 9 +++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index b415e3972336..46ce3b7adf07 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -379,8 +379,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq)
 	task_io_account_read(rreq->transferred);
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_wake_ip);
-	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
+	clear_and_wake_up_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
 	netfs_clear_subrequests(rreq, false);
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 1d438be2e1b4..82290c92ba7a 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -501,8 +501,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 		goto need_retry;
 	if ((notes & MADE_PROGRESS) && test_bit(NETFS_RREQ_PAUSE, &wreq->flags)) {
 		trace_netfs_rreq(wreq, netfs_rreq_trace_unpause);
-		clear_bit_unlock(NETFS_RREQ_PAUSE, &wreq->flags);
-		wake_up_bit(&wreq->flags, NETFS_RREQ_PAUSE);
+		clear_and_wake_up_bit(NETFS_RREQ_PAUSE, &wreq->flags);
 	}
 
 	if (notes & NEED_REASSESS) {
@@ -605,8 +604,7 @@ void netfs_write_collection_worker(struct work_struct *work)
 
 	_debug("finished");
 	trace_netfs_rreq(wreq, netfs_rreq_trace_wake_ip);
-	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
-	wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
+	clear_and_wake_up_bit(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
 
 	if (wreq->iocb) {
 		size_t written = min(wreq->transferred, wreq->len);
@@ -714,8 +712,7 @@ void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
 
-	clear_bit_unlock(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-	wake_up_bit(&subreq->flags, NETFS_SREQ_IN_PROGRESS);
+	clear_and_wake_up_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 
 	/* If we are at the head of the queue, wake up the collector,
 	 * transferring a ref to it if we were the ones to do so.

