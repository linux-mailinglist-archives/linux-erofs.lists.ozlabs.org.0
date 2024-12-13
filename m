Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 054F89F0DBF
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 14:51:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8rN308qFz3bV3
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 00:51:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734097873;
	cv=none; b=d0luPEG2SGJ57pi0nSgR667ub2VgAFF5BQ2gxtaCfQCjmaN416j068rpi/BwFUzLhkjRobtPLIqSF7HDB1ytGth5OJVDzdwBcEwCo9TLM4ebgjDsgnx/B9nPoC0u07SYSpWsVrfWAC2xK95fqzWC/HVQyyUAhMOtBRP2JMDbtNq/kKQUn5zZsiXa4BigRH16p8xNNyL/F213o8djoBG4ZRkY8arfeeCN0Tsa0kYeW1t2ra6/CteXHKmnsSc8czKwVi5nPbzwIQBaemCbNYTp2ENsFwtnVRDAQVJt1t6mcpodT9iJSa7zzkTA4WTHcOIExE8v00DYCWuChtKRrD5Ilw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734097873; c=relaxed/relaxed;
	bh=dahqI5gLkGfD05TuY+PqQn3pxJDwXGZGfLY3MOFYgVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntLreza+or5RMzZ9AN0f8NCDm5dhjDNhBuhAPUtnZ0CRxbjaD3mx/Vbnii0CgtN5JGiwE0KlTTuQXi1YEt9HANVSpHzKlNwT8mjOSRFq4+tWPf+ped2vp2KoSn1tX10Y43G5NDQPJxTCOS8vaMoLgPfXxpTDKzIaOkU6KEVQAjbksinrfYLfIAdkztVigQtndlDIeIyo6uVNvmvLtRNICXUC5Q7G8aVJtofyKj3mjvQhcgRVjypD9c5yqrXpDTMLgxp3Ak1HoyNAEy9iOjgPgjkb+6RilLPCgjBEBimmTJS3iYbaPgZdWhHVd1WAU9Dsc8MOMRGklOgJr/dv3/UoEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Opmb7oMZ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QsdFJSrj; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Opmb7oMZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QsdFJSrj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8rN03Rlnz30gv
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Dec 2024 00:51:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dahqI5gLkGfD05TuY+PqQn3pxJDwXGZGfLY3MOFYgVE=;
	b=Opmb7oMZAhU19zFew4Q9s26TEEmklbZ5TZuYFqxDphnYwpLHeZXyUlUyScVyHcke6r3zbL
	VHWOeS36i2WmfsHH/Bx0ky0XZ28jnIWBIa4wJbLZ0+IUMlhvv0Xlq2eIkTeHfKiJc9gm0D
	u8KznsG5+25p0n4DvHaG3V2MMw6MUYk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dahqI5gLkGfD05TuY+PqQn3pxJDwXGZGfLY3MOFYgVE=;
	b=QsdFJSrjz+rGTV1af2bY3rJaIsnUiu5ZeD0Dpu31sxH+5W+i9AKSvHcWDuPW7iAD9TglC+
	F/qTnG801wmcITyxs0UR4aMVxif3JivYf8u6x+pVduO3mICFMVlVTY2v2vxxVClBqVYHca
	mcfP885DwYKcJ5kwM+TLwWM8u6JB3hQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-NQm--YxLM0SK64NOpZx29g-1; Fri,
 13 Dec 2024 08:51:06 -0500
X-MC-Unique: NQm--YxLM0SK64NOpZx29g-1
X-Mimecast-MFC-AGG-ID: NQm--YxLM0SK64NOpZx29g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E4CD19560B5;
	Fri, 13 Dec 2024 13:51:02 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 058071955F40;
	Fri, 13 Dec 2024 13:50:56 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 06/10] netfs: Remove redundant use of smp_rmb()
Date: Fri, 13 Dec 2024 13:50:06 +0000
Message-ID: <20241213135013.2964079-7-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

From: Zilin Guan <zilin@seu.edu.cn>

The function netfs_unbuffered_write_iter_locked() in
fs/netfs/direct_write.c contains an unnecessary smp_rmb() call after
wait_on_bit(). Since wait_on_bit() already incorporates a memory barrier
that ensures the flag update is visible before the function returns, the
smp_rmb() provides no additional benefit and incurs unnecessary overhead.

This patch removes the redundant barrier to simplify and optimize the code.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Akira Yokosawa <akiyks@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20241207021952.2978530-1-zilin@seu.edu.cn/
---
 fs/netfs/direct_write.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 88f2adfab75e..173e8b5e6a93 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -104,7 +104,6 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		trace_netfs_rreq(wreq, netfs_rreq_trace_wait_ip);
 		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
 			    TASK_UNINTERRUPTIBLE);
-		smp_rmb(); /* Read error/transferred after RIP flag */
 		ret = wreq->error;
 		if (ret == 0) {
 			ret = wreq->transferred;

