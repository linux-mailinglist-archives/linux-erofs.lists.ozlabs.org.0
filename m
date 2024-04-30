Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BF48B77F6
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 16:02:31 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WRmTiO5X;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AV3lvWcf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VTMMn1HMPz3cTZ
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 00:02:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WRmTiO5X;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AV3lvWcf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VTMMV56Ymz3cRh
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 May 2024 00:02:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjFRfxxSIhn/sZySlzA+YPg8ujVk0zbXsyNAbtLG88o=;
	b=WRmTiO5XOrVbdJe3hyVSWzSmUbxUlvxgPBPPyrDFn55MD/gZsit8rlBNcFUaLj+T56GbvX
	x/tmeX0bnGp9JaqwcsSceqbN0sCTqgJuRqWnDK0c5dYMF9dvVm2H7P6X+n4jAOzJPpm5lz
	h7ODe2oCiyKkFW60wLnt2Z2ImyEblbc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjFRfxxSIhn/sZySlzA+YPg8ujVk0zbXsyNAbtLG88o=;
	b=AV3lvWcfF1BVU4qbOoD6utc3zKAzJplt8bUPZai8M55q2AiVL3f45rCmQQCUYocz50wQVK
	4ks9GvN9FU5409C45VR57wNaJTHqtmSGGh/XY+XzY09xLaY7F3giAAEd6rej2O5Wr6dahd
	84AKgRiMJ58TtJ96sn/SPxqx725XyQY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-ESWFmT24OQqLiwHsx02-fA-1; Tue, 30 Apr 2024 10:02:03 -0400
X-MC-Unique: ESWFmT24OQqLiwHsx02-fA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9306E834FBF;
	Tue, 30 Apr 2024 14:01:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD5441C0654E;
	Tue, 30 Apr 2024 14:01:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 12/22] mm: Export writeback_iter()
Date: Tue, 30 Apr 2024 15:00:43 +0100
Message-ID: <20240430140056.261997-13-dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-1-dhowells@redhat.com>
References: <20240430140056.261997-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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
Cc: David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, Christoph Hellwig <hch@lst.de>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-afs@lists.infradead.org, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Export writeback_iter() so that it can be used by netfslib as a module.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Christoph Hellwig <hch@lst.de>
cc: linux-mm@kvack.org
---

Notes:
    Changes
    =======
    ver #2)
     - Mark the symbol _GPL.

 mm/page-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e19b87049db..06fc89d981e8 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2546,6 +2546,7 @@ struct folio *writeback_iter(struct address_space *mapping,
 	folio_batch_release(&wbc->fbatch);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(writeback_iter);
 
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.

