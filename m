Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 964442E772F
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Dec 2020 09:48:30 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D5Q171g9LzDqJP
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Dec 2020 19:48:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1609318107;
	bh=oZK8ARXaCU/OsPbucYKY49iEjRxZoNFHtzM1ciGfCbM=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=IDkwRxen70M23CbfTK7+elRngtSLDih6mPfCBAfD9p0oQWt6Pf08CBokHYi+rv2B8
	 hAmmYqpXGlWrF6oeYvGWVKSAdRfmZGTX5BCw5LB49A01Z0Qbdf39mlJEEcqnVUxg3F
	 SSZjOY0izr3sxLj5Uh0B9SdJfOj3LLndY68UHgTxltAzteWOjyYa4aDTELbaF9NN1E
	 Ld8m6IXCArFtZzDNNRxTjR9ZdWCYr1raSnTYlfSo9hYmhgKGgm+yAuwNxK77kGyvNF
	 WH1NYEl1Vrso9Fqi7hYm1ZTBtgIpRN4H1d38mpQsc/1uzGO6mW+jn+0p53JgGKv5wI
	 kQkxrnUpp+nVg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.82; helo=sonic306-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic306-19.consmr.mail.gq1.yahoo.com
 (sonic306-19.consmr.mail.gq1.yahoo.com [98.137.68.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D5Q0X6vR4zDqGq
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Dec 2020 19:47:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1609318070; bh=ycchpPyxm27P0xjB8gSaY/UCa+/cHwMnngW4liJuoVg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=a2WW3u9Iwzu5+XKSWzChVWUtceu14c9iYIrlEVEbrH65LESqIMHVoUOCA/DYN0e0RD+E5oe2Z7AWCAQSHt7Y14zxhdFhlq33Y8pMLv4XARvlqhj9zUh/E33FhqPPVlqUkRdnh6QwLXzPiZiDhuzKcyitLXLueRU5tspeiV39kXtc9tn+I+YQPFMLn8izeReVnF0s0lZj30Jufj4YbAiSKHPaw2bZNlUs6vmOL99qn9vZY1PzAge6CYah+ZlxeD7xSDyb/b+qWLYVJdUF6LI/LO0NcFi8BuwbMhfwBkuI9v0oiNGeFdYVCbzUyOKEnAX6E9dUUljW03wfWS272fEvzw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1609318070; bh=gxGSDB8b2iMUt+DIOyJtolQt7YZdIluUBQgoIvRGbiG=;
 h=From:To:Subject:Date:From:Subject;
 b=Sqpc6ccLgWNzfDxM2ivp78XGmCf65MPtW+SKrRI2S3rQNlaIduJg7mOh7iqH+wu1cPOxu3OO744e8PILpY+2Woy2TOoThjkA+B6OeasBVXNcG7+SPveu2u0TZIZytd6DixQnAYQ72PTlM/DoE8VRovShHNyqFP28xYzN4LNp0IH98rCQdwqMdmVASXlY9HeSlcmr8ws+IuuWqPbmuXrHbLDCGN9GD59wbJjTk9oozPV7sDc4a382hNZngwNkplMi8eOmo18u7lU5y18dVNngG9c3CFo3kmoGJVc6bQEwCb+mwT6TESK8YYeuB+Zn5z6QTrUl++IA6Jv6s/uBpnu3Cg==
X-YMail-OSG: ZyLCCTsVM1lX.PaQwxHCDsGRYATIr7QoWCSclavelVICyedZfhpkpY8FSYuqpHh
 ODolUMkwwqUFc5Btk3GqSaI1wizuOrHopjvEMakdKLemHwDASnrdA8a6XjvCqQqp6nq_aSTAkNta
 hpLEab7Rn1UE4hEdPqYrrJCUOCCwnK1z31ar0WoUM8RA5Fq2NoOfiANh7MUKxVtLjvlqr.wwxlpS
 ZBVRzUbDcqq2lzK7dGYfoxTe2aWvUp_vRNfxoO9ukOZYQpN8DzRNtkkjYtM2JbfVb.Tnq0z6XKEQ
 Y9C6HuLNMpGMsQCoprECL6Pbh6QYbtl6ecHrb_2XtK4puJmW8_ZjeaLCLqdXMbsV5fK3wcqnb_4v
 74PeOu_aa3dOhgjytisl8ipkQd.Y.PUh9QjDjbYLRiq9NIUQfY.QBbdydmKWASIRCe5D.f5kEr5y
 Ujq2_z.zeKPJwdzugEM9PAP065iLCHe11INDwU_hZKbW8j2FooaRSFrPTn5Gi1NwZNJn.WaWZ1ka
 czaEQiU7GB7p9879Fj9jDXzhADbdwgMziRXk6tUm2MaCryp6N3kG16m32DmsSfyPFBceMXQ14TLZ
 22THsyXiFgzzIXZHdSCQWwX1Jzic8JEBFo5_ZNOqZMUMnxxmpGnDugtgTP_bD34b9Gld9f7ghlo3
 2KSEiI.XrgtVqALauFAtF4O2LjHvt8NcfDMzEwesF3kQaSA7ikuxhqmdsfnXQMDQZv1CIkg9rXk8
 qcGUdWwy5JpQ0s3KxYy4KnAyW7IAjqoHxoX9UoqaA4QWc89uIFowPRu7i2qLqWUmsaBDOU1QMnhx
 PIH6gMCfa5z_fGSI9gDCl6asixVD6xv42VOwoWGXMwyzhOXoAUweCxETf6cTcEUzc5OgXjeUcdiJ
 MWpa.GxMDNiaRRgcvZxcZW1uUoDsDnaJOp6bFMSA68JlLP74hAwmF1rNfMceXWdUo5uVI7RtM9nR
 NUys.v.UIsBEY8SJKzn4grMQcKJVacSkmhgZ6_JK3VpmeZjf_LcRxQe484rxvXhZPgAatkjH3wY2
 3XEho2sOitke705SfEjk8Znm4qjA.mczagVhWMyEbkJQfwLWA14KF6kTzjlc7Im5J56sICDI_XmX
 M4An5tUOgkQ9Bsxi3Udi171rb1gdktcMbjTbvqeFRKogV_tqD4MyPqpicLWMJDdrWAHRAsad4t7u
 lc7ZFotZGbMKMiWTbv.u7p3kKqGg308LFlQ0gGGCd.ffpq96JsbC4jSW.HKeSQPdrrftfsYdI4ZM
 H0teehpBk0rPlqjFQZv7iWE53pznwendvokJ3Gu.HUCWO5mRnsfO.Jma7NlSt0HHSpTNCe565B66
 .CCT_etp38FW96uEVqvuqvPV2ekCD92X.iJAB7HC0nUjZJhSWkECVc5lgEz.2gX.Tq71vj29j4IB
 vY3eMNN8BYfZimbapAWN6Yqd0qV5J9DCReQB4gwe4s4sI1bBHQG6cxmfk8atFRzi.QHZeAAzqTcu
 sA3RnhzkCm4z.opV72CQ6KJ7NNgEzd0T5MtCYj6ljZdlp6ckOdinf0CEucTkBVShlKkLq6dOWs9q
 CkVfQZJht4kQMTTWq0Zr__F.F2MHvAkbr3cElefCktuu09gsuQE8XLzwmRczyTXthS5L.6j4ZAUj
 UuZLwsJcyNkLW1_guxBzLrQYgbCGmLdi0neRFHd.lTgxC3MWaGIqM_46XNKHjIZ0fbF.fOMFQGOX
 usvPDgGuO6mV7ZbyOyVMW_Ci3nFmNxB7WfYZNlZTIYLkCRWXLSL.NQLGR.inNHoz9Gxw5YgYXurU
 NmOWSwmInHNWfhXB3nlGTif308eeNXPbvQzhpLGZmWJwDi11XsHs0RUB_5.lO32AZkJUAPgxw611
 r7YZHBR2uWGn9AG91lrUEhbp2G_NoU4zCONSKzeU0O2pGxK0sz17UPQocq_dNY8W1QYR_aYcT56W
 pfji.zltZrJXaz5H4JmVi9dLK6udUsTmc4nz6fNhLhViHXoPU8L1hIcfhSVwDMzPdohXB0a2EHbN
 HnBjtQxxMYMh2gYLgqtVw.v5TafWowPOVllsgXi0WwZJGQINcCeGLYc5_sPLdlIyeRLRIepYIvzH
 cai8YZaMSttOPJBgqRAnNuUh3ZKWPYSRs35C3XDF51omEVG1XdV_czc0ChCJCnqHd16bR7OFNLgr
 KDl9zR_TJP7qTezeBWQPH3HR2Mqe79dmWkTDoiVNFhsJAEKLucMDa7y1YhnIYm0ReHad_JlTn6Xp
 jE7.n2ULHJ0xRtLRBtOFK4mKXG64hEZHsDE2IL9KhOn2mcTVnMCdm_WQ3zu2Zt_YTH_en19lDlRC
 l1d7BN73OiZV914TJBBzF4oE68PQylJ.ZACKxaEGSPRWClTniulvbu8mHn8ts_L.QI4y0Z5nrENx
 fqVCawS21.jjLJBYHX5QTl0VHZmFf51W7SOyEKT_228W8F8IpDEE.cYOKfdn3hpCFnYjZAYmxwRP
 YQUYJpSMEztxp6KJmxPvfUpZ7uh3bAfPyEjexUbcoxP8-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Wed, 30 Dec 2020 08:47:50 +0000
Received: by smtp416.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 68e206c49d6e76b1b6872a88eb7f98ec; 
 Wed, 30 Dec 2020 08:47:44 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v0 1/3] erofs-utils: add -C# for the maximum size of
 pclusters
Date: Wed, 30 Dec 2020 16:47:26 +0800
Message-Id: <20201230084728.813-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201230084728.813-1-hsiangkao@aol.com>
References: <20201230084728.813-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

Set up -C >= EROFS_BLKSIZ (more specifically, >= lclustersize)
to enable big pcluster feature.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/erofs/config.h |  2 ++
 lib/config.c           |  1 +
 mkfs/main.c            | 14 +++++++++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 02ddf594ca60..5f5a05a8b796 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -53,6 +53,8 @@ struct erofs_configure {
 	int c_force_inodeversion;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
+
+	u32 c_physical_clusterblks;
 	u64 c_unix_timestamp;
 #ifdef WITH_ANDROID
 	char *mount_point;
diff --git a/lib/config.c b/lib/config.c
index 3ecd48140cfd..352a77c8d639 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -24,6 +24,7 @@ void erofs_init_configure(void)
 	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
+	cfg.c_physical_clusterblks = 1;
 }
 
 void erofs_show_config(void)
diff --git a/mkfs/main.c b/mkfs/main.c
index abd48be0fa4f..c4c67c962919 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -62,6 +62,7 @@ static void usage(void)
 	fputs("usage: [options] FILE DIRECTORY\n\n"
 	      "Generate erofs image from DIRECTORY to FILE, and [options] are:\n"
 	      " -zX[,Y]            X=compressor (Y=compression level, optional)\n"
+	      " -C#                specify the size of compress physical cluster in bytes\n"
 	      " -d#                set output message level to # (maximum 9)\n"
 	      " -x#                set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
 	      " -EX[,...]          X=extended options\n"
@@ -152,7 +153,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	char *endptr;
 	int opt, i;
 
-	while((opt = getopt_long(argc, argv, "d:x:z:E:T:U:",
+	while((opt = getopt_long(argc, argv, "d:x:z:E:T:U:C:",
 				 long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
@@ -248,6 +249,17 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			cfg.fs_config_file = optarg;
 			break;
 #endif
+		case 'C':
+			i = strtoull(optarg, &endptr, 0);
+			if (*endptr != '\0' ||
+			    i < EROFS_BLKSIZ || i % EROFS_BLKSIZ) {
+				erofs_err("invalid physical clustersize %s",
+					  optarg);
+				return -EINVAL;
+			}
+			cfg.c_physical_clusterblks = i / EROFS_BLKSIZ;
+			break;
+
 		case 1:
 			usage();
 			exit(0);
-- 
2.24.0

