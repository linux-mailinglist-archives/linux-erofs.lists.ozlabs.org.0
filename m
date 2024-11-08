Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B03F49C22A3
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Nov 2024 18:03:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XlQJR24Frz3c1D
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Nov 2024 04:03:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731085429;
	cv=none; b=ZfIr15NP6fQCnMkNaFZUf/1AhE+fTk9FzVOCRDRjCldXWtLxoH/vRxOfJEpw2lZnFUFkaX4h+5msMG20Iup+vh2SqFFaNQK52c2Kl1n0ttaM20okeCkEmjvu43ZY5R+0tP4wf9QwaY5MeFtBclSRyAKlgU9KRviOkrMzn++2Gq0cLal719AnNB6YPSpy0ObYh3wP2nCN7KNanr9Zhs3GjEA+uYbKDACuxx+VaFaax1bQWJ1Gh44KDm2Phe2F9SxCvnJ4qjnkc9m9dtaLMvLuw3XqxEXXtE4IEEQd6rLKaM0tn76UmL39lrsXpcoTN+D24+lDbymnzBZm/LkDDWW+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731085429; c=relaxed/relaxed;
	bh=kTE7HN+soO/Za76tq6046j/ukmrXopkun1LVu89YTbU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=MScQl5nWqWOZgv2vo827qx5aTgQ72iOtOShHNg8hTGLcsWuOkb51Ziws/lCGPywisXiE+JgnuV17BKircuZDaRJvv16xHHHxrzymjfdOKHkjQn92XR/6X5GEFGOecGS4gl0KVB9hGBv+aPrGUsULL2kiLHJzSjwLfmAXTUMwF/93GZZMfsGsnq49drVnFEXdn1p877KPB/+nMSlxh+HfpsrQE3Li3ctejK7c8eN8eJDonADrQNSj01IspCja7G1/p7S1UeuEmUuXn9fSeDYC4Xn/TiCmXvbY/pTS4VXrXO8FXmEZ/6dgfKK8LeknH4wkGcDEOzsTGv0pbP/UBXLY8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6ziPddj; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KzrJP5pO; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6ziPddj;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KzrJP5pO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XlQJM3Nhhz3btt
	for <linux-erofs@lists.ozlabs.org>; Sat,  9 Nov 2024 04:03:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731085420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTE7HN+soO/Za76tq6046j/ukmrXopkun1LVu89YTbU=;
	b=T6ziPddjG8hZJpSalG/+2LIsiO+iimsfZJF4kGKKF5IWCl5Owh3zmCM671iAUeLZHw7UzN
	CImh1y27qmH7pi5V2WGl7Uarh1tz/lSfJ5OzkSticMUDSfNnUX8yU1vXF1EZsgCZLGdm/7
	ah+D2tmM2izZryi+KM0QiUFEI8S+6Pc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731085421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTE7HN+soO/Za76tq6046j/ukmrXopkun1LVu89YTbU=;
	b=KzrJP5pOQTwLPUqr24oDWY6kAzFq1gtyDPjIRakFawuaNbRQFoc7E8T2e00sE38JGXI5NU
	8I/qbOXPpAcGje6T1jQ40BnSdetqfiNRLMFAKm7rQ/ELjpFyCB7sXzhgxw6DK32KJIb1ur
	8N/LGjEuwwPV+xQzv/uaERGRld7oiAE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-d2vfCBO4PnGWgeJI8QflhA-1; Fri,
 08 Nov 2024 12:03:36 -0500
X-MC-Unique: d2vfCBO4PnGWgeJI8QflhA-1
X-Mimecast-MFC-AGG-ID: d2vfCBO4PnGWgeJI8QflhA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE2041955EA1;
	Fri,  8 Nov 2024 17:03:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03B2C1953880;
	Fri,  8 Nov 2024 17:03:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-29-dhowells@redhat.com>
References: <20241106123559.724888-29-dhowells@redhat.com> <20241106123559.724888-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 28/33] netfs: Change the read result collector to only use one work item
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1321311.1731085403.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Nov 2024 17:03:23 +0000
Message-ID: <1321312.1731085403@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch needs the attached adjustment folding in.

David
---
commit 2c0cccc7b29a051fadb6816d31f526e4dd45ddf5
Author: David Howells <dhowells@redhat.com>
Date:   Thu Nov 7 22:22:49 2024 +0000

    netfs: Fix folio abandonment
    =

    The mechanism to handle the abandonment of a folio being read due to a=
n
    error occurring in a subrequest (such as if a signal occurs) will corr=
ectly
    abandon folios if they're entirely processed in one go; but if the
    constituent subrequests aren't processed in the same scheduled work it=
em,
    the note that the first one failed will get lost if no folios are proc=
essed
    (the ABANDON_SREQ note isn't transferred to the NETFS_RREQ_FOLIO_ABAND=
ON
    flag unless we process a folio).
    =

    Fix this by simplifying the way the mechanism works.  Replace the flag=
 with
    a variable that records the file position to which we should abandon
    folios.  Any folio that overlaps this region at the time of unlocking =
must
    be abandoned (and reread).
    =

    This works because subrequests are processed in order of file position=
 and
    each folio is processed as soon as enough subrequest transference is
    available to cover it - so when the abandonment point is moved, it cov=
ers
    only folios that draw data from the dodgy region.
    =

    Also make sure that NETFS_SREQ_FAILED is set on failure and that
    stream->failed is set when we cut the stream short.
    =

    Signed-off: David Howells <dhowells@redhat.com>
    cc: Jeff Layton <jlayton@kernel.org>
    cc: netfs@lists.linux.dev
    cc: linux-fsdevel@vger.kernel.org

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 73f51039c2fe..7f3a3c056c6e 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -46,7 +46,7 @@ static void netfs_unlock_read_folio(struct netfs_io_requ=
est *rreq,
 	struct netfs_folio *finfo;
 	struct folio *folio =3D folioq_folio(folioq, slot);
 =

-	if (unlikely(test_bit(NETFS_RREQ_FOLIO_ABANDON, &rreq->flags))) {
+	if (unlikely(folio_pos(folio) < rreq->abandon_to)) {
 		trace_netfs_folio(folio, netfs_folio_trace_abandon);
 		goto just_unlock;
 	}
@@ -126,8 +126,6 @@ static void netfs_read_unlock_folios(struct netfs_io_r=
equest *rreq,
 =

 		if (*notes & COPY_TO_CACHE)
 			set_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
-		if (*notes & ABANDON_SREQ)
-			set_bit(NETFS_RREQ_FOLIO_ABANDON, &rreq->flags);
 =

 		folio =3D folioq_folio(folioq, slot);
 		if (WARN_ONCE(!folio_test_locked(folio),
@@ -152,7 +150,6 @@ static void netfs_read_unlock_folios(struct netfs_io_r=
equest *rreq,
 		*notes |=3D MADE_PROGRESS;
 =

 		clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
-		clear_bit(NETFS_RREQ_FOLIO_ABANDON, &rreq->flags);
 =

 		/* Clean up the head folioq.  If we clear an entire folioq, then
 		 * we can get rid of it provided it's not also the tail folioq
@@ -251,6 +248,12 @@ static void netfs_collect_read_results(struct netfs_i=
o_request *rreq)
 			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &front->flags))
 				notes |=3D COPY_TO_CACHE;
 =

+			if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
+				rreq->abandon_to =3D front->start + front->len;
+				front->transferred =3D front->len;
+				transferred =3D front->len;
+				trace_netfs_rreq(rreq, netfs_rreq_trace_set_abandon);
+			}
 			if (front->start + transferred >=3D rreq->cleaned_to + fsize ||
 			    test_bit(NETFS_SREQ_HIT_EOF, &front->flags))
 				netfs_read_unlock_folios(rreq, &notes);
@@ -268,6 +271,7 @@ static void netfs_collect_read_results(struct netfs_io=
_request *rreq)
 				stream->error =3D front->error;
 				rreq->error =3D front->error;
 				set_bit(NETFS_RREQ_FAILED, &rreq->flags);
+				stream->failed =3D true;
 			}
 			notes |=3D MADE_PROGRESS | ABANDON_SREQ;
 		} else if (test_bit(NETFS_SREQ_NEED_RETRY, &front->flags)) {
@@ -566,6 +570,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subr=
equest *subreq)
 			__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 		} else {
 			netfs_stat(&netfs_n_rh_download_failed);
+			__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
 		}
 		trace_netfs_rreq(rreq, netfs_rreq_trace_set_pause);
 		set_bit(NETFS_RREQ_PAUSE, &rreq->flags);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c00cffa1da13..4af7208e1360 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -260,6 +260,7 @@ struct netfs_io_request {
 	atomic64_t		issued_to;	/* Write issuer folio cursor */
 	unsigned long long	collected_to;	/* Point we've collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
+	unsigned long long	abandon_to;	/* Position to abandon folios to */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
 	unsigned char		front_folio_order; /* Order (size) of front folio */
 	refcount_t		ref;
@@ -271,7 +272,6 @@ struct netfs_io_request {
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes =
*/
 #define NETFS_RREQ_FOLIO_COPY_TO_CACHE	6	/* Copy current folio to cache f=
rom read */
-#define NETFS_RREQ_FOLIO_ABANDON	7	/* Abandon failed folio from read */
 #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
 #define NETFS_RREQ_NONBLOCK		9	/* Don't block if possible (O_NONBLOCK) */
 #define NETFS_RREQ_BLOCKED		10	/* We blocked */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index cf14545ca2bd..22eb77b1f5e6 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -56,6 +56,7 @@
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
 	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\
 	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
+	EM(netfs_rreq_trace_set_abandon,	"S-ABNDN")	\
 	EM(netfs_rreq_trace_set_pause,		"PAUSE  ")	\
 	EM(netfs_rreq_trace_unlock,		"UNLOCK ")	\
 	EM(netfs_rreq_trace_unlock_pgpriv2,	"UNLCK-2")	\

