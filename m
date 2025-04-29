Return-Path: <linux-erofs+bounces-264-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 60203AA0516
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 09:59:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zmt5724l5z305P;
	Tue, 29 Apr 2025 17:59:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.255
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745913579;
	cv=none; b=GwGkhESPIGgOcDE3fQQt9OLINMSnW497FdlDH6EcAKV4kMLRM9PKshAX3qI9+QN9LrWyDpu5L/JQ9ZxRp/71TycnpS3kOZlXGl/HR79U+XnsWK2ZbF1ADjktw79ymvVl1goTgJ3DKp+wLeV/cQnGQORB6TAoGr8oTA5kTL5Dkl3YupFGyHFJhQyvFcQm/I00KUzi8p6KKmG0FB7k5Ju9T7m4pLj+2AIWbUmcyAUsSjHoS3clo0/QVUQmkVEQUFQAt7lab7iPiZIZwmoafdbbGvCmq6DZ9ST5jcafWd1IFrkrIWwVuEQxTz3eaVfCxdxuNhO9aCrTuYXPjc1eiMTCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745913579; c=relaxed/relaxed;
	bh=Jp0XfByIbLGSPJ4g0gcH1EopHgu8YMzsx81JvP6EVgo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T5x2bCGvd9KCFThegPshUPDyJAB+8WbAFMFYZGPTZWW/891WNDCxpYLHd7ADwPndSqgTvXEAVYm0eo+K6vFnZE3H44vVUxOccEcImoO0ao4p8wWXeSaPWnk2ROIwLc6ZU1u4JtsVXUZToPQ0RttrlOXBn5+yl5vmV9khHw4dDCYPjlH6OtoU80kcQzl8RnrdlkRFuy2zf+u/HlQ1AWrg0oE8JVz2ZTOpNUkBpzZs/zo/R44cRxEP6LtECn4tLBZb0NPBMMy2lVncg3ZaLKd9k5Y3+7Gbrfyu4rekUaCUzJSZjci2XCmhFvRQaCK/C+UTY17PUJQJMKNpT7dmk2ItBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zmt5652xHz2yYf
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 17:59:38 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zmt3m6mGXz1d19h;
	Tue, 29 Apr 2025 15:58:28 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 75BEE1402ED;
	Tue, 29 Apr 2025 15:59:35 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Apr
 2025 15:59:34 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <zbestahu@gmail.com>,
	<jefflexu@linux.alibaba.com>
CC: <dhavale@google.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v2] erofs: remove unused enum type
Date: Tue, 29 Apr 2025 07:50:56 +0000
Message-ID: <20250429075056.689570-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Opt_err is not used in EROFS, we can remove it.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
v1: https://lore.kernel.org/all/20250428142631.488431-1-lihongbo22@huawei.com/
  - Keep the trailing ','.
---
 fs/erofs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cadec6b1b554..da6ee7c39290 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -357,7 +357,6 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
 	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio,
-	Opt_err
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
-- 
2.22.0


