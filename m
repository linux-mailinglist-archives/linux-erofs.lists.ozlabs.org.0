Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF3397EDA1
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 17:08:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XC5wv1Zhwz2yVX
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 01:08:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727104124;
	cv=none; b=jyZP/xi/9PsWlGmjPJRV78DIg/GncRs/fnH7XkVfpxB8spXJsBkhEevfECmoS77VN5/ydzCI7iV8g5rlW0LifOsVh5dNcspHXRolJSTl3rbAP6aj0EtsT0CM2rgisfL34wmq7rExmBDLzU2e+z0hukXLQVtqeFfiBa+6446B3il3btjAOigqZffJ3FEIGpTY6ZjA34yiFmBAMdsCsJXDqJOkvzEyOjDWW0a1ZC78E62eZnE+I4+1YT3i3Ta0rs4EX9lOxceGajwS3jPzcQdOnRE0AXAWivIw5RGBooWjgwPMfk+3UFAYetDDGjCq8tT6mzPgK+qTxUFpkWIPv4LR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727104124; c=relaxed/relaxed;
	bh=7sJs50CQB1rXW7Czy4aIaKRpcUNrb/d4a0miNhatVWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrbXGCajy/N6WBgssKJGSnBkVuzsU/gQCo5FQAmjPw6p8zcn+PSqrZvEJ48pWyawitge7gHSfJ99rjbEW7zAjv0yvfgCRR92LoDC8W4QtBCEAk3HvfZNoyrvXz7fbpfbvAbvjc1RkQrWXUHESQntIYYORt8blGlVJaGEzZvjXRzpgee2jLcKvfZxcY/fKmMZfZNOuNLyjhv+u7qS6GVW5wOj32YnENCjxGAUd7jGw9TQFYi+qgxDsUimz9/sqPTP2HyfttGkrghT//Z8AqujNtgwjrUeLjzir7tBIrRIXeOSjd3fB2gyms6K4lTHoBJGLzAK8vd63dl7YOX19asQ5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LQ8fZjP9; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LQ8fZjP9; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LQ8fZjP9;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LQ8fZjP9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XC5wr39JHz2xg3
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 01:08:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sJs50CQB1rXW7Czy4aIaKRpcUNrb/d4a0miNhatVWk=;
	b=LQ8fZjP9fU0DElz2zVVzmbY+3+Ii4Fk2gnE2pkFu6OU/FY1RIH35R78tgMiZmngWeVYpU+
	EAviQP1q2lU3oM7nwFmoZIkRxjMvEvOioYxeDNpiY5Ltv1uM+/OnIBV1b4VBFsDrotEdxE
	tZVH4SBzax4ABFZpwCaSpt3tHvBoJy0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sJs50CQB1rXW7Czy4aIaKRpcUNrb/d4a0miNhatVWk=;
	b=LQ8fZjP9fU0DElz2zVVzmbY+3+Ii4Fk2gnE2pkFu6OU/FY1RIH35R78tgMiZmngWeVYpU+
	EAviQP1q2lU3oM7nwFmoZIkRxjMvEvOioYxeDNpiY5Ltv1uM+/OnIBV1b4VBFsDrotEdxE
	tZVH4SBzax4ABFZpwCaSpt3tHvBoJy0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-MvVAiCEgPwSeBw7yfVwWvA-1; Mon,
 23 Sep 2024 11:08:39 -0400
X-MC-Unique: MvVAiCEgPwSeBw7yfVwWvA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4E23195FE03;
	Mon, 23 Sep 2024 15:08:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C252F1954190;
	Mon, 23 Sep 2024 15:08:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 3/8] afs: Fix missing wire-up of afs_retry_request()
Date: Mon, 23 Sep 2024 16:07:47 +0100
Message-ID: <20240923150756.902363-4-dhowells@redhat.com>
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, "Dr. David Alan Gilbert" <linux@treblig.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

afs_retry_request() is supposed to be pointed to by the afs_req_ops netfs
operations table, but the pointer got lost somewhere.  The function is used
during writeback to rotate through the authentication keys that were in
force when the file was modified locally.

Fix this by adding the pointer to the function.

Fixes: 1ecb146f7cd8 ("netfs, afs: Use writeback retry to deal with alternate keys")
Reported-by: "Dr. David Alan Gilbert" <linux@treblig.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 1d30924cec5b..f717168da4ab 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -425,6 +425,7 @@ const struct netfs_request_ops afs_req_ops = {
 	.begin_writeback	= afs_begin_writeback,
 	.prepare_write		= afs_prepare_write,
 	.issue_write		= afs_issue_write,
+	.retry_request		= afs_retry_request,
 };
 
 static void afs_add_open_mmap(struct afs_vnode *vnode)

