Return-Path: <linux-erofs+bounces-1540-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 77071CD7CFD
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 03:09:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZz2n5t9Nz2yFY;
	Tue, 23 Dec 2025 13:09:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766455745;
	cv=none; b=W0lsQ7OruNIH9H99dD5ncPhAw2CxyWJSXiGGBph7O69w6zVmPBXymS3rxvHIDN6yRDniO7n8es0wEjuzCno2mdzstG/hs6ISNSdhOZ1ufg/XuI8GxpxSzzQaTn4R00iuZkb/b1Cx81eQSD174fMQMXIEZztXJ81i5mreuS23T/RaG8pzSVlNp9yIHooVlI9GTVhG8sNJnQUiG/pjv2QJlc+/J7av+f2DvWHuncUq5wiXc9bZGqiiAbaDpFZ1UH+SVfjzLB9rWoLsQVgwgSEycQ3uqbUczlPCMUztxWUKhD3fYff/3S92+0EALx5WU7NGQCUEU6rorlcmyJSkflGcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766455745; c=relaxed/relaxed;
	bh=1cRA9yZ2lUeSNR4inCl2rr0rsFzm8me84K0NkDYSyjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4ebO5V81XnKehEE/Dw5P7m45ET+qvl92fHzVUiB1Jo1e5ZEE4GT+WSrm/xLzTCEUcpX5OlV4vYBldmPynd8cLnP/l9r2PJMZF75oClRP3QFhimznt7r90wpPPWSR7ibo+D0WD/cAZMg4OXD9t2cHHN+LDR+FSOSV9M9b/a65vW3oe1A05cxDwEq8Whq/P+AYiChSntOFdx6Oj6SsGFWhtqhp/mswZo/JH8lgl3LMvTyXA7gjTyM+wB9XTDZBtK3u5vWdI8RSkqPq17uJGdtaTIidINNmbp8MvMEGk3jFuyD3pxlvuU4eoa7UcUiFSfTcZ0laxBNp/jFFDUjCw+14A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xYOb9tDf; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xYOb9tDf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZz2n0x58z2xdY
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 13:09:04 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1cRA9yZ2lUeSNR4inCl2rr0rsFzm8me84K0NkDYSyjw=;
	b=xYOb9tDfx19eGQHxJ7CkEJuDRAWU9klU/rSt4zmBXFWJQymjZ3QZMm20oECHc1+XKXm2iBDPo
	+l1Fc/DrP0soq5m5S5Vngl6ouNlI36bT5qqIu12EC7ThyGLmc448sFkBLhtsOlVG2RC1k+H58t6
	lalenIhHriDqA9swcdMStDM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dZyz94PKWz1K996;
	Tue, 23 Dec 2025 10:05:57 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id ACE924056C;
	Tue, 23 Dec 2025 10:09:01 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Dec
 2025 10:09:01 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v10 03/10] fs: Export alloc_empty_backing_file
Date: Tue, 23 Dec 2025 01:56:12 +0000
Message-ID: <20251223015618.485626-4-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251223015618.485626-1-lihongbo22@huawei.com>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
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


