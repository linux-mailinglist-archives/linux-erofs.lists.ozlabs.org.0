Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CD19F0DC8
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 14:51:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8rNV73tmz3bWy
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 00:51:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734097897;
	cv=none; b=WRPX4UUrYiNadq0BSU8qlY/oGDNKF5bGbNCV7BFYDppc0MEFTSBnzvdLJw84Fiddgp+8w1WEE5PvqjgPAadHaWrj4z4/519q/svVadhpBQykskEXfZrLsXdjydE6aTYOgUdgvZFY432hkOCkahUM+n99mxLAHegRG/RKNEyIHqjWK5+lov2+MCqCmMfJk80ZcvEMMb82u6F+snlqrQ5jARizHnlQUYWhFoR2JYgylfRtxLHxDd6xzDmNpvWi8EO4QBejnZwIS+MKGFkGOoNyXYigx/4RikmG9297tkgsXdeBghOcQ7iuz//RSx/Y40eAYQ6KsbnKBKASNgXo+dh/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734097897; c=relaxed/relaxed;
	bh=L1v5Uahl/uBNImxZaUKZS5taSNKrtxd0nK3bDl+BkV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvQiEw/GKRYjGpDeV8X2vT6hmgiys1UsjlgsKg3CeUkRrSESmZ5R6sCeBgo/IwA+2QrdttyhETeoe8knQ75HZbh6Ff8CZQW2r9lkwgXeikqVYgzZNooach1B3l7Eyezdd2YZBM/ZzTSBRn+t6mWI95R+oQaAoQ7m9VW0fpMLVIUQh1BSu6VzLy+On8qbqATGW6r7naQ/oCc4Gn9euppIafc/Ln0Fo93ldxQ22bsjcpCxN2DKnQYXUBuarevaXWEGKCDfzp6IaFrh9BhDDONpgvkgQaLfvJkq9KrMdkXiHtyv7axLY0zYFKdMDqZ3reQFYc5MtP7aIdxJocAF6M1BJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G1cDJn6k; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G1cDJn6k; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G1cDJn6k;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G1cDJn6k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8rNS4dxCz30gv
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Dec 2024 00:51:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1v5Uahl/uBNImxZaUKZS5taSNKrtxd0nK3bDl+BkV8=;
	b=G1cDJn6krI7uV0VxWKt9P4fG13NJ41fR8WR1MOycZtdGzalDlWBtXVTNw/365zDWJ1eW9H
	tdJF0n4vfgIX5nkiZjjyfPHw+afQvI2u99nOgOH6kDYj3WwkUr6hGwMhmcqXgPtugt6zNE
	tHYCrgLog5S3/A42oZvwMBJ3R4eyb9Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1v5Uahl/uBNImxZaUKZS5taSNKrtxd0nK3bDl+BkV8=;
	b=G1cDJn6krI7uV0VxWKt9P4fG13NJ41fR8WR1MOycZtdGzalDlWBtXVTNw/365zDWJ1eW9H
	tdJF0n4vfgIX5nkiZjjyfPHw+afQvI2u99nOgOH6kDYj3WwkUr6hGwMhmcqXgPtugt6zNE
	tHYCrgLog5S3/A42oZvwMBJ3R4eyb9Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-iuxIXFenMlSlR7jWS7DojA-1; Fri,
 13 Dec 2024 08:51:30 -0500
X-MC-Unique: iuxIXFenMlSlR7jWS7DojA-1
X-Mimecast-MFC-AGG-ID: iuxIXFenMlSlR7jWS7DojA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 059B41955F08;
	Fri, 13 Dec 2024 13:51:28 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 056F31956086;
	Fri, 13 Dec 2024 13:51:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 10/10] netfs: Fix the (non-)cancellation of copy when cache is temporarily disabled
Date: Fri, 13 Dec 2024 13:50:10 +0000
Message-ID: <20241213135013.2964079-11-dhowells@redhat.com>
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
Cc: linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When the caching for a cookie is temporarily disabled (e.g. due to a DIO
write on that file), future copying to the cache for that file is disabled
until all fds open on that file are closed.  However, if netfslib is using
the deprecated PG_private_2 method (such as is currently used by ceph), and
decides it wants to copy to the cache, netfs_advance_write() will just bail
at the first check seeing that the cache stream is unavailable, and
indicate that it dealt with all the content.

This means that we have no subrequests to provide notifications to drive
the state machine or even to pin the request and the request just gets
discarded, leaving the folios with PG_private_2 set.

Fix this by jumping directly to cancel the request if the cache is not
available.  That way, we don't remove mark3 from the folio_queue list and
netfs_pgpriv2_cancel() will clean up the folios.

This was found by running the generic/013 xfstest against ceph with an
active cache and the "-o fsc" option passed to ceph.  That would usually
hang

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Closes: https://lore.kernel.org/r/CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_pgpriv2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index ba5af89d37fa..54d5004fec18 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -170,6 +170,10 @@ void netfs_pgpriv2_write_to_the_cache(struct netfs_io_request *rreq)
 
 	trace_netfs_write(wreq, netfs_write_trace_copy_to_cache);
 	netfs_stat(&netfs_n_wh_copy_to_cache);
+	if (!wreq->io_streams[1].avail) {
+		netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
+		goto couldnt_start;
+	}
 
 	for (;;) {
 		error = netfs_pgpriv2_copy_folio(wreq, folio);

