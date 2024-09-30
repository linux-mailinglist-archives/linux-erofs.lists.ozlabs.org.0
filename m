Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE0198A342
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2024 14:44:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XHLPd4X3Vz2yyM
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2024 22:44:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727700291;
	cv=none; b=ir6pJtMkGem2xOON6aWSWo5k7kpmGIsH504uK/FvD0DJESIU+dQA9leP1JmJX3HlcoVDWVzMBHuLAKVDxy+hNynKt8uyI+rE5zVJ1AdTLa/Oj9+7B7q/D4YnOpQHqLvp17Vee0MPHydV8BVVQMXK70IPwBEl+WHHMN7xezgC/PaE6LZLZ5hQqTAE2gtSLRT2Bfa/O8ivNrUL08VZZazAb0Iu2ot1BpCeov+R8yRuZt3DQk0JCV8tY16gM4lp06tItKZrAQcDIQ5Svl7o17msheMAeICTqLSwDGMMacRD6B6drNeTzFr5J/lFwMpcfIr8EC+MqgAsFxlgT17UCdBmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727700291; c=relaxed/relaxed;
	bh=6bVDH90pWvwnLUcopy8GzWW9f5uyvFXFYBMlGFlIsT8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=BnGu1fmtFjDGMgNOTDHBVT95YSS+QIG2nm530WtUIkUntLbFp8FxSLM33zWI7nghkhGojZA4hX9A0fu3m2z83qyF5w2SZc+JInZxO51Pvl2Or8xZ2wz/qRVqgpbG5T7smAWc6slUs+CYZAdxWOzLyGP1dnufbtP7mg5JFXsapkGBAj4oMjGR2KVm9SdHgWmlQntP9etDNrDac74abxJYSGi44cu4OToZjfsjPxOg2/8htQ1sNhIdVP6AL7iZ36WxGX83OBjAzZs2d+a9swLBOUkdbnRcSfxKfFD0CkAeRf/pjM6QToXlorT6xHbMVGUXSmdEiRd1S59Gl/0Tb61BNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ESp4XrK8; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eWRqPYaK; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ESp4XrK8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eWRqPYaK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XHLPZ6b8jz2yq4
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Sep 2024 22:44:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727700283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bVDH90pWvwnLUcopy8GzWW9f5uyvFXFYBMlGFlIsT8=;
	b=ESp4XrK8ugs1enaSltg3WyLRmon32/oqcDhvwu8jo31FLvkUhCB3tq91sJyPn9EpCurq5S
	rw/VXtnMLOv9Xz/b+DnSFB/tUpnyRsGn4aEGf1K1ocKqv1FNRRaiUiSDcM3RXJpN7S4OQ9
	XkV+gjlXmWr9xJZ1ME3JX/iAyJyXwR8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727700284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bVDH90pWvwnLUcopy8GzWW9f5uyvFXFYBMlGFlIsT8=;
	b=eWRqPYaK9EEdMhy8+gLL0EfVCpGYsAf4UyWv/K++3pMla5X8O1Vf/DnV6j6u51Kn9mzBdT
	cauNl1DDHqQap3MHhqROeaWcUnaKEVTHsSXYASg9PhWVFZSDyYlX0ZM2ohqMdFwafaVkQ1
	7T/KbxYC+zFApoattlaV5g3o5jLiEvE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-q9x6f1A7NQmqo91dzCKIUg-1; Mon,
 30 Sep 2024 08:44:41 -0400
X-MC-Unique: q9x6f1A7NQmqo91dzCKIUg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 722E31944DDB;
	Mon, 30 Sep 2024 12:44:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3243E1979060;
	Mon, 30 Sep 2024 12:44:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240925103118.GE967758@unreal>
References: <20240925103118.GE967758@unreal> <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com> <1279816.1727220013@warthog.procyon.org.uk> <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2968939.1727700270.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Sep 2024 13:44:30 +0100
Message-ID: <2968940.1727700270@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Spam-Status: No, score=-0.3 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
Cc: asmadeus@codewreck.org, dhowells@redhat.com, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, linux-nfs@vger.kernel.org, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Okay, let's try something a little more drastic.  See if we can at least g=
et
it booting to the point we can read the tracelog.  If you can apply the
attached patch?  It won't release any folio_queue struct or put the refs o=
n
any pages, so it will quickly run out of memory - but if you have sufficie=
nt
menory, it might be enough to boot.

David
---
9p: [DEBUGGING] Don't release pages or folioq structs

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index af46a598f4d7..702286484176 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -84,8 +84,8 @@ static size_t netfs_load_buffer_from_ra(struct netfs_io_=
request *rreq,
 		folioq->orders[i] =3D order;
 		size +=3D PAGE_SIZE << order;
 =

-		if (!folio_batch_add(put_batch, folio))
-			folio_batch_release(put_batch);
+		//if (!folio_batch_add(put_batch, folio))
+		//	folio_batch_release(put_batch);
 	}
 =

 	for (int i =3D nr; i < folioq_nr_slots(folioq); i++)
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 63280791de3b..cec55b7eb5bc 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -88,7 +88,7 @@ struct folio_queue *netfs_delete_buffer_head(struct netf=
s_io_request *wreq)
 	if (next)
 		next->prev =3D NULL;
 	netfs_stat_d(&netfs_n_folioq);
-	kfree(head);
+	//kfree(head);
 	wreq->buffer =3D next;
 	return next;
 }
@@ -108,11 +108,11 @@ void netfs_clear_buffer(struct netfs_io_request *rre=
q)
 				continue;
 			if (folioq_is_marked(p, slot)) {
 				trace_netfs_folio(folio, netfs_folio_trace_put);
-				folio_put(folio);
+				//folio_put(folio);
 			}
 		}
 		netfs_stat_d(&netfs_n_folioq);
-		kfree(p);
+		//kfree(p);
 	}
 }
 =

