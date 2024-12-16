Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FA39F3AE4
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:35:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBsBj0B6Rz30PH
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 07:35:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734381307;
	cv=none; b=ORxy6pMOXWAgkOb4Vmge4CfCeS65ADiqbtlNoNt2bgG1TGoMoYHkA9tB16UXXMlRjJxWzJ9UsODKKFAzQGo5MqKdcNxHtsWthiVj6tI+pJbVSVsVfPT0igYXUHVPo70nqyitCaBJ6sXdRXrMel411jBLF/4Nq1yKQOiu8v7pk5b7zKZOlZsJIDZa0pTv5mEIsnJjPbakrnPhnlyv7ORr7d0kfRZECtBVVZAZ8cXtQqdYcoVixIoLIzs9XdjpbzdnH0EXusOWfAqo6pV9LBx8pcUFk9i1nx4LZFuGT/EJivjSHGs56O5LOIUnh9S3oOCvo/37LE79EEG5xXqyzRFgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734381307; c=relaxed/relaxed;
	bh=3uel8b3F42MjWx1FV4MNqrLkM5e1s0/oyCwTXY7gJWI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=HymUi+WUPPvZkWVEkZiVuvBG7EDe0r7IAiz1d6HK5o8lgjA9i26IWzxE6DO9mJOdFXdWWYi50cjDUxwcKup6AeEzHCUJP/rd4wHZretJK7/6vDMgz2v4YHmfJ0i0FWz2NSr74OfeGBaybGxEeygUHlC6HWXaJULlph9SVBd3gvOXE1otQ8qya1ZxXNRqCnLxnA8yPsjZqmZbW4UPwyPvKo6Y2N3rCEilj9FxK7gRgxUN/hfBe1ri3s42htgktjTVcv7VNIQard0qL0+WVYKsMtvs9ykBpznT2D3mqzlHQtBnDsZNyA3lE7qk+FTBk+nKyIwc3xR90iLFnWMuy/v1DA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nf+agUPJ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iN/V5SFi; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nf+agUPJ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iN/V5SFi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBsBf3338z2yh2
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Dec 2024 07:35:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uel8b3F42MjWx1FV4MNqrLkM5e1s0/oyCwTXY7gJWI=;
	b=Nf+agUPJsqDviwGD4epPEcSKSGM6TiF1BgYs6ppn+34gpoKVqKj83PSCTF4qhD8JN0n1Ot
	o03Zly60VqUckNAOJe9vtvq0T3cQLNAKfowa/aolK8qzAyQLm/qY2KDBCREMzrwu++dupB
	1bzbI4olAbKkDX8fr7fHEBzCVOumPEo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uel8b3F42MjWx1FV4MNqrLkM5e1s0/oyCwTXY7gJWI=;
	b=iN/V5SFi/5FJPNqGpJNqYTySpYg3aW5c3CfTQ3t4agKTFNPdbgv7SX6Jsg1EcSJ3XUV+do
	5QwsUP0Q8XvYTiUQ8fXK+jk+l/PTSm/VggDDW9Tg9sL+PHbzltnItzdc0+z7uMqPw0WNmi
	+wu6NNKL+bT2A33H+5745Fqb8Ro582E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-PLpJV9waPvq0rsK0CpjcQA-1; Mon,
 16 Dec 2024 15:34:55 -0500
X-MC-Unique: PLpJV9waPvq0rsK0CpjcQA-1
X-Mimecast-MFC-AGG-ID: PLpJV9waPvq0rsK0CpjcQA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B245219560A3;
	Mon, 16 Dec 2024 20:34:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A88819560A2;
	Mon, 16 Dec 2024 20:34:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 11/10] netfs: Fix is-caching check in read-retry
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3752047.1734381285.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Dec 2024 20:34:45 +0000
Message-ID: <3752048.1734381285@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
Cc: linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-mm@kvack.org, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

netfs: Fix is-caching check in read-retry

The read-retry code checks the NETFS_RREQ_COPY_TO_CACHE flag to determine
if there might be failed reads from the cache that need turning into reads
from the server, with the intention of skipping the complicated part if it
can.  The code that set the flag, however, got lost during the read-side
rewrite.

Fix the check to see if the cache_resources are valid instead.  The flag
can then be removed.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_retry.c |    2 +-
 include/linux/netfs.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 0e72e9226fc8..21b4a54e545e 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -49,7 +49,7 @@ static void netfs_retry_read_subrequests(struct netfs_io=
_request *rreq)
 	 * up to the first permanently failed one.
 	 */
 	if (!rreq->netfs_ops->prepare_read &&
-	    !test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags)) {
+	    !rreq->cache_resources.ops) {
 		struct netfs_io_subrequest *subreq;
 =

 		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 4083d77e3f39..ecdd5ced16a8 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -269,7 +269,6 @@ struct netfs_io_request {
 	size_t			prev_donated;	/* Fallback for subreq->prev_donated */
 	refcount_t		ref;
 	unsigned long		flags;
-#define NETFS_RREQ_COPY_TO_CACHE	1	/* Need to write to the cache */
 #define NETFS_RREQ_NO_UNLOCK_FOLIO	2	/* Don't unlock no_unlock_folio on c=
ompletion */
 #define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on com=
pletion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */

