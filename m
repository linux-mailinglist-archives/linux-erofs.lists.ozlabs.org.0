Return-Path: <linux-erofs+bounces-1530-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF27CD4E50
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Dec 2025 08:47:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZVbF6jMBz2xFn;
	Mon, 22 Dec 2025 18:47:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766389625;
	cv=none; b=NFvASMnWUpfTrLqhzN8q2OnlPxQkZhqs9K25A0vmmi7vDjT8wDzIvy/rHzFXXyyDonQfXdlV6bdrhPxq2hswV3yRm8SV5j2ai9apATt4LI2vU2pAbulo9caCVxyMVjc04CNHBrkFaLSG1JcTkPso8JqnD+HJvizUS6TUXgwlU/sCQESOmdNzhxaS+uchpi3zEK0D3lPesIpgZhF0K9k7fpOJzmXINABxhTxJjNYuFfEDSlN3k+A7/s5d3zu4WCBryafjHSBY0GH2h6i3N2pwWlvUFT8nZd4ICpLUW/40nZhtqWFslbrd+x68KZwSl7AagH9WdlFgExZG1kEva3aicA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766389625; c=relaxed/relaxed;
	bh=Q6om1Wp2psDwTXoGTSxFGwsXGX3BUSA6jyBNuJMffzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRE7nrEf/2UENn/yAOm5BgGb4FpvdJrd9j1g9AQpJ7WQb/hqz//goRrI8ZeRpMDIVXWQwD0vs1YC6MtpmeZyaoFTbs9KlZBNzZiceO6dJNWoykRD7CiEgFenFdYttGI/Lvo+zt8XAg9frf7iBc58rdz1j0pFRaMk9uZ+iSyiTNt6asxkMOWEqrvcg/T56oCabSrRGa/qrCtl+kqe2Iy3f0f35GB35VhixcxElIXesoW9CoesBBoMM+8d4Zr/QGHdj/k61190+AhXCJmuWbkrZlHw5fwWifOZBq4AJYMTxkRppmoQlm8o5GVwFi6MkU8sGvN2PIrQyV9vfGLwEyyXBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HqREb++c; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HqREb++c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZVbD1j2Fz2xpt
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Dec 2025 18:47:02 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766389618; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Q6om1Wp2psDwTXoGTSxFGwsXGX3BUSA6jyBNuJMffzw=;
	b=HqREb++ck1vY66iAfkgVoVe832YDrj7qIaUDhvaDJBxtpJBHaS9KwnOldpM6Ozipc7ZhzLiUo5crChFX7NX1r4qYuf/9G0QLOshYbl5RoQ0kX+tXpSgG1jzAuH9/pHI1GCYNBNKubTbtVnxGdJiMYxMGIjIw7rNbXwQ/WuMr4Us=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvMyarm_1766389616 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 15:46:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: mount: add `--disconnect` command
Date: Mon, 22 Dec 2025 15:46:52 +0800
Message-ID: <20251222074652.1947729-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251222074652.1947729-1-hsiangkao@linux.alibaba.com>
References: <20251222074652.1947729-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Users can use the new `--disconnect` option to forcibly disconnect or
abort NBD block devices.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mount/main.c | 55 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index b3b2e0fc33e0..693dba2dc78d 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -51,6 +51,7 @@ enum erofs_backend_drv {
 enum erofsmount_mode {
 	EROFSMOUNT_MODE_MOUNT,
 	EROFSMOUNT_MODE_UMOUNT,
+	EROFSMOUNT_MODE_DISCONNECT,
 	EROFSMOUNT_MODE_REATTACH,
 };
 
@@ -88,13 +89,14 @@ static void usage(int argc, char **argv)
 		"Manage EROFS filesystem.\n"
 		"\n"
 		"General options:\n"
-		" -V, --version		print the version number of mount.erofs and exit\n"
-		" -h, --help		display this help and exit\n"
-		" -o options		comma-separated list of mount options\n"
-		" -t type[.subtype]	filesystem type (and optional subtype)\n"
-		" 			subtypes: fuse, local, nbd\n"
-		" -u 			unmount the filesystem\n"
-		"    --reattach		reattach to an existing NBD device\n"
+		" -V, --version         print the version number of mount.erofs and exit\n"
+		" -h, --help            display this help and exit\n"
+		" -o options            comma-separated list of mount options\n"
+		" -t type[.subtype]     filesystem type (and optional subtype)\n"
+		"                       subtypes: fuse, local, nbd\n"
+		" -u                    unmount the filesystem\n"
+		"    --disconnect       abort an existing NBD device forcibly\n"
+		"    --reattach         reattach to an existing NBD device\n"
 #ifdef OCIEROFS_ENABLED
 		"\n"
 		"OCI-specific options (with -o):\n"
@@ -271,6 +273,7 @@ static int erofsmount_parse_options(int argc, char **argv)
 		{"help", no_argument, 0, 'h'},
 		{"version", no_argument, 0, 'V'},
 		{"reattach", no_argument, 0, 512},
+		{"disconnect", no_argument, 0, 513},
 		{0, 0, 0, 0},
 	};
 	char *dot;
@@ -316,6 +319,9 @@ static int erofsmount_parse_options(int argc, char **argv)
 		case 512:
 			mountcfg.mountmode = EROFSMOUNT_MODE_REATTACH;
 			break;
+		case 513:
+			mountcfg.mountmode = EROFSMOUNT_MODE_DISCONNECT;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1415,6 +1421,33 @@ err_out:
 	return err < 0 ? err : 0;
 }
 
+static int erofsmount_disconnect(const char *target)
+{
+	int nbdnum, err, fd;
+	struct stat st;
+
+	err = lstat(target, &st);
+	if (err < 0)
+		return -errno;
+
+	if (!S_ISBLK(st.st_mode) || major(st.st_rdev) != EROFS_NBD_MAJOR)
+		return -ENOTBLK;
+
+	nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
+	err = erofs_nbd_nl_disconnect(nbdnum);
+	if (err == -EOPNOTSUPP) {
+		fd = open(target, O_RDWR);
+		if (fd < 0) {
+			err = -errno;
+			goto err_out;
+		}
+		err = erofs_nbd_disconnect(fd);
+		close(fd);
+	}
+err_out:
+	return err < 0 ? err : 0;
+}
+
 int main(int argc, char *argv[])
 {
 	int err;
@@ -1443,6 +1476,14 @@ int main(int argc, char *argv[])
 		return err ? EXIT_FAILURE : EXIT_SUCCESS;
 	}
 
+	if (mountcfg.mountmode == EROFSMOUNT_MODE_DISCONNECT) {
+		err = erofsmount_disconnect(mountcfg.target);
+		if (err < 0)
+			fprintf(stderr, "Failed to disconnect %s: %s\n",
+				mountcfg.target, erofs_strerror(err));
+		return err ? EXIT_FAILURE : EXIT_SUCCESS;
+	}
+
 	if (mountcfg.backend == EROFSFUSE) {
 		err = erofsmount_fuse(mountcfg.device, mountcfg.target,
 				      mountcfg.fstype, mountcfg.full_options);
-- 
2.43.5


