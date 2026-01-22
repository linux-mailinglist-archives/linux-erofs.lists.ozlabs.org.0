Return-Path: <linux-erofs+bounces-2145-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL8IMigrcmmadwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2145-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 14:50:32 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E3E67855
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 14:50:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxjBC3fNdz30M6;
	Fri, 23 Jan 2026 00:50:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769089827;
	cv=none; b=kOPPLkz+s164RcMQ7HCS1g78YR9HmBPeDOVCmEFkWzlMjP5ApDxyRaVvSZTwRdiODcZ+qL0O8Kee63RjnYFeghV+AFmxKXibdQ6tJzakoyCuo9XS3TsCqCRdRtw+uAqCM3KMqzLV2ABgKqanUSKCGpC0BgqM7PldNc2BFKdmWtuCu8sseIQmS4mdOXiHW8RR7xqlQmbtLjMWyS4mvQ7Jd4/aNlgN7jucnh58jcskN7Hleie+E0LiucwVMXrRHPadmrwS9KQsl73BDFZjpo5p5gzKD3GgHow3v795J/NpFMZyCwMppkbDtKoYiXdrPXgJLyX4AkGQqzn5rVCy8aJOow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769089827; c=relaxed/relaxed;
	bh=IJqOVDMyH2cU6HZaQ6KGaq7L7r7sGB/NU+oSMo68sYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8rmG1opKD0ptBJN0D4KehnJtGRqrPiDx2zBpCJqzlxqLyx9mJNd+ydZ1Ylrc6n5ROLgUReWrerkdDpm/sx93OM1C2Iy2wkVuiTJRmWAzXn6BIf5iVua/4VNesaVF3uGM4LMeZprQaiTuUqAEfLyWOJZwqwPyCUrMfAP+2UvPWn+16jm9b+Or/xS0OLVBoNbwPryLXl+CXZwEBCjeJIdcqmBpjYX9cgYHnO4nDBCj2fTQNxalAXsOPx4VcqDZ1hAKGb5BHRbFy9Ua7d9qvoJjPD4jsA7ViDcPuViOTNc19ORYQbGcpONUCoCNMRvnuTAnnGGwezu5RCKsAkgjmFYJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aViTVgKb; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aViTVgKb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxjB80Yxdz309N
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 00:50:23 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IJqOVDMyH2cU6HZaQ6KGaq7L7r7sGB/NU+oSMo68sYk=;
	b=aViTVgKbU3p9F6fvfb/DRZ9GIhljQ3rKlHQMPA1II5YccTLm1l79Wl8RBcmkkhYNwMzHKxXz0
	9YV1Y0ow6kq2fONT0jz7uycW8blnvYaMxZYGGACdFOLs9cXkvJ3tWcEIwXSiiP4I/798eIXtO+j
	kCdEQvGGYPkM65v8oi6/oqU=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dxj640M5tzRhR4;
	Thu, 22 Jan 2026 21:46:52 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id C1DB64056A;
	Thu, 22 Jan 2026 21:50:16 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 21:50:16 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <hch@lst.de>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v16 01/10] fs: Export alloc_empty_backing_file
Date: Thu, 22 Jan 2026 13:37:09 +0000
Message-ID: <20260122133718.658056-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260122133718.658056-1-lihongbo22@huawei.com>
References: <20260122133718.658056-1-lihongbo22@huawei.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:chao@kernel.org,m:brauner@kernel.org,m:hch@lst.de,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:lihongbo22@huawei.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2145-lists,linux-erofs=lfdr.de];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_XOIP(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 31E3E67855
X-Rspamd-Action: no action

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


