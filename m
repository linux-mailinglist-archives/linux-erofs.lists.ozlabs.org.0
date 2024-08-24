Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D8795DDA8
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 13:57:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wrb5m4YqWz2yGv
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 21:57:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724500631;
	cv=none; b=ilGRCqrDPfxlaVyrBpruB2ari2BzeBEAKUhpNrm+74If4D2GSYUK2ob+CvYXMg+Ki6xpvs5hSr2iFvD5ssG3oW0kckXGxruc5zLkTiEQNnlbMNf1Wm/uDq71oRP1VtaUWEYrrkyrUiETewBNmfYSbHexhnUR4IVEdBvZYAQb/6OPx4UKbQp/87GKAd8ptTxhWnCq/C4MDaZsj5hG1z9oqLpKrIsgZTYvIwZGAQPKgNe24KK2ZuqQmybSvnObANV7f+fzpMTEqKVWYrcSMGxKtqm9qmwpN2ShoQac1OW8dLlSSR0bQa2QaKCJXyxWpfM0cjMR0e7LCwgz8CiLGfV82A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724500631; c=relaxed/relaxed;
	bh=7MlSZRgX4NtPTJfbL1OG/C/fCyXDm1yZsFhC7WYkkOo=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:Organization:From:In-Reply-To:References:Cc:Subject:
	 MIME-Version:Content-Type:Content-ID:Date:Message-ID:X-Scanned-By;
	b=F2sWfWWPJJ2ZKSVW9q7VNLK4QLDElNXDasBNMJGPLxMXwtC3pcG+/e8MX8oXsipzQKIvvXC1qdddTpODdjv1R/ZjDYChsV9DbJGIl28ktNnYiOaSNi4hVxo4Y1W2AYDDU0iNbq3mr8RABvfKNRmBFf5QihwD5s/n/Xp3hu5vonsKTRUDvtFFqIXRfWIsPDKuTIA0odPpJxn/AzTrsies59SOo3xD3l4GHWoi0+F9iqOLpFZYHMySXXhDw+e6OCb7pCoNKO7lEXLaHdqmuTgGL4+HT9HlFsJCv9/A+iSJa8EoyrupR3Gd6HmGunwoaCGNV4utzMfPeog0+5mjd2W9yA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CA5Ku8Vz; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CA5Ku8Vz; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CA5Ku8Vz;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CA5Ku8Vz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wrb5g1Pmgz2xtK
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 21:57:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724500625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7MlSZRgX4NtPTJfbL1OG/C/fCyXDm1yZsFhC7WYkkOo=;
	b=CA5Ku8Vzelh8UWL9LSgUv+MDFrR87Is44u0lTT0cJxyXidhVK+OwJJWPPD2bc7LDdJfvDK
	5EO1UsOin1XfWJNSWLJGt362NAxuJ68NExpY1lyMvb+jU8g211rvs+BjbbRveutRr6/OF5
	hjoBE/W/iM+YKmbhrMwNR9MMkVZ3vDc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724500625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7MlSZRgX4NtPTJfbL1OG/C/fCyXDm1yZsFhC7WYkkOo=;
	b=CA5Ku8Vzelh8UWL9LSgUv+MDFrR87Is44u0lTT0cJxyXidhVK+OwJJWPPD2bc7LDdJfvDK
	5EO1UsOin1XfWJNSWLJGt362NAxuJ68NExpY1lyMvb+jU8g211rvs+BjbbRveutRr6/OF5
	hjoBE/W/iM+YKmbhrMwNR9MMkVZ3vDc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-dsco4DIKOqS_7UEUarFQjQ-1; Sat,
 24 Aug 2024 07:57:03 -0400
X-MC-Unique: dsco4DIKOqS_7UEUarFQjQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A55D61955F43;
	Sat, 24 Aug 2024 11:56:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C96919560AA;
	Sat, 24 Aug 2024 11:56:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
Subject: [PATCH 10/9] netfs: Fix interaction of streaming writes with zero-point tracker
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <563285.1724500613.1@warthog.procyon.org.uk>
Date: Sat, 24 Aug 2024 12:56:53 +0100
Message-ID: <563286.1724500613@warthog.procyon.org.uk>
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
Cc: Paulo Alcantara <pc@manguebit.com>, Steve French <sfrench@samba.org>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

    
When a folio that is marked for streaming write (dirty, but not uptodate,
with partial content specified in the private data) is written back, the
folio is effectively switched to the blank state upon completion of the
write.  This means that if we want to read it in future, we need to reread
the whole folio.

However, if the folio is above the zero_point position, when it is read
back, it will just be cleared and the read skipped, leading to apparent
local corruption.

Fix this by increasing the zero_point to the end of the dirty data in the
folio when clearing the folio state after writeback.  This is analogous to
the folio having ->release_folio() called upon it.

This was causing the config.log generated by configuring a cpython tree on
a cifs share to get corrupted because the scripts involved were appending
text to the file in small pieces.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_collect.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 426cf87aaf2e..ae7a2043f670 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -33,6 +33,7 @@
 int netfs_folio_written_back(struct folio *folio)
 {
 	enum netfs_folio_trace why = netfs_folio_trace_clear;
+	struct netfs_inode *ictx = netfs_inode(folio->mapping->host);
 	struct netfs_folio *finfo;
 	struct netfs_group *group = NULL;
 	int gcount = 0;
@@ -41,6 +42,12 @@ int netfs_folio_written_back(struct folio *folio)
 		/* Streaming writes cannot be redirtied whilst under writeback,
 		 * so discard the streaming record.
 		 */
+		unsigned long long fend;
+
+		fend = folio_pos(folio) + finfo->dirty_offset + finfo->dirty_len;
+		if (fend > ictx->zero_point)
+			ictx->zero_point = fend;
+
 		folio_detach_private(folio);
 		group = finfo->netfs_group;
 		gcount++;

