Return-Path: <linux-erofs+bounces-1531-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3ABCD4EA1
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Dec 2025 08:55:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZVmv1dBGz2xpm;
	Mon, 22 Dec 2025 18:55:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766390127;
	cv=none; b=k1zUOmKXK2tljYH8cSAt1nOWKzVB5Mzhjgn7iPBhpNGMQmOLoPRXjDj5/LcN2Ta3dJon6ivCliHIlGr7ljoFHGvF2ke6nhuINIXwY35TL1BlIv1gQ86uNp6mnkX48UwYSomHOuWR1DOwV32rYRj4Kfet3TsI6PPnE5+NcOt5u4xDJ6IMsBDUBU0nsZ79D9a7w8QkxdNunMlLaCbNQ8vhd2DjHctSHP8Z3BGgiEqIXoE++643MlveUTzJlUYkYDx74GpHiDqoZRzXHxAWPRBSenhNFkIlGAwrlAkRLal09cBs1I2A2gI7qqWtD4gKsY7HZo4H6HHtmo/Xmavke2fALw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766390127; c=relaxed/relaxed;
	bh=44bxGW6dS2vZLLTyKlY9Pnbuw6GoVR34QeyINzfiBuo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YbMi7SA3geqeiK95eG4J2dfCdxNwEbzkkeuTHN38DodHIVibi3XLhpheqZJXwTTd50wu6ImwEXMDTKPspcYpQzTNJHwY2280sHbryZq9rHDXk1EMfILq79/XFk07jrpLTEzmApB+ACb9+ydqNdl4RaDj5ZsIjD1Izg3tbX2/UEaacFCm25PtYjLxyVT+c8GTfn5RWBxhKBhb3mZwc1LztIfO+ggIt2e3BntOGf8816xvL+ufKwI9Q9dGZMxQLCt4v9sYFPR/MZ58GdypcXNiLRc7Ysdt5JS2UnuvY149CrvDadEYOu0JYggqkuaXtZ28vqOcbzan41ahNtOekJdgOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HgOzAMnX; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HgOzAMnX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZVmr2RSzz2xFn
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Dec 2025 18:55:23 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=44bxGW6dS2vZLLTyKlY9Pnbuw6GoVR34QeyINzfiBuo=;
	b=HgOzAMnXODteD/lglAWUrIhRJOY8KJ/tEEXw42mNhV+UnyACUY4HTM69im4mhoU4vug5brA5d
	QIOqNaSZIhYZIzjK80ZtBZybDvmjA/1+Fuq0aR6tkos8LhJSNxGgx2jj2RA+WFB9LqqWX1gGGZ3
	+A0DZj+h/nKh1lOjlFFzKkA=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dZVj84jcXzRhS6;
	Mon, 22 Dec 2025 15:52:12 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id AD7E54056C;
	Mon, 22 Dec 2025 15:55:18 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 22 Dec
 2025 15:55:18 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <hudson@cyzhu.com>, <jingrui@huawei.com>,
	<wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH] erofs-utils: mount: add manpage and usage info for oci.insecure option
Date: Mon, 22 Dec 2025 15:54:21 +0800
Message-ID: <20251222075421.171161-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
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
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add manpage and cmdline usage help for the newly introduced
`oci.insecure` option in mount.erofs. Also fix an indent error.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 man/mount.erofs.8 | 3 +++
 mount/main.c      | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/man/mount.erofs.8 b/man/mount.erofs.8
index 6b3a32b..856e07f 100644
--- a/man/mount.erofs.8
+++ b/man/mount.erofs.8
@@ -117,6 +117,9 @@ Path to a tarball index file for hybrid tar+OCI mode.
 .TP
 .BI "oci.zinfo=" path
 Path to a gzip zinfo file for random access to gzip-compressed tar layers.
+.TP
+.BI "oci.insecure"
+Use HTTP instead of HTTPS to access the image registry.
 .SH NOTES
 .IP \(bu 2
 EROFS filesystems are read-only by nature. The \fBrw\fR option will be ignored.
diff --git a/mount/main.c b/mount/main.c
index ed6bcdc..1463dee 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -94,7 +94,7 @@ static void usage(int argc, char **argv)
 		" -t type[.subtype]	filesystem type (and optional subtype)\n"
 		" 			subtypes: fuse, local, nbd\n"
 		" -u 			unmount the filesystem\n"
-		"    --reattach		reattach to an existing NBD device\n"
+		" --reattach		reattach to an existing NBD device\n"
 #ifdef OCIEROFS_ENABLED
 		"\n"
 		"OCI-specific options (with -o):\n"
@@ -105,6 +105,7 @@ static void usage(int argc, char **argv)
 		"   oci.password=<pass> password for authentication (optional)\n"
 		"   oci.tarindex=<path> path to tarball index file (optional)\n"
 		"   oci.zinfo=<path>    path to gzip zinfo file (optional)\n"
+		"   oci.insecure        use HTTP instead of HTTPS (optional)\n"
 #endif
 		, argv[0]);
 }
-- 
2.43.0


