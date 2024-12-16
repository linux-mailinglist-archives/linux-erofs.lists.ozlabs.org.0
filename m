Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A46E9F3B2A
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:43:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBsNG0Y7hz30RJ
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 07:43:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734381803;
	cv=none; b=aUagZjgTDiKXs5za9IouPU75ZXHJ90rrMNtRbJBf91fYq1NYzsMhg9c14f82ctMME18M5sl5GApPwR6Awcpwlsa8ub7Oc6fnzEakCMxBCqY0fnlY61oOaPkQ1jTW3LFmOzgJl9FdRuOrsGERWDKkaWOwJDdi1vdJU2WhyqZuvOI9i7wVCMrEDQg6ZaFYC3FKZEKF7FCWlftnYrdGpTW1GD6xb9lPGUO3KKy/tZO5gmW0R+i/lMfrcDOeTn/bQEX1fKj7eFR4g9f2zV2IkMVCoZUx4J4wVGYP62I6ygDsHf9XiIUpxsCvnHrzL+0w/40l0IAZV/n5E5Gc4xqwvG1p2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734381803; c=relaxed/relaxed;
	bh=HO1trrAUxh6ged928OSrE9rZIbGVfYli8k1F5yQtGbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPQvyM1vz/HWK5R3CptkFf45lnQqJ+vtA5RsKxoMOXilJw86MhZLlqQ/3fHM52EZ49vbMKqA2lvB9QEFfmBGGLqMYIyGqE+hsodIdUfDAp/DNHBbXBhX6mLZem2GmZ1bG7W503o627vi+EOrC4YygJFalOD/3/XWCbnZhTClF988FH5NDV0q8QdHYxvnA1uiuLbt3l87uvB1TUXEqKFK9artVDPstY5e8cmv464PcMdihxvdLNe54Vdes8BHZ0fYSiQPQuNZ3WU0PGoh+u7YlxYApT9WXCxumhqlmgDJy7Gid7USuTT1nw9jEPw5uQ/pmnh2HKsybtiqwNjiqWpA7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EFD01Hok; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EFD01Hok; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EFD01Hok;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EFD01Hok;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBsNB6Stsz2xxw
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Dec 2024 07:43:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HO1trrAUxh6ged928OSrE9rZIbGVfYli8k1F5yQtGbY=;
	b=EFD01HokpE/0o/USxzIcN3QgXbgtzCASCbCcVrNfWaGib52D4vJ2bLDCSYAO0XrIG9rtB1
	HM/VqECzRjhnwv6/b3ihkXM4C5ImpWxguPFCw7mHMh6Z30oo7/SyRJhscWMcClqqVEcWDi
	0En4yMFb5ZwieR93xuDhZAiM9IUjvzA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HO1trrAUxh6ged928OSrE9rZIbGVfYli8k1F5yQtGbY=;
	b=EFD01HokpE/0o/USxzIcN3QgXbgtzCASCbCcVrNfWaGib52D4vJ2bLDCSYAO0XrIG9rtB1
	HM/VqECzRjhnwv6/b3ihkXM4C5ImpWxguPFCw7mHMh6Z30oo7/SyRJhscWMcClqqVEcWDi
	0En4yMFb5ZwieR93xuDhZAiM9IUjvzA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-BIkIYcVIPqyGpZGyQNMtTQ-1; Mon,
 16 Dec 2024 15:43:16 -0500
X-MC-Unique: BIkIYcVIPqyGpZGyQNMtTQ-1
X-Mimecast-MFC-AGG-ID: BIkIYcVIPqyGpZGyQNMtTQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4724195609D;
	Mon, 16 Dec 2024 20:43:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E5B6300F9B5;
	Mon, 16 Dec 2024 20:43:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 13/32] afs: Fix directory format encoding struct
Date: Mon, 16 Dec 2024 20:41:03 +0000
Message-ID: <20241216204124.3752367-14-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The AFS directory format structure, union afs_xdr_dir_block::meta, has too
many alloc counter slots declared and so pushes the hash table along and
over the data.  This doesn't cause a problem at the moment because I'm
currently ignoring the hash table and only using the correct number of
alloc_ctrs in the code anyway.  In future, however, I should start using
the hash table to try and speed up afs_lookup().

Fix this by using the correct constant to declare the counter array.

Fixes: 4ea219a839bf ("afs: Split the directory content defs into a header")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/xdr_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/xdr_fs.h b/fs/afs/xdr_fs.h
index 8ca868164507..cc5f143d21a3 100644
--- a/fs/afs/xdr_fs.h
+++ b/fs/afs/xdr_fs.h
@@ -88,7 +88,7 @@ union afs_xdr_dir_block {
 
 	struct {
 		struct afs_xdr_dir_hdr	hdr;
-		u8			alloc_ctrs[AFS_DIR_MAX_BLOCKS];
+		u8			alloc_ctrs[AFS_DIR_BLOCKS_WITH_CTR];
 		__be16			hashtable[AFS_DIR_HASHTBL_SIZE];
 	} meta;
 

