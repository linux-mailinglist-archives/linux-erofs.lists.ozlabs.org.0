Return-Path: <linux-erofs+bounces-1291-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326ABC0C9D8
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Oct 2025 10:21:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cw7LL5Z8fz2yrl;
	Mon, 27 Oct 2025 20:21:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761556906;
	cv=none; b=FQi+YD0cQlgCxeLIOVwYRs/F7hpxzyRaK3PvaQE5lkqP4dH69IHTyxnc02eLYQICJ2+vJ1aGP5i63KAl4snlanBE13sq/rCeRmttxfgYaZtb5Y+dbV5tS7KD5L6BOlQgcz8Fo2lsV1dhOp1zkzn99Dd/CrW420/0u2sDMr/KVDB+gLLHlwNgp45vam8dFFFX3l0nZbxl3mJaFTqaL3IQCTaHe6o31nFS+IM48mwQ9koVfMjY0h6ctbhbQ+pc9wEv5ruCwP5Ty+FekoTb3hTzaqLcTbCOhoc9KBvaE66uz1muAU2kdAr2k3V5ezkSSqe2y8I7T9lToPyJzh53rpM/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761556906; c=relaxed/relaxed;
	bh=i1iviviWytqOtff0GW48ptxl/h0BIev5Glx03CsRQpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BFQKvslD9xwSRkAr1v1tdeMaZoQJMxVbuCVG052nOC6Oenmu+gGylJP5YGVirRBxvbQGFNLC1ONcCGOm/3Z/Vy2eYyAmx5D9I0/42SuaNW69p3nWiq7pF36cOcg5HEDkeUhBS1/RaKfuNYaZBKtr2EAuDvml4baObiGuQGo8z4fOzyKUcKTSDCURITN2rbFoKhXwaYFwgIZzn66TU3QV81ORcKpYRrtz1/EiBu57gSUQmVNPxM/S4wE08sKoMxL8jnZaqcsvO9k3wEcA84A1/9QUJMXapqRE90vDzCUWwkGBadO9lty674xhHaGDmh+UFWQM7JviftOTgCfKulXOBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gjV8KMsK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gjV8KMsK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cw7LJ2t9Wz2yjy
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Oct 2025 20:21:42 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761556898; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=i1iviviWytqOtff0GW48ptxl/h0BIev5Glx03CsRQpI=;
	b=gjV8KMsKGlNrvw8nBfWSEmzq/rTyON5EFHSUDazRnmyxwnM9qrK6UO62iVSwTxpNx/P5BPVjNBdg6OCv6sIUETXVK74IFhM1A9+i3/CpkM+3ZPW/Pz3EvW64uA1ykU1L8l+rsuo/gesjv9ofrNTdvjQEz3CdMV1fSRAM0VNO0Bs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wr2mRkN_1761556891 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Oct 2025 17:21:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yifan Zhao <zhaoyifan28@huawei.com>
Subject: [PATCH 1/2] erofs-utils: lib: fix s3erofs_prepare_url()
Date: Mon, 27 Oct 2025 17:21:30 +0800
Message-ID: <20251027092131.348527-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

`mkfs.erofs` failed to generate image from Huawei OBS with the following
command:
  $ mkfs.erofs --s3=<endpoint>,urlstyle=vhost,sig=2 s3.erofs test-bucket

because it mistakenly generated a url with repeated '/':
  "https://test-bucket.<endpoint>//<keyname>"

Fix the corresponding logic now.

Reported-by: Yifan Zhao <zhaoyifan28@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/remotes/s3.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 2e7763e..3675ab6 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -47,6 +47,7 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 {
 	static const char https[] = "https://";
 	const char *schema, *host;
+	/* an additional slash is added, which wasn't specified by user inputs */
 	bool slash = false;
 	char *url = req->url;
 	int pos, i;
@@ -82,8 +83,10 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 		}
 	}
 	if (key) {
-		slash |= url[pos - 1] != '/';
-		pos -= !slash;
+		if (url[pos - 1] == '/')
+			--pos;
+		else
+			slash = true;
 		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "/%s", key);
 	}
 
-- 
2.43.5


