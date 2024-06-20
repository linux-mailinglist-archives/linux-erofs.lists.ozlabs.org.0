Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8055F910EB8
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2024 19:33:26 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UvQWKUzf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VcOdI4K7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W4ndb14Gpz3cT9
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 03:33:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UvQWKUzf;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VcOdI4K7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W4ndW3hRVz2xQH
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 03:33:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ts5ZCKmEyEPwC8pHpdqPl9OxtkpjpqDkyGOj4sN+myw=;
	b=UvQWKUzfuQ3IO5MlDBMNI1ap5zxzhO0+jz9b2M3/PdKIJqpi5zTeM84YCjIuiRFtYCwwxe
	Xos7MTdSFsY9oujJz5K5gcClizDdWQkoVGMVaOqxm1l4uFUlxpF34zjgZMVCe+PNBTtP97
	ChthCSLesdaYnN6dFPLJnPhsSKRQjMA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ts5ZCKmEyEPwC8pHpdqPl9OxtkpjpqDkyGOj4sN+myw=;
	b=VcOdI4K7XaoPKWwZ2CTjVklO0uYPlaBltIPw/3G/ZNf5rcjx3CE6Yy6+oe+8/Bvosi2pd0
	4CeIP/cFuY8tZd3v3a0ilLeNSdzUgpYW1PzHRP68lYk+WSJG8WgJTArjA/jE+QR7HXQQpr
	UoSNveiL8MceN+UdLFNm8o4TK4sgKlQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-OqI8PTsvNIisGVH6w9IAGQ-1; Thu,
 20 Jun 2024 13:33:14 -0400
X-MC-Unique: OqI8PTsvNIisGVH6w9IAGQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C42B1956056;
	Thu, 20 Jun 2024 17:33:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 340171955E80;
	Thu, 20 Jun 2024 17:32:56 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 09/17] cifs: Defer read completion
Date: Thu, 20 Jun 2024 18:31:27 +0100
Message-ID: <20240620173137.610345-10-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

---
 fs/smb/client/smb2pdu.c      | 15 ++++++++++++---
 include/trace/events/netfs.h |  7 +++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

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
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index fc5dbd19f120..db603a4e22cd 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -412,6 +412,7 @@ TRACE_EVENT(netfs_folio,
 		    __field(ino_t,			ino)
 		    __field(pgoff_t,			index)
 		    __field(unsigned int,		nr)
+		    __field(bool,			ra_trigger)
 		    __field(enum netfs_folio_trace,	why)
 			     ),
 
@@ -420,11 +421,13 @@ TRACE_EVENT(netfs_folio,
 		    __entry->why = why;
 		    __entry->index = folio_index(folio);
 		    __entry->nr = folio_nr_pages(folio);
+		    __entry->ra_trigger = folio_test_readahead(folio);
 			   ),
 
-	    TP_printk("i=%05lx ix=%05lx-%05lx %s",
+	    TP_printk("i=%05lx ix=%05lx-%05lx %s%s",
 		      __entry->ino, __entry->index, __entry->index + __entry->nr - 1,
-		      __print_symbolic(__entry->why, netfs_folio_traces))
+		      __print_symbolic(__entry->why, netfs_folio_traces),
+		      __entry->ra_trigger ? " *RA*" : "")
 	    );
 
 TRACE_EVENT(netfs_write_iter,

