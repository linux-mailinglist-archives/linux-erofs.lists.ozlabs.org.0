Return-Path: <linux-erofs+bounces-1979-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E50D39E3E
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 07:07:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvg3P0Wncz2xjb;
	Mon, 19 Jan 2026 17:07:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768802849;
	cv=none; b=nCZbnoN00FyNWBisMJyc98FzqshFDQv+4ySOfADfUjitKJ9/4SHvvuECWyrX59Sjl1dECIsUjAAs0BJIhHB+NcDL3eYnCqx5vyyfK3f0GV8bQ7CvoHKrnS6qqS0NEb6ix5RndxcXT3W34rEkWGUiPLotJZ3kDNWs7XmubajcJaYJYgzg4/vozG4GejcJMNDAiyGyXL5aD7SpSWLL6IRPgNMqL0B4NIuEzBTuolmDbwZcwD4xAY01SwQHQC2m3RiNDZbMOveEVgfV14wBxpw5/HumQvQPA6EZ2W+eyoh1osR2fOVAl1QEPIPymt2/tL/QKHhodZGmx0FdxLlaBHh9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768802849; c=relaxed/relaxed;
	bh=Mtu9BGmiSc6/JI+WWOdFf43Fu2yk/DZstI8QUQWmgso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrdrEEu6U1MZqtM94JHqwawlrd0bKUu5oPEecABTAIbRfqbzT3cY2apKOgRc4hugbOeTSdWw730quhG1azSd/HWuYUoWRtWr58aNvGWZ9Kx4XZ+s177CGQgJyPnqIxpmU/PUtP8AoIqqg7naDbzAfO/5cPjS9e8UK/7Wm8y/VyqL2caL22h/0tpvL0WadaTerLGcIFsfAOFMtQXarWFZzZkXjL52te1TdZqsrEOZEAmKVcLVLT3Y7VfHLcZmgAqmHn7JlAch42C5tQWGvDY465HqtR9VmcI8uI+NCYBwFAZL9kAwv0Byye/ULUivOOfEgl7yKogKZAEJlGh++DFfYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=py3WNnIt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=py3WNnIt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvg3H2LnBz2xSZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 17:07:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768802834; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Mtu9BGmiSc6/JI+WWOdFf43Fu2yk/DZstI8QUQWmgso=;
	b=py3WNnItbJtE8CLZ5RPK+W7Dspu4cxiCywpjnPus59+Z/zltWPT9PpULX3Tzv19TYOvgM2jIfGuqoRm3tRdSpXR9kulpOCanAM/ISJ9/wam1r7ZTPIFuHyjcHkbyHv5J7UScZk4lwUkVd55aehNUkJeru5rKRXqkZPIPlaFiVIM=
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxIlwu0_1768802831 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 14:07:12 +0800
Message-ID: <9c9312c9-1a0e-4c39-aad5-c805e1641a36@linux.alibaba.com>
Date: Mon, 19 Jan 2026 14:07:11 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs-utils: lib: fix incorrect mtime under
 -Edot-omitted
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com, oliver.yang@linux.alibaba.com
References: <392a98d3-5e31-494c-a013-030f858067ad@linux.alibaba.com>
 <20260117024356.3697202-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260117024356.3697202-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yifan,

On 2026/1/17 10:43, Yifan Zhao wrote:
> `-Edot-omitted` enables `-E48bits`, which requires specific
> configurations for g_sbi.{epoch, build_time}. Currently, the call to
> `erofs_sb_set_48bit()` occurs too late in the execution flow, causing
> the aforementioned logic to be bypassed and resulting in incorrect
> mtimes for all inodes.
> 
> This patch moves time initialization logic into `erofs_importer_init()`
> to resolve this issue.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
Can you confirm if the following patch looks good to you?
I tried to move c_unix_timestamp into mkfscfg.

 From 11e564767f62d494a7beb100c709655c60eb194a Mon Sep 17 00:00:00 2001
From: Yifan Zhao <zhaoyifan28@huawei.com>
Date: Sat, 17 Jan 2026 10:43:56 +0800
Subject: [PATCH v5] erofs-utils: lib: fix incorrect mtime under -Edot-omitted

`-Edot-omitted` enables `-E48bits`, which requires specific
configurations for g_sbi.{epoch, build_time}. Currently, the call to
`erofs_sb_set_48bit()` occurs too late in the execution flow, causing
the aforementioned logic to be bypassed and resulting in incorrect
mtimes for all inodes.

This patch moves time initialization logic into `erofs_importer_init()`
to resolve this issue.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
  include/erofs/config.h   |  1 -
  include/erofs/importer.h |  1 +
  lib/config.c             |  1 -
  lib/importer.c           | 11 +++++++++++
  mkfs/main.c              | 26 +++++++++++---------------
  5 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 525a8cd5ebfb..2a84fb515868 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -58,7 +58,6 @@ struct erofs_configure {
  	char c_force_chunkformat;
  	u8 c_mkfs_metabox_algid;
  	u32 c_max_decompressed_extent_bytes;
-	u64 c_unix_timestamp;
  	const char *mount_point;
  	u32 c_root_xattr_isize;
  #ifdef EROFS_MT_ENABLED
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 60160d6bea05..adeea7230447 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -41,6 +41,7 @@ struct erofs_importer_params {
  	u32 pclusterblks_def;
  	u32 pclusterblks_packed;
  	s32 pclusterblks_metabox;
+	s64 build_time;
  	char force_inodeversion;
  	bool ignore_mtime;
  	bool no_datainline;
diff --git a/lib/config.c b/lib/config.c
index 16b34fa840d3..5eb0ddeaa851 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -29,7 +29,6 @@ void erofs_init_configure(void)
  	cfg.c_dbg_lvl  = EROFS_WARN;
  	cfg.c_version  = PACKAGE_VERSION;
  	cfg.c_dry_run  = false;
-	cfg.c_unix_timestamp = -1;
  	cfg.c_max_decompressed_extent_bytes = -1;
  	erofs_stdout_tty = isatty(STDOUT_FILENO);
  }
diff --git a/lib/importer.c b/lib/importer.c
index 958a433b9eaa..d686c519676b 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -23,6 +23,7 @@ void erofs_importer_preset(struct erofs_importer_params *params)
  		.fixed_uid = -1,
  		.fixed_gid = -1,
  		.fsalignblks = 1,
+		.build_time = -1,
  	};
  }

@@ -83,6 +84,16 @@ int erofs_importer_init(struct erofs_importer *im)

  	if (params->dot_omitted)
  		erofs_sb_set_48bit(sbi);
+
+	if (params->build_time != -1) {
+		if (erofs_sb_has_48bit(sbi)) {
+			sbi->epoch = max_t(s64, 0, params->build_time - UINT32_MAX);
+			sbi->build_time = params->build_time - sbi->epoch;
+		} else {
+			sbi->epoch = params->build_time;
+		}
+	}
+
  	return 0;

  out_err:
diff --git a/mkfs/main.c b/mkfs/main.c
index bc001a600e7f..1ad610c6b066 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -277,8 +277,10 @@ static struct erofsmkfs_cfg {
  	/* < 0, xattr disabled and >= INT_MAX, always use inline xattrs */
  	long inlinexattr_tolerance;
  	bool inode_metazone;
+	u64 unix_timestamp;
  } mkfscfg = {
  	.inlinexattr_tolerance = 2,
+	.unix_timestamp = -1,
  };

  static unsigned int pclustersize_packed, pclustersize_max;
@@ -1099,8 +1101,8 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
  			break;

  		case 'T':
-			cfg.c_unix_timestamp = strtoull(optarg, &endptr, 0);
-			if (cfg.c_unix_timestamp == -1 || *endptr != '\0') {
+			mkfscfg.unix_timestamp = strtoull(optarg, &endptr, 0);
+			if (mkfscfg.unix_timestamp == -1 || *endptr != '\0') {
  				erofs_err("invalid UNIX timestamp %s", optarg);
  				return -EINVAL;
  			}
@@ -1605,7 +1607,7 @@ int parse_source_date_epoch(void)
  			  source_date_epoch);
  		return -EINVAL;
  	}
-	cfg.c_unix_timestamp = epoch;
+	mkfscfg.unix_timestamp = epoch;
  	cfg.c_timeinherit = TIMESTAMP_CLAMPING;
  	return 0;
  }
@@ -1731,7 +1733,6 @@ int main(int argc, char **argv)
  	bool tar_index_512b = false;
  	struct timeval t;
  	FILE *blklst = NULL;
-	s64 mkfs_time = 0;
  	int err;
  	u32 crc;

@@ -1756,17 +1757,12 @@ int main(int argc, char **argv)
  	}

  	g_sbi.fixed_nsec = 0;
-	if (cfg.c_unix_timestamp != -1) {
-		mkfs_time = cfg.c_unix_timestamp;
-	} else if (!gettimeofday(&t, NULL)) {
-		mkfs_time = t.tv_sec;
-	}
-	if (erofs_sb_has_48bit(&g_sbi)) {
-		g_sbi.epoch = max_t(s64, 0, mkfs_time - UINT32_MAX);
-		g_sbi.build_time = mkfs_time - g_sbi.epoch;
-	} else {
-		g_sbi.epoch = mkfs_time;
-	}
+	if (mkfscfg.unix_timestamp != -1)
+		importer_params.build_time = mkfscfg.unix_timestamp;
+	else if (!gettimeofday(&t, NULL))
+		importer_params.build_time = t.tv_sec;
+	else
+		importer_params.build_time = 0;

  	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDWR |
  				(incremental_mode ? 0 : O_TRUNC));
--
2.43.5


