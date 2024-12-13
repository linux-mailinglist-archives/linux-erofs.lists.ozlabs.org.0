Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D56A9F0DB5
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 14:50:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8rMZ1Jntz3bcV
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 00:50:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734097847;
	cv=none; b=BAEg/1O2bUnEEF6iqHINyRAXWef11Q0Jfs6nJY0bgEbx7qOZ1jBEXeRdXeAvgQoORlNbYYyLoMtlzN3tJRyMPHNxC6lO0139N1Fgr95fxaFR5dQBe385dfyI9Ax2mb50TXlBnJpqb0nzz+PWjxv4bBI0N3rpYnSlnijMVrpk1ZVFm2IjdPuPRc9ughc7hz2vAzhOjs7qwie7xT06fAIKmNfN90A0oMHrd9MA7KtCsWumEF6RxLPVRtt8mZVP7gpBnmjdFv15FFQIlIpOKLeGqOlwX1Pj60FXbnZMzSiEJfN8rKistLni+9DtdpFRyjzI0bNnJhAwB4JjU6e+oj/nnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734097847; c=relaxed/relaxed;
	bh=XyqR/WjDCwAE5X+NDEcLa5xYMEUn9QBuN0OBrTmThCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBDJo5+YbKmxjXjlFWpy2FFDSc3q8+Tnce7eSMCgjg179Utibf6+3bWec22hWB+sDjgcUeUT+wUIpu+NsayW0XZzIVz5HJxyoZvHVGfRdtAaLjDElNVsKhr0MV3RBQ8uQ2gxiyJll3KvobkrO/sKP4kBLydnooSOuVXdS+5mFWv0EXZHirAtSWvXhmLZzHE2xzQorg/I+4qL0QT/BOrLTpdiu33He9F1EdVm/7K05YR0lqXfBa+NTqMsPcM1LrVvTuuey0vIahDordtjxflJ6czvi4Jvco+gtBK5EvQVKNe5fMOjaXJxW8dJ00+yYXpysrGgJL8W+npAvam5GXRxww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rgc7YuW9; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rgc7YuW9; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rgc7YuW9;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rgc7YuW9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8rMV5yzGz30hC
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Dec 2024 00:50:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyqR/WjDCwAE5X+NDEcLa5xYMEUn9QBuN0OBrTmThCY=;
	b=Rgc7YuW9JNB//oZMuTVw7KwzVTQrGrFlf9xWClLXtH5PrC6i37r51AuCNiUccM8+YojxA1
	iZHWFr4uTngWfXMm3tVmDEqXaUT5J6pvAczXHANEGNkBKEXobgGWN+70yBuWdsJu93tP2Z
	ynrBp9dzQoLOkh5pDU7KAJzVH/YF3vg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyqR/WjDCwAE5X+NDEcLa5xYMEUn9QBuN0OBrTmThCY=;
	b=Rgc7YuW9JNB//oZMuTVw7KwzVTQrGrFlf9xWClLXtH5PrC6i37r51AuCNiUccM8+YojxA1
	iZHWFr4uTngWfXMm3tVmDEqXaUT5J6pvAczXHANEGNkBKEXobgGWN+70yBuWdsJu93tP2Z
	ynrBp9dzQoLOkh5pDU7KAJzVH/YF3vg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73--YEkMWSgNkChCQp0_JqhQQ-1; Fri,
 13 Dec 2024 08:50:40 -0500
X-MC-Unique: -YEkMWSgNkChCQp0_JqhQQ-1
X-Mimecast-MFC-AGG-ID: -YEkMWSgNkChCQp0_JqhQQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7662919560AF;
	Fri, 13 Dec 2024 13:50:37 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1BF2F1956089;
	Fri, 13 Dec 2024 13:50:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 02/10] netfs: Fix non-contiguous donation between completed reads
Date: Fri, 13 Dec 2024 13:50:02 +0000
Message-ID: <20241213135013.2964079-3-dhowells@redhat.com>
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
Cc: Shyam Prasad N <nspmangalore@gmail.com>, linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, Steve French <sfrench@samba.org>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, ceph-devel@vger.kernel.org, Paulo Alcantara <pc@manguebit.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When a read subrequest finishes, if it doesn't have sufficient coverage to
complete the folio(s) covering either side of it, it will donate the excess
coverage to the adjacent subrequests on either side, offloading
responsibility for unlocking the folio(s) covered to them.

Now, preference is given to donating down to a lower file offset over
donating up because that check is done first - but there's no check that
the lower subreq is actually contiguous, and so we can end up donating
incorrectly.

The scenario seen[1] is that an 8MiB readahead request spanning four 2MiB
folios is split into eight 1MiB subreqs (numbered 1 through 8).  These
terminate in the order 1,6,2,5,3,7,4,8.  What happens is:

	- 1 donates to 2
	- 6 donates to 5
	- 2 completes, unlocking the first folio (with 1).
	- 5 completes, unlocking the third folio (with 6).
	- 3 donates to 4
	- 7 donates to 4 incorrectly
	- 4 completes, unlocking the second folio (with 3), but can't use
	  the excess from 7.
	- 8 donates to 4, also incorrectly.

Fix this by preventing downward donation if the subreqs are not contiguous
(in the example above, 7 donates to 4 across the gap left by 5 and 6).

Reported-by: Shyam Prasad N <nspmangalore@gmail.com>
Closes: https://lore.kernel.org/r/CANT5p=qBwjBm-D8soFVVtswGEfmMtQXVW83=TNfUtvyHeFQZBA@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/526707.1733224486@warthog.procyon.org.uk/ [1]
---
 fs/netfs/read_collect.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 3cbb289535a8..b415e3972336 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -247,16 +247,17 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 
 	/* Deal with the trickiest case: that this subreq is in the middle of a
 	 * folio, not touching either edge, but finishes first.  In such a
-	 * case, we donate to the previous subreq, if there is one, so that the
-	 * donation is only handled when that completes - and remove this
-	 * subreq from the list.
+	 * case, we donate to the previous subreq, if there is one and if it is
+	 * contiguous, so that the donation is only handled when that completes
+	 * - and remove this subreq from the list.
 	 *
 	 * If the previous subreq finished first, we will have acquired their
 	 * donation and should be able to unlock folios and/or donate nextwards.
 	 */
 	if (!subreq->consumed &&
 	    !prev_donated &&
-	    !list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
+	    !list_is_first(&subreq->rreq_link, &rreq->subrequests) &&
+	    subreq->start == prev->start + prev->len) {
 		prev = list_prev_entry(subreq, rreq_link);
 		WRITE_ONCE(prev->next_donated, prev->next_donated + subreq->len);
 		subreq->start += subreq->len;

