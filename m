Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 795AB9F0DC6
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 14:51:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8rNN3YD8z3c7d
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 00:51:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734097890;
	cv=none; b=KXJULSGox6ujtEfdRMFaciLQtmSH0DTmPc2/CABrHi3GaAdf7plj0O9bvoMW6yADw+5Hurqzz3Ck336RRS4G5iRcJbLsKW6NX1kpXDUdS54LVa1KLwEPYS1+9ONpJc5L1zoo8vBhw3OICTm4jcM5+Grc6BPsJDxyRgegnNEJu6O+UEZDHMIvT+0YIJZEn3s8yd8xf3qXlpvscMJVbgJuUSCgkkFAPaUnJ8h4Sk0u/qtxX3LRrLXRh3C+zHrMkqsyJ8dKnfMq13BJCO/oMIc7qFNzIcMRxYKmwWmFSwGz3htZGTld74hnK8lxnhvwIYkF8ytroyTL2GJlEkS+GY5oLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734097890; c=relaxed/relaxed;
	bh=uxmqCJdKFxLw/y1tKF8ZCDzW6SWRkgRIhZKChhoKrx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJ9JPdwhyU1p0QGBuJ2vRIzvFVDEb13mYtL7ZJOO1GZSCF31HfzZDlfW3bwjoQvpTMy6vNgbStJm20FpT8LrLKIT5vuT/liMSXbrwmKm9y0Q7xLWwrDuFjvtNv0l6vzqA0W2Pgf+GJrUTp8ROmpDoK++XBJwklcEgUZf8dTeUO5iTTXHK6PCjwKj2mecMAQsFrZEpHE7LL/+98ocN3dIV6OLBU19HvlweS8pD/qfHqU0qNGufTpKYZOGJKBimkBhpx00NKaak5JOfVL/oROtKDDrpOblOPnX1r0eTSGJdTNa3neBKsUrTWfEPz0fGTx9hT1FKLfjv4dM2dXykUoGAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EPTCGeJn; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=etPuia+Y; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EPTCGeJn;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=etPuia+Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8rNK3FRdz3bTJ
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Dec 2024 00:51:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxmqCJdKFxLw/y1tKF8ZCDzW6SWRkgRIhZKChhoKrx8=;
	b=EPTCGeJnLv5NK6U38fRYUO0oBtth0p5AaSoH85boTKbDnwwysck1/w3Vf46s4ieew9uaD5
	g5SNHne7UJQGOep4s07JHwZjWHqvYp5oK7p52xjJeMFNMIlhvAU50mExsW8W9mGmqjgHgH
	Y11OlbfNJwak05ovsBQ5hdYNHACF7kw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxmqCJdKFxLw/y1tKF8ZCDzW6SWRkgRIhZKChhoKrx8=;
	b=etPuia+YlR7Hm67piKIC+ZuvqSVxGJ+c958fSfA38WjN+UUcmiY3/0/mp1XhTlgUIgXUwC
	trhssI5YeevnnJ25DmxEuoVlLoWr65sSKdR23TRMJxzfHJYHTcriCibg98COSpLEyMNKgg
	Pv7khOSaNyZQxjgepapb9KnLhOXIYZk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-dpcO627eMBu77q5ky2OXKQ-1; Fri,
 13 Dec 2024 08:51:23 -0500
X-MC-Unique: dpcO627eMBu77q5ky2OXKQ-1
X-Mimecast-MFC-AGG-ID: dpcO627eMBu77q5ky2OXKQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AFF11955E95;
	Fri, 13 Dec 2024 13:51:21 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 643061956086;
	Fri, 13 Dec 2024 13:51:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 09/10] netfs: Fix ceph copy to cache on write-begin
Date: Fri, 13 Dec 2024 13:50:09 +0000
Message-ID: <20241213135013.2964079-10-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
Cc: linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

At the end of netfs_unlock_read_folio() in which folios are marked
appropriately for copying to the cache (either with by being marked dirty
and having their private data set or by having PG_private_2 set) and then
unlocked, the folio_queue struct has the entry pointing to the folio
cleared.  This presents a problem for netfs_pgpriv2_write_to_the_cache(),
which is used to write folios marked with PG_private_2 to the cache as it
expects to be able to trawl the folio_queue list thereafter to find the
relevant folios, leading to a hang.

Fix this by not clearing the folio_queue entry if we're going to do the
deprecated copy-to-cache.  The clearance will be done instead as the folios
are written to the cache.

This can be reproduced by starting cachefiles, mounting a ceph filesystem
with "-o fsc" and writing to it.

Fixes: 796a4049640b ("netfs: In readahead, put the folio refs as soon extracted")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Closes: https://lore.kernel.org/r/CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 47ed3a5044e2..e8624f5c7fcc 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -62,10 +62,14 @@ static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
 		} else {
 			trace_netfs_folio(folio, netfs_folio_trace_read_done);
 		}
+
+		folioq_clear(folioq, slot);
 	} else {
 		// TODO: Use of PG_private_2 is deprecated.
 		if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
 			netfs_pgpriv2_mark_copy_to_cache(subreq, rreq, folioq, slot);
+		else
+			folioq_clear(folioq, slot);
 	}
 
 	if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
@@ -77,8 +81,6 @@ static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
 			folio_unlock(folio);
 		}
 	}
-
-	folioq_clear(folioq, slot);
 }
 
 /*

