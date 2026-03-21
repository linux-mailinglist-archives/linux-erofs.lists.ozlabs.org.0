Return-Path: <linux-erofs+bounces-2911-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKOKAUa5vmksYgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2911-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 16:29:10 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8A82E616F
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 16:29:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdNdF2Vvwz2yZN;
	Sun, 22 Mar 2026 02:29:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774106945;
	cv=none; b=eEEqopkZ3kZ72XCAnjCu+AiSsKEDSPDWE+MP/8b839u833aAQqSNboyY/j03P4jJS8VXZUhAFkDkcQYz796QlaMCHSKhZTroQgTh4tuf5eC0P6wJnTMUwIWUFgopeqaeNsMT/6HPt3Pjvr1c8P4jzQ5+wD1tOGpXuhEWncsvUFNAUs25t5FQ/YQaTQLJ+SAZdT8IHozmUwkdESbDLqlclrKbttLaXspT0ho/3rDY0Zhk6ycsy66HXZjiDXD4eQVxweCtBzv1VE5p3ZhexB5+JCYfloC0HIM1YAmH2PlqVG15ffpN9CJ5H9kVQKz59fW+dGahFx2YY+JUZMw7HgKCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774106945; c=relaxed/relaxed;
	bh=d/XbhvlR455I0TI6zw79cbj76KRpWd4F4taHdMNOGgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GusvVmFFvWY2IEe7kLUteZ4NuCNbI6i0fRmMP1Cyzgjxhnlqvg4NZ0Xy/YiWkw3FIdTBfCBGr0uRFqKSZEA1kAtwhNG72UBdBBqj3qS7G30zzGYsCr4pk3nS/SopjISpe4sKhjSKDDZeJhcYRdjGFsmDdLrCXuZUmL+gtV8gAVCpxgWoalrwnJnfDd/L7+yya6fdBZ5W6iRYLaaYkjYG/chfDoKH7/2VK8QDNJZJg2mqNiqCNompZcQSo7zpUBB9v3bEz46fJRH1CAGzRuPxtRhaTOlEZor0DIogJohVsfsSqWWmNZJbP7gOnG73E77vq5Hqx5TL59PKScNGcDwFJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CAU3Gdyg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CAU3Gdyg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdNdD3kt7z2yFl
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 02:29:04 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35a211df8e3so2036000a91.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774106941; x=1774711741; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/XbhvlR455I0TI6zw79cbj76KRpWd4F4taHdMNOGgM=;
        b=CAU3Gdyg+GsTjho7GHPolcXg8Rdgw3BYFrmANVx1gGh7bDk3FqYaCOpbQLPyVrHCVQ
         ylEUQyMwPrrdb6H1KKbpLXusnxq/oj76jqEUS0DJJyG3dSj8eDKI/FCtlAXks+juIwnP
         xQdCvH0im0HyHSu5cUdb92utNtt2+c9huwmlGooukFfZs+/FiNuRsV5h5Ui3ddMuj8W0
         rz530ArS3VpQmUGqPUJRBOtwMZhbKyK8ma/PeT5STR3SxfpWEk4rqoSn5Nbn1HSOQ7Rz
         E0NEZ7+OQvUGkmdISbSo2HHBo4dyKQJaaJ3rvEF6YG631l04X6u8esn/18gCOdH8nkLb
         P7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774106941; x=1774711741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d/XbhvlR455I0TI6zw79cbj76KRpWd4F4taHdMNOGgM=;
        b=nxYCOArS66Gv6MMNfIsSxVfkg8+lY2zHmws86DwuaGsgcIe6z7iRe3PHmOQF3uWR9Q
         OgHyGdVeZ1ElnBBNUHWsp4JtoXM9S7ZAGUr3W3xnPwEf2BtOrol7lykv57hMNMQXz4um
         5w9bgI3lGB10BioUF7CYp4F7guEaVhAVBaCFwA/6cI3maD8T3DzaoiPsgIRT9L8Rh6LA
         ifQnX6BbP3Ps3IyoLN7J4mHY6MsuHb0sB6I0SbEFjGfrk2kAbGEYD7XPBfLGKdQqWVdK
         f+0Vj97EOs7q9WdihuzI6gxC+BniWQF/Dq6cVG7rIUySE3tcaa9dDLTv/jgw79Qru+Oi
         vPOQ==
X-Gm-Message-State: AOJu0YzkVJXkEZZ5dO9L7MOk64rowcpywZ8hlr7diGf0GjEXRbJoSdJe
	8Jnp0D4VghNEuJIysJFToJi1qDkNfGcagda4hSjktUHgy+wVAe98Gt4p/CXpq1XWdw0=
X-Gm-Gg: ATEYQzw+gt3dfK33LYjk9bmUPf0OlPTf2t3mjo2YHBs8Vs1clLt1Lr0RwJeNx139MnA
	7Icno/BZxvhYZSv0srxwkd6O+a6vBbTWHhM5rNHzRzhSeyOcKfzqb6J7Fa+lpXJZfleLOI6D9bb
	cIFZyN1G1It0ZvA9toJPxaVoIo9CmvNRjD/tHQHqMg17SGx4Q1DMbRucIduN7Z7vHiGXKoRfSwX
	FOhbqgpL+ixsD3vU3DrudEDMrySIrPLUN9ovsFb1YhOh/JHgy818TOtVuc9cXII8WOWrs0qlTZQ
	/VsE+WiNTarg+spPMlGQ/Q9aFG+Z7zAzcV+0CDIn6nrSthATxGzq/NbfoXdfwIMM8bwrhf91q+z
	18a3MH1SUQ3NN5NwLG3hvnDbuWS5hEtU8W8PS7wgKY0SFKdn4lX/hurwkQaLz5gb0xhfMNDuzpz
	XLOyG2fATroDQQNdi+YdDLdRvBi2Klxs3Lj48bbxco2/LxMkjCOhJjNlTVRAZnxcOLwjhZnDE1/
	oR9gL3OhahcNNKYVbE1KJcKoSAcRRcaevo=
X-Received: by 2002:a17:90b:5203:b0:35a:1762:92fc with SMTP id 98e67ed59e1d1-35bd2d1b999mr5174403a91.26.1774106941243;
        Sat, 21 Mar 2026 08:29:01 -0700 (PDT)
Received: from localhost.localdomain ([104.28.157.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc6017492sm8395364a91.5.2026.03.21.08.28.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Mar 2026 08:29:00 -0700 (PDT)
From: adigitX <adityakammati.workspace@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: adigitX <adityakammati.workspace@gmail.com>
Subject: [RFC PATCH 1/5] erofs-utils: mkfs: add manifest source mode plumbing
Date: Sat, 21 Mar 2026 20:58:28 +0530
Message-ID: <20260321152832.29735-2-adityakammati.workspace@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321152832.29735-1-adityakammati.workspace@gmail.com>
References: <20260321152832.29735-1-adityakammati.workspace@gmail.com>
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
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2911-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[adityakammatiworkspace@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3F8A82E616F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

---
 mkfs/main.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 58c18f9..9641f2f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -60,6 +60,7 @@ static struct option long_options[] = {
 	{"gid-offset", required_argument, NULL, 17},
 	{"tar", optional_argument, NULL, 20},
 	{"aufs", no_argument, NULL, 21},
+	{"manifest", optional_argument, NULL, 22},
 	{"mount-point", required_argument, NULL, 512},
 #ifdef WITH_ANDROID
 	{"product-out", required_argument, NULL, 513},
@@ -209,6 +210,8 @@ static void usage(int argc, char **argv)
 		" --gid-offset=#         add offset # to all file gids (# = id offset)\n"
 		" --hard-dereference     dereference hardlinks, add links as separate inodes\n"
 		" --ignore-mtime         use build time instead of strict per-file modification time\n"
+		" --manifest[=X]         generate an image from a manifest source\n"
+		"                        (X = auto|composefs|proto; default: auto)\n"
 		" --max-extent-bytes=#   set maximum decompressed extent size # in bytes\n"
 		" --mount-point=X        X=prefix of target fs path (default: /)\n"
 		" --preserve-mtime       keep per-file modification time strictly\n"
@@ -316,12 +319,19 @@ enum {
 
 static enum {
 	EROFS_MKFS_SOURCE_LOCALDIR,
+	EROFS_MKFS_SOURCE_MANIFEST,
 	EROFS_MKFS_SOURCE_TAR,
 	EROFS_MKFS_SOURCE_S3,
 	EROFS_MKFS_SOURCE_OCI,
 	EROFS_MKFS_SOURCE_REBUILD,
 } source_mode;
 
+static enum {
+	EROFS_MKFS_MANIFEST_AUTO,
+	EROFS_MKFS_MANIFEST_COMPOSEFS,
+	EROFS_MKFS_MANIFEST_PROTO,
+} manifest_format;
+
 static unsigned int rebuild_src_count;
 static LIST_HEAD(rebuild_src_list);
 static u8 fixeduuid[16];
@@ -331,6 +341,33 @@ static int tarerofs_decoder;
 static FILE *vmdk_dcf;
 static char *mkfs_aws_zinfo_file;
 
+static int mkfs_parse_manifest_cfg(const char *arg)
+{
+	if (source_mode != EROFS_MKFS_SOURCE_LOCALDIR) {
+		erofs_err("--manifest cannot be used together with another source mode");
+		return -EINVAL;
+	}
+
+	source_mode = EROFS_MKFS_SOURCE_MANIFEST;
+	manifest_format = EROFS_MKFS_MANIFEST_AUTO;
+
+	if (!arg || !*arg)
+		return 0;
+	if (!strcmp(arg, "auto"))
+		return 0;
+	if (!strcmp(arg, "composefs")) {
+		manifest_format = EROFS_MKFS_MANIFEST_COMPOSEFS;
+		return 0;
+	}
+	if (!strcmp(arg, "proto")) {
+		manifest_format = EROFS_MKFS_MANIFEST_PROTO;
+		return 0;
+	}
+
+	erofs_err("invalid manifest format %s", arg);
+	return -EINVAL;
+}
+
 static int erofs_mkfs_feat_set_legacy_compress(struct erofs_importer_params *params,
 					       bool en, const char *val,
 					       unsigned int vallen)
@@ -612,20 +649,24 @@ static int mkfs_apply_zfeature_bits(struct erofs_importer_params *params,
 	return 0;
 }
 
-static void mkfs_parse_tar_cfg(char *cfg)
+static void mkfs_parse_tar_cfg(char *arg)
 {
 	char *p;
 
+	if (source_mode != EROFS_MKFS_SOURCE_LOCALDIR) {
+		erofs_err("--tar cannot be used together with another source mode");
+		return;
+	}
 	source_mode = EROFS_MKFS_SOURCE_TAR;
-	if (!cfg)
+	if (!arg)
 		return;
-	p = strchr(cfg, ',');
+	p = strchr(arg, ',');
 	if (p) {
 		*p = '\0';
 		if ((*++p) != '\0')
 			erofstar.mapfile = strdup(p);
 	}
-	if (!strcmp(cfg, "headerball"))
+	if (!strcmp(arg, "headerball"))
 		erofstar.headeronly_mode = true;
 
 	if (erofstar.headeronly_mode || !strcmp(optarg, "i") ||
@@ -1047,6 +1088,11 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
 			source_mode = EROFS_MKFS_SOURCE_REBUILD;
 		}
 		break;
+	case EROFS_MKFS_SOURCE_MANIFEST:
+		cfg.c_src_path = strdup(argv[optind++]);
+		if (!cfg.c_src_path)
+			return -ENOMEM;
+		break;
 	case EROFS_MKFS_SOURCE_TAR:
 		cfg.c_src_path = strdup(argv[optind++]);
 		if (!cfg.c_src_path)
@@ -1363,6 +1409,11 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 		case 21:
 			erofstar.aufs = true;
 			break;
+		case 22:
+			err = mkfs_parse_manifest_cfg(optarg);
+			if (err)
+				return err;
+			break;
 		case 516:
 			params->ovlfs_strip = !optarg || !strcmp(optarg, "1");
 			break;
@@ -1585,9 +1636,14 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 		err = mkfs_parse_sources(argc, argv, optind);
 		if (err)
 			return err;
-	} else if (source_mode != EROFS_MKFS_SOURCE_TAR) {
+	} else if (source_mode != EROFS_MKFS_SOURCE_TAR &&
+		   source_mode != EROFS_MKFS_SOURCE_MANIFEST) {
 		erofs_err("missing argument: SOURCE(s)");
 		return -EINVAL;
+	} else if (source_mode == EROFS_MKFS_SOURCE_MANIFEST) {
+		cfg.c_src_path = strdup("-");
+		if (!cfg.c_src_path)
+			return -ENOMEM;
 	} else {
 		int dupfd;
 
@@ -2032,6 +2088,9 @@ int main(int argc, char **argv)
 	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
 		while (!(err = tarerofs_parse_tar(&importer, &erofstar)))
 			;
+	} else if (source_mode == EROFS_MKFS_SOURCE_MANIFEST) {
+		erofs_err("manifest input support is not implemented yet");
+		err = -EOPNOTSUPP;
 	} else if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
 		err = erofs_mkfs_rebuild_load_trees(root);
 #ifdef S3EROFS_ENABLED
-- 
2.51.0


