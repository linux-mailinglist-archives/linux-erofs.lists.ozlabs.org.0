Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D20A98943A
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Sep 2024 11:13:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XGdlZ3rKpz2xpl
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Sep 2024 19:12:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727601176;
	cv=none; b=ELJOuEOnwYY2VWETQt/FMNK6ITdBqMWFoyUnXpT+3zRR3F3sIhc864obBfKLfbBwwKKtZSz/OLa2BB/dgaNaE3qdZXYMUmLyY/c75Q9BPqIoXTOHkzxQnHVPa3OJGm5ccagkkX4NNJITpC//HSQ0prIE+d1Jwn3gigZy6BlsNkNX/93byBqqQBRm7CadRbbnxQesbM0vAUfBvb5mC3Gn1ltT16kb/u//1fwmK+F4vxVTvS+BVnwrJWFmZEUUIQZi1z5ecdI+Xpo23RIsSXpE+LaV+SFWQirW7E11rU9mwVIJ7VTie8DJ9K72IdudZG46B9EglJln5230Z4HhMIebow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727601176; c=relaxed/relaxed;
	bh=JiqqlxmQYH/fiwHpJ0K7lC2A6lz/Rw3eIk1FtzNUMEY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=DCFEQhPhIydIFmJydaP9h9ya+Jbq8gjGmcQM8spePh0X/ta+ykt0DTpZhVQ5mmk91fqg6pl69Ty3QDbbzzTuHLBSgjxGdAPwZ7FYU+8T1uuE92idKBPHYlctH2uEznBh3L+Z5IXCzhiVFlXZcX4LjLyy/5/E5/DWMsqQ3CBTZacXRdNls4evrbBQAVP9GWCWfFewkdL/k4qb5CvNysWJHD9OZxOxd5RYf0UEA0q0/94YGF0FT7PCJode3C1HAOs+U86R1ajVT0N+j2MduBc5dghR26YvV+mgCOwp4jDpLrkyupvCf1WsBcnK2c5EaM30DFO9hRi/cNAUrDfLfPn9pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=geisaKZ0; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=geisaKZ0; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=geisaKZ0;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=geisaKZ0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XGdlW37N6z2xY6
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Sep 2024 19:12:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727601169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiqqlxmQYH/fiwHpJ0K7lC2A6lz/Rw3eIk1FtzNUMEY=;
	b=geisaKZ0tEVP1mMoZaypcZl9zAVGwdCqDAbgc7WD8F6ekgXf/+KT50slSE+CB0pINOTNKd
	ToRlaPoz9MZJcrAARzCWmIJNytx0c+BupfsQjIEooazTQcUT5CWNrZHKblwIb2+MDFDM5y
	QMsG4c+5AuVUNsfn8hiMWZM8fzGI7QM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727601169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiqqlxmQYH/fiwHpJ0K7lC2A6lz/Rw3eIk1FtzNUMEY=;
	b=geisaKZ0tEVP1mMoZaypcZl9zAVGwdCqDAbgc7WD8F6ekgXf/+KT50slSE+CB0pINOTNKd
	ToRlaPoz9MZJcrAARzCWmIJNytx0c+BupfsQjIEooazTQcUT5CWNrZHKblwIb2+MDFDM5y
	QMsG4c+5AuVUNsfn8hiMWZM8fzGI7QM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-ngDjsBEOMcCfzSSWO9NFYQ-1; Sun,
 29 Sep 2024 05:12:45 -0400
X-MC-Unique: ngDjsBEOMcCfzSSWO9NFYQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F5D4195FE25;
	Sun, 29 Sep 2024 09:12:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F1CB519560AE;
	Sun, 29 Sep 2024 09:12:34 +0000 (UTC)
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
Content-ID: <2808174.1727601153.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 29 Sep 2024 10:12:33 +0100
Message-ID: <2808175.1727601153@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Can you try the attached?  I've also put it on my branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Dnetfs-fixes

David
---
9p: Don't revert the I/O iterator after reading

Don't revert the I/O iterator before returning from p9_client_read_once().
netfslib doesn't require the reversion and nor doed 9P directory reading.

Make p9_client_read() use a temporary iterator to call down into
p9_client_read_once(), and advance that by the amount read.

Reported-by: Manu Bretelle <chantr4@gmail.com>
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Reported-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 net/9p/client.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 5cd94721d974..be59b0a94eaf 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1519,13 +1519,15 @@ p9_client_read(struct p9_fid *fid, u64 offset, str=
uct iov_iter *to, int *err)
 	*err =3D 0;
 =

 	while (iov_iter_count(to)) {
+		struct iov_iter tmp =3D *to;
 		int count;
 =

-		count =3D p9_client_read_once(fid, offset, to, err);
+		count =3D p9_client_read_once(fid, offset, &tmp, err);
 		if (!count || *err)
 			break;
 		offset +=3D count;
 		total +=3D count;
+		iov_iter_advance(to, count);
 	}
 	return total;
 }
@@ -1567,16 +1569,12 @@ p9_client_read_once(struct p9_fid *fid, u64 offset=
, struct iov_iter *to,
 	}
 	if (IS_ERR(req)) {
 		*err =3D PTR_ERR(req);
-		if (!non_zc)
-			iov_iter_revert(to, count - iov_iter_count(to));
 		return 0;
 	}
 =

 	*err =3D p9pdu_readf(&req->rc, clnt->proto_version,
 			   "D", &received, &dataptr);
 	if (*err) {
-		if (!non_zc)
-			iov_iter_revert(to, count - iov_iter_count(to));
 		trace_9p_protocol_dump(clnt, &req->rc);
 		p9_req_put(clnt, req);
 		return 0;
@@ -1596,8 +1594,6 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, =
struct iov_iter *to,
 			p9_req_put(clnt, req);
 			return n;
 		}
-	} else {
-		iov_iter_revert(to, count - received - iov_iter_count(to));
 	}
 	p9_req_put(clnt, req);
 	return received;

