Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF6596336A
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 23:03:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WvH2T30yzz2yqB
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 07:03:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724879023;
	cv=none; b=CvFNXMMy52vwdxH5a7i2db9KBaQOxbMUY1lp9jdPbRCs3XJ4otfSyzGckYUNGUqoJwie3UbZ90MwCvoFyH9p5710mCL8iPnoLGYS8OiPxGbCEs0RTTad7I5tQbns9BG6Blv3o1OEj0NEcnpIrudozR6YKwXlBRsS2sZ8pO/eDvWjuPVwAKXjlsy0iVdTkJnZjtFjlOZbYuKlMROwY+nMI1N3OKCnCqlhMzoFQx9Ltq+WVa6o2L5B8YfViJs5cf/9tvhanV27WTRzNJ9jLS+xgEv16X22q4v3g2UmT1u6d/OhzN+d0Sa1gmZ0NUBnL59Q7dGB6hs/WfcBgcGjfv7Gmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724879023; c=relaxed/relaxed;
	bh=gafgwUBwZzk/cup16/E12xqM5SQfOL2Vg1E23SCR1HY=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=UZa5GqzqmrX3NrQq/JLA2xCbv9Maf/uQkOo0N0qD2OU/QHq6FBY8jkHO6ULZmEk1Ie/Nb4u0QrpCrNFKOPQNzSIQ9J9Bbi616E5oMxiwkOksA4/4b0o/GUTGqLsnoIAoextj+7VqkJBux8IdlWcSgoVMtZDzi+aEeUldOII32kS1psG1Tr0G5m8x7PcNILh0PO2MZkE9D4lwOcaY0x5MVX6qVIScaZnuDfLQtd0v4RxRfViX1CgnDIDHSQr+BYQy+uxKpeAcNorOYBUUiJRP/y60bPjX1wb5pjGn0IhLWzJ1nLtUfTGFXHM6OUEXSnTfIPkFl30pfvCXlrjjaU1h3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fzBTOMnx; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fzBTOMnx; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fzBTOMnx;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fzBTOMnx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WvH2R0B5zz2yVv
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 07:03:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724879020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gafgwUBwZzk/cup16/E12xqM5SQfOL2Vg1E23SCR1HY=;
	b=fzBTOMnxc3ilHTTnWIv1OCncXdg78wm2/kDsAPsIC+T3l0+JuceKtdJUr+EiBm6ln6rQsD
	pUpym7YkRdH/S9iz7eiQd8BS7/QqakmB5QAxpEeW5VJ62Uh3mwlMDCamySQwgIdfQXoN1q
	fR/AgHQntS4mtQumtUQzXC4d3fuTHeM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724879020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gafgwUBwZzk/cup16/E12xqM5SQfOL2Vg1E23SCR1HY=;
	b=fzBTOMnxc3ilHTTnWIv1OCncXdg78wm2/kDsAPsIC+T3l0+JuceKtdJUr+EiBm6ln6rQsD
	pUpym7YkRdH/S9iz7eiQd8BS7/QqakmB5QAxpEeW5VJ62Uh3mwlMDCamySQwgIdfQXoN1q
	fR/AgHQntS4mtQumtUQzXC4d3fuTHeM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-nlBAerB_MSuc8tJsU0uD8A-1; Wed,
 28 Aug 2024 17:03:34 -0400
X-MC-Unique: nlBAerB_MSuc8tJsU0uD8A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 060FE1955BEE;
	Wed, 28 Aug 2024 21:03:30 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74A7019560A3;
	Wed, 28 Aug 2024 21:03:21 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 4/6] mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
Date: Wed, 28 Aug 2024 22:02:45 +0100
Message-ID: <20240828210249.1078637-5-dhowells@redhat.com>
In-Reply-To: <20240828210249.1078637-1-dhowells@redhat.com>
References: <20240828210249.1078637-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Matthew Wilcox <willy@infradead.org>, linux-afs@lists.infradead.org, devel@lists.orangefs.org, Christian Brauner <brauner@kernel.org>, Tom Talpey <tom@talpey.com>, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
rather than truncate_inode_pages_range().  The latter clears the
invalidated bit of a partial pages rather than discarding it entirely.
This causes copy_file_range() to fail on cifs because the partial pages at
either end of the destination range aren't evicted and reread, but rather
just partly cleared.

This causes generic/075 and generic/112 xfstests to fail.

Fixes: 74e797d79cf1 ("mm: Provide a means of invalidation without using launder_folio")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: devel@lists.orangefs.org
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..0ca9c1377b68 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4231,7 +4231,7 @@ int filemap_invalidate_inode(struct inode *inode, bool flush,
 	}
 
 	/* Wait for writeback to complete on all folios and discard. */
-	truncate_inode_pages_range(mapping, start, end);
+	invalidate_inode_pages2_range(mapping, start / PAGE_SIZE, end / PAGE_SIZE);
 
 unlock:
 	filemap_invalidate_unlock(mapping);

