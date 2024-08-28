Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D7D963366
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 23:03:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WvH2F6crbz2ysZ
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 07:03:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724879012;
	cv=none; b=P3EkWoUotSEkv4pJA22YFb+xjsF2DJ8eBvQwacfzo4SW2vFJ1SWZ3I9g9IB3s1eHOyyLkvZwMba6eFYA8TkCiHFDq/t/BmzvzVdghXiobmmYXxXhaiiDdQJTBnzSYyxIOQi7bz+gvMP4INFAeepZtWsmBKKNVtNUs22wKVrDyp1UgQrQHetA1Qw87hYY45S+J+0d7IiLoeY3ZV1Yl8jlq4+3S+ecMbhLTbwstiCbixf6e12ZN2RI7pg2QAfDKbnL6duEn0KFaFl249iWpVrf141VZGddJHt0JtnEVvdsiHN9n97mkZUBmPk0RKIDNoIFHluicU9g3jk/booqAnHCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724879012; c=relaxed/relaxed;
	bh=29rNMGcbzhhOXDnkGZZqENHeVIOwTy/JkQWfMjJEQZk=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=eZQOg/nCe4dsoNIN/bZQZObuWpb6LU/uoSxUc0kNaGYb0k9vt6Jsk4JM43ozjY9ZIAlrzqe9BZ2ZgXmVrntukwFuJ+dV4p9GHCM302AzaeeFrv5rTK8mVr6MvX7dVfA88ay2BhgEEWzpaQ/F4BI+1tWyMpuEio+dMGGbfS3WmN0Ev3AOV81uo6IW9cyAmpYu1NP0Xq9ZJNW0dlpoY831lyamFToWihHylntMHVDPHdhpr/1Wdu9MzWel7Nji8e31y1nGd4x/8+6IrSZw82VT+ZDLndEXO0yscnt7fED5nSIJQ9CxeFFfOE+uzx8DiKltiryTaucQxE5hFES8gOoELg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PCbH2FjZ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PCbH2FjZ; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PCbH2FjZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PCbH2FjZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WvH2D0Mrxz2y8X
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 07:03:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724879009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29rNMGcbzhhOXDnkGZZqENHeVIOwTy/JkQWfMjJEQZk=;
	b=PCbH2FjZOna6MV7D7B3LoaRqc7//Zan18XONNCPXqk6w5agxjYH2MHW74OV3yZwYQo5udS
	RGE8yCpUp16iAPIfSJGkT51s1jUhCcCCMRpbQnD1z4q3qJuVuE4L/T5AO8oBqGZJdwuddY
	73P1cqPcsCgpN73MtWB7q5E6kZn1xVk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724879009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29rNMGcbzhhOXDnkGZZqENHeVIOwTy/JkQWfMjJEQZk=;
	b=PCbH2FjZOna6MV7D7B3LoaRqc7//Zan18XONNCPXqk6w5agxjYH2MHW74OV3yZwYQo5udS
	RGE8yCpUp16iAPIfSJGkT51s1jUhCcCCMRpbQnD1z4q3qJuVuE4L/T5AO8oBqGZJdwuddY
	73P1cqPcsCgpN73MtWB7q5E6kZn1xVk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-Gp7aQV_ZPh6R-b_4tg_Akg-1; Wed,
 28 Aug 2024 17:03:24 -0400
X-MC-Unique: Gp7aQV_ZPh6R-b_4tg_Akg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30BFC19560B7;
	Wed, 28 Aug 2024 21:03:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B57471955F1B;
	Wed, 28 Aug 2024 21:03:15 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 3/6] cifs: Fix copy offload to flush destination region
Date: Wed, 28 Aug 2024 22:02:44 +0100
Message-ID: <20240828210249.1078637-4-dhowells@redhat.com>
In-Reply-To: <20240828210249.1078637-1-dhowells@redhat.com>
References: <20240828210249.1078637-1-dhowells@redhat.com>
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-cifs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Shyam Prasad N <nspmangalore@gmail.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Steve French <stfrench@microsoft.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix cifs_file_copychunk_range() to flush the destination region before
invalidating it to avoid potential loss of data should the copy fail, in
whole or in part, in some way.

Fixes: 7b2404a886f8 ("cifs: Fix flushing, invalidation and file size with copy_file_range()")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsfs.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index d89485235425..2a2523c93944 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1341,7 +1341,6 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	struct cifsFileInfo *smb_file_target;
 	struct cifs_tcon *src_tcon;
 	struct cifs_tcon *target_tcon;
-	unsigned long long destend, fstart, fend;
 	ssize_t rc;
 
 	cifs_dbg(FYI, "copychunk range\n");
@@ -1391,25 +1390,13 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 			goto unlock;
 	}
 
-	destend = destoff + len - 1;
-
-	/* Flush the folios at either end of the destination range to prevent
-	 * accidental loss of dirty data outside of the range.
+	/* Flush and invalidate all the folios in the destination region.  If
+	 * the copy was successful, then some of the flush is extra overhead,
+	 * but we need to allow for the copy failing in some way (eg. ENOSPC).
 	 */
-	fstart = destoff;
-	fend = destend;
-
-	rc = cifs_flush_folio(target_inode, destoff, &fstart, &fend, true);
+	rc = filemap_invalidate_inode(target_inode, true, destoff, destoff + len - 1);
 	if (rc)
 		goto unlock;
-	rc = cifs_flush_folio(target_inode, destend, &fstart, &fend, false);
-	if (rc)
-		goto unlock;
-	if (fend > target_cifsi->netfs.zero_point)
-		target_cifsi->netfs.zero_point = fend + 1;
-
-	/* Discard all the folios that overlap the destination region. */
-	truncate_inode_pages_range(&target_inode->i_data, fstart, fend);
 
 	fscache_invalidate(cifs_inode_cookie(target_inode), NULL,
 			   i_size_read(target_inode), 0);

