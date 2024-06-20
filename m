Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DEC911216
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2024 21:30:29 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F4edSRb6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F4edSRb6;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W4rDd6pmwz3cXd
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 05:30:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F4edSRb6;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F4edSRb6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W4rDY36Ztz3cVn
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 05:30:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718911817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwdtAySFtKK2OLXgT+61d7SC+sWlPRojSuQ75KtZ2Nc=;
	b=F4edSRb6ynBaiSuiXwJwObT/OOz6H80H/cYp53iIw41wc+lRWkMpwFA/RbFvIlrtxfEz/A
	PfdlTuG9kpttbESILL7Z8aXFyJuCbCozTG1X4T9nxzMCXjd3ghTFqvP4X/sekW2gfsMRBK
	8EIr9o9SeKmFr7fDBxTZOd2C3TeF4pA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718911817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwdtAySFtKK2OLXgT+61d7SC+sWlPRojSuQ75KtZ2Nc=;
	b=F4edSRb6ynBaiSuiXwJwObT/OOz6H80H/cYp53iIw41wc+lRWkMpwFA/RbFvIlrtxfEz/A
	PfdlTuG9kpttbESILL7Z8aXFyJuCbCozTG1X4T9nxzMCXjd3ghTFqvP4X/sekW2gfsMRBK
	8EIr9o9SeKmFr7fDBxTZOd2C3TeF4pA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-A6ZZI-hHP42woi_qbb99ZA-1; Thu,
 20 Jun 2024 15:30:13 -0400
X-MC-Unique: A6ZZI-hHP42woi_qbb99ZA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81A401956088;
	Thu, 20 Jun 2024 19:30:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.156])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E2001956087;
	Thu, 20 Jun 2024 19:30:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-10-dhowells@redhat.com>
References: <20240620173137.610345-10-dhowells@redhat.com> <20240620173137.610345-1-dhowells@redhat.com>
Subject: [PATCH v2 09/17] cifs: Defer read completion
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <612370.1718911800.1@warthog.procyon.org.uk>
Date: Thu, 20 Jun 2024 20:30:00 +0100
Message-ID: <612371.1718911800@warthog.procyon.org.uk>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Oops - a bit of debugging code had got left in this patch and I forgot to
fill out the description.  Updated patch attached.

David
---
cifs: Defer read completion

Defer read completion from the I/O thread to the cifsiod thread so as not
to slow down the I/O thread.  This restores the behaviour of v6.9.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2pdu.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 38a06e8a0f90..e213cecd5094 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4484,6 +4484,16 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	return rc;
 }
 
+static void smb2_readv_worker(struct work_struct *work)
+{
+	struct cifs_io_subrequest *rdata =
+		container_of(work, struct cifs_io_subrequest, subreq.work);
+
+	netfs_subreq_terminated(&rdata->subreq,
+				(rdata->result == 0 || rdata->result == -EAGAIN) ?
+				rdata->got_bytes : rdata->result, true);
+}
+
 static void
 smb2_readv_callback(struct mid_q_entry *mid)
 {
@@ -4578,9 +4588,8 @@ smb2_readv_callback(struct mid_q_entry *mid)
 			rdata->result = 0;
 	}
 	rdata->credits.value = 0;
-	netfs_subreq_terminated(&rdata->subreq,
-				(rdata->result == 0 || rdata->result == -EAGAIN) ?
-				rdata->got_bytes : rdata->result, true);
+	INIT_WORK(&rdata->subreq.work, smb2_readv_worker);
+	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
 }

