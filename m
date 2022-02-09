Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9064AE63C
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 01:53:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JthFn1j5Hz2ymg
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 11:53:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1644368013;
	bh=AVJ77ctT3fZt2dca29RFPoYdyF9QlHx2A6deHtwbLqk=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=mI5G6LP/NSA4GjDbKo/lKID6NLWQllOOZ0ry2Fz0y7fvEIAUNsLmcAqmWnBykpytS
	 +jv2bxgnzWwX57KJztPRdtzR6fqfbTopXq8Qediev110+rhUNQ9eezI1TDfC1s9PYO
	 rUv5eXQeRWXVj5rs56uqa/e153tOXNKQFqrEKcx9rYMfSISdwbvr2XgZ7SbiUU1G4i
	 AmE1jWv6nUyvuDDKARbpSefpNveg/0CMOezHBPTavY99s/jD6zIpd3FLDFCLU0zZDO
	 ouQwK+Ok+5ocIa10AvSVqlV7ApswSKfJm3FtMusYPuoH35Cj7krx2AW8TGHBq2b7H3
	 vEDoz1Xyv8ssw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--pcc.bounces.google.com (client-ip=2607:f8b0:4864:20::b4a;
 helo=mail-yb1-xb4a.google.com;
 envelope-from=3hradygmkc8g3qqu22uzs.q20zw18b-s52t6zw676.2dzop6.25u@flex--pcc.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=d1OtkuuY; dkim-atps=neutral
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JthFg6sDlz2xKT
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 11:53:27 +1100 (AEDT)
Received: by mail-yb1-xb4a.google.com with SMTP id
 j17-20020a25ec11000000b0061dabf74012so1337889ybh.15
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Feb 2022 16:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=AVJ77ctT3fZt2dca29RFPoYdyF9QlHx2A6deHtwbLqk=;
 b=i1YNz8JeByMFCnxhGh7Xt3rA2vW1F9Ov1jSXDn1mfXGRmFzFj6mrP1zvsy3pJCxCJk
 sIEAarU+zirId/oebLhn0y8mZ5ttV2VfgRDj4ZpGRb45SelGmQM1bejrHq+Q371sGTD2
 X/R2bwOE5UJ8ggS0EL1AoYggPGVHdDL2n7sWLAImLos4xfJQHGhT/lMycwOGuFOosiEj
 Tjev3RbXR/0TJYcgnjzR38mhijSrauZ6w96PF3SU0nK4g7m7p+lRhK5PwSFInwc+FBSq
 ziloWnP5jmF0I3Tity/2BAVcg68Fi78bsSrmYxm9dZnHGNWh73Og/VqgQ+GS+yLfYgqQ
 qlcw==
X-Gm-Message-State: AOAM530GGTxHZDzBxqkvc6Tr/Be4DFUEIhCANDKiZLO1CNzKNFKjgJqw
 Pm7FkFQ/w7jpij/SIlH7TCRCkFo=
X-Google-Smtp-Source: ABdhPJwNPgHn8ejguq3LptjcnZdLJqykndS5/Zw2b8KABDfwRjsNomjE3oABvwRVLJb7zPUiEL1NQa4=
X-Received: from pcc-desktop.svl.corp.google.com
 ([2620:15c:2ce:200:ddfa:541c:9dba:6ba0])
 (user=pcc job=sendgmr) by 2002:a5b:98f:: with SMTP id
 c15mr26661ybq.214.1644368005485; 
 Tue, 08 Feb 2022 16:53:25 -0800 (PST)
Date: Tue,  8 Feb 2022 16:53:07 -0800
In-Reply-To: <20220209005307.1288161-1-pcc@google.com>
Message-Id: <20220209005307.1288161-2-pcc@google.com>
Mime-Version: 1.0
References: <20220209005307.1288161-1-pcc@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH] erofs-utils: Print program name and version to stdout
To: xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
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
From: Peter Collingbourne via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Peter Collingbourne <pcc@google.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The program name and version is not an error message, so it should
go to stdout, not stderr.

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 dump/main.c | 2 +-
 fsck/main.c | 2 +-
 fuse/main.c | 2 +-
 mkfs/main.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index b7560ec..ad1b62e 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -109,7 +109,7 @@ static void usage(void)
 
 static void erofsdump_print_version(void)
 {
-	fprintf(stderr, "dump.erofs %s\n", cfg.c_version);
+	printf("dump.erofs %s\n", cfg.c_version);
 }
 
 static int erofsdump_parse_options_cfg(int argc, char **argv)
diff --git a/fsck/main.c b/fsck/main.c
index aefa881..2ebc5e9 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -43,7 +43,7 @@ static void usage(void)
 
 static void erofsfsck_print_version(void)
 {
-	fprintf(stderr, "fsck.erofs %s\n", cfg.c_version);
+	printf("fsck.erofs %s\n", cfg.c_version);
 }
 
 static int erofsfsck_parse_options_cfg(int argc, char **argv)
diff --git a/fuse/main.c b/fuse/main.c
index 255965e..b7760e4 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -210,7 +210,7 @@ int main(int argc, char *argv[])
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
 
 	erofs_init_configure();
-	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
+	printf("%s %s\n", basename(argv[0]), cfg.c_version);
 
 #if defined(HAVE_EXECINFO_H) && defined(HAVE_BACKTRACE)
 	if (signal(SIGSEGV, signal_handle_sigsegv) == SIG_ERR) {
diff --git a/mkfs/main.c b/mkfs/main.c
index 58a6441..4325ab4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -548,7 +548,7 @@ int parse_source_date_epoch(void)
 void erofs_show_progs(int argc, char *argv[])
 {
 	if (cfg.c_dbg_lvl >= EROFS_WARN)
-		fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
+		printf("%s %s\n", basename(argv[0]), cfg.c_version);
 }
 
 int main(int argc, char **argv)
-- 
2.35.0.263.gb82422642f-goog

