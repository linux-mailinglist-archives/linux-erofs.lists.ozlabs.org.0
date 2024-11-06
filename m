Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E839BE9E3
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 13:38:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xk4W24qvHz3bgd
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 23:38:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730896700;
	cv=none; b=bG25aLe5m33DLgiX074276vE6sIWGNdFkJ+BLDZeIwZHNbUmUV759UWncybwN0czTrtVqUlvAJ3m/fBkM110OEqK+enrtoaBm2X7o3yJF7N5I1sW8KFa5XLDNvigszrn/IzKjod9rdp9x8w30Nnfb+9Nwtmnzw3nFihCj/SjeGhWiO7Og2twnkMi5sKmXlIq3/1sacg1ByTT5YY0kBgOobUre+qmBLoos1j5TlQCJufZluEvMPyrIHYAQg846Qo5nIkk49xFSjNMhucsgEcgsl++RfAkWeoFiY7TYGv46TfsykNZ2KaqJA/kdngskvesL0ALgcho5fRSY7blD//QGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730896700; c=relaxed/relaxed;
	bh=E8xdMX/uFcK2gZEOhPcswqOMkVx14v1DliFqQKEHbv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGDDIahJHiQHKECcg30v4DQVznK8HYM3CKl7fXEuth5raztxaKkL1PZAJC3u2KEqtnuw/1QnDzMdqWcaGIhhclEZ83nX0gOjZEeXt/ysG+KZn830lfBt0VI+sxExl7YU0Jorfflbddze8Bc+5sOvdemIbv1n+fvmU0EMGNkxfeUjVYqVG96bkiN6Di5qCaxaJ3nrB7hrfs9Njk8ys9yzmeKm2xsPpDqZITjJ6NVPyPIJJ0w/WkGk4ddN8We4iiLbKBGXtP8oZ6K7p7zkIed3qnbPNwc8kQUKuAyRUpHWw3UEXXf5twtvGUwYHp8MLr9W41m8blh50z/mV5TAILK0+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OUWHta8j; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OUWHta8j; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OUWHta8j;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OUWHta8j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xk4Vz5CYbz30MR
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Nov 2024 23:38:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8xdMX/uFcK2gZEOhPcswqOMkVx14v1DliFqQKEHbv4=;
	b=OUWHta8jdIxrUeSKPzVXGmfmVo+qpliiGi6r13JaHgdT8JtW0aCSn8oj3S5XPC8h8rIhdR
	GgNCEfKurUaczHbr1GLEqYhLwpbo3VfKHXXYCYvamcMmgEig0Y1ETWnvw708AKmP/a8i24
	FRP4JEX6sHgZGPXkpejTTqFLban1Sa4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8xdMX/uFcK2gZEOhPcswqOMkVx14v1DliFqQKEHbv4=;
	b=OUWHta8jdIxrUeSKPzVXGmfmVo+qpliiGi6r13JaHgdT8JtW0aCSn8oj3S5XPC8h8rIhdR
	GgNCEfKurUaczHbr1GLEqYhLwpbo3VfKHXXYCYvamcMmgEig0Y1ETWnvw708AKmP/a8i24
	FRP4JEX6sHgZGPXkpejTTqFLban1Sa4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-zdyHnP1yP8m_vWpFMKCmhA-1; Wed,
 06 Nov 2024 07:38:12 -0500
X-MC-Unique: zdyHnP1yP8m_vWpFMKCmhA-1
X-Mimecast-MFC-AGG-ID: zdyHnP1yP8m_vWpFMKCmhA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBB9A1955EEA;
	Wed,  6 Nov 2024 12:37:57 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42F98195607C;
	Wed,  6 Nov 2024 12:37:52 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 14/33] afs: Fix EEXIST error returned from afs_rmdir() to be ENOTEMPTY
Date: Wed,  6 Nov 2024 12:35:38 +0000
Message-ID: <20241106123559.724888-15-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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

AFS servers pass back a code indicating EEXIST when they're asked to remove
a directory that is not empty rather than ENOTEMPTY because not all the
systems that an AFS server can run on have the latter error available and
AFS preexisted the addition of that error in general.

Fix afs_rmdir() to translate EEXIST to ENOTEMPTY.

Fixes: 260a980317da ("[AFS]: Add "directory write" support.")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index ada363af5aab..50edd1cae28a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1472,7 +1472,12 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
 		op->file[1].vnode = vnode;
 	}
 
-	return afs_do_sync_operation(op);
+	ret = afs_do_sync_operation(op);
+
+	/* Not all systems that can host afs servers have ENOTEMPTY. */
+	if (ret == -EEXIST)
+		ret = -ENOTEMPTY;
+	return ret;
 
 error:
 	return afs_put_operation(op);

