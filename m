Return-Path: <linux-erofs+bounces-1025-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 10346B55F80
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Sep 2025 10:28:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cP4Db5Vpwz2xnr;
	Sat, 13 Sep 2025 18:27:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.43
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757752079;
	cv=none; b=i8i5KOqaCLDuWyS4V70gebPyiH9fKquLzVHd9QBKXu8w9de9ut09Hxo+r6OPV2w155M87o9+kFXwZ8emDc2b+SHXuCWCLop7DPB9n8Ow2SrElXUxg1DoO7SGdC/klG8WfAkKWhnYMzgydifIg62mj9o2zKdmKCnaGAL5SE+PL5L7NQftSqtumYpzaJBVcPjg71ieFTmilVVayVcu0godvHuYQaR0OwU9LkrgApdeuLa/oOtjNN+7UUs6ZHnEkNdYmeMAV9uO1ealzSbL+BZjto1+J7GK0cmv3dxq2FCt6PbAxTLUlnAYFYpnt7nXgOHOi8bd5+yd1IkOh1jVZfI/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757752079; c=relaxed/relaxed;
	bh=A1mfPw7+jqtCr8XaKeVT6MyIrShxFbTrFzCtDJq3m+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bG7MWluFJalsDHUcxve4oKmhVlprVx/a8h2jx1l4uQM2hjSX0m4Csi8ZV2GqrY3hSrBP41SPwCQH7Avkme7ttOb71d8rHnXinIsSMWcILpjvsON7iS9LYqbvNjw/Ay8jwT0UVqzfIcomA8HS7JCEDgjTl12OuomxvmUMuS1APdcyGc13nUNCY4lHApt9dW5VJgYO0da7zf3Icy7l2O3X3+qwdTaZ1z2kd+bsvUqo7VcqEOCZuzpY8u3Ll91Tk1NEACjx8Iz3BceuXuwf0IMdzkZgjac1Xxjl0iONbxJ23WyXG0zs/viGGmEGrWcWATuLbInpiFRvCDTHNpeEuGJvng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.43; helo=out28-43.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.43; helo=out28-43.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-43.mail.aliyun.com (out28-43.mail.aliyun.com [115.124.28.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cP4DZ67mjz2ypV
	for <linux-erofs@lists.ozlabs.org>; Sat, 13 Sep 2025 18:27:58 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eeCA7px_1757752070 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 13 Sep 2025 16:27:53 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1 1/2] mount: change oci layer option from "oci=X" to "oci.layer=X"
Date: Sat, 13 Sep 2025 16:27:47 +0800
Message-ID: <20250913082748.88070-2-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913082748.88070-1-hudson@cyzhu.com>
References: <20250913082748.88070-1-hudson@cyzhu.com>
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
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Chengyu Zhu <hudsonzhu@tencent.com>

Make the OCI layer index option more consistent with other OCI options
by changing the format from "oci=X" to "oci.layer=X".

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 mount/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 5677031..f368746 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -82,9 +82,9 @@ static int erofsmount_parse_oci_option(const char *option)
 	struct ocierofs_config *oci_cfg = &nbdsrc.ocicfg;
 	char *p;
 
-	p = strstr(option, "oci=");
+	p = strstr(option, "oci.layer=");
 	if (p != NULL) {
-		p += strlen("oci=");
+		p += strlen("oci.layer=");
 		{
 			char *endptr;
 			unsigned long v = strtoul(p, &endptr, 10);
-- 
2.51.0


