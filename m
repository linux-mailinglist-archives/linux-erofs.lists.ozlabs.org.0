Return-Path: <linux-erofs+bounces-1661-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CD58FCEBA47
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Dec 2025 10:14:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dh45Y3r1hz2yNJ;
	Wed, 31 Dec 2025 20:14:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767172449;
	cv=none; b=Z3tA0SPHL3aKEgj0ILPIZrtAMQTZOGtLwf/aaRDiyEIm5ovYvm/QaceU52Vbjn4Wcgfy+ltxE1EMOQpYHaaXqFbAs4t7zF6fZdiigagit9khEqPoOg1xs7Yx1N4krpd0vWd7U7rX1cJBuUxeO8LwkkLS0g3KKXd6ae/bqJSHs3zCTrubjWdXIleUC12KxUEA7JHCYECNoEAqKfppEY8qRS+VeJ9pSmlunGF1Ob2AioyL8746/m/Xnv2tkZLBgLqRpLc7NDr1HoYLOMKwZKFjGuqCjqmKvFUCleqxbcP/4OTCQ2PCNnBuNdCdhXyO6Fr2A1yviJ2x0UvHvfnQRUJYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767172449; c=relaxed/relaxed;
	bh=IJqOVDMyH2cU6HZaQ6KGaq7L7r7sGB/NU+oSMo68sYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ON6TABkTnXSOGXbyw4SXEZIKBCsN6eUfbUTuqpjQNYT08VHcOqY1L+0/q7Xx/M9yr/x5a0AfSq9j2c+wwOJsa6mVumvBQqTiqpqCPS1SUuYVkyCcNTklTkv5ou3HYQMlQ2yOpR8lWHgXz9eju9iD4MmAAXyiRrBdvX/XOFTjrOA4npLfT7iaf0jt+anHx5bFGxy5Lq+BhoDafMrjJeud4pPZkmRoyQNMbm35OGZKje4mtp7OtwRxyUCMPJRZh+oPVgDLOFTO34NvGqeWXrUKF/xbvY3cAdO8/90v7ZaAzufxerMsrNAAOn7b3wNkqDP7ul4hjVm1gtlk0CKRj7Xm6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aViTVgKb; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aViTVgKb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dh45T42dHz2yP8
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Dec 2025 20:14:04 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IJqOVDMyH2cU6HZaQ6KGaq7L7r7sGB/NU+oSMo68sYk=;
	b=aViTVgKbU3p9F6fvfb/DRZ9GIhljQ3rKlHQMPA1II5YccTLm1l79Wl8RBcmkkhYNwMzHKxXz0
	9YV1Y0ow6kq2fONT0jz7uycW8blnvYaMxZYGGACdFOLs9cXkvJ3tWcEIwXSiiP4I/798eIXtO+j
	kCdEQvGGYPkM65v8oi6/oqU=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dh41k4dcTzpStp;
	Wed, 31 Dec 2025 17:10:50 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A3484056B;
	Wed, 31 Dec 2025 17:13:59 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 17:13:58 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 03/10] fs: Export alloc_empty_backing_file
Date: Wed, 31 Dec 2025 09:01:11 +0000
Message-ID: <20251231090118.541061-4-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251231090118.541061-1-lihongbo22@huawei.com>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Acked-by: Amir Goldstein <amir73il@gmail.com>
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


