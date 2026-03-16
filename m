Return-Path: <linux-erofs+bounces-2743-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGowJRHht2lDWwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2743-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:53:05 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A6298436
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:53:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZBl256b8z2ygh;
	Mon, 16 Mar 2026 21:53:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773658382;
	cv=none; b=j2AygTgiG+4FI/UgbvhE/BbZDYJGLFdVdq1rxsMPaGVZkU45PYWXOduZmaCtJB/iEfRAt0iC1yI8M98isblE3J3L0IbaicRXVURgtskcYOYy8of8JqExqjU+RoospiDIFew6mh3hnsYIMO0z+uUgOoFOTp7dKCfwcyWKVEApEM092F1q/ctPzfsu0EyHFdPnsbCNULIP8hAGsbi4Cpp8x0xkQKebUPYkYW8pzgfJi6ePceYbkx7jQO+n6AWWLiIvE2K9oxEY4THTGpJ91c4H7iTfv7PyjScnt1GhznBxhfuMk94b9pBdFYZmdu+QgZmJBvHLowNC9q/5hVPwmpZBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773658382; c=relaxed/relaxed;
	bh=eI7BcGXiPqgCf8fnNfBg4ModAK07P/xgkHvmytzUeQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngN2MIRxc6ygp2DlhSC47ccFpyfY1J/ChFzjbOK2TdBZedNq0UDHqJRPWrLsktrjdqt2JJFznvd8qqEdFXW49xR45DgV9v1pPZ5JakIB/4eha9mnYcBfe7b42D3bGa+ofG6dDaDoSk13DaqtOv+QiAKsxWDmlsh2+2r8eMEEv0Yp2jd+9XZQrAZKNglhq5PGob8qbd+/kNe9vQ7TRl5AxCOJAud1u7KqSmRUS/x3vrmGWgoGxasJOp8Ng4K/8prFmokUEi06Z4ef3n36UBPl0r2o++M2TL5CulGJY/K2DcuPKqYZ3aAhP7Bgpu/JpAqJC17lIX+TKrwEwyOsFQtK3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QswOp2Bn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QswOp2Bn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZBl203Rfz2xlm
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:53:01 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-35a1d4a095bso1968538a91.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 03:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773658380; x=1774263180; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eI7BcGXiPqgCf8fnNfBg4ModAK07P/xgkHvmytzUeQY=;
        b=QswOp2BnciqYku6ajQdL1vXwJh/6FZJJtphVqHLW32g5ro1wW2UB793aZyuiwG3Mrh
         BdV7/74KP464Xw27bfHkPehYGUIoGJkCuRLvOkiQg9VjIs4PUK7WjDHL/r9ODU47T4Jq
         9EjkIWeP8i1JbzYHusFZEYx4Esux6UsfXv3zleJ+4ZkJB8hs1GwQl5o9sc200UxBncL0
         1wPc93uxz06UA4IH27bevA7GxkoGxF99anYuVi3Ve/pp5wtB1TR9g63myC+lC4gxEqR8
         3bWFcIBWsc+JoXMR+dhpbr+uZahhXiOGLiIeAIB93obmFHVaxLbwHD9/QSQyZ+jeXdgC
         ssLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658380; x=1774263180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eI7BcGXiPqgCf8fnNfBg4ModAK07P/xgkHvmytzUeQY=;
        b=I0PEMHKVydgMZw9O6uHrdG1JOMqfST/KZTQ2dtV/+h/N6NqwafVkX3PZx7okgm/re3
         bhz9NgcPQEh9ePZwlNbJHA/64dTB9uRQ1iUFeOMwrpOSW36YEU9UtLuYcuhn1GMgPd0M
         gPyUZnlfCb9RbeUo7CpxcwMSOzEurm39jMkBe/yAN0WzkLIUvWCXY8aP+JFtuz7XEBqh
         +M7qXL3OkqHoH5DpBdE8+mvjZpBFSMLEoKfaxv5P3WzeXoQx8PcOyICriZGrBHh5jzQO
         9SqxiSE8AM4hSbsJI7EjD7bssXyqyOoZKJuYZPv57op8oMd1p/jtPrF+nDtbs9mZFYFA
         TbbQ==
X-Gm-Message-State: AOJu0YyMDOK59Ak7HAao2MWEf0yYXoCfHeQU90ljY0jgT3s2BKGXH+VN
	Qtu3v1Lh96knvD2DV6dk5HlCEUYjwOS7SdVBW26mVCzJypUtkI7xf6wT0Mp/0PV2d4g=
X-Gm-Gg: ATEYQzwLQcc+pcexEUzKXnqisODuN8as74jpgD1jBO4z90hCZ1NgmI0JmGCJyIoyIAv
	R9aNiF9WODfWs8RjmvUxXEtt5LURup3LNlLKXTiuWg1C/QoEWVUMkg+i6nEtHzezKIoivO7Rtay
	TwJRVxxuy+JO7DM9HxUr6TNeYksOd0g/5C5h3R63LNiNL+Yf3wuKyxu0TxiNTMXqg538krWKnwW
	n5FB3iktmsB0TuqX7TTgEB5vODKT7GjBSVY+zch2knCm2Lg/MwSWIbBzta1RHw32j9wKl6vnvGS
	JFF1Sg/Up3/3+4xbFrpiSka3B95aQoGa0bEsMXK4Viz9c79UScg31XTi5O/P00skbMJJThXV5jl
	Unk7jMOpbIfFPSzUSFYRu6dXtpKgY52htkeIa4l8Fp3dGcXNOLIW4GMFp5YBPQkTm7MukZWL6n6
	xVog0W+7HRKNQLQRCiQp4h7lXKyRABViDukaxWLGSbjHrKU0Hra+E=
X-Received: by 2002:a17:90b:498d:b0:356:21e9:73ff with SMTP id 98e67ed59e1d1-35a21fd7f9bmr9842422a91.11.1773658379992;
        Mon, 16 Mar 2026 03:52:59 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b94e8baf9sm1693569a91.13.2026.03.16.03.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:52:59 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v2] erofs-utils: mkfs: add --exclude-path-from and --exclude-regex-from
Date: Mon, 16 Mar 2026 16:22:40 +0530
Message-ID: <20260316105242.6894-3-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316105242.6894-1-nithurshen.dev@gmail.com>
References: <20260306085717.12776-1-nithurshen.dev@gmail.com>
 <20260316105242.6894-1-nithurshen.dev@gmail.com>
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
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2743-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 036A6298436
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


