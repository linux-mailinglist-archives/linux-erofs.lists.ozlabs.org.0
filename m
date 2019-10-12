Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4116D4B52
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2019 02:19:21 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46qln02qT0zDqbh
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2019 11:19:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1570839556;
	bh=3Yi0GYImduhFgp7imscyTJNQ6JuNpvJgACp+LweeaA0=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TGtfcNjVCd5Dfh3Mlb29FyIN9R8unCafI1d4Uf/8uRCddy2JFHSl+UJzTQGXf16C+
	 E9FnKQK4BexP9hktvAw/c4ujEm2FlRtTfxpZFuQ1WIbLn0nPrsGqG+y8hWfZ2gAIYm
	 4oFU6pbAmpni0NNpuj7PJ+QM9T8jjKmtRftyTtpR5E/yxhkBPpoKX+ZsrMuenZ/rO6
	 gfLWmoenLh0NKGtT5LZN4LoR8Vf7g7/KbCDt3xY1rwCF2aCXibuS2fvsKCJnkdOfcx
	 vU/3CNYRCv8dVZKkDgtYA6I5t8QBpdAmYOniH1jJyKmMbb+B7wsaQKvI4IcVoRPWXp
	 /g6raV62msaZQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.206; helo=sonic311-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="gIN7+ibe"; 
 dkim-atps=neutral
Received: from sonic311-25.consmr.mail.gq1.yahoo.com
 (sonic311-25.consmr.mail.gq1.yahoo.com [98.137.65.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46qlmn2Yp0zDqYp
 for <linux-erofs@lists.ozlabs.org>; Sat, 12 Oct 2019 11:19:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1570839536; bh=SL3H/FOCoMqJSkATnw12YekW0r+NJhaCVkE7cfrsrAc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=gIN7+ibefiWuiKXS5wKslChfVIN4pK+9ibtH3AJljL+CFPxFqy9elFYzcQeTXyyBKd6t+W3L28hiUYtsj9SlBsoRYjGYHCkGMjY5MosA2WKC3htdG/63HQrbk5zO6RLCYbOMORzOzRhOfjAKQ9y7MxAfHbHXFDjq/u3TfnQNxeQQRvYpb0vv5zPn98fDxTn2FhgmGzppVNhkCOuWPxEVdhZIhcFAiA75M+meRfNQM/HMHKelB961d4oOU+ontRAW9plBItyNvZWvHq+fFSIGlJRSImlhSrGg5o743WJC5O9OL6CUhNS9jPvOxT0HjfVERPxPtG1kNpjHxBWNyMA9FA==
X-YMail-OSG: ANAzsiUVM1mo5pNCjZRFfe6yhIctwRP8tNOZG_7o.9LtZv5EtMRhou7sOZs5rj1
 90tzksWYnuV8PYtkG3aReajcbhjyqC8zlEKH6lqbSYxKewrs9Vt_1sD1H8FtoAQ3IvpDAjYIqY8k
 7WErgQtwoPrIM6UhDWWK5BuOWGVlatg3lDrdF706t4iCuTzNAvvBjygfHxbti3IznIkLoLgxfm9N
 tObPmf29pmNDSfygEVwtUsU3xLtX_S4Pp_FEgdZ7PcnB6h.jed.JmHr7lotS28kTxYfw2rDi5oYp
 mQrsup_XNC.Sbk9VppkzMaD2QtjkvyWp47H3Z2.gznuuQL.nvBKviDp88UJ0717DzEB2Ixbnro5F
 8KZebio_IpfEMSlEzgrkWIxMyMH6wwUn9LmJYNeS7ooYp2nHRlPXnv6nrxAVamx9kqv2FdK8PtHl
 M34wgysxJbKySI8DCEDhHNIiXQT3waEQlmd_y9STT.6FLdW99Pd6kXaGuNO2yA7_gnWtCgtcKVub
 piD0Q8IRv_kDYaHRv0qWuuaCZE4rYQwJdvBd1c8Jx4R02aOvZhZH.Ihc.bMm.ODmS62UsWOrlgUd
 ryHWq6iSj5FCQ5hq42NLNjqualZvSCOinteNWiUH4bFqr2XMdeJIwRh4o3Yxv2PjFvoqcOapeWPJ
 T5gzWc81bwhulGvfHS9pYp5LzOjaI.._.4xX9xuuhJjoaLDX.Ghfr2XpFBOaqXKgpoB1zzmao_wL
 bZyQISCielxTgZmf4O4BaHeVAWteTXrMHUUazRACdWZqp_cA43YVnhHXt5fPcpAIKADhcrfLpYgp
 Cm9ey11hSV_hmtkQ_4pADYCYwSzv54cG5wypZmquzqWAU4.ZanWLbqhebB_K3.90xoSaxR2E6G69
 sckHnjOYXTqPTk0YzBCSdzLSPhAqQhvSCthlphePegsU49ZEosd_BqciMN66BoAdilHlQfiN07T7
 0UF3lYoyb_A0gpdP3ggfBeHxNBkEkuiuudCvyf2xT6BffXckTCtIfhAVnmKxizIo6VabteiPh.DE
 iKl.Loo5pCfIUG90Kz3jTqjD_HU5W7vjHGPEnVVYpTme3._XTZ4cGAmq2qqLkuL4jhmlLs_mva46
 rnmBn2Ue4skRI8goOHieFeqKYVhlC.dGni8_ueqpEul77CiQacLWy0ZaOQ0hgzCy9jU0.FkMqV5_
 ygvae_epXT46yH3GgV7nJZ7O6onffk467SC8OZkpGLp5DkQHgOj788nNbFP2VhLlTHwhJWg1X0xU
 Y1W9f8JDjtDypfRqVP8MVrUoS1FXhdQMYrUbRLawSSkcuoXvw3sQnzh0u6sJgEHJqQ_LP8a8_Wuu
 eWf0-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sat, 12 Oct 2019 00:18:56 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 8e6385f3e9d260cf02209428d4d57fa2; 
 Sat, 12 Oct 2019 00:18:53 +0000 (UTC)
Date: Sat, 12 Oct 2019 08:18:50 +0800
To: Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH v4][ 1/2] erofs-utils: introduce fixed UNIX timestamp
Message-ID: <20191012001847.GA5701@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191011170953.6267-1-blucerlee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011170953.6267-1-blucerlee@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Sat, Oct 12, 2019 at 01:09:52AM +0800, Li Guifu wrote:
> Introduce option "-T" for UNIX timestamp.
> 
> Signed-off-by: Li Guifu <blucerlee@gmail.com>
> ---

Applied with the following minor changes.
Let me know if you have some other thoughts...

From 0da0c97cc5ca7e02192ee99dde0a82cb531823a6 Mon Sep 17 00:00:00 2001
From: Li Guifu <blucerlee@gmail.com>
Date: Sat, 12 Oct 2019 01:09:52 +0800
Subject: [PATCH] erofs-utils: introduce fixed UNIX timestamp

Introduce option "-T" for UNIX timestamp.

Signed-off-by: Li Guifu <blucerlee@gmail.com>
[ Gao Xiang: use u64 for timestamp rather than long long. ]
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/erofs/config.h |  1 +
 lib/config.c           |  1 +
 mkfs/main.c            | 16 ++++++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 8b09430..9711638 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -28,6 +28,7 @@ struct erofs_configure {
 	char *c_compr_alg_master;
 	int c_compr_level_master;
 	int c_force_inodeversion;
+	u64 c_unix_timestamp;
 };
 
 extern struct erofs_configure cfg;
diff --git a/lib/config.c b/lib/config.c
index 110c8b6..4cddc25 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -23,6 +23,7 @@ void erofs_init_configure(void)
 	cfg.c_compr_level_master = -1;
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
 	cfg.c_force_inodeversion = 0;
+	cfg.c_unix_timestamp = -1;
 }
 
 void erofs_show_config(void)
diff --git a/mkfs/main.c b/mkfs/main.c
index 4b279c0..6ecc905 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -29,6 +29,7 @@ static void usage(void)
 	fprintf(stderr, " -zX[,Y]   X=compressor (Y=compression level, optional)\n");
 	fprintf(stderr, " -d#       set output message level to # (maximum 9)\n");
 	fprintf(stderr, " -EX[,...] X=extended options\n");
+	fprintf(stderr, " -T#       set a fixed UNIX timestamp # to all files\n");
 }
 
 static int parse_extended_opts(const char *opts)
@@ -90,9 +91,10 @@ static int parse_extended_opts(const char *opts)
 
 static int mkfs_parse_options_cfg(int argc, char *argv[])
 {
+	char *endptr;
 	int opt, i;
 
-	while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
+	while ((opt = getopt(argc, argv, "d:z:E:T:")) != -1) {
 		switch (opt) {
 		case 'z':
 			if (!optarg) {
@@ -125,6 +127,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (opt)
 				return opt;
 			break;
+		case 'T':
+			cfg.c_unix_timestamp = strtoull(optarg, &endptr, 0);
+			if (cfg.c_unix_timestamp == -1 || *endptr != '\0') {
+				erofs_err("invalid UNIX timestamp %s", optarg);
+				return -EINVAL;
+			}
+			break;
 
 		default: /* '?' */
 			return -EINVAL;
@@ -223,7 +232,10 @@ int main(int argc, char **argv)
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

