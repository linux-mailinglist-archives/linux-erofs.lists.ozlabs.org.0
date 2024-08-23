Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A7095D708
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 22:08:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WrB3J6Xnzz30Jc
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 06:08:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724443723;
	cv=none; b=LeaR1pn2++cVqZTEyh8ZZzZXOX4S32uYWxLmQ8cGhpluJv22Z3dIG2Mbl6z+PQ8a1axy4YvE+2/6+GVgeHb46G4GpgAE6AVeyDaVymNYYMrMiPav9c+JQqS3BshOHW+PutYs64+aCwF5zG5vJlP2Q2xfnbIfNKJiPCLcTsMKXeWsHpSqD1uld+i+nhuTrFQdarLsQ26vj5gfUZP0SuSnX1YVpka0EWUgWj7wUVkFKHzSYZwM0HTkTpY18ABLgRu6UiddtvguaN/j97sF1z7Gz+R0Mr77maXmQR/Z0Iu82qagqZ91bsSp3DNA70OSejTGk5V2o95QVDXDXmdZwj2zLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724443723; c=relaxed/relaxed;
	bh=i1WfTcBSz40dFfs4YPek5T5SHQcjJbpn4yprFOLb05E=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=TDBMvkz5HeR7FrLhTfYfy3qrD/OcFd6PuIdxhDKioDkQ4tx7abqKJwLSy7gcSYL3dgwtNpYeTgKnIXzY/Nc/KE/yj82Tr4w5yHcu3n++Iwi//2tIt/cZymOGjIhFdcEDzm9Bh12QpVzlEsqnrRg7eiYbh2AEG1YIsALemjxtbZBdJyzbyIkSygyLxDV6ZZGF08JoedraxBCpSTE5YrdnQCO1nBrFKdnBE7HTpmwYcC0SEARIIauJyeDCr7rc8dRd4GX8MbghsOohqnCUS66mBFF2SnmZcPMlduYBensqJGJm4kUUcdDRl9lc7+h0+dCmc8j1LEiVpBRGmb2uEnnnmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L/kJOHsZ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L/kJOHsZ; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L/kJOHsZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L/kJOHsZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WrB3G6Xvvz301f
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 06:08:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1WfTcBSz40dFfs4YPek5T5SHQcjJbpn4yprFOLb05E=;
	b=L/kJOHsZsQjcBYhWZ5zShuljoNGt/gMYdhm/Z9Gs/8ffJFAN4lQZbFZ3ukbzhPrP5P36Mn
	MKDFF1nnHCSuViSbfl6XxbF7nplwaIFEVBK95Refn2db7/tSJpcztWhx+yIt6Zw5EG4MP3
	MkZi/XuXHKVT0T9j3ksF1f/2zhBcBRo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1WfTcBSz40dFfs4YPek5T5SHQcjJbpn4yprFOLb05E=;
	b=L/kJOHsZsQjcBYhWZ5zShuljoNGt/gMYdhm/Z9Gs/8ffJFAN4lQZbFZ3ukbzhPrP5P36Mn
	MKDFF1nnHCSuViSbfl6XxbF7nplwaIFEVBK95Refn2db7/tSJpcztWhx+yIt6Zw5EG4MP3
	MkZi/XuXHKVT0T9j3ksF1f/2zhBcBRo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-Djwg1nHIPVOepKsh7DLV1g-1; Fri,
 23 Aug 2024 16:08:37 -0400
X-MC-Unique: Djwg1nHIPVOepKsh7DLV1g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A790219560A2;
	Fri, 23 Aug 2024 20:08:34 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7292D3001FE5;
	Fri, 23 Aug 2024 20:08:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 1/9] mm: Fix missing folio invalidation calls during truncation
Date: Fri, 23 Aug 2024 21:08:09 +0100
Message-ID: <20240823200819.532106-2-dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, Paulo Alcantara <pc@manguebit.com>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When AS_RELEASE_ALWAYS is set on a mapping, the ->release_folio() and
->invalidate_folio() calls should be invoked even if PG_private and
PG_private_2 aren't set.  This is used by netfslib to keep track of the
point above which reads can be skipped in favour of just zeroing pagecache
locally.

There are a couple of places in truncation in which invalidation is only
called when folio_has_private() is true.  Fix these to check
folio_needs_release() instead.

Without this, the generic/075 and generic/112 xfstests (both fsx-based
tests) fail with minimum folio size patches applied[1].

Fixes: b4fa966f03b7 ("mm, netfs, fscache: stop read optimisation when folio removed from pagecache")
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
 mm/truncate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 4d61fbdd4b2f..0668cd340a46 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -157,7 +157,7 @@ static void truncate_cleanup_folio(struct folio *folio)
 	if (folio_mapped(folio))
 		unmap_mapping_folio(folio);
 
-	if (folio_has_private(folio))
+	if (folio_needs_release(folio))
 		folio_invalidate(folio, 0, folio_size(folio));
 
 	/*
@@ -219,7 +219,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	if (!mapping_inaccessible(folio->mapping))
 		folio_zero_range(folio, offset, length);
 
-	if (folio_has_private(folio))
+	if (folio_needs_release(folio))
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;

