Return-Path: <linux-erofs+bounces-1574-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7576CDB4D5
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 05:22:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbdy76lpHz2xqm;
	Wed, 24 Dec 2025 15:22:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766550143;
	cv=none; b=NHKQRUdLnX5pae0wGOSaibZeDJ7dNYsJRRO9p7vPWRwywK/WjzBdOU2lEoh5N0RjO0MvJFDGTbO9xLc7+CbEicBujM03eDWetWTM4mzhezYDTJ4UVyh0lyIdaEJBGjw4IxEDQXPLJkRTeUXUqbTiQfBRClGOeeHOrkeRIgL/YtWyClB+Xw4ut71Nz4BnadgTdkRsg+FpfG2EuIrDdEv4NFnF8B5lzKiNUN+uEaDdO7yj6Ee+TxpexxS5hUmtj4OJLNOnWgJTRx+0trdaddQbFZDpK272M4tiUgs08BX0WHnwyrv1UM3dfn6WWy/lJGiix7dNuHkrapHvytnHYH7XXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766550143; c=relaxed/relaxed;
	bh=pCEmq/7pHVFqz5yCBp8Mya2y3rUOY7LVIakJQzG9dVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8ShK0eWVK/mkygOg0iLxqf/ZesPdioyLExXEKq2JzYJoDUzMbn9GAoPmG7HbcLHSxN7BIjpJZrQZLs5abbiKuy/4m/dkNJJHoku4va+n6RbPG37Ud40D5xd7vO0mejbh4YfZVayLkupiFnw98Uptww+XEV1w4xIVj0iQxrchYA2DPbBr0KZ4vFINUT2f8rH9xHU0fWoUWR34Kfr7INESYY8xDI+5fREs9sa2GPcxVM7ECKZq/p6pCOAI4KGfoE9203M2vhhfuS0GnMxPsuZVIW+p/frNT4La/qjV8uWUbe3b9kLAxfyeFMkJhGUH3rfBJS8qcUomD18AoaUHHD+RQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=i1AjIdsa; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=i1AjIdsa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbdy71kTVz2x99
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 15:22:23 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pCEmq/7pHVFqz5yCBp8Mya2y3rUOY7LVIakJQzG9dVQ=;
	b=i1AjIdsaoG1hZ0YSlACtNP9nGN/ILaNjIBwDd8Elzxk+UU4cfMMe2h2lHZGfv5lvpUmUWzlFV
	XoVS+M4ZWk0V7yELt5NLcRzz8mDxiEZ0WyJKCbk80PL2uB2iJRXlS62NNxoeCpleOXa5qUkqRim
	wuegOGIfTOtQxh5Pb88teAo=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dbdtQ5cnrz1prKH;
	Wed, 24 Dec 2025 12:19:10 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C80C40363;
	Wed, 24 Dec 2025 12:22:19 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 24 Dec
 2025 12:22:18 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v11 03/10] fs: Export alloc_empty_backing_file
Date: Wed, 24 Dec 2025 04:09:25 +0000
Message-ID: <20251224040932.496478-4-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251224040932.496478-1-lihongbo22@huawei.com>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

There is no need to open nonexistent real files if backing files
couldn't be backed by real files (e.g., EROFS page cache sharing
doesn't need typical real files to open again).

Therefore, we export the alloc_empty_backing_file() helper, allowing
filesystems to dynamically set the backing file without real file
open. This is particularly useful for obtaining the correct @path
and @inode when calling file_user_path() and file_user_inode().

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/file_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index cd4a3db4659a..476edfe7d8f5 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -308,6 +308,7 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
 	return &ff->file;
 }
+EXPORT_SYMBOL_GPL(alloc_empty_backing_file);
 
 /**
  * file_init_path - initialize a 'struct file' based on path
-- 
2.22.0


