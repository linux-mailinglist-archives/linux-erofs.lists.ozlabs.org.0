Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F180995D2A5
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 18:12:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wr4pt2bnbz304C
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 02:12:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724429557;
	cv=none; b=c6ormFCcYqFqEUcCU3kd2HroEl7NfH8P7w0U09a6uc+/kdfQ9tzRBBvyEuvYiAxu+di4rh8OIejZsbnTSnojlArJNT9qxaroQ2ra3tefQEKRN0mfrsCHSTQQzPK/kNp3BNgarF6LjkWud9aAbbMiIEoeiA1iQZhNlIruoFf1BfuMgoyQo9lDOKdEm1NGbkcQ74KcOc7qHnVdIExtVqDFwWLyPSLkGoGonhz/oNvGn13Fvf4alakSVOnS6qja7uev2jne940x5HlbqUMgumVxOltSex9KKTdb6UJ0jxVaEQ7vUH2XAIlyvZRnnhDNOtovTstaA7xRC+NFvN4S9ZZXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724429557; c=relaxed/relaxed;
	bh=BgDxF6Y2BCwscRMX/1nHWh5c3+O9vNtYrvIJazlGbCw=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=ntl5e7hBwqUogQD5TlVQ2x5DInlzGJCo95YcDx9fdCGPBxpuZgENK1b7/i+vvACGsS8GuN0R3neMvU8ukWKJ7JyO8XYVFMpoEv3lhIC0dS9HEDB6bEtIC/04qG8Oe3XD52JQzyLSXy5NxPWOtFu9hrahpXWurrdre/qmZA68ukO6SvQolkK+eA3U7M1A4ZgF1U2YVkC2JGjXuIM+UTfz4isI0cEFS8nJHtMzDEy+gHFz2QIMBvHc2ixddbod2aZnpNV9QRB7ZctdrlfhLdWOe51IG1W4kfArIYEyBE7STSr48lJLZ54lY8NROpvQKPaTsIlQBGHJ01aocX8J/cqCIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e3H7wYqD; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e3H7wYqD; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e3H7wYqD;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e3H7wYqD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wr4pr6cRGz2yJ9
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 02:12:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BgDxF6Y2BCwscRMX/1nHWh5c3+O9vNtYrvIJazlGbCw=;
	b=e3H7wYqDJQsurpaaBJJ9ZUvDBR0ogevevx7CqHjuFLwalC5CfLOFn4LiTMPMnTj6ZzLAkO
	0C6+fU+YNxhj20pQ3gTxxD8XuzdlNLBr27CpDROPLplJA7LX0n2h+f1HNiSE14HFYo3oWG
	6f6hrEzqmIMVTgB8kibPfKjGZQWYssE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BgDxF6Y2BCwscRMX/1nHWh5c3+O9vNtYrvIJazlGbCw=;
	b=e3H7wYqDJQsurpaaBJJ9ZUvDBR0ogevevx7CqHjuFLwalC5CfLOFn4LiTMPMnTj6ZzLAkO
	0C6+fU+YNxhj20pQ3gTxxD8XuzdlNLBr27CpDROPLplJA7LX0n2h+f1HNiSE14HFYo3oWG
	6f6hrEzqmIMVTgB8kibPfKjGZQWYssE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-w4BHTpKQMVyxJPieBikXbA-1; Fri,
 23 Aug 2024 12:12:27 -0400
X-MC-Unique: w4BHTpKQMVyxJPieBikXbA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1319F1955D45;
	Fri, 23 Aug 2024 16:12:24 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FC54300019C;
	Fri, 23 Aug 2024 16:12:17 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 1/5] cifs: Fix FALLOC_FL_PUNCH_HOLE support
Date: Fri, 23 Aug 2024 17:12:02 +0100
Message-ID: <20240823161209.434705-2-dhowells@redhat.com>
In-Reply-To: <20240823161209.434705-1-dhowells@redhat.com>
References: <20240823161209.434705-1-dhowells@redhat.com>
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Steve French <sfrench@samba.org>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Shyam Prasad N <nspmangalore@gmail.com>, Paulo Alcantara <pc@manguebit.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The cifs filesystem doesn't quite emulate FALLOC_FL_PUNCH_HOLE correctly
(note that due to lack of protocol support, it can't actually implement it
directly).  Whilst it will (partially) invalidate dirty folios in the
pagecache, it doesn't write them back first, and so the EOF marker on the
server may be lower than inode->i_size.

This presents a problem, however, as if the punched hole invalidates the
tail of the locally cached dirty data, writeback won't know it needs to
move the EOF over to account for the hole punch (which isn't supposed to
move the EOF).  We could just write zeroes over the punched out region of
the pagecache and write that back - but this is supposed to be a
deallocatory operation.

Fix this by manually moving the EOF over on the server after the operation
if the hole punched would corrupt it.

Note that the FSCTL_SET_ZERO_DATA RPC and the setting of the EOF should
probably be compounded to stop a third party interfering (or, at least,
massively reduce the chance).

This was reproducible occasionally by using fsx with the following script:

	truncate 0x0 0x375e2 0x0
	punch_hole 0x2f6d3 0x6ab5 0x375e2
	truncate 0x0 0x3a71f 0x375e2
	mapread 0xee05 0xcf12 0x3a71f
	write 0x2078e 0x5604 0x3a71f
	write 0x3ebdf 0x1421 0x3a71f *
	punch_hole 0x379d0 0x8630 0x40000 *
	mapread 0x2aaa2 0x85b 0x40000
	fallocate 0x1b401 0x9ada 0x40000
	read 0x15f2 0x7d32 0x40000
	read 0x32f37 0x7a3b 0x40000 *

The second "write" should extend the EOF to 0x40000, and the "punch_hole"
should operate inside of that - but that depends on whether the VM gets in
and writes back the data first.  If it doesn't, the file ends up 0x3a71f in
size, not 0x40000.

Fixes: 31742c5a3317 ("enable fallocate punch hole ("fallocate -p") for SMB3")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
---
 fs/smb/client/smb2ops.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 322cabc69c6f..763a17e62750 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3305,6 +3305,7 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 	struct inode *inode = file_inode(file);
 	struct cifsFileInfo *cfile = file->private_data;
 	struct file_zero_data_information fsctl_buf;
+	unsigned long long end = offset + len, i_size, remote_i_size;
 	long rc;
 	unsigned int xid;
 	__u8 set_sparse = 1;
@@ -3336,6 +3337,29 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 			(char *)&fsctl_buf,
 			sizeof(struct file_zero_data_information),
 			CIFSMaxBufSize, NULL, NULL);
+
+	if (rc)
+		goto unlock;
+
+	/* If there's dirty data in the buffer that would extend the EOF if it
+	 * were written, then we need to move the EOF marker over to the lower
+	 * of the high end of the hole and the proposed EOF.  The problem is
+	 * that we locally hole-punch the tail of the dirty data, the proposed
+	 * EOF update will end up in the wrong place.
+	 */
+	i_size = i_size_read(inode);
+	remote_i_size = netfs_inode(inode)->remote_i_size;
+	if (end > remote_i_size && i_size > remote_i_size) {
+		unsigned long long extend_to = umin(end, i_size);
+		rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
+				  cfile->fid.volatile_fid, cfile->pid, extend_to);
+		if (rc >= 0) {
+			netfs_inode(inode)->remote_i_size = extend_to;
+			trace_netfs_set_size(inode, netfs_size_trace_punch_hole);
+		}
+	}
+
+unlock:
 	filemap_invalidate_unlock(inode->i_mapping);
 out:
 	inode_unlock(inode);

