Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8B1968493
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 12:24:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725272649;
	bh=+xsQAoH83hKuiLcCZfUhZ/tqVmWdb4UrtSbMHcg8gsw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=SLjmyd6MnEQAXBJBNdSjaC7QjvcwzWB6Owjy5AD1rJ95cchAOZ21csFvpEdqHmrPr
	 Sboj6Sms3txS59BJb9jmbrx/fpymBP2u/Yi1NcnpaIMI+9t8INcZ8SzrfkSaFsY7QJ
	 8H0Y0oEUJo6yY7MV/ZQwak6PgG8K8jsAeMwhJXf4Hq/OOjHUtXoNc1nPCS5/RTopY6
	 ci50cPKG2cnTAGxArh/opncmHEUgh67O5RaOMSmhPhXIW5kJY9n9eCe8yCXupUAvg3
	 6dRef6J5KrJBggt1+dRf+dJTme/0DYRhllIQxCdBocolKPcxnwUV/gd3pswW0HH8mK
	 jMVidRagaWvxg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy4c93V5Xz3c7Q
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 20:24:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.231
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725272645;
	cv=none; b=Pz+WDhzATfb1Y7mmeF1n8jn1/MkGZp8RGz7E56UeO9WRz2okK+L7W2dpFpByxMWzaWhFj+3HIdfulZsQjFgVDxUwTFsRp3NU5xLUjIPmq5S/wzQUiIecWbOaG6NnSXsbX2P8OilEyNi5Ig3JnyNjtFY6qbsWz8esrCXqVBeZIqTrAZqM7uBoEhWfADj0gKF4KCbt640XhBqk09ARF6MM5ECahBPBMrWOxnCubhjNmwL/gIO34N4G13yXK4MzumEas9tmX8tJosuQfD9P6a4Eu3aH4v9zCQQ5GUK1i4UEQuy8wj38Hq1KUd9mD7DtBngFx+Dd3HYdMB7zFcjgvMJR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725272645; c=relaxed/relaxed;
	bh=+xsQAoH83hKuiLcCZfUhZ/tqVmWdb4UrtSbMHcg8gsw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=U2pXtSiSqUPFPPkW+GWp95L+1cVpaI6B384AXclhgxtS+SJTzEm7JavSPQ9VtNJ4yDerAiK8QJ4O5hBiD73cPdeJf0H7beJdZdUm+vpttgZRDmbt/baBIcX/g0BaI5rmD0gmVxVyS9d+Qe73iRz1yxirD2QZ/2ANplVNI0zP8C0LvM6xUOgFpryERZbedKjN5wRTqMFixl5tLQmfzZXmiW6U1+0DavS7XIoFYpbJYmzdULvIeHuMw7vy7Jnpuhu+zP6XiXi/kUPDhEvqlMvi5J3PqonYbtKJ1qna6zj6nU99v2bKdp7rg+/emwVF/JBqEEHi4ziWJQplXvw4VPMkjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=dokRTYbL; dkim-atps=neutral; spf=pass (client-ip=203.205.221.231; helo=out203-205-221-231.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=dokRTYbL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.231; helo=out203-205-221-231.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4Wy4c32tncz2xZY
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 20:24:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725272639; bh=+xsQAoH83hKuiLcCZfUhZ/tqVmWdb4UrtSbMHcg8gsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dokRTYbL3fBm2WaqcBC679rKknWmyqtDX3UC220eUJMBTizG4CdSpK4Rcep/UKYhA
	 UivLc5pPNQfHuhQqxzhf7tXqyniQq36vRjeMbl00kljHSIyF/M0b3uvzylCtS4coq7
	 qq4mOeqIE8dLJ8oTc9oA0+cpgD9zRqTdLhz5Now8=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 5B60D264; Mon, 02 Sep 2024 18:22:54 +0800
X-QQ-mid: xmsmtpt1725272576tb1w0a4u9
Message-ID: <tencent_1E2599023C54426692690818C4E61D6F5109@qq.com>
X-QQ-XMAILINFO: OW4JKxETGMY2FyXFUqSmVeeCpTwIsFvOKobtotw2fK19ml5C8lE7XHHzWkU/Vz
	 70qOjZxuckbbqSoFPqo8ppHgWw0L6J3r1kseZsGd5FLQrtogGnPpYC78KPVbsdWm9LLSuZDMpLVH
	 KnprhrbH1DamadC3gGdEjjuYAv5/u1LY5E5pdnxGVt1sgC32ZdWmIrPSMiNEz1LOPAek3NqnNZnG
	 8d0UXGeqq8Z2jlLUk2MRfgaWlKDbtRg0j7OUsqQhqXHOpXcK4vF71HSIpjxZdJvJ8rQYusKP+oqe
	 LZsINl0dWOeh+bh4PrwtpjYYnf5qTZfMHVrsP9wq8cZlv9tEb5n7529ufrILp+Zki2pMGhl26Ti1
	 BP61IjHO/A4EiZFG34Z4S4sYlXnVbWvOQmVDXV9OaWCFk75kKq3rxhCR+4d/9D1qnW+CAj/0hpaT
	 hR5zWLdoCONLofWWO4tdy2hUDFUgBaRUn9c8nDYm/BKnBUk1UBAfoF8jDhfeJdx6qrUc6bzSyhHY
	 0p0nJ8KLIQF8J3UKndcJrxuJA9JuLqsxsDH/43DIE3RpZPThT9XwqFT7zv0IdBQhl7pa/ze3UQnY
	 kVQ2NAReJGi26pjtV0L589slQBjS9RTkGmr8qF2ewdc7gvdoex0sQYape/XyAMlU60pFHgMZClQK
	 xV6ENLzGECNvKh6Xp5Oe3kfImcCC2o9/JjtyRhCurv/Ezl8PEoQlgTwhLiApkc74kA63jb4og0OR
	 K9b0HsaYoCsQY7tYAKSJM6pS9Ieb86WFF4tAGv0wXi4lLEBDh5HEt7uK8MpyrpA6sldvMZ8F5XFs
	 bbTsc9s/UxxPHS0mILYKrHx+TC96BMWMAAVpI1ov6OMtbIuKoTdcJmv2S0wo6EhoQ/msvCc/qmDO
	 o/iR0xepC3o5L6a4p+K5yHk1F4liS2WlgjEA9Uai+hp/80vtft5447l8+VNFJPqj197wPlze90h0
	 RA5sX7WC1rBL83iI11AibZ1xkE6EWIOgHbLfXGtcWFQ3iv7usE/Q==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: tests: add fssum option for fsck
Date: Mon,  2 Sep 2024 18:22:52 +0800
X-OQ-MSGID: <20240902102252.2150182-3-kyr1ewang@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902102252.2150182-1-kyr1ewang@qq.com>
References: <20240902102252.2150182-1-kyr1ewang@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Jiawei Wang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jiawei Wang <kyr1ewang@qq.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch introduces a fssum option to the erofs-utils fsck tool, 
enabling checksum calculation for erofs image files.

Signed-off-by: Jiawei Wang <kyr1ewang@qq.com>
---
 fsck/Makefile.am |  3 ++-
 fsck/main.c      | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 5bdee4d..b7f0289 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -4,7 +4,8 @@
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = fsck.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
-fsck_erofs_SOURCES = main.c
+noinst_HEADERS = fssum.h
+fsck_erofs_SOURCES = main.c fssum.c
 fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
diff --git a/fsck/main.c b/fsck/main.c
index 28f1e7e..de0a872 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -13,6 +13,7 @@
 #include "erofs/compress.h"
 #include "erofs/decompress.h"
 #include "erofs/dir.h"
+#include "fssum.h"
 #include "../lib/compressor.h"
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
@@ -31,6 +32,7 @@ struct erofsfsck_cfg {
 	bool overwrite;
 	bool preserve_owner;
 	bool preserve_perms;
+	bool fssum;
 };
 static struct erofsfsck_cfg fsckcfg;
 
@@ -48,6 +50,7 @@ static struct option long_options[] = {
 	{"no-preserve-owner", no_argument, 0, 10},
 	{"no-preserve-perms", no_argument, 0, 11},
 	{"offset", required_argument, 0, 12},
+	{"fssum", no_argument, 0, 13},
 	{0, 0, 0, 0},
 };
 
@@ -98,6 +101,7 @@ static void usage(int argc, char **argv)
 		" --extract[=X]          check if all files are well encoded, optionally\n"
 		"                        extract to X\n"
 		" --offset=#             skip # bytes at the beginning of IMAGE\n"
+		" --fssum                calculate the checksum of iamge\n"
 		"\n"
 		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
 		"\n"
@@ -225,6 +229,9 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 				return -EINVAL;
 			}
 			break;
+		case 13:
+			fsckcfg.fssum = true;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -932,6 +939,20 @@ out:
 	return ret;
 }
 
+static int erofsfsck_sum_image(struct erofs_sb_info *sbi)
+{
+	struct erofs_dir_context ctx = {
+		.flags = 0,
+		.pnid = 0,
+		.dir = NULL,
+		.de_nid = sbi->root_nid,
+		.dname = "",
+		.de_namelen = 0,
+	};
+	
+	return erofs_fssum_calculate(&ctx);
+}
+
 #ifdef FUZZING
 int erofsfsck_fuzz_one(int argc, char *argv[])
 #else
@@ -953,6 +974,7 @@ int main(int argc, char *argv[])
 	fsckcfg.check_decomp = false;
 	fsckcfg.force = false;
 	fsckcfg.overwrite = false;
+	fsckcfg.fssum = false;
 	fsckcfg.preserve_owner = fsckcfg.superuser;
 	fsckcfg.preserve_perms = fsckcfg.superuser;
 
@@ -1017,6 +1039,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (fsckcfg.fssum) {
+		err = erofsfsck_sum_image(&g_sbi);
+		if (err)
+			erofs_err("fssum calculation for image falied");
+	}
 exit_hardlink:
 	if (fsckcfg.extract_path)
 		erofsfsck_hardlink_exit();
-- 
2.34.1

