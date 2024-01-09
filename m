Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F52828BBE
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 19:02:03 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mw79En6x;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mw79En6x;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T8dzr5hVTz30hC
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jan 2024 05:02:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mw79En6x;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mw79En6x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T8dzf2NDbz3bs2
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jan 2024 05:01:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704823307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htZaU1/QSRuOWh3B5AYLSVZDvmENK74hhmVyyviJXCk=;
	b=Mw79En6xx9Xgsgvzu+AbYkYvMAGtIcGagvybsznZKbknBpL5lN/W2+3/YWwLl9ZS1L+OMc
	8UVA3zZvvYZ0879q9W2ItO9jKya0F33cWD9xhlOKYIxtqCDPX0jxAlOeHNHotQOvtX8Cvc
	J8VUaIeNNyQ8u/AyLpWk6PPaVonusIs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704823307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htZaU1/QSRuOWh3B5AYLSVZDvmENK74hhmVyyviJXCk=;
	b=Mw79En6xx9Xgsgvzu+AbYkYvMAGtIcGagvybsznZKbknBpL5lN/W2+3/YWwLl9ZS1L+OMc
	8UVA3zZvvYZ0879q9W2ItO9jKya0F33cWD9xhlOKYIxtqCDPX0jxAlOeHNHotQOvtX8Cvc
	J8VUaIeNNyQ8u/AyLpWk6PPaVonusIs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-1HRLsJ-qPNSJzgSw3CTxDA-1; Tue, 09 Jan 2024 13:01:44 -0500
X-MC-Unique: 1HRLsJ-qPNSJzgSw3CTxDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01B2C85A58E;
	Tue,  9 Jan 2024 18:01:41 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C01671121306;
	Tue,  9 Jan 2024 18:01:37 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 4/4] cifs: Don't use certain internal folio_*() functions
Date: Tue,  9 Jan 2024 18:01:15 +0000
Message-ID: <20240109180117.1669008-5-dhowells@redhat.com>
In-Reply-To: <20240109180117.1669008-1-dhowells@redhat.com>
References: <20240109180117.1669008-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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
Cc: David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Filesystems should not be using folio->index not folio_index(folio) and
folio->mapping, not folio_mapping() or folio_file_mapping() in filesystem
code.

Change this automagically with:

perl -p -i -e 's/folio_mapping[(]([^)]*)[)]/\1->mapping/g' fs/smb/client/*.c
perl -p -i -e 's/folio_file_mapping[(]([^)]*)[)]/\1->mapping/g' fs/smb/client/*.c
perl -p -i -e 's/folio_index[(]([^)]*)[)]/\1->index/g' fs/smb/client/*.c

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Ronnie Sahlberg <lsahlber@redhat.com>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index b02b7f0a47dc..253e06a7875e 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -87,7 +87,7 @@ void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len
 			continue;
 		if (!folio_test_writeback(folio)) {
 			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
-				  len, start, folio_index(folio), end);
+				  len, start, folio->index, end);
 			continue;
 		}
 
@@ -120,7 +120,7 @@ void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len
 			continue;
 		if (!folio_test_writeback(folio)) {
 			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
-				  len, start, folio_index(folio), end);
+				  len, start, folio->index, end);
 			continue;
 		}
 
@@ -151,7 +151,7 @@ void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int le
 	xas_for_each(&xas, folio, end) {
 		if (!folio_test_writeback(folio)) {
 			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
-				  len, start, folio_index(folio), end);
+				  len, start, folio->index, end);
 			continue;
 		}
 
@@ -2649,7 +2649,7 @@ static void cifs_extend_writeback(struct address_space *mapping,
 				continue;
 			if (xa_is_value(folio))
 				break;
-			if (folio_index(folio) != index)
+			if (folio->index != index)
 				break;
 			if (!folio_try_get_rcu(folio)) {
 				xas_reset(&xas);
@@ -2899,7 +2899,7 @@ static int cifs_writepages_region(struct address_space *mapping,
 					goto skip_write;
 			}
 
-			if (folio_mapping(folio) != mapping ||
+			if (folio->mapping != mapping ||
 			    !folio_test_dirty(folio)) {
 				start += folio_size(folio);
 				folio_unlock(folio);

