Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB9C96336C
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 23:03:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WvH2b5xV0z2yqB
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 07:03:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724879030;
	cv=none; b=FNwy7xzb3hJHJIW54/AuYjLcmETdkmxDVlPRgcPj1k21rV1LkdZsX3YxCBlgH9wi9rnojWUPP2yqQUrBpHZZNc4j0l3L+DxFIkV6YYZLycxaKQ3FGf055ZaQLrtBBypsvm6RIPBjOwoaFbCLKmffQCJAkn9hUp+4SkjE4SQ0FqBmMWQJYvb7ycE5my1bsWFYe5iVofPi23ePr1Q6ostyQZ5hM0B/pkwuw62EvH+gFl2NjFYNbwiY9543BVrS5N4RehY83LUOFwP/Jp4yLR6oT7gyQY5CEXe+ON9yTBI7hxC6jYiyqHHjCNKVIE02Bp7Nt7PERvICu4kvDrxltv2ymA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724879030; c=relaxed/relaxed;
	bh=cZLOwDsDBBJUFs2hQlOukyGuDHu131MWSIeu0yUM/RI=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=EM9UaEJJpIVzKAGDbd3jhdIYs7KZrGu/tstAcPZjqXgg9xArXOANuWmWY8/vEPnJyRzZtx8z+MPXKCEm7Y/uUTYbGQQ6dRt1V+VH6SG6AluZKqaydPZDoQZFFN/y33/FcO78gBnI618piyQXTG9r/WIPGbAMs8o7anvj/S4EC6mO/UVR25q0Ys2TQQZupgfJfsa0zuBEVgw945VCtuZWdqWcUvaPSI5TGztABrgUEA07uSV0oUjduMPx+HNfCA1tSDzB+sLs4DLaCgCSQy4DrCaE1xxscNYBBIUtbh2DBeCw1IqUM/PZwAW+agGCboUAaExc3ges3vZAdpspzmmq4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ap3waTHu; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DXVcqLKU; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ap3waTHu;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DXVcqLKU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WvH2Y4Zbwz2y8X
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 07:03:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724879026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZLOwDsDBBJUFs2hQlOukyGuDHu131MWSIeu0yUM/RI=;
	b=ap3waTHu1A1S/knsqHYKbjH82Id2KRKM1JsPMncYV+qs4PKtPe256evVgWVgGRiz//I/2S
	MbV7hlwdzQlR3pS+YXVJvS6bq3EEBHtjHZ3GKHe56+lIvH2eh74M3AQSR4snRoycBePjov
	tDaYwEso0EwLlLB7eEAvy9HX8XYykq8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724879027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZLOwDsDBBJUFs2hQlOukyGuDHu131MWSIeu0yUM/RI=;
	b=DXVcqLKUD7UOg0qt6hSvC1eHg0p2Ye/H/nkSicRZULlnqFOt5S5l778JDcpvSWxaH9uz68
	+p2qq+wE9QKkKIFA4VDAEctLo2g16f9j8z3Aw/GuSUkk80jIc+uk+D9Jr+4wm0W8QGZ9a8
	vBAsOI10lOnmf/aee7MgxG+JAWSBcnc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-vc_IMyGmMNa-yhlY57doPw-1; Wed,
 28 Aug 2024 17:03:40 -0400
X-MC-Unique: vc_IMyGmMNa-yhlY57doPw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06D7A1955D48;
	Wed, 28 Aug 2024 21:03:37 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C66B30001A1;
	Wed, 28 Aug 2024 21:03:30 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 5/6] cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target region
Date: Wed, 28 Aug 2024 22:02:46 +0100
Message-ID: <20240828210249.1078637-6-dhowells@redhat.com>
In-Reply-To: <20240828210249.1078637-1-dhowells@redhat.com>
References: <20240828210249.1078637-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-cifs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Pavel Shilovsky <pshilov@microsoft.com>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Shyam Prasad N <nspmangalore@gmail.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Steve French <stfrench@microsoft.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Under certain conditions, the range to be cleared by FALLOC_FL_ZERO_RANGE
may only be buffered locally and not yet have been flushed to the server.
For example:

	xfs_io -f -t -c "pwrite -S 0x41 0 4k" \
		     -c "pwrite -S 0x42 4k 4k" \
		     -c "fzero 0 4k" \
		     -c "pread -v 0 8k" /xfstest.test/foo

will write two 4KiB blocks of data, which get buffered in the pagecache,
and then fallocate() is used to clear the first 4KiB block on the server -
but we don't flush the data first, which means the EOF position on the
server is wrong, and so the FSCTL_SET_ZERO_DATA RPC fails (and xfs_io
ignores the error), but then when we try to read it, we see the old data.

Fix this by preflushing any part of the target region that above the
server's idea of the EOF position to force the server to update its EOF
position.

Note, however, that we don't want to simply expand the file by moving the
EOF before doing the FSCTL_SET_ZERO_DATA[*] because someone else might see
the zeroed region or if the RPC fails we then have to try to clean it up or
risk getting corruption.

[*] And we have to move the EOF first otherwise FSCTL_SET_ZERO_DATA won't
do what we want.

This fixes the generic/008 xfstest.

[!] Note: A better way to do this might be to split the operation into two
parts: we only do FSCTL_SET_ZERO_DATA for the part of the range below the
server's EOF and then, if that worked, invalidate the buffered pages for the
part above the range.

Fixes: 6b69040247e1 ("cifs/smb3: Fix data inconsistent when zero file range")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
cc: Pavel Shilovsky <pshilov@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/smb2ops.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index a6f00b157275..4df84ebe8dbe 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3237,13 +3237,15 @@ static long smb3_zero_data(struct file *file, struct cifs_tcon *tcon,
 }
 
 static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
-			    loff_t offset, loff_t len, bool keep_size)
+			    unsigned long long offset, unsigned long long len,
+			    bool keep_size)
 {
 	struct cifs_ses *ses = tcon->ses;
 	struct inode *inode = file_inode(file);
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifsFileInfo *cfile = file->private_data;
-	unsigned long long new_size;
+	struct netfs_inode *ictx = netfs_inode(inode);
+	unsigned long long i_size, new_size, remote_size;
 	long rc;
 	unsigned int xid;
 
@@ -3255,6 +3257,16 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	inode_lock(inode);
 	filemap_invalidate_lock(inode->i_mapping);
 
+	i_size = i_size_read(inode);
+	remote_size = ictx->remote_i_size;
+	if (offset + len >= remote_size && offset < i_size) {
+		unsigned long long top = umin(offset + len, i_size);
+
+		rc = filemap_write_and_wait_range(inode->i_mapping, offset, top - 1);
+		if (rc < 0)
+			goto zero_range_exit;
+	}
+
 	/*
 	 * We zero the range through ioctl, so we need remove the page caches
 	 * first, otherwise the data may be inconsistent with the server.

