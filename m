Return-Path: <linux-erofs+bounces-1163-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8816FBCA6AB
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Oct 2025 19:46:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cjHP11mPQz2ySJ;
	Fri, 10 Oct 2025 04:46:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760031989;
	cv=none; b=UjolDCbpyeYwnj78U995/ifV/kEt5n9wewJi3curEDSLLl68f+hjPi+7Xb7gFMdMhb7qz/bBH5ZjBM4TfVqqK9j/Pl6Xu/ni2XTaP1Kz/AgRqteB21QJgMTjL/WXmmFnk3qiMbPwOWhbw+Tjgb8BFmLEsxlPcdW2+rP5mVTCMVm5EfVUXrUVlnpXS8gvvuIBN//nV55zERP+2b2xzJj0Av1Y2nCoCfPGnDL5Ibs4YTHVmCDNF5xvnS8iMAbroVL9RM6p5wSxPXY5y5BGRJ/V8vfviN6J0BMfM2KHHrDlOssMAe2bXFm1N/miabV/pPDTWs8LD8DbOGEz9xaMt+MVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760031989; c=relaxed/relaxed;
	bh=g5OUtaSjbyIlxkGsZiqPAHnqQCdqK+w4tXTOvM1oimE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VRqtAQJO9ruv4aLZ3rBb/nCUvtBCTaLhe/Osql/axclSKMCmNYQ4dch2DEAXCkH3uv3otaHo5/KCX1MM6k5DjMo31I5BCI5FWrOMJTogz+1/ZBC/fispGab+gFan+4IukWwCPJy6mZf3AWl/LSo4Hee+dvhDnvGKYHb4p1mq6WX64Tl/dimEqI+WcnYK9xNi8RT10+Rg90f9+FelhMjO9pmVVd/PmC6rdaZFPL1BSfuNyKy6fKDaL6dY3kmOshWlm9MK4M43ZMZVNR5MYqgXGf7TAsScU3Nhi2TOFB7DBm7BURTnP/0JksSTlha7F7GNE8Di8WLp7fY31Pv0TH7siQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=btOR7JaD; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=btOR7JaD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cjHNy5r3Jz2yPS
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Oct 2025 04:46:25 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760031978; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=g5OUtaSjbyIlxkGsZiqPAHnqQCdqK+w4tXTOvM1oimE=;
	b=btOR7JaD5QEn3LxfB+8r3BQ23uqdYPteBYcrc15U+0CSFkhqZsSbbi5+b3SVUJYuVHIgKjo3/ZIbdhs6MJsvUoQuyvx8+GlNRv/E5WhPgu7AZTEZI/EOzN2sgkUBKQDEefqU0I11c9hifABhkPYESQjU0iSJisJCkBhPTe0jNpU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WppybGz_1760031973 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Oct 2025 01:46:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH] erofs-utils: dump: add support for `--blkid-udev`
Date: Fri, 10 Oct 2025 01:46:11 +0800
Message-ID: <20251009174611.763664-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

For example, it can be used to disable udev's parsing of metadata and
the creation of persistent symlinks for that device [1], in order to
avoid unnecessary network access which can take long time.

```sh
cat << EOF > /etc/udev/rules.d/59-skip-nbd-erofs-persistent-storage.rules

IMPORT{db}="UDEV_DISABLE_PERSISTENT_STORAGE_RULES_FLAG"
IMPORT{program}="/usr/local/bin/dump.erofs --blkid-udev %N"

ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="nbd*", ENV{ID_FS_TYPE}=="erofs", ENV{UDEV_DISABLE_PERSISTENT_STORAGE_RULES_FLAG}="1"
EOF
```

[1] https://github.com/systemd/systemd/pull/3714
Cc: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/dump/main.c b/dump/main.c
index f685799..99fdfde 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -26,6 +26,7 @@ struct erofsdump_cfg {
 	bool show_statistics;
 	bool show_subdirectories;
 	bool show_file_content;
+	bool show_blkid_udev;
 	erofs_nid_t nid;
 	const char *inode_path;
 };
@@ -81,6 +82,7 @@ static struct option long_options[] = {
 	{"ls", no_argument, NULL, 5},
 	{"offset", required_argument, NULL, 6},
 	{"cat", no_argument, NULL, 7},
+	{"blkid-udev", no_argument, NULL, 512},
 	{0, 0, 0, 0},
 };
 
@@ -125,6 +127,7 @@ static void usage(int argc, char **argv)
 		" -S              show statistic information of the image\n"
 		" -e              show extent info (INODE required)\n"
 		" -s              show information about superblock\n"
+		" --blkid-udev    print block device attributes for easy import into the udev environment\n"
 		" --device=X      specify an extra device to be used together\n"
 		" --ls            show directory contents (INODE required)\n"
 		" --cat           show file contents (INODE required)\n"
@@ -198,6 +201,9 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 		case 7:
 			dumpcfg.show_file_content = true;
 			break;
+		case 512:
+			dumpcfg.show_blkid_udev = true;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -765,6 +771,9 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	if (dumpcfg.show_blkid_udev)
+		cfg.c_dbg_lvl = -1;
+
 	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDONLY | O_TRUNC);
 	if (err) {
 		erofs_err("failed to open image file");
@@ -777,6 +786,15 @@ int main(int argc, char **argv)
 		goto exit_dev_close;
 	}
 
+	if (dumpcfg.show_blkid_udev) {
+		char uuid_str[37];
+
+		erofs_uuid_unparse_lower(g_sbi.uuid, uuid_str);
+		printf("ID_FS_UUID=%s\nID_FS_UUID_ENC=%s\nID_FS_TYPE=erofs\nID_FS_USAGE=filesystem\n",
+		       uuid_str, uuid_str);
+		goto exit_dev_close;
+	}
+
 	if (dumpcfg.show_file_content) {
 		if (dumpcfg.show_superblock || dumpcfg.show_statistics || dumpcfg.show_subdirectories) {
 			fprintf(stderr, "The '--cat' flag is incompatible with '-S', '-e', '-s' and '--ls'.\n");
-- 
2.43.5


