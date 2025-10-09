Return-Path: <linux-erofs+bounces-1164-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AF24CBCA6FF
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Oct 2025 19:53:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cjHYS379yz2yPS;
	Fri, 10 Oct 2025 04:53:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760032428;
	cv=none; b=lpBesR49Ay6UMCaILdkL3Yo10j+81+HkEjub7wZFtPTsIWUplYrcOQaPtfH2tfhobjzofHdckFhkgvn4IjfVUfan1zG1T+3iYWK0UOi6bm3ni+qtLk0LCv99JSHTVcaZczUiofz19cz8dFVVbkvEYJEYpvApxEa+1OiYYsuCOReFxX+CHNhxAY3CPRC6U0nn9fhup4iKSoXLzHgo6JlER79IRT68hxqfaHoKRrHIbJAqaxQYBk6bwkpKEU/cUlo9HN2YlbfDu2Xu2DuuNaC6Sf3ZRDN/k0dyk7gpzLsB5ERW2Z7FIGmHRqBmjDmYwvn6AD+o3xvJRoYbIGpqyI833w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760032428; c=relaxed/relaxed;
	bh=ILFTMXO67yKLzoxmHWtOpnokjIKuKjqScdejc2p5rT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdumdgGThSlJusZ+CN2w3LzkVFhHBPS9ZgJznW1UIyJUGMOfvGc636CXZFn0HqXxj1SZybn/x7YHmNpVPpf4f9X0f6O5GQaz22zv27sxq+XnZjyWssgDOTuTMSwv/Po6bsaCh2CkPm7meLcOm/k0sf6wkHGf4SrnSxFDBtx66qXFEubh+5z98H4xgpd8bxD0MzPSiGkzWtQvb8XP3zfa4Yn5WK+KLJZfdJkaiym0hxKSz8JbiaOT2OF9ttEKzQ73iVEFIfremXD/Rka9l/jKXAJ4lX7ThVnf0WGuP1dddPt1ox+97hHlmnAhE4GL4mKfT9QZ4OYhz2WmtXfxe9az2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IL2uVpRk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IL2uVpRk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cjHYQ4Ngsz2xnt
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Oct 2025 04:53:45 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760032422; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ILFTMXO67yKLzoxmHWtOpnokjIKuKjqScdejc2p5rT8=;
	b=IL2uVpRkVj7hFbmt3ClWlliRCW5pZXTrcRXgAWXJuT2CKu1Nbawy6FLEA228SYFqvxm3zVpXklqY4UlM34/NrSo5cibjwuEhwiz0xE/ij5mVlSypoJ9eLCseV+5+WDf1LP2Kc9aOvkHY/k5jPP5z4Nn+HN+jIPDUPlo1PXBpm88=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wpq0-wI_1760032420 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Oct 2025 01:53:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v2] erofs-utils: dump: add support for `--blkid-udev`
Date: Fri, 10 Oct 2025 01:53:39 +0800
Message-ID: <20251009175339.774057-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251009174611.763664-1-hsiangkao@linux.alibaba.com>
References: <20251009174611.763664-1-hsiangkao@linux.alibaba.com>
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
the creation of persistent symlinks for that device [1], to avoid
unnecessary network access that can take some time.

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
index f685799..4ad3f7b 100644
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
+		goto exit_put_super;
+	}
+
 	if (dumpcfg.show_file_content) {
 		if (dumpcfg.show_superblock || dumpcfg.show_statistics || dumpcfg.show_subdirectories) {
 			fprintf(stderr, "The '--cat' flag is incompatible with '-S', '-e', '-s' and '--ls'.\n");
-- 
2.43.5


