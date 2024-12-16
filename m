Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDEA9F3B48
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:44:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBsQ02Ds1z30RJ
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 07:44:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734381895;
	cv=none; b=cgrOn1YLamGvEP+BJNSre5UqumsjrzkiqDdEWjyQ8JHv61WPSP3zrvNdZuwNUYyEu7z7zV9U4UKfrAhx9O7JGCKnWCCIJ94rr/BGgkJC9Bx1M+4bvKjj0VVd6+GcxeEN4Wt/+dziU7C6ompxHLkG3Q2KgS84D/sZWn3p1OQHuslPhtReSpdFs7386IyUoVfQjkzhMU1Jgj/PEviPi4mF4dmSFCif5GF6ki8gcss4dpCjrcrRrvQ/IyuTz55RtUsdvV1Lg/pX6SemOOuKMmiPN1wH6rONAFQfz7cy3gv7HIto71IqlGUTRWxQ9xwkVzoZaDcAEkVWt1KSbcB+lJpv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734381895; c=relaxed/relaxed;
	bh=OD7OFhROQKelkcByNJaNSCbQEDK9VQdKlLwzfBYpReY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKjHpRgq+aTqhETD/MCBh3sCRwqQrAiPuK0SdFB+vldxa/jiv4zDYd6s6WjNQ+91kofdCzK2svvmIhlWG6P+Q/Clf76aVkOPjRhZRnf/09OriInw34363own8c2rrByq07Ul68M4V1OWJ4mp1sPUSfRsCHF/jNgcS2S/8T2ReJc1i47Cnb3Xf9KeQF7RuPvDI/m3xfnX8BuVQG0bNP0dloHOuZnHxZ8p9R2xrUi2cwB+jrId4mQE6XXDbI9+h+aMAa4hquTNR9R3p4D0aUFOuDsGbpsb56EcnUJw1nyr8IUsgjs3aeVazoh7al1fzBxnwt8mV+JkpQg0QCNjd347VA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UvDzA9nt; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FMGdOIND; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UvDzA9nt;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FMGdOIND;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBsPy3hVpz2y8V
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Dec 2024 07:44:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OD7OFhROQKelkcByNJaNSCbQEDK9VQdKlLwzfBYpReY=;
	b=UvDzA9ntHMCtwMYmvdTk/0mZs1iOaLNfMAy7f+iaNOYz3l8b9e35SrmEZf/Jg57wDvRq2m
	uF23y+CB5M8OeGJBX7HC6mPYYvCoSPU8ES2Dd9Xs67A63BKbjb8yY6gmz61w/onUCoEp7s
	/6Kpu41ChoO5p9tFPE8O8XRU774Jtc0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OD7OFhROQKelkcByNJaNSCbQEDK9VQdKlLwzfBYpReY=;
	b=FMGdOINDDIP0DE83sQeq1lI7xUiIapyjBD45T8rBdxyYQrrpTxELKQkdZhex77EOTQ5yjQ
	bqsr5R6pt2BrKUpXonT7twQm8NANxu6QrVsgm8r6PY2pGL4UTUv/hXnrhlXkbmz72JMROF
	buBEDNvALozHLxyMPA/6fSdmyP5Ce4A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-f8sLclnoMPWiiWVwG3_7qA-1; Mon,
 16 Dec 2024 15:44:48 -0500
X-MC-Unique: f8sLclnoMPWiiWVwG3_7qA-1
X-Mimecast-MFC-AGG-ID: f8sLclnoMPWiiWVwG3_7qA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0E1719560A1;
	Mon, 16 Dec 2024 20:44:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3908430044C1;
	Mon, 16 Dec 2024 20:44:40 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 26/32] Display waited-on page index after 1min of waiting
Date: Mon, 16 Dec 2024 20:41:16 +0000
Message-ID: <20241216204124.3752367-27-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

---
 mm/filemap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f61cf51c2238..1b6ab9915bc8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1236,6 +1236,8 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	bool thrashing = false;
 	unsigned long pflags;
 	bool in_thrashing;
+	pgoff_t index = folio->index;
+	long timeout = 60 * HZ;
 
 	if (bit_nr == PG_locked &&
 	    !folio_test_uptodate(folio) && folio_test_workingset(folio)) {
@@ -1305,7 +1307,14 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 			if (signal_pending_state(state, current))
 				break;
 
-			io_schedule();
+			if (timeout > 0) {
+				timeout = io_schedule_timeout(timeout);
+				if (timeout <= 0)
+					pr_warn("folio wait took too long (ix=%lx)\n",
+						index);
+			} else {
+				io_schedule();
+			}
 			continue;
 		}
 

