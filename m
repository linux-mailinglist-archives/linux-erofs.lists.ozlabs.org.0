Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1D695D710
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 22:09:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WrB3q4fpzz304r
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 06:09:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724443749;
	cv=none; b=kJtO/QtQsZxY7G5Bq9WhLCIuV1mifuW/g5cWem7/seTiiYORpQ0pdcj9Bw9elHL2y0hB/WAmwTpCfSVSGnr8oRcPHoTC8hQr6vBIPsgRk5CEW+3anw0ENRySZG3feCER0WGQlEegZEjjOPm6lofwbZ2qksL4cxcyMzI7nkPZQDsgAOLRA1mUVOv/VMm87rKJh5dAqCTul89VHcT6ec0r94Z3wfkygIez98TgpCqWByA6ILikC7+pMINL3BxWkaWXvociX/3PzmDfQ2Nzxo/idyZSUjGCH7xHrPy57TUZRwDOUpTY9xWiKUg36xwfAJdfuTRBRVyqIS40ca7dGETH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724443749; c=relaxed/relaxed;
	bh=J+Q2VjHdhruKVNJRsL+DNuwA1V8DkjXpTij4fAf/kXM=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=SpPRBqLxJ8vTKFvXtMGhAueROem6FAKWAI9WJ/kGKFKrfQfceWgqmxAFrFoaAeEF4c3hp6+1Lm7W+7xM9CbExym4vDvPK42MZWNQhWC3E/xBBCh+pYw+CWOGe9XKmNgwnos4ZCVHPHCCom/97BaoAAvi4qiVNxAXo7xN64NQvrNGM7vKER7csFdgx1qI8dduT7CXEueDIE7BfaoY6oLzQhdFuWwlbmV0zkJKs3AWk8CaZ8U8LGfE2usQiS5SOUAoJPa96xWZCLWDnpwIaLomn4of/PkKAJEuaGUim0RkUEfK+2OGeQgnplC3Z/rysTL9ayzlQKFMgzUaZtQMDCvpUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TO0/Ttlo; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TO0/Ttlo; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TO0/Ttlo;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TO0/Ttlo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WrB3m6pV3z2yXs
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 06:09:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+Q2VjHdhruKVNJRsL+DNuwA1V8DkjXpTij4fAf/kXM=;
	b=TO0/Ttlo1nHVZptc0jDkSwDfZojcak1ILGYqeEVFnhBO8cfFpFPVMr2lMOusR8rJoqfaEh
	NeIaUdBQoK9LOFkzsF1sjBr85XXhTcfdL+DqrAsNGH0kc4h/8rPK5VNAWoT3R3zRfUskUX
	VleR4uZqZs72tOAm8ai8DDRmQASEV/o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+Q2VjHdhruKVNJRsL+DNuwA1V8DkjXpTij4fAf/kXM=;
	b=TO0/Ttlo1nHVZptc0jDkSwDfZojcak1ILGYqeEVFnhBO8cfFpFPVMr2lMOusR8rJoqfaEh
	NeIaUdBQoK9LOFkzsF1sjBr85XXhTcfdL+DqrAsNGH0kc4h/8rPK5VNAWoT3R3zRfUskUX
	VleR4uZqZs72tOAm8ai8DDRmQASEV/o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-iX0mBMvkOMy-sMazWAhTNw-1; Fri,
 23 Aug 2024 16:09:01 -0400
X-MC-Unique: iX0mBMvkOMy-sMazWAhTNw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A0991955D48;
	Fri, 23 Aug 2024 20:08:59 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90C0319560AE;
	Fri, 23 Aug 2024 20:08:54 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 5/9] netfs: Fix missing iterator reset on retry of short read
Date: Fri, 23 Aug 2024 21:08:13 +0100
Message-ID: <20240823200819.532106-6-dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, Paulo Alcantara <pc@manguebit.com>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix netfs_rreq_perform_resubmissions() to reset before retrying a short
read, otherwise the wrong part of the output buffer will be used.

Fixes: 92b6cc5d1e7c ("netfs: Add iov_iters to (sub)requests to describe various buffers")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 5367caf3fa28..4da0a494e860 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -313,6 +313,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 			netfs_reset_subreq_iter(rreq, subreq);
 			netfs_read_from_server(rreq, subreq);
 		} else if (test_bit(NETFS_SREQ_SHORT_IO, &subreq->flags)) {
+			netfs_reset_subreq_iter(rreq, subreq);
 			netfs_rreq_short_read(rreq, subreq);
 		}
 	}

