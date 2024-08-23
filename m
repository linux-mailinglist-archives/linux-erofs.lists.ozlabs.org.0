Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF0895D70E
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 22:08:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WrB3Y5Wxgz30Bj
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 06:08:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724443735;
	cv=none; b=Lxw8vbjcDxBVeiDPDAlfRhjiCqQRTDIW5FxeCpQPPAfefr9l6Aze5mLWgxlORxEYi6i+By/gE3QCaQHqe9P/6B8mu0sgzCdlDFfnruQBxK0P1VdMbDV2KoRAq5f3rNdYngYzy/eqVl1elaJgLU4PYAX2h5q2QtaricKJ7H7ruDuix6kyDcJuxcvBXkdmk+uNTWTWQEA7bS67m/ObmZyKtX8VxL1A3075Kw0ZhojhvKv0j/7EI94YKId+QfISpguYzvH4nXDbLsRV3FbgYBg9K7IELKmXuBXX0Z86DFg60N0UE/B+37241mLF5SJ5hqG6BjAEIGbSvhZnuhaC6/jZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724443735; c=relaxed/relaxed;
	bh=B4tfOtZ3an7b1aGGuqLauY14dten5jR69+zwwl0cSBE=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=AAJuarg7rntaSruIwehP2xxIOjZCnw9ksgYxsl/EKsDJtCRVUdoNvffRCSrjtXOAKSNLyFlmofgmq14WNjMxb0VhFQbUKScPIx8JpbAyT6vLBfJniRxaOVafZUUtPQBNLo6oIw9nL3swBkZErC9FPbxOJIGkx7r+TUJjNH73BXlpsfL41cow7YK/Ht4r52Oxh6LUxW+m26QH5L6RkyDrbgBGtsDRW6loV/U9Hv1hV9CAEkIaqMm6PZ+1OU3W9TucKeHJoGSeaaeCt66jzNtEw6rv50ZmZ1Wde5F6BmhERLSuAfHUprUP7kEldb8JIpHTeObgJlubWp1g2lP/nktIwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ekz4yxq1; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ebc02KxX; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ekz4yxq1;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ebc02KxX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WrB3W3cjhz309k
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 06:08:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4tfOtZ3an7b1aGGuqLauY14dten5jR69+zwwl0cSBE=;
	b=ekz4yxq1RLQzM5Xgnwd9faEVqSNzz4WywcsTRXv/TnieTnLRJ+uIN5CFnBzRVyCUoMVF2H
	GgYOMpc8dEXHQyKjeJfLjZglTPo8F+sWPJwlzewJjyF8tRCEkr79AteZfSBsIf1g88R2HH
	JBb1GPKUGDcELj0snBvEPdnRvQUamp8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4tfOtZ3an7b1aGGuqLauY14dten5jR69+zwwl0cSBE=;
	b=Ebc02KxXo1EZcK0jc2JKJsAi2xzewLgsNhLSslVIokS+1h+AOXFI6dT5Xz08w3EGim8xwm
	0bUqTVTDoLjM7omnTNgsY7cE9WUVoV8IO2OzeUg0RaslhgJ1zCU0SrPBJgegwy1z9YBHab
	NOQ+9GgxW8kzMy9ZNwv5i7j5rq6xq8Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-JPiGnaA-NR6p3XE_f4cFaQ-1; Fri,
 23 Aug 2024 16:08:49 -0400
X-MC-Unique: JPiGnaA-NR6p3XE_f4cFaQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 385D61955D50;
	Fri, 23 Aug 2024 20:08:47 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8E451955DD8;
	Fri, 23 Aug 2024 20:08:41 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 3/9] netfs: Fix netfs_release_folio() to say no if folio dirty
Date: Fri, 23 Aug 2024 21:08:11 +0100
Message-ID: <20240823200819.532106-4-dhowells@redhat.com>
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

Fix netfs_release_folio() to say no (ie. return false) if the folio is
dirty (analogous with iomap's behaviour).  Without this, it will say yes to
the release of a dirty page by split_huge_page_to_list_to_order(), which
will result in the loss of untruncated data in the folio.

Without this, the generic/075 and generic/112 xfstests (both fsx-based
tests) fail with minimum folio size patches applied[1].

Fixes: c1ec4d7c2e13 ("netfs: Provide invalidate_folio and release_folio calls")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Pankaj Raghav <p.raghav@samsung.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20240815090849.972355-1-kernel@pankajraghav.com/ [1]
---
 fs/netfs/misc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 554a1a4615ad..69324761fcf7 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -161,6 +161,9 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 	struct netfs_inode *ctx = netfs_inode(folio_inode(folio));
 	unsigned long long end;
 
+	if (folio_test_dirty(folio))
+		return false;
+
 	end = folio_pos(folio) + folio_size(folio);
 	if (end > ctx->zero_point)
 		ctx->zero_point = end;

