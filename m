Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C16D4647
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2019 19:10:13 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46qZFt4PyFzDqcD
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2019 04:10:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OdQLKPi6"; 
 dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46qZFm53SYzDqZG
 for <linux-erofs@lists.ozlabs.org>; Sat, 12 Oct 2019 04:10:04 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id j11so4749237plk.3
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2019 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=L/y3+NOCpDBtXBXa9dFBQ7KsGJue8w3PLZTtdZbqbIA=;
 b=OdQLKPi6/BCcJVIXXnfN8xJhBecUZsEyJUdCu69X0WKiLiApNyLLBmU7/duQZ5A3yS
 p4VzMMgt7gXkMIFRurlhoVrBk4eEvdiF8wcsThzbWWj3Hk5jAa5tA+CqkTFzZDb2ngZN
 64JHYF6WmlN/zHHDcDByN5kepEjn8VQ3GyW4oqhnGdPGaXnR6fGj5EgmpOlfl2QwlRDr
 q1Stg46U7N/RG1S+yVscOSSwNsW0kQjLvy7ShjgCf86U/RQCICYVUHSTJfW9zOw+vPwQ
 C2FBxNMlRfVLo2useXlJWEoDJhG9BkbY3eXDjixt1/6X4DQQ2H54ErPobvrPTGw50lDE
 b6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=L/y3+NOCpDBtXBXa9dFBQ7KsGJue8w3PLZTtdZbqbIA=;
 b=MO6WuYee6JneP9qM3P/+H2C67B+eMVclnN53L/CY8ZLzULLIZytMKJ7IixCXfPNH2o
 wmoBEIpzDInerI0/aJZBi58SgW6INP9yuBTjZ2ZbWgyVGnSlzUo72ZS4TiZTj2RAZeXG
 bzshWO/Z/l4eJgt2WNKHuXfRcrCpydzywwRZ3DV53hixHhnDHmP87tfR1elzZvnpnKZB
 uH5IFjx2vSE09CkDwD4JEndCaux5FBFBzA8wwIYs2jCgEa2bjOs0OEASIxSN658SK/j4
 C7EERlhqJyVvrIvzQ8NGefCiIBNODPIsuTnJIYQ6FBqy7Ef+tFhp9SIGahUnZubSN9En
 ynGw==
X-Gm-Message-State: APjAAAUnxuR5DlipzLe/OM2EkV90PcAOMuX22+T3bgt0h9pbj2f1ny3N
 M/+tevY2jFok5l/mM9xBxHbTL51pnIU=
X-Google-Smtp-Source: APXvYqwahxdcbgKOct034PZ0EEd4wUXJTz30vQuZ+GsWvffpUInZ0VRNlZ996w1adEd7aNRJPSehBQ==
X-Received: by 2002:a17:902:8691:: with SMTP id
 g17mr15050244plo.231.1570813800618; 
 Fri, 11 Oct 2019 10:10:00 -0700 (PDT)
Received: from localhost (li2016-34.members.linode.com. [172.105.123.34])
 by smtp.gmail.com with ESMTPSA id e3sm6978588pjs.15.2019.10.11.10.09.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Oct 2019 10:10:00 -0700 (PDT)
From: Li Guifu <blucerlee@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4][ 1/2] erofs-utils: introduce fixed UNIX timestamp
Date: Sat, 12 Oct 2019 01:09:52 +0800
Message-Id: <20191011170953.6267-1-blucerlee@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce option "-T" for UNIX timestamp.

Signed-off-by: Li Guifu <blucerlee@gmail.com>
---
 include/erofs/config.h |  1 +
 lib/config.c           |  1 +
 mkfs/main.c            | 11 +++++++++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index fde936c..8df05a1 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -30,6 +30,7 @@ struct erofs_configure {
 	int c_force_inodeversion;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
+	long long c_unix_timestamp;
 };
 
 extern struct erofs_configure cfg;
diff --git a/lib/config.c b/lib/config.c
index dc10754..cee835c 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -24,6 +24,7 @@ void erofs_init_configure(void)
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
 	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
+	cfg.c_unix_timestamp = -1;
 }
 
 void erofs_show_config(void)
diff --git a/mkfs/main.c b/mkfs/main.c
index 978c5b4..77a4b78 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -30,6 +30,7 @@ static void usage(void)
 	fprintf(stderr, " -zX[,Y]   X=compressor (Y=compression level, optional)\n");
 	fprintf(stderr, " -d#       set output message level to # (maximum 9)\n");
 	fprintf(stderr, " -EX[,...] X=extended options\n");
+	fprintf(stderr, " -T#       set a fixed UNIX timestamp # to all files\n");
 }
 
 static int parse_extended_opts(const char *opts)
@@ -93,7 +94,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 {
 	int opt, i;
 
-	while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
+	while ((opt = getopt(argc, argv, "d:z:E:T:")) != -1) {
 		switch (opt) {
 		case 'z':
 			if (!optarg) {
@@ -126,6 +127,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (opt)
 				return opt;
 			break;
+		case 'T':
+			cfg.c_unix_timestamp = atoll(optarg);
+			break;
 
 		default: /* '?' */
 			return -EINVAL;
@@ -224,7 +228,10 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	if (!gettimeofday(&t, NULL)) {
+	if (cfg.c_unix_timestamp != -1) {
+		sbi.build_time      = cfg.c_unix_timestamp;
+		sbi.build_time_nsec = 0;
+	} else if (!gettimeofday(&t, NULL)) {
 		sbi.build_time      = t.tv_sec;
 		sbi.build_time_nsec = t.tv_usec;
 	}
-- 
2.17.1

