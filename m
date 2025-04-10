Return-Path: <linux-erofs+bounces-183-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC4A837CD
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Apr 2025 06:24:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZY6CJ35nrz3blF;
	Thu, 10 Apr 2025 14:24:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.61.248
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744259052;
	cv=none; b=GEreN+/CkwESHIqu/dEdOA/vbMc12Ac16vEActoUVSEAR2WnV0DcJcOWHo2ybDZBEHxV5UzjxQYnyRHeNKXPpYIhC13R28p2LuIOuxp9ohX+rDYNIka7yD60kgyEKJLFZngcBy37a5m94OC1M4ta8uOhcTISkPYhrooGDaGwOt1UnBLH8C89njtVCL5uhaYCJ01iKqv2b+Ezl0unMtIr8R6AUPwh1uMgDxvbnHosbAMyZ21Od8NuI+ygUlfQctfVV2MR6aJcJgMPZQG3Ui6lwwiQthzz6OQy7ZUmVwsSiDZDpTHXxfGSZaCC0KX5j213xz9Ra4Tw1vvgw3dt1iy/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744259052; c=relaxed/relaxed;
	bh=rdQaoupoWSuKenvzSZk93TGaT9NIMgnBD3sAEEpi4TQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axuTcFS/uNPMlBkoshgbE3bAwauLVG6hPTvwFda04HQpvwhgeaNmSZZyvT9TR+i7V2z6tNrn9OxBER8WJ7UyGKrIpyVEPIrEOryyKSF0bhKLVkfCnm5IE052D4ckSVLbmny90a82IzyH1FAPziRwP/6fd9v/+yWmoEeNie2jKG3Cs7yNvJzZTV8vHdEfex0PFFx0XSiPVvjLT3IBZK8P5u91UjwG0h/OdlHwqxzZPZHDqDFVEojA2Ela2YxqVMtAFqhldVakIQmkplGvNSZ6MXJpnf9CMhWHv3jJIXNx2VYTrIYffDCaH/HylyG7c7n1RpJxWXtoXrabRaVk4uKN1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZY6CH3V0Dz3bkT
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 14:24:11 +1000 (AEST)
Received: from jtjnmail201622.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202504101222487160;
        Thu, 10 Apr 2025 12:22:48 +0800
Received: from localhost.localdomain (10.94.13.146) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Apr 2025 12:22:49 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 1/2] erofs: remove duplicate code
Date: Thu, 10 Apr 2025 00:20:47 -0400
Message-ID: <20250410042048.3044-2-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20250410042048.3044-1-liubo03@inspur.com>
References: <20250410042048.3044-1-liubo03@inspur.com>
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
Content-Type: text/plain
X-Originating-IP: [10.94.13.146]
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201622.home.langchao.com (10.100.2.22)
tUid: 202541012224878572f2772b211192696efaeb6fd526f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Remove duplicate code in function z_erofs_register_pcluster()

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 fs/erofs/zdata.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 0671184d9cf1..5c061aaeeb45 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -725,7 +725,6 @@ static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 	lockref_init(&pcl->lockref); /* one ref for this request */
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->pclustersize = map->m_plen;
-	pcl->pageofs_in = pageofs_in;
 	pcl->length = 0;
 	pcl->partial = true;
 	pcl->next = fe->head;
-- 
2.31.1


