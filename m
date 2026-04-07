Return-Path: <linux-erofs+bounces-3213-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD1gMrTM1GmtxgcAu9opvQ
	(envelope-from <linux-erofs+bounces-3213-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 11:21:56 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3593ABDF0
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 11:21:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqggh43wTz2ySk;
	Tue, 07 Apr 2026 19:21:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775553712;
	cv=none; b=QGm/UDTd/wIcVkY9im7lR/NW2vlnjwLSXu48DrdrjRV3bW5s1vwHSlw8R/onCn1bSXFvJMRnZRnpd1B+6TgtG78gmXRw1xsg5ZWfXa0A/08VuSnqcKeziaXqrWeKSDV0OQfMs1sU991Vb8UYmqU7a6wW9eiI9WTVwMrQ8QI7nIXuBed1a09ZeMMZEjrKklRxQVEYJrTsZ7b2HX+iyIDLMaZhj4aa14b2Hidh2vhRkYQPLuhxru2Nn6r/VpAk5BSePrmkagRJXbGRyyV+xA6NftmfWCwT+KtDv4L/bHjfuRXKa1jVUsNGTgJbF8ylFyFFkHwFrrhHK4CqBpEFKkIByw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775553712; c=relaxed/relaxed;
	bh=3MH0DU34KiFB1LLDij7HGH8TJLeaRpn6a1h9YGH6ASE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbLb3wsZk50ss6KQMe1Q69bJS9Ql724d85j6kCCjEJA0+n95ZMNr4IFhoQdir7GFDClUmAAZfadWh2xLIJycQ2R3ik9xp/vEtMmQt45rfIe0qPULL9GEIgu6M91Tc+Mo33sLL2CxsPlPABBNrn9jb49572VY2ACAOq9hzkDbyFYSbaRuXcbIgfnUubnpPHc45I9FeQ+xWBRKe4+S+ayQZjOG1pdZsId4/E3/30Adw5pnLM3TNzfBKgJ+cCnkNNSgyTPMQvltqrAqfsqEQfFILl07S0TzNuYhxEAqLFer+WlAMykTXlsWSAHZYU5XNP4iZ7rOPJTbYdQCQ97uHNnhAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FM7mJXf+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FM7mJXf+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqggg1DL4z2ySS
	for <linux-erofs@lists.ozlabs.org>; Tue, 07 Apr 2026 19:21:49 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2b2503753efso39379945ad.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 07 Apr 2026 02:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775553707; x=1776158507; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3MH0DU34KiFB1LLDij7HGH8TJLeaRpn6a1h9YGH6ASE=;
        b=FM7mJXf+5gEXn81eEQXxMJb4dZ3BWT0Z6va7Uu48IgnFeLd7GMoOlZfswJhSoLCl8A
         0GuMJf7Hn21qOtmc9Ja0df/Kuvk/K4j2/vIzBwMa6vzJbU/iGQ/8eueQz/bGEZsR+Knr
         Jqots+MHHZ/qVJVe45LbdmdHCryO4JJwsRfL01l96P82JcWniiALCw4gKikWn/1pVC1F
         g9tCTWz6NnPp4GzxHFMDP4hud+l66c9NHI1w4kiX6aJzP7czXjgKbxbzOGO3JelByx+B
         di9HeZGnoqI3OFdC3v6gUlwBuAdOQWBADuLez/wrMGGo0Q6HFpU5Irrfy94XQbIU7k2d
         WapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553707; x=1776158507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MH0DU34KiFB1LLDij7HGH8TJLeaRpn6a1h9YGH6ASE=;
        b=e0EJAWfqq2jpSwlOR2Miqotcd84/SOCrvMnTq+EUa/IuVUZX5cy0z6Ho1yhE6/Q/Vu
         QIRcQvUF4Hx1PSpF7Cj+z4o/niEjE26M0gQEHQSMhcSxgPEq2oGCQrcDdTG/kgp61/YN
         thygGqFJlfjymwk0sPvat+Mj4ECsi3wIOcMxvw4omMECR3TsMzf0E7KUtJ8RPS5sHaZo
         sOznE3gAUonOAklqBNmO2R0x8PG3jPU2jRUfxmzU3AH6Kov0Of+93hwz/NdPuFh2bT9x
         6e8Gvh7n9h/nvSsf5ByWlbthXQXYp7iLyVdD84fGyjxn4IcecKZhKeBd7hg7DQrmvzEZ
         H4uw==
X-Gm-Message-State: AOJu0YycA6PQ3oXDFABxaVxlnUjVXcz1CQuivXQnliAS/QH8esfNEAup
	UQ3L9YRLYklK3nqdtKip3e3zQt+zLm1QyFKWDUekdE/mOSuEuyQ4xaZwD8VZpw==
X-Gm-Gg: AeBDieuABGv+pKGCplbZnuJxAj3Ba0wWFejhcqB02MAbWOVvOFpVSvkwWgn0Asrw2f0
	c0liDQFX1PmGAGWEh9+p173lCrJRbBOE5GqrHmrJQq8AKq+UK9d5rk/DcV9ptGq6C4JqITlgSR4
	mVYxXceIMwhwrGNMJwoBW/HSsa19ecFK+JmpvKuwklUtQuXQ2jACQAmYZBWMQ4kFVn9WH1nEPgw
	ZCjxgf6p06o5Z1wfMUAuEqVGumWAM0G1ngh1fV2SncLS+Gvs3GsPdgy46f6XxViRgQU8HyNLUvK
	LhASGtUsObdc+OX5cuGqvhdGI9ZFBL00wLYgLjC7KGktyqnVHeFw452HPFf15rLrNOw/oN8R8ar
	sq8tzgASycDgFdu570GrXb3H24QAZRWJ/paX77Lz4jGOYqO9dqw3fJHltJgE/DChT8vzYdGiTBL
	0hlH8DXahNvSDbgnt/z1pvhzh9Li78AW9NHsMV/dtrd6GP+Pk=
X-Received: by 2002:a17:903:3b88:b0:2b2:3eec:c75f with SMTP id d9443c01a7336-2b2819173dfmr161650625ad.28.1775553707491;
        Tue, 07 Apr 2026 02:21:47 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477a13dsm166369315ad.26.2026.04.07.02.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:21:47 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH] erofs-utils: fix erofs_sys_lsetxattr() returning positive errno
Date: Tue,  7 Apr 2026 17:21:41 +0800
Message-ID: <20260407092141.11697-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
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
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3213-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4E3593ABDF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_sys_lsetxattr() returns bare `errno` (a positive value) on
failure, unlike its sibling erofs_sys_lgetxattr() which correctly
returns `-errno`.

Fix by returning -errno, consistent with erofs_sys_lgetxattr().

Fixes: e0d85fc5a282 ("erofs-utils: lib: introduce erofs_sys_lsetxattr()")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 lib/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 565070a..af1b9ca 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -123,7 +123,7 @@ ssize_t erofs_sys_lsetxattr(const char *path, const char *name,
 	errno = ENODATA;
 #endif
 	if (ret < 0)
-		return errno;
+		return -errno;
 	return ret;
 }
 
-- 
2.43.0


