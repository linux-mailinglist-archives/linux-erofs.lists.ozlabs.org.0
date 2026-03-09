Return-Path: <linux-erofs+bounces-2540-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIq6DYDBrmmRIgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2540-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 13:48:00 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DF4239215
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 13:47:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTxcq4rMpz309P;
	Mon, 09 Mar 2026 23:47:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773060475;
	cv=none; b=bstARHFWBbiDKiyHU4Xc748ULypC9RocYfBbbf63AIMMWs9F9rVjifxiCy/uKz3f1JmT9aGzgg7/ty+DKKdqz4LCwsNMOOB+0e1vpiOdvC3gEqcXiwsiD1NnKUzJcyYzcwOVsTJKyY4X2I57QfodKy5BajNSQ+8DsowROl5PUEouk7NAWnPfmakXUpYHq+7WusAAgmBWeVxkSvJuUFRftpziZ91r21/fPoEzlWDMiNzaMKDzKdLcTyQr1nWynngtHdxv4sBAwM5n26MCMuiIX7G9vb/eg4VnXjJjxJvQ7OtwCBtNGvEFIMiRaV/LCK8ONThTRBHNcXlP8s1dx/92qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773060475; c=relaxed/relaxed;
	bh=eI7BcGXiPqgCf8fnNfBg4ModAK07P/xgkHvmytzUeQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZKBNmHC5ubkhYYg7uwNrbt43Zo7VJR0pPhsSyLO0cVLf4z+PYQBhtIbNHfB5uuWeKC39+cKE5fDgk5dz25NN2lAr7dh/8HM0psemfRt4SMn6CpZ/qazmdKlWEdp9dXayxUS6ScJD75+Pfkz0YnwCEAZ87wA0rgYWY5nyX07UsQJtgtDR1q/XkIsvdkV44e/5suCxnXU7BFe5riOh2yzDfRtD8MHHgxFAg/0cEUPc+yuiBXMWoF6IokjH/S174orl9bdXtJnWqQ/tbCILs+e+3ESpb3PMLKoCFPkw2irKRXXKBjU6NfqRRLMazFjcHGTuWIG0mqiIjAfPAtUMG1Gcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Nr+CwKtU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Nr+CwKtU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTxcp5Fpbz2ySb
	for <linux-erofs@lists.ozlabs.org>; Mon, 09 Mar 2026 23:47:53 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2ae46fc8ec1so56374695ad.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 09 Mar 2026 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773060471; x=1773665271; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eI7BcGXiPqgCf8fnNfBg4ModAK07P/xgkHvmytzUeQY=;
        b=Nr+CwKtUtb/eavzdfu9KL9X6G7SF34iMpYgfh7JShV1x/112vTxTRH4nEqiXr7TOpY
         o8MWhCwphRUOf6Z0cpJqHtfQQ+U/5zogmW8/thDDc6JhXweYioRMfMLxObl50UKSUMvc
         yTCAtgPkASTjDhXGDIEEJBSRmD84ZRYy9Ub3i1OSzUL/IfUI5UN6tUlSBgD4h+H75Lc6
         AkQ3P7JNSCPHKTIA3aKdAi0wgc7eXh/4/fK5gzvvxggTOUG7l0yKpZnUEhqYBkGSPATK
         VF9PvwOHVgFkcr874C4+Gm79sU0kFaokEPjSwt2MM1lRtFCzvWdTiKP78mT1HLcKNW3c
         IzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060471; x=1773665271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eI7BcGXiPqgCf8fnNfBg4ModAK07P/xgkHvmytzUeQY=;
        b=apB7tIwtnUXGRWQo37u7GpHVKsj/1tss96lbwx/y5hpXI21a5/pSem8bujYoTPc68I
         uCr1QqOAvwE8iUkcL0+EYnVUkrvbx4bu8FRDffEBRcKAuLds+XOLPL0ju5NxzAaqsuzU
         N5LDDHX3T5nL8HoVcjeGviYslJ7tqnhBNCsjSvguIVYzU4h0r3kAm3zhczWA5IRpzzOv
         /w4DL/OpyMZPDddt2eSVS+tlseP4Zed9aPgy/NGs2DJWreFlUuvfl+/V2kzWyekNdtkY
         77hzDSZ3HYlUg7BHnPbBmh74nE8dzw2hloXdiTxK2G4C3mMuX/te9zJ3uXSgL5zi5zll
         Cfmg==
X-Gm-Message-State: AOJu0YwGKOpCofYm2k6zmk8ND258Kv2TrMKHaU1E5UFMos4AL/2acS8Z
	Pspkp9GEpL49cus5N0ds9li7PWgoBXwAl9XR7/kVlhAd0udsLyw52CCU1aQc6q1s
X-Gm-Gg: ATEYQzyUBikTB6qkAGlnBMpwHn6mZiGQT77s7UjxV9wBYRaNl6GBvXrZ7styYa5ZIOA
	CKDLLFYSZEL3ALn/gfKWaE1d40FN18yq6oCkMvu957HZFgRzXS2NV2rayoU6b9gYDCDc2oyaXXj
	LiM+1AIyrskZz4LF+Ntv7mu/orPgj3CSE7RZbuAYhHSTmrx+ecpS1mOTXlHhyajMmY+Vgc6kL9S
	KocF/ZuJkXUDTaWTwMF8WCyiLOehE/QFYEKDU0OU/V17aDk4FVJCHZ2Pbnvn5jRfHi7WDHFaYCJ
	KA6CiVXIIguVEBQH1zDvreYpyqJ59rEugvBiKPknC6dz7iXz5Z55GUaEVxT0KJ/r8LTe//zBX/0
	vv+zKjb8+uBInuwuLjunWPIEaYd72RzZrWSFaaQpasBHn6CnPl7SMvsxpvqoK7x6OEI6BG67LzE
	/QVLuYXOp66+CWQIO/uyEskQi9SNuTSRPMgwHub9GOul3mfLwu7OQ=
X-Received: by 2002:a17:903:110e:b0:2ae:6457:3099 with SMTP id d9443c01a7336-2ae8243413cmr110022835ad.26.1773060471510;
        Mon, 09 Mar 2026 05:47:51 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840b2e9dsm153595405ad.85.2026.03.09.05.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:47:50 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	haoyifan28@huawei.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v2] erofs-utils: mkfs: add --exclude-path-from and --exclude-regex-from
Date: Mon,  9 Mar 2026 18:17:43 +0530
Message-ID: <20260309124743.61096-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260308034749.22233-1-nithurshen.dev@gmail.com>
References: <20260308034749.22233-1-nithurshen.dev@gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 53DF4239215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-2540-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,huawei.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

Currently, users who want to exclude multiple specific files or paths
must pass them one-by-one using --exclude-path or --exclude-regex via
the command line. This becomes cumbersome for complex build systems
with dozens of exclusions.

This patch introduces --exclude-path-from=FILE and
--exclude-regex-from=FILE flags to mkfs.erofs. Similar to standard
archiving tools, they allow users to supply a text file containing a
list of literal paths or regular expressions to exclude, which are
read line-by-line and applied to the EROFS build process.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 mkfs/main.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 07ef086..1240771 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -39,6 +39,8 @@ static struct option long_options[] = {
 	{"help", no_argument, 0, 'h'},
 	{"exclude-path", required_argument, NULL, 2},
 	{"exclude-regex", required_argument, NULL, 3},
+	{"exclude-path-from", required_argument, NULL, 540},
+	{"exclude-regex-from", required_argument, NULL, 541},
 #ifdef HAVE_LIBSELINUX
 	{"file-contexts", required_argument, NULL, 4},
 #endif
@@ -199,6 +201,8 @@ static void usage(int argc, char **argv)
 		" --dsunit=#             align all data block addresses to multiples of #\n"
 		" --exclude-path=X       avoid including file X (X = exact literal path)\n"
 		" --exclude-regex=X      avoid including files that match X (X = regular expression)\n"
+		" --exclude-path-from=X  avoid including files listed in file X\n"
+		" --exclude-regex-from=X avoid including regexes listed in file X\n"
 #ifdef HAVE_LIBSELINUX
 		" --file-contexts=X      specify a file contexts file to setup selinux labels\n"
 #endif
@@ -1246,6 +1250,41 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 		case 7:
 			params->fixed_uid = params->fixed_gid = 0;
 			break;
+			case 540:
+			case 541: {
+				FILE *f = fopen(optarg, "r");
+				if (!f) {
+					erofs_err("failed to open exclude file: %s", optarg);
+					return -errno;
+				}
+
+				char *line = NULL;
+				size_t len = 0;
+				ssize_t read;
+				bool is_regex = (opt == 541);
+
+				while ((read = getline(&line, &len, f)) != -1) {
+					if (read > 0 && line[read - 1] == '\n') {
+						line[read - 1] = '\0';
+						read--;
+					}
+
+					if (read == 0) continue;
+
+					err = erofs_parse_exclude_path(line, is_regex);
+					if (err) {
+						erofs_err("failed to parse exclude rule from file: %s",
+							  erofs_strerror(err));
+						free(line);
+						fclose(f);
+						return err;
+					}
+				}
+				free(line);
+				fclose(f);
+				break;
+			}
+
 #ifndef NDEBUG
 		case 8:
 			cfg.c_random_pclusterblks = true;
-- 
2.51.0


