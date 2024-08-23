Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2645695D2A9
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 18:12:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wr4q417vYz302P
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 02:12:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724429566;
	cv=none; b=FBrSYi5lGuKlky/4sh53r1NmgaCKgnC57NQKCq46Znyip03Nfanh6i/wkTiKBlj2WRrnjt34ZOSIz8YiqygrHOPJFJND2jqz1fkF5VaV+fXK1BVy7y9ggjbRWJr2u6LDpbHiwYWTVbYgkYtpIuoA6xO02vSkzoTynUlBiob7DBynVCwBPFLnxUZsJzkSIASJgr7YUTBHui95QPdp0A7BeryYGgCeRRim4rdeG02RmfxwtdnKndjAjbcU9iqEdfPb3rGOnHc06+4KTkd1KEF4oOnpBsvCpud2+DXhN/mdJNEhqFyhFIgEb5FEa8/Wr5kb1cFiXXgwIxXklcpcG/GqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724429566; c=relaxed/relaxed;
	bh=UF1dQkOHc38/CxHdvA+HTnp1kknbAHEKTFkwj9qcOQo=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=ZXfLB3Z3++7RdPbzuNZTYqVrIXxbA9alOZQPWDIKVlGVAd7G76SLj+a0T5K6gEahLBFG/GQo1/IxAdDz02UyMtVzB6mo4IrEL63J9n4aO+FsNpQwTglL+YV0ezrxF6vV8MsxkhfiOVzAApfRlH0kxyk46j0NP4NO9eKqOxKMGniKO4QmsGNPwBDyRZKRPx/sA7dcKasA4GK628zpKmHOnbm0DkchoTOFGbEirTU+aFl62pLJ9Mja0YnFuo4aulyVY+cZVRUDjm/b8W2rqtIvGru2Abp8zjgsTvGzbOGS8Hd/3kHSUy7guvGtotXxDIXkEIbUi7wFsJmOId20y/NL3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B4jNADsy; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B4jNADsy; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B4jNADsy;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B4jNADsy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wr4q14ZF1z2yh1
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 02:12:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UF1dQkOHc38/CxHdvA+HTnp1kknbAHEKTFkwj9qcOQo=;
	b=B4jNADsyyUT10rwVOUheZYf9TMziINehSlVUcl2UlTxjqBFP4fELN2WWHDintqE0DXdhk3
	6reXGxbWXoPSUBTSHKMYI3N9Zm9uCLMf07FNM1kLyy2SWnLDLXeIBUlVQYDhT0/YfsF5kK
	oYqqhPIn9Thg2mnHkT4d5YcWqBzWYpY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UF1dQkOHc38/CxHdvA+HTnp1kknbAHEKTFkwj9qcOQo=;
	b=B4jNADsyyUT10rwVOUheZYf9TMziINehSlVUcl2UlTxjqBFP4fELN2WWHDintqE0DXdhk3
	6reXGxbWXoPSUBTSHKMYI3N9Zm9uCLMf07FNM1kLyy2SWnLDLXeIBUlVQYDhT0/YfsF5kK
	oYqqhPIn9Thg2mnHkT4d5YcWqBzWYpY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-8smGqBV2N5OacPwQdgxAmQ-1; Fri,
 23 Aug 2024 12:12:39 -0400
X-MC-Unique: 8smGqBV2N5OacPwQdgxAmQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 571C51955D4E;
	Fri, 23 Aug 2024 16:12:36 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11C6819560AA;
	Fri, 23 Aug 2024 16:12:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 3/5] netfs: Fix missing iterator reset on retry of short read
Date: Fri, 23 Aug 2024 17:12:04 +0100
Message-ID: <20240823161209.434705-4-dhowells@redhat.com>
In-Reply-To: <20240823161209.434705-1-dhowells@redhat.com>
References: <20240823161209.434705-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Steve French <sfrench@samba.org>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Paulo Alcantara <pc@manguebit.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix netfs_rreq_perform_resubmissions() to reset before retrying a short
read, otherwise the wrong part of the output buffer will be used.

Fixes: 92b6cc5d1e7c ("netfs: Add iov_iters to (sub)requests to describe various buffers")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 605b667fe3a6..d6ada4eba744 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -315,6 +315,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 			netfs_read_from_server(rreq, subreq);
 		} else if (test_bit(NETFS_SREQ_SHORT_IO, &subreq->flags)) {
 			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
+			netfs_reset_subreq_iter(rreq, subreq);
 			netfs_rreq_short_read(rreq, subreq);
 		}
 	}

