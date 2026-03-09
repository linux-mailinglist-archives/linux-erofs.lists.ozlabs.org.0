Return-Path: <linux-erofs+bounces-2541-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA62CD7CrmmRIgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2541-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 13:51:10 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7322392D6
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 13:51:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTxhV4FSqz3bnm;
	Mon, 09 Mar 2026 23:51:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773060666;
	cv=none; b=QoR70lC08DuVHTAnqnixf41RrfP8ETq/yJq577fgZy3L6A93Zc1vD+0vGWvsI9yCDfJVH7Yoj87TWkwTNWM9YkCp3Sbt+3GwDOPmIlZZxlggntLlYhVoY4yvGLfDiWy4lz0AZN29UQMyJdkJ+wxwis8zx8cGzmq9qlF2pem1UkBiltawqLSecNaAZU2Q0s74WIXLrhkCWTCM4SaWTixiCQinWtnE/FNvscXDsGew7qa7lKwUetUg6FxmqcJDF2gTRkJs7RC0tR9vtADkJfwSQ4ErnsmAeEtrcBSkmpZ9dKWH8Dp67GGyR+g8Pe5VeSdrIzcIb+EldPch3q5yCYrxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773060666; c=relaxed/relaxed;
	bh=eI7BcGXiPqgCf8fnNfBg4ModAK07P/xgkHvmytzUeQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCDPOxcwJ9ZO4tNpe3qAZmQI6m+jZeAxtGT+Oyx4D3Nqedb2VwRPjTitxPqqFyno/z4ESJzGcaHDnkpcJV22Jb8C5fa3tR+JgO4EL7Hpv+4UTmX0wFaZn1cN60JaDDEhE5duwgagwfocJmYflYlOrWP8QnTztPJZWdMZiNihH6bkZERwZq8GtRJMJwWNox37TDlckKtjjTU0P7jJ7w0Xpk1pCxPp12dY3kWFVuFyE+A/6x0h4ZpBLS8aoEm9tzkkm39cAzJ7Q57Rs3CoF3u4QolRpQzeBiN3nkS9O9luXx4yuuC4QVLJS+FEnuQy4m7D+69tOq7xHxDQEvJr5dBgiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ecocjs6X; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ecocjs6X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTxhT5Hvwz2ySb
	for <linux-erofs@lists.ozlabs.org>; Mon, 09 Mar 2026 23:51:05 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-35982fd8910so3647516a91.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 09 Mar 2026 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773060664; x=1773665464; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eI7BcGXiPqgCf8fnNfBg4ModAK07P/xgkHvmytzUeQY=;
        b=Ecocjs6Xzls/5BlTfaBhtKXTj6RUetfw+a1KbNI7Ftx3noAJAAdWk5bKpNUuPYsNcI
         tjO4w6qaW3iNaxvMzMNuft2vLOtbfdSOO6+9lIqk39LRd7HSAzhsfkoNBwscyU/6NzxB
         TFYaZK6MXCsjhiMqCsYK33i7DPbbYLRd06qCcIOGkDFM+IxZFRNgOEf7glo0dgLScmfn
         3FMOTzpyRjBhovRfayuV14C46IwIVZ3ZC7s88zlGvIqxhiXoGj7/KFHwlCU+mICQbrt7
         3JQx2hufM+nLfKzWH1Zh2XnDg2tkPKSJZspVOaaClKsWCEu/uZr3fi/0cPOFOELZPlwa
         RCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060664; x=1773665464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eI7BcGXiPqgCf8fnNfBg4ModAK07P/xgkHvmytzUeQY=;
        b=U+z8VbXxeqYcj27/lWPTXUzGWav0gHuHt/bSyAis08t/hmOATHwKTXupwnpMvQVJxB
         6hYifTnB5nZsxmQ4PCj7iywzBQ8dLxTpB2EgfJvkT0G2rXha+pmtkIFQF3vWRvjQl6fK
         wVtIOvryMwjI8MPSjUPl1T3vPudJODNO7150a4YJVR6ZrvCSI8UestJOt/k7Htuqooz3
         GgZwqrkLr/Xfn2NSJIueZ4iQ5P4gaKB3LrwrbvHLlop9dIULsMNXcPp95UXAGwQDWyxt
         00rEkFT5U6BTSU8DoK0tCR4DkzmfkFd6JUT8g9JGvZn0/1J6DdO8S6+YbaB27d07JFKC
         kG2w==
X-Gm-Message-State: AOJu0YxulXcFann/1BErB3CY0N8XugVZ/J7jw76GPG/KvrQQaK2MlbuK
	x9BOp1HZUAQzUOi3uiNmdLc0GmJXWrTd8a4U2bc6eM3TiKrr29Nj2fbODXBAsXsW
X-Gm-Gg: ATEYQzz3veZanL2zmX8KT0QKiFMjzxXkmt1GUCOVxH9yaXdU7makG6tJed3j7tBLrGn
	clYpt0xFlo1OGyGTrd4pxqQkTmAywI2wZJeL7e14FfbSXa4Tov4HvEdOJ6Yf+Kjo0buwdd71yRt
	yYoWGsUSV2aMoyAoMIVL7GPQQOPZB+h8N1LYAJamodK6coenHFQtM91dN/aRzV0MP+AZH8HmIOT
	xV8OLiLW4nhAg3IL4UbmIlQV4Mr9gpLGkKuVDtAwEqhfAFqo6VnKMCSXH1mf0R8HMtDjWHbADRr
	dF1JU5sGST8MfIlutBZqQclJkQJhck0FEXS350UtbvG06f+FONBbIEfjcPhC9XVkLT+urEioz+k
	wQGGu3vG+OAfuXqKW85KAxv0E2PdkPDSMx82uxrHNtj2Ale4pa8nCJM9uxpQJyZnP7nS33eRMdt
	rl7ihV13EPNqf4qJHDy+V+uZvu9e33k+f4YI+cx1DVxsKObOaWZb0=
X-Received: by 2002:a17:90a:d404:b0:341:134:a962 with SMTP id 98e67ed59e1d1-359be31e147mr9770680a91.28.1773060663678;
        Mon, 09 Mar 2026 05:51:03 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c4eb8c48sm12431689a91.10.2026.03.09.05.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:51:03 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	zhaoyifan28@huawei.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v2] erofs-utils: mkfs: add --exclude-path-from and --exclude-regex-from
Date: Mon,  9 Mar 2026 18:20:56 +0530
Message-ID: <20260309125056.61926-1-nithurshen.dev@gmail.com>
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
X-Rspamd-Queue-Id: 3A7322392D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-2541-lists,linux-erofs=lfdr.de];
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


