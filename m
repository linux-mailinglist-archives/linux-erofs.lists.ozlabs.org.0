Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE495D70D
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 22:08:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WrB3W2Ntzz304B
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 06:08:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724443733;
	cv=none; b=CMGhbWrh0Vrwoan1Jq14HuHI2oX/oETveMtX5IpxsTIKg2wyO1xpaeGIuTAGaU24RvXecu/ov6osuoZbXCuI/A2Z7dkLLattOw7hhNIKmhagHxZmIkSmFi4kx6XawJuT+f7CVyvFR0AuNwhie+TQqXHrQUhX0SSI2iLOt7zKrB4/vB/SxrxqfjW2EQAlxPtLhr5iLrFP9bx5Snuyu1dm1Nl6qWVrogfOR9sNZP58rEiuwwPPQ+vrGMHHpNlJaJg7vc6DygQG57MaMCzMYFkHUhuJqrEveDhdxFzgKEAHKiJ7RUBZdjW6XOcCAryKVvwVQuOVyJNDMZ8R6hhYN4R64A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724443733; c=relaxed/relaxed;
	bh=LLNXobqu9Lr51n4CzgcItZvbbRppxWdYVF89daxGYJk=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=RCq7DM7vMsl+M36IHqHgpFjd3WIEj/U9JmVARXCPx6ZFH7Iw2o7DUoifjUeIf9N9oPzIJ9jC9gioQeNdw0UAEzIttS/4K+TdVXarfplDqnKPsCQKw0wjXdU0V8pQPCiuUf7iPDTdt6PuwqcvRRzd7whbT8Mfaf+asq4q7PHHAtveEyWh3Y2A8W0hDnwGqJ6UFe1Rh0nHA3PyOx62zSqVtAhqcWKqpdLL8/ntAR061hciiXTFdGZOeTC1MJsv1CgvZdKkBxAp6O2GExNhuRszrzke+dfIhzlv6VDd9VQtfvvekEUPh6sSE0nOEFfQzb6pSc6XRCDfqH+sJzwzHXYrig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N440LJsG; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ISqPTdQS; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N440LJsG;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ISqPTdQS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WrB3T09brz2xZj
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 06:08:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLNXobqu9Lr51n4CzgcItZvbbRppxWdYVF89daxGYJk=;
	b=N440LJsGGOY/B2U51BAAmYfpFknVsyB5eK+wBVN0rwORqx3SLRefS4Cpvl173FcwPTElHG
	nZdW5Chy5M74mxR9XOVQXOYYFPxwGC4w2ucpgg8b98wCJl6n87dFPUou9Rk6c6+oU1nZuI
	xTtfVSTK7vTmk1IOAhbNldZy49KwHp8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLNXobqu9Lr51n4CzgcItZvbbRppxWdYVF89daxGYJk=;
	b=ISqPTdQS48YLnhgpEnwONrCYBaClmgpCC/qOr9NPUcGt2nclAc0xY1klVdL0x9EaTq2LlL
	dnNCMGr9pVtPg5pSGFfbweClzECnh527uYunmWA4CVUvRFPbTOoso5FxFmVr/LlmEuUW6n
	lDZNAq2xNB1ehtjOGr5bBPkyP0Y4YvA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-xMba_EeYPL-FTD2gDob40w-1; Fri,
 23 Aug 2024 16:08:44 -0400
X-MC-Unique: xMba_EeYPL-FTD2gDob40w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96CB019560AD;
	Fri, 23 Aug 2024 20:08:40 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE7901955E8C;
	Fri, 23 Aug 2024 20:08:35 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 2/9] afs: Fix post-setattr file edit to do truncation correctly
Date: Fri, 23 Aug 2024 21:08:10 +0100
Message-ID: <20240823200819.532106-3-dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, Paulo Alcantara <pc@manguebit.com>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

At the end of an kAFS RPC operation, there is an "edit" phase (originally
intended for post-directory modification ops to edit the local image) that
the setattr VFS op uses to fix up the pagecache if the RPC that requested
truncation of a file was successful.

afs_setattr_edit_file() calls truncate_setsize() which sets i_size, expands
the pagecache if needed and truncates the pagecache.  The first two of
those, however, are redundant as they've already been done by
afs_setattr_success() under the io_lock and the first is also done under
the callback lock (cb_lock).

Fix afs_setattr_edit_file() to call truncate_pagecache() instead (which is
called by truncate_setsize(), thereby skipping the redundant parts.

Fixes: 100ccd18bb41 ("netfs: Optimise away reads above the point at which there can be no data")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Pankaj Raghav <p.raghav@samsung.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/inode.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 3acf5e050072..a95e77670b49 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -695,13 +695,18 @@ static void afs_setattr_edit_file(struct afs_operation *op)
 {
 	struct afs_vnode_param *vp = &op->file[0];
 	struct afs_vnode *vnode = vp->vnode;
+	struct inode *inode = &vnode->netfs.inode;
 
 	if (op->setattr.attr->ia_valid & ATTR_SIZE) {
 		loff_t size = op->setattr.attr->ia_size;
-		loff_t i_size = op->setattr.old_i_size;
+		loff_t old = op->setattr.old_i_size;
+
+		/* Note: inode->i_size was updated by afs_apply_status() inside
+		 * the I/O and callback locks.
+		 */
 
-		if (size != i_size) {
-			truncate_setsize(&vnode->netfs.inode, size);
+		if (size != old) {
+			truncate_pagecache(inode, size);
 			netfs_resize_file(&vnode->netfs, size, true);
 			fscache_resize_cookie(afs_vnode_cache(vnode), size);
 		}

