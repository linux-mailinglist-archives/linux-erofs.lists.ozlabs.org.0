Return-Path: <linux-erofs+bounces-1399-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95669C6465A
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 14:37:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d981k1lSFz300F;
	Tue, 18 Nov 2025 00:37:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763386650;
	cv=none; b=NuUK6u5KkfNcEUbNGlbGRJDxIQG/Y+IVs6KQf+wU5z4Xko2hrp4OZ8WsJ2QxzuymZb3pg4JsTEY6HqWAO14xKGxSPwS76LOG7ypooOU1ZSWu/dQa+GdSa1U7GzbTXS2ladTx98M5gjqGEZ+YGknpngFJniley4K2q2NDGQIBD+NPkJwfvkHUxkJIfCAU4PqtjiKgO5cKhXGZR2vkEHIGfp7mI3e9x7d41vNUNKVAlIB4GbvwhI0D3iY6kj9ddmd9sILglm5hVpbqgco9//JEtjA6w1sn6wDL1e/OzOUpZjsNo03ibbc9bIglX+cIPlCT+VtP97VS7cvFTO7r2BKy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763386650; c=relaxed/relaxed;
	bh=p0umYnge/9FjlLkpy4PvS2wcFW3FASjdMXzdFE5g+6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3/hR/W468Pi+YzYNcLpJXPaKo9ydlxt3wHzS/xGPupxw0G5AE+s/JnbSRnjfiX3IHjh7c6wgnfievDXJGq0yySDcAo+Fn3kn1B9NAbB/U5F0Sv/qr8SBFlHl2mRuOQwiyZOkKj35DBqeeVmi78dbQUv88KUT37QPzu/XEOV6RtKplQZiN8YdnPKMvG4J9DR93S+I1UEqvtCk/xnasAxjfevilhzSwvkGvrKzY4S9Djfn/TLuvy6KqDswFmbjUn2JeXujmT0Eql7BglbkdCdR2K+8ptt1KMR2oTB2W/rFeD+VU85sYu+Usw7DI0zyLJeqAdmrIYRTaQ7BBuuHQjGWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ykDEiun6; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ykDEiun6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d981d4Yrdz308g
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Nov 2025 00:37:25 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=p0umYnge/9FjlLkpy4PvS2wcFW3FASjdMXzdFE5g+6g=;
	b=ykDEiun6uQV0x6mT1Z3+CS6s2um2ALZmoXqzXZGY9B7fYbgrrdPioYXkHBidFDyRjPXiFpoX5
	tfyRDEhEfpPqwNAu49HkEEPW+idu9Q908Jdp9+RqzZdOZ8pM6dvRNpwCDF+rAULgwyGFT/BDItI
	i9tinlXEg7iqM4Ht/Uxq20Y=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d97zq2zltz12Lfd;
	Mon, 17 Nov 2025 21:35:51 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 043B1180471;
	Mon, 17 Nov 2025 21:37:20 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:37:19 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 10/10] erofs: implement .fadvise for page cache share
Date: Mon, 17 Nov 2025 13:25:37 +0000
Message-ID: <20251117132537.227116-11-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251117132537.227116-1-lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

This patch implements the .fadvise interface for page cache share.
Similar to overlayfs, it drops those clean, unused pages through
vfs_fadvise().

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/ishare.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index da735d69f21f..d8bff0cdf702 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -230,6 +230,16 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 	return generic_file_readonly_mmap(file, vma);
 }
 
+static int erofs_ishare_fadvise(struct file *file, loff_t offset,
+				      loff_t len, int advice)
+{
+	struct file *realfile = file->private_data;
+
+	if (!realfile)
+		return -EINVAL;
+	return vfs_fadvise(realfile, offset, len, advice);
+}
+
 const struct file_operations erofs_ishare_fops = {
 	.open		= erofs_ishare_file_open,
 	.llseek		= generic_file_llseek,
@@ -238,6 +248,7 @@ const struct file_operations erofs_ishare_fops = {
 	.release	= erofs_ishare_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_ishare_fadvise,
 };
 
 /*
-- 
2.22.0


