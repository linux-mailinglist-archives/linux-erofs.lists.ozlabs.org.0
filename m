Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A6D95D2AF
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 18:12:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wr4qF3yvNz302D
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 02:12:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724429575;
	cv=none; b=YGw4kkixIs6AVtcKAhzx1bTmXevgbUEBfHNqKxYJ5orazXUMz+FBIiur/zlcrPV9t4/XG56e1mWpPajHIRED1RFfYbgRedAoI9kEaECqY2zzfRsPUIhNS+zCjJ032+Vkc383v11FJdbrzaQzdqJrSljz9Rr9aRa7+a25CZQOI/+ejvQAHPhgyIGqLCcD7VLmna2JGTkwPDFYWUASUv5TquCUMYHj/FVhwbN+f5rzQimff+ONvPVfyyItdhbd/ca6fWfPyt0s9pfb8PswqZ1rrNyQtDVsklYF/wn0ta9xjhOXADChhpnBu8BMdn0sMFa9GSrifkBPatFX1dP6PSVvdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724429575; c=relaxed/relaxed;
	bh=C4kdxje9pJwe2F8kxgsN+SQonQ75sAMbOz8YwNBazmI=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=KWImCYUMAJHGI4fhGcXL8OMGkBpl4U24Qtu+zU8Ue3WqCx9ObQSVgbTEw1o5mItoqy5I3aQoc7hG2QD5EYOuTnGrXK1XMzZrk85onDqtw/aMRfHGqLKbiPwLasIeF+PX+si+r+lrjNpg2zz5NI73BSbuaFjFe38DAybtrPRJzPVvki1TRusZI3S8KghKTqr5JlS8U63xc8BE3QTWr40mhy82nJdI7Y3LWPQZKV6bEUjVzl1QXK6YQgzR4YZfeD6R0R92uikGo7KO+vLoCFt6IB6RnwP6DqdyuZ8+N0zrQt97LAmF/dCd9pASAdOdJ5LqXVJzKlTgvc+YiKPH/nnXRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LpWj2SkP; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TwLEnlth; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LpWj2SkP;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TwLEnlth;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wr4qB6xPLz2ytN
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 02:12:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4kdxje9pJwe2F8kxgsN+SQonQ75sAMbOz8YwNBazmI=;
	b=LpWj2SkP51jpUmkjArjNRAdXzF9hZhS/XCQwcbfMJ5Dv6DNul3TkRGeA/VBqXAOSSaGLY6
	3eSmKPU43PAwi5Ue9CsxbVZRAtobdLsuCu6nHWj6AERw6wwEkUnVf7ewW5dkYA44mCBq1R
	7ECo28grhBTUnRaCfNtoLwZ0Xst5I18=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4kdxje9pJwe2F8kxgsN+SQonQ75sAMbOz8YwNBazmI=;
	b=TwLEnlthX9rOYg98Xon+OSkg5xRz/p7wVSuwbQ/jpwwxsgvac5mFOsUIeSQJt961EcZI0/
	M5CdDRImWTSBCOFGoyCW1a0HRG4xk8Z0CqGIcJT/860mL62GJDR5PamOdzE7Ttg77OfEKi
	5In9uMtQJ/tr8yqwgDeQ7mCFohXSNI0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-tWlcgTiVMRa8lhTgu6q_UA-1; Fri,
 23 Aug 2024 12:12:44 -0400
X-MC-Unique: tWlcgTiVMRa8lhTgu6q_UA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFCD01955D47;
	Fri, 23 Aug 2024 16:12:41 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B46D19560A3;
	Fri, 23 Aug 2024 16:12:37 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 4/5] cifs: Fix short read handling
Date: Fri, 23 Aug 2024 17:12:05 +0100
Message-ID: <20240823161209.434705-5-dhowells@redhat.com>
In-Reply-To: <20240823161209.434705-1-dhowells@redhat.com>
References: <20240823161209.434705-1-dhowells@redhat.com>
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Steve French <sfrench@samba.org>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Paulo Alcantara <pc@manguebit.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix smb2_readv_callback() to always take -ENODATA as indicating we hit EOF
and to always set the NETFS_SREQ_HIT_EOF flag rather than only doing it
under some circumstances.

Fixes: 942ad91e2956 ("netfs, cifs: Fix handling of short DIO read")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2pdu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index e182fdbec887..9829784e8ec5 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4601,16 +4601,8 @@ smb2_readv_callback(struct mid_q_entry *mid)
 				     rdata->got_bytes);
 
 	if (rdata->result == -ENODATA) {
-		/* We may have got an EOF error because fallocate
-		 * failed to enlarge the file.
-		 */
-		if (rdata->subreq.start + rdata->subreq.transferred < rdata->subreq.rreq->i_size)
-			rdata->result = 0;
-		if (rdata->subreq.start + rdata->subreq.transferred + rdata->got_bytes >=
-		    ictx->remote_i_size) {
-			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
-			rdata->result = 0;
-		}
+		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+		rdata->result = 0;
 	} else {
 		if (rdata->got_bytes < rdata->actual_len &&
 		    rdata->subreq.start + rdata->subreq.transferred + rdata->got_bytes ==

