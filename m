Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245E2979C64
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 10:02:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726473739;
	bh=+xsQAoH83hKuiLcCZfUhZ/tqVmWdb4UrtSbMHcg8gsw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ENHocaMgW2Hs3cLZtkk5hrhthpWalUevISOzR0YJMB4lum8K3mseHpT0t18EtQnhf
	 E8Xg7C81QP61Lkb3iW8X3KH8zWqfIdgCPE8F1wFq3Cua9cqU2bUA2UgigLsyFLVsbZ
	 gWlMS9gT/xliqCJAJIFE/BYTHj2f+3gTgd4LY56FmEgiKgUVpHHgBztNI7hp8mYXaZ
	 CKTAsRzGp1OtwJMtknOkPIDvQGc74ragDcYNkdOBrAOVXBea3XHoZWEbUx6M8k/Et+
	 RGChC2swhQaAM59WMrgNHNXuDL/QOF1Uug7cv2Dijcrj6pxPy2FJyVbCyJURZDS3KO
	 C43f8AF573jrg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6cp31L3mz2yYd
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 18:02:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726473736;
	cv=none; b=dqyUxE+11umACF9ph3P4LlT15zP5ZJWVZRDv7y5Z+eFlfk5e24PUhwYh+/dsZjW7EUX6gOwY5S5tk5QAu5p1XtwcGE7AUk1aDJRXEORh+a+MseIiguMWCf4QFZjGN3Symo+mLfj7b8IgMcjGUxaZ+3AXSf20ls035psjJVxylKAU2Ro3xVIp0QsaeWc9J3s6Vt3gpEYjSBHWo233m5ThqMAOQAiXMDR6Hnv8xM/AWtMOxDY0isdc3ueVLh/IWEHcIBpLqFc5IbFlzvRsODiIQFN5nXibR6NXgzAi5p9K41WquhSWJVOTbH7U7mAS5h4Nu9I3k8ISbSauiqS51FFeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726473736; c=relaxed/relaxed;
	bh=+xsQAoH83hKuiLcCZfUhZ/tqVmWdb4UrtSbMHcg8gsw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=V2E5tU+LmJJBDq6RfzzjLpKa9WYPOz38UyTq8EmLdljDR+ZkJbADapfvYgGwU8EBEZsEJmnDeRPz8yMPEh9O1BjTWt+F/a8jyOkXhefasts1NIcAPzsa7q817wurCpXhT+O4X8y+/I4sXFID7FULqTQG6rozjraah6dp89ljX4Zyg/abqQX3MJC7ZXsMvQViYmAp802NDFqokFPy4qtdC5S3ZS88D93f3LMDFs1JMp+S53VUplhJZQt8wXfCTR4joHuE4620DinG48Qp76cIh4iWkSpcsNR9ayf3p0qku6qB0GZSshMl1huapPF9J3tmVWbnuOYNYdZ3jugDmTzI3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=lAtYYDL9; dkim-atps=neutral; spf=pass (client-ip=203.205.221.191; helo=out203-205-221-191.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=lAtYYDL9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.191; helo=out203-205-221-191.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4X6cp03VbSz2xHW
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 18:02:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1726473735; bh=+xsQAoH83hKuiLcCZfUhZ/tqVmWdb4UrtSbMHcg8gsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lAtYYDL9/UFmVRR9rj3RwO0emn1USf7pbwI2yDYMayyRAIP9Gy9MWiOb1nvYu1sFU
	 uYgNyecr7p1/r09wEJ7VNmtxdJCCpQbBpQAr4+oyx76sKWMjTmami6pmrBr0C0eVUb
	 kqM0k4Wi/tp5Y/qoCClXCq2Ydlsdgk+RBfxQzdsU=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id DBA8E8E2; Mon, 16 Sep 2024 15:54:58 +0800
X-QQ-mid: xmsmtpt1726473300tsmzrq0q6
Message-ID: <tencent_5BBF5B04C9D58026959E990D9A1A06C37907@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/DhYawxLh8rO0x9IRhi28BmalnouZo01RuKVG2A6UShbFYcjZGF
	 Sr8sJnwrYY0v50hNA5KzyEOxU4mtdT8RFtBx4UUH0BZEuxwQc4rZGMuReVLIBMirgtXP7LSqGwkH
	 VkBBpdo4A8VCX58DfkWd1YOtQSg1OqrdoLp0CbRZYn8JsPYkYdZsAj4tnRJN17ki108UWdbw65xv
	 4z9Z/No4Y2ITU7ovgwsPX6vUOhjPZN2Qkt2PM+7JaPEp+tSug94lkhdm2/6wOavM8JqfRjVmjPiJ
	 skdehqCUp6H88gD5rZbVzkfJxYsf0pUclBAtFFiARwtzCpODxq+VWG0NMQpHzFCrgwlESsAcf/qu
	 lnScaoyuirlGUankLIc8u5e5Q8XSXdv86urnvYwsRWnJTAfYSaEkYv2W1p/q8J7Lg7VhDZEuROWZ
	 ASzmWS77pe1VD54Lzl674U+r3pTKZEV744kCIHnYC6sdOb4uB8M5vp1zkRWHHvX+C76CUppR7lFN
	 KSkJkHb0eeUHAABvCWuZSgrEGpEtZgd93c8wEKM3UAnDnsRQfz4Sug3TDDztHDonCR2lp3FoKu2c
	 n0F7Oy92+tA9QuHUebM/qiWrb72YlH7Q0sRpn094G/5KriATGiSSbNUOgqKaVn5KYSnI0MiGvwZF
	 aYgHOa9O2QFuLKZmVy4Sq4DdEaCvJ9U905Scd0Qnz1CKOga7/JirLHqAVVy8rOb7YJt3fvwY/3FT
	 y+o6QsmHCaO1hSW6kKQZto09CD7ht04ruwfv1qTHJes8HswkF4M2CqdV7GZHWt/2367Dvci6vBv6
	 7ScUc3rsSQFUXmRss9rpNXalDNK6lZb9NzwUnUj/3oiLw2Is6SBCDJs1IhAzuf6uwcQrg6DZyII2
	 ZyRepd9S1YQBGS/ZSIlQWSuTdSsbrQ649nGWH3/xy4zf6SjGjDMmpBeh59yZbJRntTD8vk/nwZue
	 Y+PNSm66zRBq/5o+GVZm5x9Jdufm9k7PGtExuTi37h/df/Sx/WAS5dtYlFj8nzt+yy1BKSpI2d7C
	 j/72I2MYHxRF69tmhcgaQWFCVO6vMUPM6Emf52W0UOmZq3/mPw
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: tests: add fssum option for fsck
Date: Mon, 16 Sep 2024 15:54:57 +0800
X-OQ-MSGID: <20240916075457.2448082-3-kyr1ewang@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916075457.2448082-1-kyr1ewang@qq.com>
References: <20240916075457.2448082-1-kyr1ewang@qq.com>
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

