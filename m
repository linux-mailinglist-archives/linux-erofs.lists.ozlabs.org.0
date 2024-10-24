Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575269AE786
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Oct 2024 16:07:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZ76F2W0cz3bdV
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 01:07:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729778868;
	cv=none; b=EvItspEGpt364TEOhIxqQZOcN62eN7it4yS4XiSZLlNFRrAD4aMVkWR2/Imhpf4JWCyeSjSY08vnJNbV3JXr64sF8WKt/jRiYgAyt7nDzSn7oE/up8RXhGhTJlNeAL/bHmZlRKKRocyDnkjTkpZlzeGUEBwkqd5BVQMJ/DdrT1XpGvYfazp5U9TH+305L6s9rHEHyzKOuM86ydKfNssME6BdALrh9A1a79OSzVhGIXj4qv0Pt5qSiqC/Q6h7lVmEl0U4PyVPKO+D703in2j3VaUkf/DyCr/25RNHg7Z9mtWsw0TK4npsWuHyAtTDzmnXw7r7j3nAFN3z+NmpnmJY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729778868; c=relaxed/relaxed;
	bh=E8xdMX/uFcK2gZEOhPcswqOMkVx14v1DliFqQKEHbv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiLDFga7KMC8aFN3v3PRTtmKGlcvUxvrz7MTk6BAeWuMkSDvWhYlNcZZhyO+YO2W+ZamaJKN17lEYRXHl+n1jdROVhNKTsYkErQoGUdbjtwXjduwHkyaPy4UYLJmBWhtIq29lCDVCA5z+hkJuH/au9ZvdCGgL25ErCR/z8bkh/XycrQk5S0gjzwkMiTnwo8uw0yeZVs0OoHswBAotHJY0vqvzeLEbJrW+jCD8DnyhNQ/g5qLKoLl8AiHD0CRDApGTQsbFzGvAiAQHd0NRlLXII6i6BkX9+JBrEwuBpCrIPRWqQ7YAszozNyBycY1He9a0uIDd/CrsJ4dxmf5P/uPcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LFN9Yhs/; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TNWkKgIg; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LFN9Yhs/;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TNWkKgIg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZ76C26Ftz2ysv
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Oct 2024 01:07:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8xdMX/uFcK2gZEOhPcswqOMkVx14v1DliFqQKEHbv4=;
	b=LFN9Yhs/wxJ7+TjTZuzr/KE58YyC0PvS5duH/DceqhY+H0wvM+KsE0FIKMED8jj1D+me5C
	5QRlabCEWLhbF0vwcctZWCNlJdjMzDrLRCI3WoNbn2qbrc6IABG2zLEvU6fZrFNQ8Zxspw
	S9NwDNRh7IUOyagUkIyySwvBuMLFlG4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8xdMX/uFcK2gZEOhPcswqOMkVx14v1DliFqQKEHbv4=;
	b=TNWkKgIg7TjuI5WnX1kBjTaRgTSxAiyQ9+aMLxYOjOxVRBSlEDbR1W/m0OYayloo98DU7Q
	Lm15Zi8lV49VGyXLAn+jZWuEttbc2TvKfuOqTIWS/SziZSK0DsQFtszPavQfcTzHXGEIA0
	53j2RbG7uapCDKfmUy9scHdj22hiWts=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-S4S2A4KAOVabOf3n8LI1SQ-1; Thu,
 24 Oct 2024 10:07:38 -0400
X-MC-Unique: S4S2A4KAOVabOf3n8LI1SQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 537361955BE7;
	Thu, 24 Oct 2024 14:07:35 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE6B21955F43;
	Thu, 24 Oct 2024 14:07:28 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 13/27] afs: Fix EEXIST error returned from afs_rmdir() to be ENOTEMPTY
Date: Thu, 24 Oct 2024 15:05:11 +0100
Message-ID: <20241024140539.3828093-14-dhowells@redhat.com>
In-Reply-To: <20241024140539.3828093-1-dhowells@redhat.com>
References: <20241024140539.3828093-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

