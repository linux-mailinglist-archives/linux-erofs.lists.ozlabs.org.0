Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 66087709E59
	for <lists+linux-erofs@lfdr.de>; Fri, 19 May 2023 19:39:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QNDcB29fHz3gm8
	for <lists+linux-erofs@lfdr.de>; Sat, 20 May 2023 03:39:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtBK3c+g;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtBK3c+g;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtBK3c+g;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtBK3c+g;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QNDYC0P2Mz3gWd
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 May 2023 03:36:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684517804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pz0JzTfyguqmRs+s7VJfsEiogd94Y6MnQ8Q6Ffay1Y8=;
	b=UtBK3c+gk3xG8tNXncwhzTD5LdcZMjplEi5Ybhp/Sm1zu6dnWxiz/Jj+lIIawhf96dFKLN
	2n5xA+xWH1sWHfdx5SK/j0Y5xW/QH/GGa0zqyiwrI1X5wHYcVRCx1q5joy2hK17kh1RkRF
	eJfzg2NSa06mUeB4BGMAWkl3jKU4+yI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684517804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pz0JzTfyguqmRs+s7VJfsEiogd94Y6MnQ8Q6Ffay1Y8=;
	b=UtBK3c+gk3xG8tNXncwhzTD5LdcZMjplEi5Ybhp/Sm1zu6dnWxiz/Jj+lIIawhf96dFKLN
	2n5xA+xWH1sWHfdx5SK/j0Y5xW/QH/GGa0zqyiwrI1X5wHYcVRCx1q5joy2hK17kh1RkRF
	eJfzg2NSa06mUeB4BGMAWkl3jKU4+yI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-7DYBFcjjOiyLTQA7uPnMRg-1; Fri, 19 May 2023 13:36:40 -0400
X-MC-Unique: 7DYBFcjjOiyLTQA7uPnMRg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DF97800159;
	Fri, 19 May 2023 17:36:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BFB7C140E954;
	Fri, 19 May 2023 17:36:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: linux-cachefs@redhat.com
Subject: [PATCH] cachefilesd: Remove pointer poisoning code as it is likely to fail under ASLR
MIME-Version: 1.0
Date: Fri, 19 May 2023 18:36:39 +0100
Message-ID: <1853806.1684517799@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1853805.1684517798.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
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
Cc: dhowells@redhat.com, linux-erofs@lists.ozlabs.org, Jeff Layton <jlayton@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

   =20
The pointer checking code assumes that addresses in the range 0x60000000 to
0x6fffffff are not going to be encountered and can thus be used to poison
dead pointers.  Unfortunately, this assumption breaks occasionally on
systems with address space layout randomisation.

Remove the poisoning and, in particular, the poison checking which will cau=
se
the process to abort with no message as to why.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 cachefilesd.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/cachefilesd.c b/cachefilesd.c
index d4d236f..6c435f6 100644
--- a/cachefilesd.c
+++ b/cachefilesd.c
@@ -1092,7 +1092,6 @@ static void put_object(struct object *object)
=20
 =09parent =3D object->parent;
=20
-=09memset(object, 0x6d, sizeof(struct object));
 =09free(object);
=20
 =09if (parent)
@@ -1213,7 +1212,6 @@ static void insert_into_cull_table(struct object *obj=
ect)
=20
 =09/* newest object in table will be displaced by this one */
 =09put_object(cullbuild[0]);
-=09cullbuild[0] =3D (void *)(0x6b000000 | __LINE__);
 =09object->usage++;
=20
 =09/* place directly in first slot if second is older */
@@ -1391,7 +1389,7 @@ next:
=20
 =09=09=09if (loop =3D=3D nr_in_ready_table - 1) {
 =09=09=09=09/* child was oldest object */
-=09=09=09=09cullready[--nr_in_ready_table] =3D (void *)(0x6b000000 | __LIN=
E__);
+=09=09=09=09cullready[--nr_in_ready_table] =3D NULL;
 =09=09=09=09put_object(child);
 =09=09=09=09goto removed;
 =09=09=09}
@@ -1400,7 +1398,7 @@ next:
 =09=09=09=09memmove(&cullready[loop],
 =09=09=09=09=09&cullready[loop + 1],
 =09=09=09=09=09(nr_in_ready_table - (loop + 1)) * sizeof(cullready[0]));
-=09=09=09=09cullready[--nr_in_ready_table] =3D (void *)(0x6b000000 | __LIN=
E__);
+=09=09=09=09cullready[--nr_in_ready_table] =3D NULL;
 =09=09=09=09put_object(child);
 =09=09=09=09goto removed;
 =09=09=09}
@@ -1411,7 +1409,7 @@ next:
=20
 =09=09=09if (loop =3D=3D nr_in_build_table - 1) {
 =09=09=09=09/* child was oldest object */
-=09=09=09=09cullbuild[--nr_in_build_table] =3D (void *)(0x6b000000 | __LIN=
E__);
+=09=09=09=09cullbuild[--nr_in_build_table] =3D NULL;
 =09=09=09=09put_object(child);
 =09=09=09}
 =09=09=09else if (loop < nr_in_build_table - 1) {
@@ -1419,7 +1417,7 @@ next:
 =09=09=09=09memmove(&cullbuild[loop],
 =09=09=09=09=09&cullbuild[loop + 1],
 =09=09=09=09=09(nr_in_build_table - (loop + 1)) * sizeof(cullbuild[0]));
-=09=09=09=09cullbuild[--nr_in_build_table] =3D (void *)(0x6b000000 | __LIN=
E__);
+=09=09=09=09cullbuild[--nr_in_build_table] =3D NULL;
 =09=09=09=09put_object(child);
 =09=09=09}
=20
@@ -1531,10 +1529,10 @@ static void decant_cull_table(void)
=20
 =09=09n =3D copy * sizeof(cullready[0]);
 =09=09memcpy(cullready, cullbuild, n);
-=09=09memset(cullbuild, 0x6e, n);
+=09=09memset(cullbuild, 0, n);
 =09=09nr_in_ready_table =3D nr_in_build_table;
 =09=09nr_in_build_table =3D 0;
-=09=09goto check;
+=09=09return;
 =09}
=20
 =09/* decant some of the build table if there's space */
@@ -1542,7 +1540,7 @@ static void decant_cull_table(void)
 =09=09error("Less than zero space in ready table");
 =09space =3D culltable_size - nr_in_ready_table;
 =09if (space =3D=3D 0)
-=09=09goto check;
+=09=09return;
=20
 =09/* work out how much of the build table we can copy */
 =09copy =3D avail =3D nr_in_build_table;
@@ -1559,16 +1557,11 @@ static void decant_cull_table(void)
 =09nr_in_ready_table +=3D copy;
=20
 =09memcpy(&cullready[0], &cullbuild[leave], copy * sizeof(cullready[0]));
-=09memset(&cullbuild[leave], 0x6b, copy * sizeof(cullbuild[0]));
+=09memset(&cullbuild[leave], 0, copy * sizeof(cullbuild[0]));
 =09nr_in_build_table =3D leave;
=20
 =09if (copy + leave > culltable_size)
 =09=09error("Scan table exceeded (%d+%d)", copy, leave);
-
-check:
-=09for (loop =3D 0; loop < nr_in_ready_table; loop++)
-=09=09if (((long)cullready[loop] & 0xf0000000) =3D=3D 0x60000000)
-=09=09=09abort();
 }
=20
 /*************************************************************************=
****/
@@ -1645,6 +1638,6 @@ static void cull_objects(void)
=20
 =09if (cullready[nr_in_ready_table - 1]->cullable) {
 =09=09cull_object(cullready[nr_in_ready_table - 1]);
-=09=09cullready[--nr_in_ready_table] =3D (void *)(0x6b000000 | __LINE__);
+=09=09cullready[--nr_in_ready_table] =3D NULL;
 =09}
 }

