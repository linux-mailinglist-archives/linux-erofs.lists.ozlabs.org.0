Return-Path: <linux-erofs+bounces-247-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C84A9F38B
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Apr 2025 16:35:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZmQw33ywNz3064;
	Tue, 29 Apr 2025 00:35:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745850915;
	cv=none; b=EVgZuzlklUzhNgDvRr1MS/CynaLi4ZvYiuGXQYlMgyCXYbHScy+2XNhJAIgsnhCDR/h9+YOciGHViL45V4hm2Apgbmb1yKaffbCrovQare24Grl/G9lLXeuyp2FSJumn5ROKtEV2FKWHj2WHLWvgRWPQv56cowV74QQM7vlbRc6ZgW8dJ/LBQH0yi1Boqr837/rTEBwwf5YKBklckAlcKoz9Z8xIw3zra+p9lD8IggTLlqiVaWOrHI6ik1PMwQWfLIykUHVXn3wtJ7VG5mxQRaDzBkiQFoKRbN1Rk6Bhq5JP54baMKFcGIFc0WxONeG0ScYLGaZn8c66J8G7iEUHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745850915; c=relaxed/relaxed;
	bh=p2WGx/Gu0uedNefnFz7rkHF2DwEmhwQUO8Jf0ocXqHk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GZIbGqSQjj70L+3+upoUX+ngC0Yzb8MNQxmT9DpjATSRvyMZM4+qOGasln6k8R2yf74LOWnwsvq6VUVhtt2fpVbZxmsg7qwN+57/B2MU9v4tf5P/1hM/Mt3vdysl1/a0Q9EPH3gz90pCV+J8+IzLLkYlFaCd9fUynwc6iJyDIq7fm3Yhow60tj2bHpcegfUrfMAE2/+NwNVjrDb3hXgSzRGIbUvlu3Jirs0fLn6B02nxIj7sIx6046RkVCgMlZhTBkuGRLiOVkBlnqxijiBbdoexSyOOFHPw5pFy19KvrXHJhtGHu7HJKXbHG0YP2x0+oML44jDSaNfdQBfrldyr8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZmQw26XwRz2yr9
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 00:35:14 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZmQvX3Wy2z2TS20;
	Mon, 28 Apr 2025 22:34:48 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id ABA681402CE;
	Mon, 28 Apr 2025 22:35:11 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Apr
 2025 22:35:11 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <zbestahu@gmail.com>,
	<jefflexu@linux.alibaba.com>
CC: <dhavale@google.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH] erofs: remove unused enum type
Date: Mon, 28 Apr 2025 14:26:31 +0000
Message-ID: <20250428142631.488431-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Opt_err is not used in EROFS, we can remove it.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c1c350c6fbf4..fd365a611f13 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -356,8 +356,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
-	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio,
-	Opt_err
+	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
-- 
2.22.0


