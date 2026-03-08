Return-Path: <linux-erofs+bounces-2533-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePeNKnXxrGk/wQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2533-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 08 Mar 2026 04:48:05 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCD022E71B
	for <lists+linux-erofs@lfdr.de>; Sun, 08 Mar 2026 04:48:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fT5hJ6Cy8z2xdL;
	Sun, 08 Mar 2026 14:48:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772941680;
	cv=none; b=L5WbCFDE3XQw3QmvdkyA/JW9vi6h/kWCcB3RifVm8vaKWPbWAdf4GqgXBFKW2iOv/deGzg5Bf9d4dadlA2frSJlRF0OZW30PmPH6eoEwBL44BINxhMDHcovi9Pc8gRXaNuDAqFM+XoLD9KFkjjQRTGF7V/8fkyNB4cX0apn7y8IH5G2ofKQXuXElmjEg//tDLew6a8TwD6elgz2Xd8Y5EUdLSg9Ll/z9tDJtt0atVWh5YL3Jg/R5wVlfJ+oElAjyhEy8Raz87OxjX9W5WhpCPPP8unV9risa2oBwrPpDaCJdZ+zK1DPQXUwy0LaMol2cWdSSKCkIq9KsUZqmd44Nqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772941680; c=relaxed/relaxed;
	bh=eFa2ndSF4p4Wqz2MqpBaWtBCgQBOTYyTI+WKfe9IqGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUf900jqwvZnU9dQ6oB17uwCaFV9lZA57gr+mL1kBTXuJE7cSmyJ3y+EHVhhZ2RTDFE53DG1co2rYddn5zXiwh0krYUkQ3ayD2JHNZzSoviVefxkhxa6wWVXunHgmUJ6S0yr8mE0ZqgEjEHwvQD5ioRfw0q/KYHOmEFTVoS7hGnVOnOiIBWveAvGHAgLuoDxWAZ/MCTnyxDIi21dYzJbRHZ2ZmnbnJ5F/zwQ5IsIn7Mj70A/uU9zu8LfcxeSjwRVDeGoR9NeyPcexKExs2S7jk2AS1mOfMko9NzamVcDPG1jc9XCy9kxrAJAagAr4P2z2KvN4PUC4dn+KzfhFjSFVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Nwnbm7Ms; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Nwnbm7Ms;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fT5hH4cYxz2xS2
	for <linux-erofs@lists.ozlabs.org>; Sun, 08 Mar 2026 14:47:58 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-829928e512aso1525953b3a.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 07 Mar 2026 19:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772941676; x=1773546476; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eFa2ndSF4p4Wqz2MqpBaWtBCgQBOTYyTI+WKfe9IqGg=;
        b=Nwnbm7MsliGpyXl+sRksAWoiOWyAI+EASgb9GNnD4SZHSkK89JbCkibz4O/3JDZUvV
         rqwsFnCsW0POtjIM0kDaaNTSp7Gw1p1lwz/kEUvUmbwU+8J1b9nZlbLg7KHt9h7vAZ7x
         vg08wClGzUlfRiqiPekV6YPXQv2gIB2nPqUiIxARw3zd4Zg1Ont3i4dem3YyB/5sMAbT
         3KgZ15M6aAY9oroK1hjgZasOmuXab3dhfc/7DrJxI/Vd1iu1wFuo8gXxmf1kfqRT9n/a
         3svBwzhKbkhTxUsBss9XF/TPrio5JWfasKZIfMVxS9nh144d3MGOPny19QuMt7Jo8bU/
         SEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772941676; x=1773546476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFa2ndSF4p4Wqz2MqpBaWtBCgQBOTYyTI+WKfe9IqGg=;
        b=wr7L850VdSNESjStoG3RbLMiIJd8f5eMxkqjE4IXRcU3wDr8m4GFUpF0+UdIz5exGx
         DnIm+wiyW5Suxw3iC9QE57yjkYt023l8XAKnHHWl0+Osw1AfHS20JBHerWwqgWZ0Wy9B
         OBChttCoUni6UJVtQhKcWGffu6GyaUYfgcqABT/7QGiJiRl1Po2nS9ck+gLdIJS6AIJZ
         KQuGAI3x+qREWhVJ4LktS6bTNHrNnmTUIZluiCBS+FDyOr0lTObWeZbr0wXWO87A3O2K
         k9bZrwIb/DuPQVI8BwCyMSJilbqwnibFtir0HJORRcdDKvCmfCESGPYHfINXQlRqvrrv
         CxfQ==
X-Gm-Message-State: AOJu0YwYBPP8+3ycRhn1+pALvXuY1hJ0MvRaNAZ5j7UG0RcKfRTWXLab
	DGTDmYCjxfWYXaMWsGhn1diSiap3AwTrcT/hl5Ji5c3uHWB+CG3JQ5TDnEE05U60
X-Gm-Gg: ATEYQzxWOrakndJHK9C1p4120m5aKRaU7HQ/sEFwhPmqFlT9ont6mHsw2/c2JT+q+1Z
	OlvmAjHvbm3Cj/LqUNGc8c38FIIjcpfq1Gh+FioAVY/+9OXWFmoX0h5Z7oT7/oe/CM39Qp0SNLl
	w5V6Kv4jiuKnyOr+oT5A6lIwkH71GHpfXdZE/bgDt7vjfptonx2355lIhXiFbQaMcdmDue+jS/P
	F6Vd7nf/nGfFLEo3eIZ7VanvY3eKUB0iXNXFtD+edGVGbtL/1jVaPrZHcof3tyoUya7vGWBR0B+
	CkI/IyEJnXjDbKxDR7goszJa98UxSByPNOkpQKV+zvssszaK2EbpDyyvFs+gx9CEYgwMR74wVqe
	6QjWzXzDb9kGJTzpEeOWCXO7y6re87sX/JFJP2QMMMS+yiV89BG2mypDn4iU/tUTwYTTAB07Uqz
	qTPQ+HIdFp2lowY0tSfHr9HPrzOuyHFsivUPDYRmQxkG9Wz6aHaV8=
X-Received: by 2002:a05:6a00:8d94:b0:821:7d7e:41d5 with SMTP id d2e1a72fcca58-829a2f9fa0emr5947704b3a.52.1772941676118;
        Sat, 07 Mar 2026 19:47:56 -0800 (PST)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4638141sm6155903b3a.6.2026.03.07.19.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 19:47:55 -0800 (PST)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH] erofs-utils: mkfs: add --exclude-from option
Date: Sun,  8 Mar 2026 09:17:49 +0530
Message-ID: <20260308034749.22233-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
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
X-Rspamd-Queue-Id: 0BCD022E71B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2533-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Currently, users who want to exclude multiple specific files or paths must pass them one-by-one using --exclude-path or --exclude-regex via the command line. This becomes cumbersome for complex build systems with dozens of exclusions.

This patch introduces an \`--exclude-from=FILE\` flag to mkfs.erofs.

Similar to standard archiving tools, it allows users to supply a text file containing a list of paths or regexes to exclude, which are read line-by-line and applied to the EROFS build process.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 mkfs/main.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 07ef086..a6cd251 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -39,6 +39,7 @@ static struct option long_options[] = {
 	{"help", no_argument, 0, 'h'},
 	{"exclude-path", required_argument, NULL, 2},
 	{"exclude-regex", required_argument, NULL, 3},
+	{"exclude-from", required_argument, NULL, 540},
 #ifdef HAVE_LIBSELINUX
 	{"file-contexts", required_argument, NULL, 4},
 #endif
@@ -199,6 +200,7 @@ static void usage(int argc, char **argv)
 		" --dsunit=#             align all data block addresses to multiples of #\n"
 		" --exclude-path=X       avoid including file X (X = exact literal path)\n"
 		" --exclude-regex=X      avoid including files that match X (X = regular expression)\n"
+		" --exclude-from=X       avoid including files listed in file X\n"
 #ifdef HAVE_LIBSELINUX
 		" --file-contexts=X      specify a file contexts file to setup selinux labels\n"
 #endif
@@ -1246,6 +1248,39 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 		case 7:
 			params->fixed_uid = params->fixed_gid = 0;
 			break;
+		case 540: {
+			FILE *f = fopen(optarg, "r");
+			if (!f) {
+				erofs_err("failed to open exclude file: %s", optarg);
+				return -errno;
+			}
+
+			char *line = NULL;
+			size_t len = 0;
+			ssize_t read;
+
+			while ((read = getline(&line, &len, f)) != -1) {
+				if (read > 0 && line[read - 1] == '\n') {
+					line[read - 1] = '\0';
+					read--;
+				}
+
+				if (read == 0) continue;
+
+				opt = erofs_parse_exclude_path(line, false);
+				if (opt) {
+					erofs_err("failed to parse exclude path from file: %s",
+						  erofs_strerror(opt));
+					free(line);
+					fclose(f);
+					return opt;
+				}
+			}
+			free(line);
+			fclose(f);
+			break;
+			}
+
 #ifndef NDEBUG
 		case 8:
 			cfg.c_random_pclusterblks = true;
-- 
2.51.0


