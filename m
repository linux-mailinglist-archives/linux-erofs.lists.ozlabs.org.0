Return-Path: <linux-erofs+bounces-224-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C97A99F38
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Apr 2025 05:06:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZjgqW3ykXz30W9;
	Thu, 24 Apr 2025 13:06:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745464007;
	cv=none; b=OVQ8F755HcgPKAGvgR2VWnhvZJxM2MjKWeVCSTNI13TL66sn5GygavYxckKvnAsP8e17Em50vhID4aYmDsiwuGf4EnmEQvBCvj3CddTabOw9CBclngXWs3sT4YEdJQ80V8aedQ2hL69JkK1kQg4zlOxkY6N+Zc/3mhJgnyDGqAAeOrAgcObUAWCwTWjolUGMoZMO1S/IRKJAF2lFI+rmN5rfApM60iRi68XMIEU3rsONqbjPPKNLjMO/IAuIodep1Hlppcut4wdJa8WUbTAmJOVlIjhZlUsBr55PS0wYRuqqW+ob+ZnKn1etIJprMZMvDlj01Tf7Ut0S3RnNbcgVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745464007; c=relaxed/relaxed;
	bh=kR9+9X18obZ2htipeDETQU7N2C54zHbwd0AExBZ2t+U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S+gfdhiCfHbWCn4aCnNnlKszswZN5v6N9qT0YToWWbBdxlssJHmDUTZsU+1/Qw3A+yUZtNNNb9iN4sm58reIV+PYvybpG5xNYumg0azVcgM6NX1g1eH45d7sOWO9SFxMdy1Z6NxzSwudaqlyyeLksuITnTrTmIqJ88TjM046XCH5WvszU0wGFwaJkbCCeLoF5FGtQU/zh9qpFr2uTWYJc2ipUxu4RKQy13w73j96zC6gTNKR0XlupvI169qLEZA1C+4YrlCMY4q5E04oqEw4PU/Jc0Ec07QTzO4/0Gs5wVFbt8o7FQurPfgtI24uRrkRRqwpIFIosXHtRmQ09VGTcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZjgqV5j1Vz2yfv
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 13:06:46 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zjgkd1XJ5zvWq5;
	Thu, 24 Apr 2025 11:02:33 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id AF639180B45;
	Thu, 24 Apr 2025 11:06:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Apr
 2025 11:06:42 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>
CC: <dhavale@google.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Date: Thu, 24 Apr 2025 11:06:53 +0800
Message-ID: <20250424030653.3308358-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

I have a solid background in file systems and since much of my
recent work has focused on EROFS, I am familiar with it. Now I
have the time and am willing to help review EROFS patches.

I hope my participation can be helpful to the EROFS patch review
process.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa1e04e87d1d..f286c96ea7db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8719,6 +8719,7 @@ M:	Chao Yu <chao@kernel.org>
 R:	Yue Hu <zbestahu@gmail.com>
 R:	Jeffle Xu <jefflexu@linux.alibaba.com>
 R:	Sandeep Dhavale <dhavale@google.com>
+R:	Hongbo Li <lihongbo22@huawei.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 W:	https://erofs.docs.kernel.org
-- 
2.34.1


