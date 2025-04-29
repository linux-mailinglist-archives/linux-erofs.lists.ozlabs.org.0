Return-Path: <linux-erofs+bounces-263-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA357AA0514
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 09:59:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zmt4b5QjPz305P;
	Tue, 29 Apr 2025 17:59:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745913551;
	cv=none; b=BFQwmUnlgMisajtc+dmscC2Pj2Nttjf4Ur0fAOV3GI0yamkmFWbJL8PrSn8aoevv5nwgnzUGAb6k+SI++uO/JjNGrtO0/DVFy6rrwNeY8NJDXLGq2Dlr73NiEpp7JT5HvfVGa/2zCLdg/9CN+lqTAPH3olS5rvFS5mXHfiRfwrCBS1ZyZjRAF017T2N6chAcp1q993nLOMARJkzjKCS3UDvHhXv1faJ0Icp1aab4chKYNcQUE4JIxw0/ZMYyJyijDrTYeQghAUsWBv9Z7UgyaPWjKMtMIKwyNOqTrUlf2I3+BY4gcbDIi6ErkidiMLgfncro95HvwoRgA5J7yF8IBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745913551; c=relaxed/relaxed;
	bh=NoVu4Z91hbSYspHyUx1AHCX+FjgBIkfLAOMEroHJ3rg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nm9nhruVtnYN4Jjhjm3RRIO+fIEDMtVRBb+W2hAi+2m97E6b00ZFqxVLyVi7T1vrxgM3Xo07lLfSDlSnd7Zot1YkChX05nl+yrF5L5/AOpA80CfJ35DLdvmgLhxYcvwXXf9LX6vgNVWdA8C+RFCrLQrkpeu6hRS+UBMERcMoCVmKuLxXnW5+2ALjW+ouql5XD0tU2bLNS3tAiuEH3N41LTo2GG3mOP+auQuUvr+GPD+QZ1Ny6hmye7z89krObcTr7kJfDT0fPXf+koCCvGjC3RIRew5D+r2DoTEuTzoJlSbE9RUJMnObYssPESjL59KRDNZVuX3MXnHJaSSpqrCSQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zmt4Z5pYVz2yYf
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 17:59:10 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Zmt291m0hz1R7cm;
	Tue, 29 Apr 2025 15:57:05 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9653E1A0188;
	Tue, 29 Apr 2025 15:59:07 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Apr
 2025 15:59:07 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <zbestahu@gmail.com>,
	<jefflexu@linux.alibaba.com>
CC: <dhavale@google.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v2] erofs: reject unknown option if it is not supported
Date: Tue, 29 Apr 2025 07:50:29 +0000
Message-ID: <20250429075029.689511-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
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
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Some options are supported depending on different compiling config,
and these option will not fail during mount if they are not
supported. This is very weird, so we can reject them if they are
not supported.

For (no)acl, (no)user_xattr and dax related option, these are common
option in other fses, so we keep them in the old way (e.g.: will error
out the log if they are not supported).

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
v1: https://lore.kernel.org/all/20250428142545.484818-1-lihongbo22@huawei.com/
  - Keep (no)acl and (no)user_xattr in old way.
---
 fs/erofs/super.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cadec6b1b554..45038981ea12 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -376,14 +376,20 @@ static const struct constant_table erofs_dax_param_enums[] = {
 static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_flag_no("user_xattr",	Opt_user_xattr),
 	fsparam_flag_no("acl",		Opt_acl),
+#ifdef CONFIG_EROFS_FS_ZIP
 	fsparam_enum("cache_strategy",	Opt_cache_strategy,
 		     erofs_param_cache_strategy),
+#endif
 	fsparam_flag("dax",             Opt_dax),
 	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
 	fsparam_string("device",	Opt_device),
+#ifdef CONFIG_EROFS_FS_ONDEMAND
 	fsparam_string("fsid",		Opt_fsid),
 	fsparam_string("domain_id",	Opt_domain_id),
+#endif
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
 	fsparam_flag_no("directio",	Opt_directio),
+#endif
 	{}
 };
 
@@ -444,13 +450,11 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		errorfc(fc, "{,no}acl options not supported");
 #endif
 		break;
-	case Opt_cache_strategy:
 #ifdef CONFIG_EROFS_FS_ZIP
+	case Opt_cache_strategy:
 		sbi->opt.cache_strategy = result.uint_32;
-#else
-		errorfc(fc, "compression not supported, cache_strategy ignored");
-#endif
 		break;
+#endif
 	case Opt_dax:
 		if (!erofs_fc_set_dax_mode(fc, EROFS_MOUNT_DAX_ALWAYS))
 			return -EINVAL;
@@ -491,22 +495,15 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		if (!sbi->domain_id)
 			return -ENOMEM;
 		break;
-#else
-	case Opt_fsid:
-	case Opt_domain_id:
-		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
-		break;
 #endif
-	case Opt_directio:
 #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+	case Opt_directio:
 		if (result.boolean)
 			set_opt(&sbi->opt, DIRECT_IO);
 		else
 			clear_opt(&sbi->opt, DIRECT_IO);
-#else
-		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
-#endif
 		break;
+#endif
 	}
 	return 0;
 }
-- 
2.22.0


