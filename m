Return-Path: <linux-erofs+bounces-2451-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFsQAEuCpWltCwYAu9opvQ
	(envelope-from <linux-erofs+bounces-2451-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 13:27:55 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140AB1D85C8
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 13:27:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPdVH6gX4z2xc8;
	Mon, 02 Mar 2026 23:27:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772454439;
	cv=none; b=hKUsBblqh2qBeICWG4sp7V+s6r/VsCLlcoiVyB0b+6JCOUuiD4W0OuKii5xd5aVWDpYkDZyFN9wlMjFLeru+ZZAVgL8hbziSGX0bnzMQq4lR5N7vAPx1BPtuCKG0JBOfafwSN/LeYbp6gYBwTIXT32UWLsKb4W/bzxhSrvHFndy2MYtA6njh5ZwF4104OX42jxWhZz4huEby3JWgy3h68qClsZ6p+43MvSUwnBVRIaGQ82dPRorar9psYMi+PRb3y83y1levsBELl+1Tf0ZORDnsnh+nSxEZbcCcHVbtQzUvLIZbqH6gOkcrcOF6b2NBw8UU59EQSvTqsUSqWAClcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772454439; c=relaxed/relaxed;
	bh=kG16c1sDYe3TyH1iYdzCyMngiyeEqWIPPMfKug2p/8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lIt6OEjJIYNLEPdWmuKVfltgbbyQdh4kYYsuy9oiIS9w3B7ZmFFzQWq0u7Dcr3OYfx6s0ym3XWyTAf1QHJUlE0KDqnESOuYPcxpxF/R8aiOtqCqUqpncejUD6NesLv+NzDfxsV/k80TlOivvETfP7LVafRpazAR63JKAH8qQHIyFLUZqCXyRaZTbjkXFS9zybM6mgJ4z3O7WS4rc1Bu3zxANYmerPlWOtOL/1BAV6L+bNcKvT2G7ukB+x5TCXk9DjcZF95PTGfiGY6oNgZDZoAV4N/+1wFzPTjP6wXXTM/I/YOQMBR0KvhT8BbgslT5QUTNvS42zj3H7Bu8CvcR4Ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hnsms2ON; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=hardikkumarpro0005@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hnsms2ON;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=hardikkumarpro0005@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPdVH18crz2xGF
	for <linux-erofs@lists.ozlabs.org>; Mon, 02 Mar 2026 23:27:18 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-827270d50d4so4566970b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Mar 2026 04:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772454437; x=1773059237; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kG16c1sDYe3TyH1iYdzCyMngiyeEqWIPPMfKug2p/8o=;
        b=hnsms2ONjUChOT2H/fzq31yus8dTVdpUvGV5NCEnY4AG/0wQwqwR8VlPYgF3/hZirO
         Dz+di6VcnaLPTyHgAJO1N8XIZqpnflUmyXWnBOwHvsIEKn/AY1YYy4N0cHMwKhEp9HQ/
         QJWl0eN2iEBVk2pd9O3Mz2H5Uopp1hGlRyCvDEeY0UUBPH2NEaaBndb4zfl9u5PJ0SeB
         k5K4Att5OaU03930QEE6R8QMBmrE0S/Gu1zCnlQWkaQCNq8TnZAl/F2OVYO5yLMNIdRS
         QwMytzWyjsGLMfVEbmuYpA8Wlt2/q2MoeSUqlbhiI4N65a0cMl1eeFzBEJ+/iLDW8D5k
         H7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772454437; x=1773059237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG16c1sDYe3TyH1iYdzCyMngiyeEqWIPPMfKug2p/8o=;
        b=NoviAJ/+ITFcrwDsLtdUkL9qxhDtoYdCDney7hOXsgQw/4Rwxw7t+5veaI352lpZqz
         /Pvm0qLOYO/5MmnQLAZnAkdKXSBLwjLZefhB30WmB6tOK+koxp9VT+PP9HiJoSz+Q0HI
         w7QjlGkt/jh/SF7GMAC7l8cwR79Puv1a2nrv6QD/QgDqWAu4iSDAyrSpekf9XKmi0doy
         Zt8yAjNLNCJRlSeEaIDY0Slz3CMiiilXI1GVDqMcJIRKh8FQbZypIRMrfJ+ktA8LzBe8
         8D0/kMTKohnD8j+/68dYrFkbZBNCXtCXb9mPZNNF5dYc+JSXPeN9JZuiUbrksFN5kQwL
         HkwA==
X-Gm-Message-State: AOJu0Yys5xFVx9sKURcW8aKOtzFeSfdyiFeS7KSCkI6V2YE+iWBwYvt1
	GOJKIJCSAV1X0VacIRzUU48zXDHTPS8EicPcuMhWGIctUZ7/GP81vdSFRM8N7Q==
X-Gm-Gg: ATEYQzziuu3SUx+SeqcBbEiddSJqbdfmz7Bs2yBNKeo72TIYssWVwoNeLDHqaD1C107
	9G0jcP60BaMI6I/4JViB0GNfmarBZhdZ/c9QBD2GQmlfpf0u7uflwZtmUrblF8tm8l8WH/G2qQi
	DD9FKid7CBwIYakviXbyZHn/1n45ua9ozmMQ921KZMrJhdfF9CDC/cZHjm0KAG5SISLkbK7Dc9F
	yfVw0f7vl3qY3B5PuG9OJn8WMA4R8o5/V2Iw6gbhZZDiV22mqQqXIG2gEFiFG5CJ1Mk87cb8nzi
	pugk4mB/pFGRWG7zT2u69EZEV4YAiRvd0WfwDDAuUjAPBzL3YRU0AP/Ojn2PD/b41JgVdYwoOL/
	03eSpMzqqjQNQbj/ZCDXDvq9EwfZc8eMOrh+mXmnYdo1eHcuU0ofhSTFajdovTl6Olee+p7N1UT
	uorOaR3fZ5bwCwvQ==
X-Received: by 2002:a05:6a20:4321:b0:35d:cad7:cd63 with SMTP id adf61e73a8af0-395c3a58e12mr12046268637.30.1772454436673;
        Mon, 02 Mar 2026 04:27:16 -0800 (PST)
Received: from vitap ([2a09:bac5:3e09:16aa::242:a3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa806295sm11840118a12.16.2026.03.02.04.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 04:27:16 -0800 (PST)
From: Hardik <hardikkumarpro0005@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com
Subject: [PATCH] erofs-utils: mount: fix flag-clearing bug and missing error check in parse_flagopts
Date: Mon,  2 Mar 2026 17:57:10 +0530
Message-ID: <20260302122710.1459-1-hardikkumarpro0005@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-2451-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hardikkumarpro0005@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,foxmail.com:email,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 140AB1D85C8
X-Rspamd-Action: no action

From: Yifan Zhao <yifan.yfzhao@foxmail.com>

The MS_* constants in glibc's <sys/mount.h> are defined as members of
an anonymous enum whose underlying type is unsigned int (because the
last member, MS_NOUSER, is initialised with '1U << 31').  Therefore
~MS_RDONLY, ~MS_NOSUID, etc. are unsigned int values that, when stored
into a 'long flags' field, undergo zero-extension, not sign-extension.
As a result every 'clearing' entry (rw, suid, dev, exec, async, atime,
diratime, norelatime, loud) produced a positive long, so the
opts[i].flags < 0 guard in erofsmount_parse_flagopts() was never true
and the corresponding flags were set rather than cleared.

Fix by casting the operand to long before applying bitwise-NOT,
ensuring the result is a negative long with the correct bit pattern.

Also add the missing return-value check for erofsmount_parse_flagopts()
in the '-o' option handler.

Reported-by: Robert Rose <robert.rose@mailbox.org>
Closes: https://github.com/NixOS/nixpkgs/issues/494653
Signed-off-By: Yifan Zhao <yifan.yfzhao@foxmail.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/tencent_003DF0338EAB42F1573BC0CCFBEACE321E06@qq.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mount/main.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index b04be5d..dbee2ec 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -203,15 +203,15 @@ static long erofsmount_parse_flagopts(char *s, long flags, char **more)
 	} opts[] = {
 		{"defaults", 0}, {"quiet", 0}, // NOPs
 		{"user", 0}, {"nouser", 0}, // checked in fstab, ignored in -o
-		{"ro", MS_RDONLY}, {"rw", ~MS_RDONLY},
-		{"nosuid", MS_NOSUID}, {"suid", ~MS_NOSUID},
-		{"nodev", MS_NODEV}, {"dev", ~MS_NODEV},
-		{"noexec", MS_NOEXEC}, {"exec", ~MS_NOEXEC},
-		{"sync", MS_SYNCHRONOUS}, {"async", ~MS_SYNCHRONOUS},
-		{"noatime", MS_NOATIME}, {"atime", ~MS_NOATIME},
-		{"norelatime", ~MS_RELATIME}, {"relatime", MS_RELATIME},
-		{"nodiratime", MS_NODIRATIME}, {"diratime", ~MS_NODIRATIME},
-		{"loud", ~MS_SILENT},
+		{"ro", MS_RDONLY}, {"rw", ~(long)MS_RDONLY},
+		{"nosuid", MS_NOSUID}, {"suid", ~(long)MS_NOSUID},
+		{"nodev", MS_NODEV}, {"dev", ~(long)MS_NODEV},
+		{"noexec", MS_NOEXEC}, {"exec", ~(long)MS_NOEXEC},
+		{"sync", MS_SYNCHRONOUS}, {"async", ~(long)MS_SYNCHRONOUS},
+		{"noatime", MS_NOATIME}, {"atime", ~(long)MS_NOATIME},
+		{"norelatime", ~(long)MS_RELATIME}, {"relatime", MS_RELATIME},
+		{"nodiratime", MS_NODIRATIME}, {"diratime", ~(long)MS_NODIRATIME},
+		{"loud", ~(long)MS_SILENT},
 		{"remount", MS_REMOUNT}, {"move", MS_MOVE},
 		// mand dirsync rec iversion strictatime
 	};
@@ -281,6 +281,7 @@ static int erofsmount_parse_options(int argc, char **argv)
 		{0, 0, 0, 0},
 	};
 	char *dot;
+	long ret;
 	int opt;
 	int i;
 
@@ -305,9 +306,11 @@ static int erofsmount_parse_options(int argc, char **argv)
 			break;
 		case 'o':
 			mountcfg.full_options = optarg;
-			mountcfg.flags =
-				erofsmount_parse_flagopts(optarg, mountcfg.flags,
-							  &mountcfg.options);
+			ret = erofsmount_parse_flagopts(optarg, mountcfg.flags,
+							&mountcfg.options);
+			if (ret < 0)
+				return (int)ret;
+			mountcfg.flags = ret;
 			break;
 		case 't':
 			dot = strchr(optarg, '.');
-- 
2.53.0.windows.1


