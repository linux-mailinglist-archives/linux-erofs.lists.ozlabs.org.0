Return-Path: <linux-erofs+bounces-1494-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD1FCC13D5
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Dec 2025 08:07:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dVp0F4D7dz2yFK;
	Tue, 16 Dec 2025 18:07:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765868845;
	cv=none; b=ZQ4cprbERnbIB2jEeYbHUIHXrqMXgl6mw617PVLTpg6bNva/5XSTFty97sHwvxFFCU9B/ithIODK0uUG/xXFL+8raXLU5JxabZuuWGPzlPBHOzQsbHjwfV6+cHj8o4gGqKDROrI716sBgpVQJw9GkG/ccRtgyKyAwTtEqS1gkxrDuEEOGRM9W4v9kTdej4gNTzUuOOdkaiTnk3T1b6rJNIZTSTV8CYmTvOKZYyUU1uNIdT/arM7brz6gN6n3G7ge3hj7wkK4WJm0+YZEDG9iLzcUQsi1h8VQxWsIlKHpce3bohweiKfplnMA2ijC4WJO0dLQFpAMcRTTo1TH+3HNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765868845; c=relaxed/relaxed;
	bh=Z/hlSoy9BU/VFyb2m7Y0tcDCpyH9W7rl4SrWptcSnYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKzEm7hKBi4GtFntNtw9dZxhKzxHoXVRhpkYce/WJheBosO0HIDAViR3UEzgssAQfRsDRwkYYsCeI57H2s5LUT71zyZn4sZuTQVqFP7chkLH5HkzhUATiBkpe4Swf5Jq3wPpejnuShnNpePxxQWV0lvnZHg9NvgcqVxpMVWMRZ10CRjsrCjVLePLBEITkb1dQ0G8TfojE6QlhIPcn0psat687rH77cS4PyPmOMkkwGDrXplST5OvWazIn1Fnu5I7eflD8S5DavnzkoW6E71yWDF65hWb9exGnXBI4VaX4QxleLP5GMscaGPqf1OLeDWwHjENOIeZSnKimOBIjQMrAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=YmXokJdG; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=YmXokJdG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dVp0B4HcGz2yDY
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Dec 2025 18:07:20 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Z/hlSoy9BU/VFyb2m7Y0tcDCpyH9W7rl4SrWptcSnYI=;
	b=YmXokJdG74CYq7hlT+QSgHVAbxgKgt+TErkxF/QHAL7HYP+ikkUEWOvhMIcIxwRN5AoDkeHTA
	yd1HAX1IHvFxLsfYCNyFUf15D7pRxCFEyMDh4Ldk8yehznhIi9vTf50qOjfqQikLD1lpd2Mimzc
	5xONMQX58t+18RT/Cmvs4Fo=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dVnxR0tpRznTVd;
	Tue, 16 Dec 2025 15:04:59 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 353B214011F;
	Tue, 16 Dec 2025 15:07:13 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 16 Dec
 2025 15:07:12 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <hudson@cyzhu.com>, <jingrui@huawei.com>,
	<wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 2/2] erofs-utils: lib: oci: restrict `ocierofs_io_open()` to single-layer images
Date: Tue, 16 Dec 2025 15:05:57 +0800
Message-ID: <20251216070557.743122-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216070557.743122-1-zhaoyifan28@huawei.com>
References: <20251216070557.743122-1-zhaoyifan28@huawei.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

When mounting an OCI image with `mount.erofs -t erofs.nbd` without
specifying either `oci.layer=` or `oci.blob=`, a segfault occurs in the
`ocierofs_download_blob_range() → ocierofs_find_layer_by_digest()` call
path due to an empty `ctx->blob_digest`.

As mounting multi-layer OCI images is not yet supported, let's exit
early in `ocierofs_io_open()` with an error in this case.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/remotes/oci.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index d5afd6a..ce7a1a5 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -1479,16 +1479,18 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
 		return -ENOMEM;
 
 	err = ocierofs_init(ctx, cfg);
-	if (err) {
-		free(ctx);
-		return err;
+	if (err)
+		goto out;
+
+	if (!ctx->blob_digest) {
+		err = -EINVAL;
+		goto out;
 	}
 
 	oci_iostream = calloc(1, sizeof(*oci_iostream));
 	if (!oci_iostream) {
-		ocierofs_ctx_cleanup(ctx);
-		free(ctx);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto out;
 	}
 
 	oci_iostream->ctx = ctx;
@@ -1496,6 +1498,11 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
 	*vfile = (struct erofs_vfile){.ops = &ocierofs_io_vfops};
 	*(struct ocierofs_iostream **)vfile->payload = oci_iostream;
 	return 0;
+
+out:
+	ocierofs_ctx_cleanup(ctx);
+	free(ctx);
+	return err;
 }
 
 char *ocierofs_encode_userpass(const char *username, const char *password)
-- 
2.43.0


