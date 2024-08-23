Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B16895D2B1
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 18:13:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wr4qJ0KYbz309c
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 02:13:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724429578;
	cv=none; b=Hb3pqQ1k4qIevLoKkwv4wLcPHfUzpWZ5ZSsPuuTedFU+RRvoMDXHnTyjtGgasLcoGQ0nXPTot6FRnAXQz35z5lreuX4ha7dqvn3ALE1md8IjunDjq+f3dqaqS5DaAM7PhOo82H4lx7eG5PXtnAjIv+0RgdWCkld9WOZMRBMdP64AHlP+DVHKYO+mivxj3gaIjDmFLmRR8V0TWHajgOPTNk/YlTpN4Tt6SqFvDtAjDIrgw3Ko7UtOtyUowpKQBp9myyW+UcV2zoed7jPx9v8kHgq1FZfEm/q1GWFWiA3jiAuCHf7ilqG6hVwMpQtXtJQr1YyuPHRA7+U0op3uxWhV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724429578; c=relaxed/relaxed;
	bh=FBChvUZyQ988u9TYFlpOvF0mis7ud805n023OENZupc=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=ecPpR/syYAKb2xwAWSCjAbJQMdNwQNdxMRpehl5Wq8zUzyc2SaDhe2gv8d5zlWfNthwD1SqGcolc4Lc3pgNx7KZGYajbuIhzHhgsf4jPUrUWu+MXQ7Yuvx3akqXnpLj1TQ7nuH55FrvpKk8brw5Maw3Cyzc+mMNmPK33+YK6pAbdP0MaJJX290I9Ylm83e1i69KzLGXP1vVVeZhKVAIVwZ/hqw3e5eLAXVhP9dHHQhlvi5QYFgEdoqnVIS/fSFM42W2SqgzIuflmAZD6oqpLrnc4hZdxrzXuxOSJU4+zb81Cg4MTQbsTmrkmcO68dkFrTLyR9muHn2P75ocC2M7lKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z2BxGL2X; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z2BxGL2X; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z2BxGL2X;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z2BxGL2X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wr4qG17bkz2yyT
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 02:12:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBChvUZyQ988u9TYFlpOvF0mis7ud805n023OENZupc=;
	b=Z2BxGL2XOhofL8edwfiYtjisYD28KWHnNRxyxaGgCnEliUSaa8gwlqYGAjm2oHELG0lCv0
	kH0IWMh+sdiONQasJL2pbBVl60gAlybRaWJUj1u0cihcfl6ragyjIemilxd7LGEUd3mnE/
	VQm4kBhbmk5M3QrdiQcWWcvUL7OcAQM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBChvUZyQ988u9TYFlpOvF0mis7ud805n023OENZupc=;
	b=Z2BxGL2XOhofL8edwfiYtjisYD28KWHnNRxyxaGgCnEliUSaa8gwlqYGAjm2oHELG0lCv0
	kH0IWMh+sdiONQasJL2pbBVl60gAlybRaWJUj1u0cihcfl6ragyjIemilxd7LGEUd3mnE/
	VQm4kBhbmk5M3QrdiQcWWcvUL7OcAQM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-HzxncWQrPICf3GrzTUMYmQ-1; Fri,
 23 Aug 2024 12:12:49 -0400
X-MC-Unique: HzxncWQrPICf3GrzTUMYmQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CFB61954B02;
	Fri, 23 Aug 2024 16:12:47 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 368AE19560A3;
	Fri, 23 Aug 2024 16:12:43 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 5/5] cifs: Fix credit handling
Date: Fri, 23 Aug 2024 17:12:06 +0100
Message-ID: <20240823161209.434705-6-dhowells@redhat.com>
In-Reply-To: <20240823161209.434705-1-dhowells@redhat.com>
References: <20240823161209.434705-1-dhowells@redhat.com>
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Steve French <sfrench@samba.org>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Paulo Alcantara <pc@manguebit.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix some bits of credit handling:

 (1) Use the ->actual_len value rather than the total subrequest length in
     smb2_adjust_credits() so that we don't trip the error message that we
     don't have sufficient credits allocated in a retry.

 (2) Set wdata->actual_len in writes as smb2_adjust_credits() now expects to
     see it set.

 (3) Reset the in_flight_check flag on a retry as we're doing a new read.

 (4) Add a missing credit resubmission trace.

Fixes: 82d55e76bf2f ("cifs: Fix lack of credit renegotiation on read retry")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/file.c    | 9 +++++++++
 fs/smb/client/smb2ops.c | 2 +-
 fs/smb/client/trace.h   | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 493c16e7c4ab..b94802438c62 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -111,6 +111,7 @@ static void cifs_issue_write(struct netfs_io_subrequest *subreq)
 		goto fail;
 	}
 
+	wdata->actual_len = wdata->subreq.len;
 	rc = adjust_credits(wdata->server, wdata, cifs_trace_rw_credits_issue_write_adjust);
 	if (rc)
 		goto fail;
@@ -227,6 +228,14 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 						   &rdata->credits);
 		if (rc)
 			goto out;
+
+		rdata->credits.in_flight_check = 1;
+
+		trace_smb3_rw_credits(rdata->rreq->debug_id,
+				      rdata->subreq.debug_index,
+				      rdata->credits.value,
+				      server->credits, server->in_flight, 0,
+				      cifs_trace_rw_credits_read_resubmit);
 	}
 
 	if (req->cfile->invalidHandle) {
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 20e674990760..5090088ba727 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -301,7 +301,7 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 		    unsigned int /*enum smb3_rw_credits_trace*/ trace)
 {
 	struct cifs_credits *credits = &subreq->credits;
-	int new_val = DIV_ROUND_UP(subreq->subreq.len, SMB2_MAX_BUFFER_SIZE);
+	int new_val = DIV_ROUND_UP(subreq->actual_len, SMB2_MAX_BUFFER_SIZE);
 	int scredits, in_flight;
 
 	if (!credits->value || credits->value == new_val)
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 0f0c10c7ada7..8e9964001e2a 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -30,6 +30,7 @@
 	EM(cifs_trace_rw_credits_old_session,		"old-session") \
 	EM(cifs_trace_rw_credits_read_response_add,	"rd-resp-add") \
 	EM(cifs_trace_rw_credits_read_response_clear,	"rd-resp-clr") \
+	EM(cifs_trace_rw_credits_read_resubmit,		"rd-resubmit") \
 	EM(cifs_trace_rw_credits_read_submit,		"rd-submit  ") \
 	EM(cifs_trace_rw_credits_write_prepare,		"wr-prepare ") \
 	EM(cifs_trace_rw_credits_write_response_add,	"wr-resp-add") \

