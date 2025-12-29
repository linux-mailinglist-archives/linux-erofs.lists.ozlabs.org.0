Return-Path: <linux-erofs+bounces-1626-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA05CE5DCD
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 04:27:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dfhVV2rQDz2xrC;
	Mon, 29 Dec 2025 14:27:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766978850;
	cv=none; b=gdh0zm2/4OoAFWyIjovpvzr++DL4jdumP/xq8XX1K/kQuGw0MmvwXT8cnhErlIqBzvxYDcMADqSBR1pIuhDsVVnU+VXSnIn0JWqO5GZp3m41/YWPpQ/5a0LrFlJRH4Ba4WKs+Ywb2HNsfSJp9OFAkDwUtsxb1iK8TrRQ2nre9sKldMEdQwnaPIA9dGhqQn77SV9TaoSoXOGXeBRLxjbN41ghX0+ouZCOvF5CZCCwPBmXzcUInzgbWxbUHsBYy4rLvmxz3jr5mlGlpP3aLG8ABpdmcHJq46OzsGkva6aeLL9k13rfD/L5NBd7UMCbq8KHBpexYei0J61d8EsnU14ukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766978850; c=relaxed/relaxed;
	bh=5wj4/Ijj2yz25cm89BZXqH1Ql/QS964PPbteZlwTiCg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BLdcyMgaiNt1wPUwDUSCVSTkgWWPSn+rPG1Zx2QEO6DRwLwGdKMZr1vHzroXR38wyXiAJ3Tokfko8NeLVnvdypFUfUvofb5cRO44l7Qa7H4JT6W/QG4siu1plnPJX+GGS/Anujn05dMJtre0QGZu4TCxP9MSKXAG4Uw7eEZ+QEwZYgWN2hPV8cp9qZTAuNUpRFqrtqXKSlg9/EVbZmXmkoVLxO13AdmCdUx9pd+nRQPgUuw85veuCO5yCsc36xou148sBKCMBWjrrdvnHqP4W1+g+pbg12uuLjJZjSfAmbWxTDjtYtuC0wBaqGeFEQDwvTJqB/akmGY8cL7it71ZdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AJKB9HSM; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AJKB9HSM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dfhVR6dyMz2xqj
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 14:27:27 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5wj4/Ijj2yz25cm89BZXqH1Ql/QS964PPbteZlwTiCg=;
	b=AJKB9HSMgi0HL+/6NcyDuT+sSaaOSezsg9BGdDpOpgXKvx1PYnsA1exNjDL0J5c0tx7jGcaYF
	opyfHEYw02YEGXQ98tDYKnUZ+gThQBFiP6AVyeX/+cuQpPlP7xHfnCsCjAZs0pbZ29Z3Q91CoaE
	hyFLaeBmVGTLoNxgm01+X7A=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dfhQW4zK0zcb0c
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 11:24:03 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 9771940539
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 11:27:18 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 29 Dec
 2025 11:27:18 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [RESEND PATCH 1/2] erofs-utils: lib: oci: restrict `ocierofs_io_open()` to single-layer images
Date: Mon, 29 Dec 2025 11:26:12 +0800
Message-ID: <20251229032613.87807-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
index f29c344..c8711ea 100644
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


