Return-Path: <linux-erofs+bounces-1533-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E6FCD5261
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Dec 2025 09:47:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZWwn07yXz2xpm;
	Mon, 22 Dec 2025 19:47:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766393240;
	cv=none; b=ZI4mOsXB+ZQyaXMickTDha6J2nr+rDMPS3DdYf455jYKU2sAP+z3YAkD3RyGcJNYazG/ijDydraumBfrOy4FJY++ip19au7Mu4zRvAhSPApKzX2yStTYDPatjs/g/P32cPbz4R1fAwLDCpsPL1k4We6Yx+442QtFCfdeARN2fdyJlP3EVTcxB+XKZz3gihA2xotE4083XkCmm6LizonO0T2cT1hBNcZUZ/n+q7MqYGbINXjuRw4nwPZo8Vwb4jcNuCTh9zpofb+lJtS23s43BhN0UFRdAMF4MijXOj8kRkkhyUHWIkglM+Qn3xFwXHtckeX34e/MLQtSyAykNlI71A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766393240; c=relaxed/relaxed;
	bh=uAB6GajwTAHhQZxWhKeZupLTz6nP0b+Udfllx0cCQ2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLHrDFCiJbaIYO8IDGLHITbQLh8wnjNCDtlz2uWY2o6BK1ZOHoU+idQ5HoY+9oXik2wVaVvIUrjIJQacsOjeiu88DhTTd5CoSVO3PN0S/jcI8MgIA86DNoDjbBkpouXZXm79VYUefmsGCLjLLVC4rp6sCZnStXZNHTJ3bVYm97oKxzJwz2480GKIoMZUvSKKe3YzZ7/A6YjIZnygLX0emhyZhDFfV5+9YbtJsSACWmLZq5XUqeBqdiMa2CWOcX1k299n5kRqde9B42otioG7re6GLjM49eKfzWHKdR3+svCLszPn3ob3rSKoF3j5HDg9FVaWPsyeuADyViEvFJ3OxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Xe+tdNDH; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Xe+tdNDH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZWwj5nKFz2xSZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Dec 2025 19:47:15 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uAB6GajwTAHhQZxWhKeZupLTz6nP0b+Udfllx0cCQ2Q=;
	b=Xe+tdNDHCRwUYSwmA1hBZ6SW9sgTingKOHhu2PvpO52FR52U7JLZRCkdQbNCJZOuNO5d6+1kI
	10GD1pfhHdsl9HVESPscyPlgyrQY6LAldmIUkUnZl0x7nqVihZQaQ7h8bT/tMoFl3qdHCeutfuG
	rN6i0UBkeIwCWS1xioes3uQ=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dZWrz2WG6zRhRm;
	Mon, 22 Dec 2025 16:44:03 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 672B640567;
	Mon, 22 Dec 2025 16:47:09 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 22 Dec
 2025 16:47:08 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <hudson@cyzhu.com>, <jingrui@huawei.com>,
	<wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH v2] erofs-utils: mount: add manpage and usage info for oci.insecure option
Date: Mon, 22 Dec 2025 16:46:12 +0800
Message-ID: <20251222084612.172380-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222075421.171161-1-zhaoyifan28@huawei.com>
References: <20251222075421.171161-1-zhaoyifan28@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add manpage and cmdline usage help for the newly introduced
`oci.insecure` option in mount.erofs.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 man/mount.erofs.8 | 3 +++
 mount/main.c      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/man/mount.erofs.8 b/man/mount.erofs.8
index 6b3a32b..856e07f 100644
--- a/man/mount.erofs.8
+++ b/man/mount.erofs.8
@@ -117,6 +117,9 @@ Path to a tarball index file for hybrid tar+OCI mode.
 .TP
 .BI "oci.zinfo=" path
 Path to a gzip zinfo file for random access to gzip-compressed tar layers.
+.TP
+.BI "oci.insecure"
+Use HTTP instead of HTTPS to access the image registry.
 .SH NOTES
 .IP \(bu 2
 EROFS filesystems are read-only by nature. The \fBrw\fR option will be ignored.
diff --git a/mount/main.c b/mount/main.c
index ed6bcdc..6652cf5 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -105,6 +105,7 @@ static void usage(int argc, char **argv)
 		"   oci.password=<pass> password for authentication (optional)\n"
 		"   oci.tarindex=<path> path to tarball index file (optional)\n"
 		"   oci.zinfo=<path>    path to gzip zinfo file (optional)\n"
+		"   oci.insecure        use HTTP instead of HTTPS (optional)\n"
 #endif
 		, argv[0]);
 }
-- 
2.43.0


